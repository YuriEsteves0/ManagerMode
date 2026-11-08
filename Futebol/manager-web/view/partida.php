<link rel="stylesheet" href="assets/css/partida.css">

<?php

$estadoJogo = $_SESSION['estado_jogo'];
$idClubeJogador = $estadoJogo->clube->id;
$apiService = new ApiService();

// ================= SALVAR PARTIDA =================

// Manda o resultado pro Spring Boot (PUT /partida/placar)
function salvarPlacar(array $dados): bool {
  $ch = curl_init('http://localhost:8080/partida/placar');
  curl_setopt_array($ch, [
    CURLOPT_CUSTOMREQUEST  => 'PUT',
    CURLOPT_POSTFIELDS     => json_encode($dados),
    CURLOPT_HTTPHEADER     => ['Content-Type: application/json'],
    CURLOPT_RETURNTRANSFER => true,
  ]);
  curl_exec($ch);
  $status = curl_getinfo($ch, CURLINFO_HTTP_CODE);
  curl_close($ch);
  return $status === 200;
}

// Clicou em "Próximo": salva a partida e vai pra imprensa
if (isset($_GET['finalizar']) && isset($_SESSION['partida_pendente'])) {
  $dados = $_SESSION['partida_pendente'];
  $dados['cartoes'] = (object) $dados['cartoes']; // sem isso, cartões vazios viram [] e o Spring dá erro 400

  if (salvarPlacar($dados)) {
    $_SESSION['id_ultima_partida'] = $dados['idPartida']; // usado na página da imprensa
    unset($_SESSION['partida_pendente']);
    echo "<script>location.replace('index.php?pag=imprensa')</script>";
  } else {
    echo "<p>Erro ao salvar a partida. Tente de novo.</p>";
  }
  return;
}

// ================= DADOS DA PARTIDA =================

$proximoJogo = $apiService->get("/partidas/clube/{$idClubeJogador}/proximaPartida?dataAtual={$estadoJogo->dataAtual->format('d/m/Y')}");

$dataJogo = $proximoJogo ? new DateTime($proximoJogo['dataPartida']) : null;

if (isset($_GET['avancar']) && $dataJogo) {
  $estadoJogo->dataAtual = clone $dataJogo;
}

$ehDiaDeJogo = $dataJogo && $estadoJogo->dataAtual->format('Y-m-d') === $dataJogo->format('Y-m-d');

$dias = [];
if ($dataJogo && !$ehDiaDeJogo) {
  $dia = (clone $estadoJogo->dataAtual)->setTime(0, 0);
  $fim = (clone $dataJogo)->setTime(0, 0);
  while ($dia <= $fim) {
    $dias[] = $dia->format('d');
    $dia->modify('+1 day');
  }
}

// ================= SIMULAÇÃO =================

function media(array $v): float {
  return count($v) ? array_sum($v) / count($v) : 0;
}

// Usa os titulares (titular = 0): 1 goleiro + 10 de linha. Calcula ataque/defesa.
// ATENÇÃO: confira na entidade Jogadores o que o campo "titular" significa de verdade.
function forcaTime(array $jogadores): array {
  usort($jogadores, fn($a, $b) => $b['overall'] <=> $a['overall']);

  $titulares = array_values(array_filter($jogadores, fn($j) => (int)$j['titular'] === 0));

  $goleiros = array_values(array_filter($titulares, fn($j) => $j['posicaoPrincipal'] === 'GOL'));
  $linha    = array_values(array_filter($titulares, fn($j) => $j['posicaoPrincipal'] !== 'GOL'));

  // Fallback: se faltar gente escalada, completa com os melhores do elenco
  if (count($goleiros) === 0) {
    $goleiros = array_values(array_filter($jogadores, fn($j) => $j['posicaoPrincipal'] === 'GOL'));
  }
  if (count($linha) < 10) {
    $idsLinha = array_column($linha, 'idJogador');
    $reservas = array_filter(
      $jogadores,
      fn($j) => $j['posicaoPrincipal'] !== 'GOL' && !in_array($j['idJogador'], $idsLinha)
    );
    $linha = array_merge($linha, array_slice(array_values($reservas), 0, 10 - count($linha)));
  }

  $linha   = array_slice($linha, 0, 10);
  $goleiro = $goleiros[0]['overall'] ?? 50;

  $ataque = media(array_map(
    fn($j) => $j['finalizacao'] * 0.4 + $j['passe'] * 0.3 + $j['velocidade'] * 0.3, $linha));

  $defesa = media(array_map(
    fn($j) => $j['marcacao'] * 0.4 + $j['forca'] * 0.3 + $j['inteligencia'] * 0.3, $linha));
  $defesa = $defesa * 0.7 + $goleiro * 0.3; // goleiro pesa 30% da defesa

  return ['ataque' => $ataque, 'defesa' => $defesa, 'linha' => $linha];
}

function poisson(float $lambda): int {
  $limite = exp(-$lambda);
  $k = 0;
  $p = 1.0;
  do {
    $k++;
    $p *= mt_rand() / mt_getrandmax();
  } while ($p > $limite);
  return $k - 1;
}

function sortearJogador(array $jogadores, callable $peso): array {
  $total = array_sum(array_map($peso, $jogadores));
  $sorteio = mt_rand() / mt_getrandmax() * $total;
  foreach ($jogadores as $j) {
    $sorteio -= $peso($j);
    if ($sorteio <= 0) return $j;
  }
  return end($jogadores);
}

function eventosDoLado(string $lado, array $time, int $gols): array {
  $eventos = [];
  $linha = $time['linha'];

  for ($i = 0; $i < $gols; $i++) {
    $autor = sortearJogador($linha, fn($j) => $j['finalizacao'] ** 2);
    $eventos[] = [
      'minuto' => mt_rand(1, 90), 'tipo' => 'gol', 'lado' => $lado,
      'jogador' => $autor['nomeJogador'], 'idJogador' => $autor['idJogador'],
    ];
  }

  // Amarelos: média de 1.5 por time. Quem marca pior (marcação baixa) leva mais.
  for ($i = poisson(1.5); $i > 0; $i--) {
    $j = sortearJogador($linha, fn($j) => 101 - $j['marcacao']);
    $eventos[] = [
      'minuto' => mt_rand(1, 90), 'tipo' => 'amarelo', 'lado' => $lado,
      'jogador' => $j['nomeJogador'], 'idJogador' => $j['idJogador'],
    ];
  }

  // Vermelho: 5% de chance por time
  if (mt_rand(1, 100) <= 5) {
    $j = sortearJogador($linha, fn($j) => 101 - $j['marcacao']);
    $eventos[] = [
      'minuto' => mt_rand(20, 90), 'tipo' => 'vermelho', 'lado' => $lado,
      'jogador' => $j['nomeJogador'], 'idJogador' => $j['idJogador'],
    ];
  }

  return $eventos;
}

$eventos = [];

if ($ehDiaDeJogo) {
  $jogadoresMandante  = $apiService->get("/jogadores/clube/{$proximoJogo['clubeMandante']['id']}?todos=true");
  $jogadoresVisitante = $apiService->get("/jogadores/clube/{$proximoJogo['clubeVisitante']['id']}?todos=true");

  // sorteia a seed uma vez por carreira e reaproveita nas próximas vezes
  if (!isset($_SESSION['seed_jogo'])) {
    $_SESSION['seed_jogo'] = random_int(1, 999999);
  }
  mt_srand($proximoJogo['idPartida'] + $_SESSION['seed_jogo']);

  $mandante  = forcaTime($jogadoresMandante);
  $visitante = forcaTime($jogadoresVisitante);

  $BASE = 1.35;        // média de gols por time num jogo equilibrado
  $PESO_FORCA = 2.0;   // quanto a diferença de qualidade pesa (use o valor que você calibrou)
  $CASA = 1.10;        // vantagem de jogar em casa

  $lambdaMandante  = $BASE * $CASA * (($mandante['ataque']  / $visitante['defesa']) ** $PESO_FORCA);
  $lambdaVisitante = $BASE / $CASA * (($visitante['ataque'] / $mandante['defesa'])  ** $PESO_FORCA);

  $lambdaMandante  = max(0.25, min(4.0, $lambdaMandante));
  $lambdaVisitante = max(0.25, min(4.0, $lambdaVisitante));

  $golsMandante  = poisson($lambdaMandante);
  $golsVisitante = poisson($lambdaVisitante);

  $eventos = array_merge(
    eventosDoLado('mandante',  $mandante,  $golsMandante),
    eventosDoLado('visitante', $visitante, $golsVisitante)
  );
  usort($eventos, fn($a, $b) => $a['minuto'] <=> $b['minuto']);

  // Monta os cartões no formato que o Spring espera: idJogador => ["AMARELO", ...]
  $cartoes = [];
  foreach ($eventos as $e) {
    if ($e['tipo'] === 'amarelo')  $cartoes[$e['idJogador']][] = 'AMARELO';
    if ($e['tipo'] === 'vermelho') $cartoes[$e['idJogador']][] = 'VERMELHO';
  }

  // Guarda na sessão. Só vai pro banco quando o jogador clicar em "Próximo".
  $_SESSION['partida_pendente'] = [
    'idPartida'     => $proximoJogo['idPartida'],
    'golsMandante'  => $golsMandante,
    'golsVisitante' => $golsVisitante,
    'cartoes'       => $cartoes,
  ];
}

?>

<main>

  <?php if ($ehDiaDeJogo): ?>

    <!-- ======== DIA DE JOGO: PLACAR AO VIVO ======== -->

    <svg width="0" height="0" style="position:absolute">
      <defs>
        <symbol id="escudo-generico" viewBox="0 0 48 54">
          <path d="M24 2 L44 9 V25 C44 39 35 48 24 52 C13 48 4 39 4 25 V9 Z" />
        </symbol>
        <symbol id="icone-bola" viewBox="0 0 24 24">
          <circle cx="12" cy="12" r="9" fill="none" stroke="currentColor" stroke-width="1.6" />
          <path d="M12 7l3.5 2.5-1.3 4h-4.4l-1.3-4Z" fill="currentColor" />
        </symbol>
      </defs>
    </svg>

    <section class="box" data-eventos='<?= htmlspecialchars(json_encode($eventos), ENT_QUOTES) ?>'>

      <div class="placar">
        <div class="time-placar">
          <img src="assets/<?= $proximoJogo['clubeMandante']['foto'] ?>" alt="" style="width: 60px; height: 60px; object-fit: contain;">
          <span class="nome-time"><?= $proximoJogo['clubeMandante']['nomeClube'] ?></span>
        </div>

        <div class="centro-placar">
          <!-- Começa 0 — 0. O JS vai somando conforme os gols acontecem -->
          <span class="resultado">
            <span class="gols-mandante" style="display:inline-block">0</span>
            —
            <span class="gols-visitante" style="display:inline-block">0</span>
          </span>
          <span class="tempo">00:00</span>
        </div>

        <div class="time-placar">
          <img src="assets/<?= $proximoJogo['clubeVisitante']['foto'] ?>" alt="" style="width: 60px; height: 60px; object-fit: contain;">
          <span class="nome-time"><?= $proximoJogo['clubeVisitante']['nomeClube'] ?></span>
        </div>
      </div>

      <div class="acontecimentos">
        <h2>Acontecimentos da partida</h2>
        <!-- Vazio: o JS cria as linhas conforme os minutos passam -->
        <div class="rolavel"></div>
      </div>

      <button class="btn-pular" type="button">Pular partida</button>

      <!-- "Próximo" salva a partida no banco e depois vai pra imprensa -->
      <a href="index.php?pag=partida&finalizar=1" class="link-proximo" hidden>
        <button class="btn-primario">Próximo</button>
      </a>

    </section>

  <?php elseif ($dataJogo): ?>

    <!-- ======== SEM JOGO HOJE: DIAS PASSANDO ======== -->

    <section class="box dias-passando" data-dias='<?= htmlspecialchars(json_encode($dias), ENT_QUOTES) ?>'>

      <p class="dias-rotulo">Sem jogo hoje</p>
      <h1 class="dia-atual">dia <?= $dias[0] ?></h1>

      <a href="index.php?pag=partida&avancar=1" class="link-avancar" hidden>
        <button class="btn-primario">Ir para o dia do jogo</button>
      </a>

    </section>

  <?php else: ?>

    <!-- ======== SEM PRÓXIMA PARTIDA ======== -->

    <section class="box">
      <h2>Nenhuma partida agendada</h2>
    </section>

  <?php endif; ?>

</main>

<script src="assets/js/animations/partida.js"></script>
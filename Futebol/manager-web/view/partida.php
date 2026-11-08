<link rel="stylesheet" href="assets/css/partida.css">

<?php

$estadoJogo = $_SESSION['estado_jogo'];
$idClubeJogador = $estadoJogo->clube->id;
$idLiga = (int)($estadoJogo->liga ?? 0);
$apiService = new ApiService();

// ================= CONFIG DA API =================
// Ajuste aqui se o método HTTP ou a URL forem diferentes no seu controller.
const API_BASE = 'http://localhost:8080';
const METODO_ESTATISTICA = 'PUT';
const METODO_CLASSIFICACAO = 'PUT';
const ROTA_PLACAR = '/partida/placar';

// ================= CHAMADAS À API =================

// Chamada genérica pro Spring Boot. Considera sucesso qualquer 2xx.
function chamarApi(string $metodo, string $rota, array $dados): bool {
  $ch = curl_init(API_BASE . $rota);
  curl_setopt_array($ch, [
    CURLOPT_CUSTOMREQUEST  => $metodo,
    CURLOPT_POSTFIELDS     => json_encode($dados),
    CURLOPT_HTTPHEADER     => ['Content-Type: application/json'],
    CURLOPT_RETURNTRANSFER => true,
  ]);
  curl_exec($ch);
  $status = curl_getinfo($ch, CURLINFO_HTTP_CODE);
  curl_close($ch);
  return $status >= 200 && $status < 300;
}

// Clicou em "Próximo": salva placar, estatísticas dos jogadores e pontos dos clubes.
// Cada envio bem-sucedido é anotado em "enviados". Se algo falhar no meio,
// ao tentar de novo só reenvia o que faltou (evita somar gols/pontos duas vezes).
if (isset($_GET['finalizar']) && isset($_SESSION['partida_pendente'])) {
  $pendente = $_SESSION['partida_pendente'];
  $pendente['enviados'] = $pendente['enviados'] ?? [];

  // sem isso, cartões vazios viram [] e o Spring dá erro 400
  $placar = $pendente['placar'];
  $placar['cartoes'] = (object) $placar['cartoes'];

  $envios = [['chave' => 'placar', 'metodo' => 'PUT', 'rota' => ROTA_PLACAR, 'dados' => $placar]];

  foreach ($pendente['estatisticas'] as $e) {
    $envios[] = ['chave' => $e['chave'], 'metodo' => METODO_ESTATISTICA, 'rota' => $e['rota'], 'dados' => $e['dados']];
  }
  foreach ($pendente['classificacao'] as $c) {
    $envios[] = ['chave' => $c['chave'], 'metodo' => METODO_CLASSIFICACAO, 'rota' => $c['rota'], 'dados' => $c['dados']];
  }

  $falhou = false;
  foreach ($envios as $envio) {
    if (in_array($envio['chave'], $pendente['enviados'], true)) continue;

    if (chamarApi($envio['metodo'], $envio['rota'], $envio['dados'])) {
      $pendente['enviados'][] = $envio['chave'];
    } else {
      $falhou = true;
      $_SESSION['partida_pendente'] = $pendente; // guarda o progresso
      echo "<p>Erro ao salvar ({$envio['chave']}). "
         . "<a href='index.php?pag=partida&finalizar=1'>Tentar de novo</a></p>";
      break;
    }
  }

  if (!$falhou) {
    $_SESSION['id_ultima_partida'] = $pendente['placar']['idPartida']; // usado na página da imprensa
    unset($_SESSION['partida_pendente']);
    echo "<script>location.replace('index.php?pag=imprensa')</script>";
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

  $linha     = array_slice($linha, 0, 10);
  $goleiroJ  = $goleiros[0] ?? null;
  $goleiro   = $goleiroJ['overall'] ?? 50;

  $ataque = media(array_map(
    fn($j) => $j['finalizacao'] * 0.4 + $j['passe'] * 0.3 + $j['velocidade'] * 0.3, $linha));

  $defesa = media(array_map(
    fn($j) => $j['marcacao'] * 0.4 + $j['forca'] * 0.3 + $j['inteligencia'] * 0.3, $linha));
  $defesa = $defesa * 0.7 + $goleiro * 0.3; // goleiro pesa 30% da defesa

  return ['ataque' => $ataque, 'defesa' => $defesa, 'linha' => $linha, 'goleiro' => $goleiroJ];
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

    // 75% dos gols têm assistência. Quem passa melhor tem mais chance. Nunca é o próprio autor.
    $assistente = null;
    if (mt_rand(1, 100) <= 75) {
      $candidatos = array_values(array_filter(
        $linha,
        fn($j) => (int)$j['idJogador'] !== (int)$autor['idJogador']
      ));
      if ($candidatos) {
        $assistente = sortearJogador($candidatos, fn($j) => $j['passe'] ** 2);
      }
    }

    $eventos[] = [
      'minuto' => mt_rand(1, 90), 'tipo' => 'gol', 'lado' => $lado,
      'jogador' => $autor['nomeJogador'], 'idJogador' => $autor['idJogador'],
      'assistente'   => $assistente['nomeJogador'] ?? null,
      'idAssistente' => $assistente['idJogador'] ?? null,
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

// Monta o request de estatística de cada jogador que entrou em campo (goleiro + 10 de linha).
// Cada chamada soma 1 jogo no banco, então todo titular recebe uma, mesmo sem gol.
function montarEstatisticas(array $time, array $eventos, string $lado, int $golsPro, int $golsContra, int $ano, int $idLiga): array {
  $saida = [];
  $goleiroId = $time['goleiro'] ? (int)$time['goleiro']['idJogador'] : null;
  $escalados = array_filter(array_merge([$time['goleiro']], $time['linha']));

  foreach ($escalados as $j) {
    $id = (int)$j['idJogador'];
    $gols = $assist = $amarelos = $vermelhos = 0;

    foreach ($eventos as $e) {
      if ($e['lado'] !== $lado) continue;
      if ($e['tipo'] === 'gol') {
        if ((int)$e['idJogador'] === $id) $gols++;
        if ($e['idAssistente'] !== null && (int)$e['idAssistente'] === $id) $assist++;
      } elseif ($e['tipo'] === 'amarelo' && (int)$e['idJogador'] === $id) {
        $amarelos++;
      } elseif ($e['tipo'] === 'vermelho' && (int)$e['idJogador'] === $id) {
        $vermelhos++;
      }
    }

    // Nota da partida (3.0 a 10.0): resultado, gols, assistências, cartões, defesa e um pouco de sorte
    $ehGoleiro = $id === $goleiroId;
    $nota = 6.0;
    $nota += $golsPro > $golsContra ? 0.5 : ($golsPro < $golsContra ? -0.3 : 0.0);
    $nota += $gols * 1.0 + $assist * 0.6 - $amarelos * 0.3 - $vermelhos * 1.5;
    if ($golsContra === 0) {
      $nota += $ehGoleiro ? 0.8 : 0.3;
    } else {
      $nota -= min($golsContra, 4) * ($ehGoleiro ? 0.3 : 0.1);
    }
    $nota += (mt_rand() / mt_getrandmax() - 0.5) * 1.6;
    $nota = round(max(3.0, min(10.0, $nota)), 1);

    $saida[] = [
      'chave' => "stat:$id",
      'rota'  => "/jogador/$id/competicao/$idLiga/estatistica",
      'dados' => [
        'idJogador'    => $id,
        'idCompeticao' => $idLiga,
        'ano'          => $ano,
        'gols'         => $gols,
        'assistencias' => $assist,
        'notaPartida'  => $nota,
      ],
    ];
  }

  return $saida;
}

$eventos = [];

if ($ehDiaDeJogo) {
  $idMandante  = (int)$proximoJogo['clubeMandante']['id'];
  $idVisitante = (int)$proximoJogo['clubeVisitante']['id'];

  $jogadoresMandante  = $apiService->get("/jogadores/clube/{$idMandante}?todos=true");
  $jogadoresVisitante = $apiService->get("/jogadores/clube/{$idVisitante}?todos=true");

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

  // Estatísticas individuais (gols, assistências, nota) dos dois times
  $anoAtual = (int)$estadoJogo->dataAtual->format('Y');
  $estatisticas = [];
  if ($idLiga > 0) {
    $estatisticas = array_merge(
      montarEstatisticas($mandante,  $eventos, 'mandante',  $golsMandante,  $golsVisitante, $anoAtual, $idLiga),
      montarEstatisticas($visitante, $eventos, 'visitante', $golsVisitante, $golsMandante,  $anoAtual, $idLiga)
    );
  }

  // Pontos: vitória 3, empate 1, derrota 0
  $pontosMandante  = $golsMandante > $golsVisitante ? 3 : ($golsMandante === $golsVisitante ? 1 : 0);
  $pontosVisitante = $golsVisitante > $golsMandante ? 3 : ($golsMandante === $golsVisitante ? 1 : 0);

  $classificacao = [];
  if ($idLiga > 0) {
    $classificacao = [
      [
        'chave' => "pts:$idMandante",
        'rota'  => "/competicoes/$idMandante/classificao", // mesma grafia do seu endpoint
        'dados' => ['idClube' => $idMandante, 'idCompeticao' => $idLiga, 'pontosAdicionados' => $pontosMandante],
      ],
      [
        'chave' => "pts:$idVisitante",
        'rota'  => "/competicoes/$idVisitante/classificao",
        'dados' => ['idClube' => $idVisitante, 'idCompeticao' => $idLiga, 'pontosAdicionados' => $pontosVisitante],
      ],
    ];
  }

  // Guarda na sessão. Só vai pro banco quando o jogador clicar em "Próximo".
  $_SESSION['partida_pendente'] = [
    'placar' => [
      'idPartida'     => $proximoJogo['idPartida'],
      'golsMandante'  => $golsMandante,
      'golsVisitante' => $golsVisitante,
      'cartoes'       => $cartoes,
    ],
    'estatisticas'  => $estatisticas,
    'classificacao' => $classificacao,
    'enviados'      => [],
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

      <!-- "Próximo" salva tudo no banco e depois vai pra imprensa -->
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
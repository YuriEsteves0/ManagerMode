<link rel="stylesheet" href="assets/css/partida.css">

<?php

$estadoJogo = $_SESSION['estado_jogo'];
$idClubeJogador = $estadoJogo->clube->id;
$apiService = new ApiService();

$proximoJogo = $apiService->get("/partidas/clube/{$idClubeJogador}/proximaPartida?dataAtual={$estadoJogo->dataAtual->format('d/m/Y')}");

// A API devolve "2026-01-10" em dataPartida. Se não vier jogo (fim da temporada), fica null.
$dataJogo = $proximoJogo ? new DateTime($proximoJogo['dataPartida']) : null;

// Clicou em "Ir para o dia do jogo": pula a data atual direto para o dia da partida
if (isset($_GET['avancar']) && $dataJogo) {
  $estadoJogo->dataAtual = clone $dataJogo;
}

// Compara só a data (Y-m-d), ignorando hora
$ehDiaDeJogo = $dataJogo && $estadoJogo->dataAtual->format('Y-m-d') === $dataJogo->format('Y-m-d');

// Monta a lista de dias entre hoje e o jogo (só quando NÃO é dia de jogo)
$dias = [];
if ($dataJogo && !$ehDiaDeJogo) {
  $dia = (clone $estadoJogo->dataAtual)->setTime(0, 0);
  $fim = (clone $dataJogo)->setTime(0, 0);

  while ($dia <= $fim) {
    $dias[] = $dia->format('d');
    $dia->modify('+1 day');
  }
}

// EVENTOS DA PARTIDA (MOCK).
// tipo: 'gol' | 'amarelo' | 'vermelho'   lado: 'mandante' | 'visitante'
// TODO: quando o backend mandar os eventos, trocar por $proximoJogo['eventos'] ?? []
// O placar final é calculado a partir dos gols desta lista.
$eventos = [
  ['minuto' => 12, 'tipo' => 'gol',      'lado' => 'mandante',  'jogador' => 'P. Coutinho'],
  ['minuto' => 45, 'tipo' => 'gol',      'lado' => 'visitante', 'jogador' => 'R. Almeida'],
  ['minuto' => 63, 'tipo' => 'amarelo',  'lado' => 'mandante',  'jogador' => 'Hugo Moura'],
  ['minuto' => 78, 'tipo' => 'gol',      'lado' => 'mandante',  'jogador' => 'P. Coutinho'],
  ['minuto' => 82, 'tipo' => 'vermelho', 'lado' => 'mandante',  'jogador' => 'Hugo Moura'],
  ['minuto' => 89, 'tipo' => 'gol', 'lado' => 'visitante', 'jogador' => 'Loide Augusto'],
];

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

      <a href="index.php?pag=imprensa" class="link-proximo" hidden>
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
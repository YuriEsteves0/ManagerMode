<link rel="stylesheet" href="assets/css/imprensa.css">

<?php

$apiService = new ApiService();
$estado_jogo = $_SESSION['estado_jogo'];
$idClubeJogador = $estado_jogo->clube->id;


$idPartida = $_SESSION['id_ultima_partida'] ?? null;
$diaAntes = (clone $estado_jogo->dataAtual)->modify('-1 day')->format('d/m/Y');

$pergunta = null;

if ($idPartida) {
  // Só sorteia se ainda não sorteou pra ESSA partida
  if (!isset($_SESSION['pergunta_imprensa']) || $_SESSION['pergunta_imprensa_partida'] !== $idPartida) {
    $partida = $apiService->get("/partida/{$idPartida}");
    $statusPartida = "";

    $clubeAtualEOque = null;
    if ($partida['clubeVisitante']['id'] == $idClubeJogador) {
      $clubeAtualEOque = "VISITANTE";
    } else {
      $clubeAtualEOque = "MANDANTE";
    }

    if($clubeAtualEOque == "VISITANTE"){
      if($partida['golsVisitante'] > $partida['golsMandante']){
        $statusPartida = "VITORIA";
      }else if($partida['golsVisitante'] == $partida['golsMandante']){
        $statusPartida = "EMPATE";
      }else{
        $statusPartida = "DERROTA";
      }
    }else{
      if($partida['golsMandante'] > $partida['golsVisitante']){
        $statusPartida = "VITORIA";
      }else if($partida['golsMandante'] == $partida['golsVisitante']){
        $statusPartida = "EMPATE";
      }else{
        $statusPartida = "DERROTA";
      }
    }

    $_SESSION['pergunta_imprensa'] = $apiService->get("/perguntas?tipoResultado={$statusPartida}");
    $_SESSION['pergunta_imprensa_partida'] = $idPartida;
  }
  $pergunta = $_SESSION['pergunta_imprensa'];
}

?>

<section class="box">

  <div class="pergunta-reporter">
    <div class="avatar-reporter">JR</div>
    <p>
      <span class="rotulo">Repórter:</span>
      <span class="texto-pergunta"><?= $pergunta['tituloPergunta'] ?></span>
    </p>
  </div>

  <div class="opcoes-resposta">
    <div class="opcao-resposta">
      <input type="radio" name="resposta-imprensa" id="resposta-1" checked>
      <label for="resposta-1"><?= $pergunta['resposta1'] ?></label>
    </div>
    <div class="opcao-resposta">
      <input type="radio" name="resposta-imprensa" id="resposta-2">
      <label for="resposta-2"><?= $pergunta['resposta2'] ?></label>
    </div>
    <div class="opcao-resposta">
      <input type="radio" name="resposta-imprensa" id="resposta-3">
      <label for="resposta-3"><?= $pergunta['resposta3'] ?></label>
    </div>
  </div>

  <a href="index.php?pag=inicio&fim_imprensa=1">
    <button class="btn-primario">Próximo</button>
  </a>

</section>
<script src="assets/js/animations/imprensa.js"></script>
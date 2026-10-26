<link rel="stylesheet" href="assets/css/carreira.css">

<?php

$estadoJogo = $_SESSION['estado_jogo'];
$apiService = new ApiService();
$idTecnico = $estadoJogo->idManager;
$idClube = $estadoJogo->clube->id;

$propostaClubes = $apiService->get("/propostas-emprego/{$idTecnico}");
$manager = $apiService->get("/manager/{$idTecnico}");
$clube = $apiService->get("/clubes/{$idClube}");
$tituloConquistados = $apiService->get("/manager/{$idTecnico}/titulos");
$historicoClubes = $apiService->get("/manager/{$idTecnico}/historico");
?>

<main>
  <svg width="0" height="0" style="position:absolute">
    <defs>
      <symbol id="escudo-generico" viewBox="0 0 48 54">
        <path d="M24 2 L44 9 V25 C44 39 35 48 24 52 C13 48 4 39 4 25 V9 Z" />
      </symbol>
    </defs>
  </svg>

  <div class="pagina">
    <div>
      <h1 class="titulo">Carreira</h1>
      <p class="subtitulo">Gerencie sua trajetória, seu vínculo atual e as propostas recebidas.</p>
    </div>

    <div class="layout-carreira">
      <section class="box" id="box-tecnico">
        <h2>Ficha do técnico</h2>
        <div class="rolavel">

          <div class="perfil-tecnico">
            <img class="avatar-tecnico" src="assets/<?= $manager['foto'] ?>" style="width: 88px; height: 88px; object-fit:cover;" alt="">
            <div>
              <div class="nome"><?= $manager['nomeManager'] ?></div>
              <div class="clube-atual">
                <img src="assets/<?= $clube['foto'] ?>" class="escudo-mini">
                <?= $clube['nomeClube'] ?>
              </div>
              <div class="badges-perfil">
                <span class="tag nacionalidade"><?= $manager['nacionalidade'] ?></span>
                <span class="tag contrato">Contrato restante: <?= formatarMesesParaAnos($manager['contratoFim']) ?></span>
                <span class="tag reputacao"><?= $manager['reputacao'] ?></span>
              </div>
            </div>
          </div>

          <div>
            <h2>Títulos conquistados</h2>
            <div class="lista-titulos">
              <?php

              foreach ($tituloConquistados as $titulo) {
              ?>

                <div class="titulo-item">
                  <svg class="icone-troféu" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6">
                    <path d="M7 4h10v4a5 5 0 0 1-10 0V4Z" />
                    <path d="M7 5H4a3 3 0 0 0 3 4" />
                    <path d="M17 5h3a3 3 0 0 1-3 4" />
                    <path d="M12 13v3" />
                    <path d="M9 20h6" />
                    <path d="M10 16h4l1 4H9l1-4Z" />
                  </svg>
                  <span class="nome-titulo"><?= $titulo['nomeCompeticao'] ?></span>
                  <span class="qtd"><?= $titulo['ano'] ?></span>
                </div>

              <?php
              }

              ?>

            </div>
          </div>

          <div>
            <h2>Histórico dos últimos 5 clubes</h2>
            <div style="display:flex; flex-direction:column; gap:8px;">

              <?php
              foreach ($historicoClubes as $clube) {
                $clubeAtual = ($clube['nomeClube'] == $estadoJogo->clube->nomeClube) ? $clube['ano'] . " - Atual" : $clube['ano'];
              ?>

                <div class="historico-clube">
                  <img src="assets/<?= $clube['foto'] ?>" alt="" style="width: 22px !important; height: 22px !important; object-fit: contain;">
                  <span class="nome-clube-hist"><?= $clube['nomeClube'] ?></span>
                  <span class="periodo"><?= $clubeAtual ?></span>
                </div>

              <?php
              }

              ?>
            </div>
          </div>

          <div>
            <h2>Desempenho por temporada</h2>
            <table>
              <thead>
                <tr>
                  <th>Ano</th>
                  <th class="num">Jogos</th>
                  <th class="num">V</th>
                  <th class="num">E</th>
                  <th class="num">D</th>
                </tr>
              </thead>
              <tbody>
                <tr class="destaque">
                  <td class="destaque-coluna">a fazer</td>
                  <td class="num">a fazer</td>
                  <td class="num">a fazer</td>
                  <td class="num">a fazer</td>
                  <td class="num">a fazer</td>
                </tr>
                <!-- <tr>
                  <td>2025</td>
                  <td class="num">118</td>
                  <td class="num">65</td>
                  <td class="num">30</td>
                  <td class="num">23</td>
                </tr>
                <tr>
                  <td>2024</td>
                  <td class="num">96</td>
                  <td class="num">50</td>
                  <td class="num">26</td>
                  <td class="num">20</td>
                </tr>
                <tr>
                  <td>2023</td>
                  <td class="num">88</td>
                  <td class="num">44</td>
                  <td class="num">25</td>
                  <td class="num">19</td>
                </tr> -->
              </tbody>
            </table>
          </div>

        </div>
      </section>

      <!-- ===================== CAIXA DIREITA — MERCADO/PROPOSTAS ===================== -->
      <section class="box" id="box-mercado">
        <h2>Mercado de trabalho</h2>
        <div class="rolavel">

          <div class="bloco-demissao">
            <button class="btn-secundario perigo">Pedir demissão do clube atual</button>
          </div>

          <div style="display:flex; flex-direction:column; gap:10px;">
            <?php

            foreach ($propostaClubes as $clube) {
            ?>

              <div class="item-linha proposta">
                <img src="assets/<?= $clube['clube']['foto'] ?>" alt="" style="width: 40px !important; height: 40px !important;">
                <div class="dados-clube">
                  <span class="nome-clube"><?= $clube['clube']['nomeClube'] ?></span>
                  <span class="liga-clube">Reputação: <?= $clube['clube']['reputacao'] ?>/100</span>
                </div>
                <div class="salario">R$ <?= formatarNumero($clube['salarioOferecido']) ?><span>por mês</span></div>
                <button class="btn-primario pequeno">Aceitar</button>
              </div>

            <?php

            }

            ?>


          </div>

        </div>
      </section>

    </div>
  </div>

</main>

<script src="assets/js/animations/carreira.js"></script>
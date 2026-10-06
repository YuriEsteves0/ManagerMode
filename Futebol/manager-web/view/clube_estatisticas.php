<link rel="stylesheet" href="assets/css/clube_estatisticas.css">

<?php

$clube = $_SESSION['estado_jogo'] ?? null;
$apiService = new ApiService();

$clubeAPI = $apiService->get("/clubes/{$clube->clube->id}");
$ligaInfo = $apiService->get("/competicoes/{$clube->liga}");

// 1. Bilheteria (2.5 jogos por mês em casa, 70% de público médio, ingresso R$ 50)
$capacidadeEstadio = $clubeAPI['capacidadeEstadio'] ?? 0;
$bilheteriaMensal = ($capacidadeEstadio * 0.70) * 50 * 2.5;

// 2. Venda de Camisas (Dividido por 12 meses, lucro líquido de R$ 40 por peça)
$camisasVendidas = $clubeAPI['camisasVendidas'] ?? 0;
$receitaCamisasMensal = ($camisasVendidas / 12) * 40;

// 3. Sócio-Torcedor (0.5% dos torcedores como sócios pagando R$ 40/mês)
$qntTorcedores = $clubeAPI['qntTorcedores'] ?? 0;
$receitaSociosMensal = ($qntTorcedores * 0.005) * 40;

// 4. Mídia/Patrocínio base (15% do orçamento total dividido em 12 meses)
$orcamento = $clubeAPI['orcamento'] ?? 0;
$receitaMidiaPatrocinio = ($orcamento * 0.15) / 12;

$receitaMensalTotal = $bilheteriaMensal + $receitaCamisasMensal + $receitaSociosMensal + $receitaMidiaPatrocinio;

// $patrocinador = ($clubeAPI['nomePatrocinador'] != null) ? $clubeAPI['nomePatrocinador'] : "Sem patrocínio";
$patrocinadorAPI = $apiService->get("/clubes/{$clube->clube->id}/patrocinador");
$patrocinador = $patrocinadorAPI['nomePatrocinador'] ?? 'Sem patrocínio';

$ultimasTempEstatistica = $apiService->get("/clubes/{$clube->clube->id}/estatisticasAno");

$upgradesClube = $apiService->get("/clubes/{$clube->clube->id}/upgrades") ?? [];

?>

<main>

    <h1 class="titulo">Estatísticas do Clube</h1>

    <div class="layout">

        <section class="box">
            <div class="clube-cabecalho">
                <img src="assets/<?= htmlspecialchars($clubeAPI['foto'] ?? '') ?>" alt="" style="width: 54px; height: 54px; object-fit: contain;">

                <div>
                    <strong><?= htmlspecialchars($clubeAPI['nomeClube'] ?? '') ?></strong><br>
                    <span><?= htmlspecialchars($ligaInfo['nomeCompeticao'] ?? '') ?></span>
                </div>
            </div>

            <div class="stats-grid">
                <div class="stat-item"><span>Valor do clube</span><strong>R$ <?= formatarNumero($clubeAPI['valorClube']) ?></strong></div>
                <div class="stat-item"><span>Torcedores</span><strong><?= formatarNumero($clubeAPI['qntTorcedores']) ?></strong></div>
                <div class="stat-item"><span>Reputação</span><strong><?= $clubeAPI['reputacao'] ?> / 100</strong></div>
                <div class="stat-item"><span>Orçamento</span><strong>R$ <?= formatarNumero($clubeAPI['orcamento']) ?></strong></div>

                <div class="stat-item"><span>Receita mensal</span><strong>R$ <?= formatarNumero($receitaMensalTotal) ?></strong></div>

                <div class="stat-item"><span>Patrocinador</span><strong><?= $patrocinador ?></strong></div>
            </div>

            <h2>Últimas Temporadas</h2>
            <table class="historico">
                <thead>
                    <tr>
                        <th>Ano</th>
                        <th>J</th>
                        <th>V</th>
                        <th>E</th>
                        <th>D</th>
                        <th>GF</th>
                        <th>GS</th>
                    </tr>
                </thead>
                <tbody>
                    <?php

                    foreach ($ultimasTempEstatistica as $temporada) {
                    ?>
                        <tr>
                            <td class="ano"><?= $temporada['ano'] ?></td>
                            <td><?= $temporada['jogos'] ?></td>
                            <td><?= $temporada['vitorias'] ?></td>
                            <td><?= $temporada['empates'] ?></td>
                            <td><?= $temporada['derrotas'] ?></td>
                            <td><?= $temporada['golsFeitos'] ?></td>
                            <td><?= $temporada['golsSofridos'] ?></td>
                        </tr>

                    <?php
                    }

                    ?>
                </tbody>
            </table>
        </section>

        <section class="box">
            <h2>Melhorias do Clube</h2>
            <div class="upgrades">

                <?php foreach ($upgradesClube as $up):
                    $nivelAtual  = (int) $up['nivelAtual'];
                    $nivelMaximo = (int) $up['nivelMaximo'];
                    $noMaximo    = $nivelAtual >= $nivelMaximo;

                    $bonusAtual  = round($up['modificador'] * $nivelAtual * 100);
                    $bonusProx   = round($up['modificador'] * ($nivelAtual + 1) * 100);
                    $custoProx   = $up['preco'] * ($nivelAtual + 1);
                    $semDinheiro = $orcamento < $custoProx;
                    $percentual  = $nivelMaximo > 0 ? ($nivelAtual / $nivelMaximo) * 100 : 0;
                ?>
                    <div class="upgrade">
                        <div class="upgrade-topo">
                            <strong><?= htmlspecialchars($up['nomeUpgrade']) ?></strong>
                            <div class="nivel">
                                <span>Nível <?= $nivelAtual ?>/<?= $nivelMaximo ?></span>
                                <div class="barra">
                                    <div class="barra-preenchida" style="width: <?= $percentual ?>%"></div>
                                </div>
                            </div>
                        </div>

                        <p class="efeito"><?= htmlspecialchars($up['descricao']) ?></p>
                        <p class="efeito">Bônus atual: <strong>+<?= $bonusAtual ?>%</strong></p>

                        <?php if ($noMaximo): ?>
                            <p class="proximo">Nível máximo atingido</p>
                        <?php else: ?>
                            <p class="proximo">Próximo nível: +<?= $bonusProx ?>%</p>
                        <?php endif; ?>

                        <div class="upgrade-rodape">
                            <span class="preco">
                                <?= $noMaximo ? '—' : 'R$ ' . formatarNumero((int) $custoProx) ?>
                            </span>
                            <button class="btn-melhorar"
                                data-upgrade-id="<?= (int) $up['idUpgrade'] ?>"
                                <?= ($noMaximo || $semDinheiro) ? 'disabled' : '' ?>>
                                <?= $noMaximo ? 'Máximo' : 'Melhorar' ?>
                            </button>
                        </div>
                    </div>
                <?php endforeach; ?>

            </div>
        </section>

    </div>

</main>
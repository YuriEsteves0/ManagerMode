<link rel="stylesheet" href="assets/css/inicio.css">

<?php
$idLiga = $_SESSION['carreira']['liga'] ?? "";
$apiService = new ApiService();

$idClubeJogador = $_SESSION['carreira']['clube']['id'] ?? "";
$classificacao = $apiService->getClassificacaoProxima($idLiga, $idClubeJogador);

$indiceJogador = 0;
foreach ($classificacao as $i => $c) {
    if ($c['clube_idClube'] == $idClubeJogador) {
        $indiceJogador = $i;
        break;
    }
}

$tamanhoJanela = 5;
$inicio = max(0, min($indiceJogador - 2, count($classificacao) - $tamanhoJanela));
$tabelaReduzida = array_slice($classificacao, $inicio, $tamanhoJanela, true);

$jogadores = $apiService->get("/jogadores/clube/{$idClubeJogador}");

?>

<main>
    <div class="grid">

        <section class="box" id="box-elenco">
            <h2>Elenco</h2>
            <div class="jogadores">
                <?php foreach ($jogadores as $j): ?>
                    <div class="jogador">
                        <div class="bolinha"><?= (int)$j['numeroCamisa'] ?></div>
                        <span><?= htmlspecialchars($j['nomeJogador']) ?></span>
                    </div>
                <?php endforeach; ?>
            </div>
        </section>

        <section class="box" id="box-jogos">
            <h2>Próximos Jogos</h2>
            <div class="jogos-lista">
                <div class="jogo-item"><strong>Rodada 14 — vs Palmeiras</strong><span>Fora • 12/10, 16h</span></div>
                <div class="jogo-item"><strong>Rodada 15 — vs Fluminense</strong><span>Casa • 19/10, 20h</span></div>
                <div class="jogo-item"><strong>Copa do Brasil — vs Grêmio</strong><span>Casa • 23/10, 21h30</span></div>
                <div class="jogo-item"><strong>Rodada 16 — vs São Paulo</strong><span>Fora • 26/10, 18h30</span></div>
            </div>
        </section>

        <section class="box" id="box-artilharia">
            <h2>Artilharia</h2>
            <ul class="lista-num">
                <li><span class="nome">Pedro</span><span class="valor">14 gols</span></li>
                <li><span class="nome">Rayan</span><span class="valor">10 gols</span></li>
                <li><span class="nome">Luiz Araújo</span><span class="valor">8 gols</span></li>
                <li><span class="nome">Estevão</span><span class="valor">6 gols</span></li>
                <li><span class="nome">Gerson</span><span class="valor">5 gols</span></li>
            </ul>
        </section>

        <section class="box" id="box-tabela">
            <h2>Tabela</h2>
            <table>
                <thead>
                    <tr>
                        <th>Pos</th>
                        <th>Time</th>
                        <th class="num">P</th>
                        <th class="num">J</th>
                        <th class="num">V</th>
                        <th class="num">SG</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($tabelaReduzida as $i => $clube):
                        $ehJogador = $clube['clube_idClube'] == $idClubeJogador;
                    ?>
                        <tr class="<?= $ehJogador ? 'destaque' : '' ?>">
                            <td class="pos"><?= $i + 1 ?>º</td>
                            <td><?= htmlspecialchars($clube['nomeClube'] ?? 'Clube ' . $clube['clube_idClube']) ?></td>
                            <td class="num"><?= $clube['pontos'] ?></td>
                            <td class="num">0</td>
                            <td class="num">0</td>
                            <td class="num">0</td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </section>

        <section class="box" id="box-transf">
            <h2>Transferências <span class="tag-janela aberta">Janela aberta</span></h2>
            <ul class="noticias">
                <li><strong>BOMBA!</strong> Chelsea demonstra interesse em Rayan (Seu Clube)</li>
                <li><strong>OFICIAL!</strong> Vasco da Gama contrata lateral Léo Ortiz</li>
                <li><strong>SONDAGEM!</strong> Al-Hilal pergunta valores por Pedro (Seu Clube)</li>
                <li><strong>NEGOCIAÇÃO!</strong> Fluminense reforça proposta por Gerson</li>
                <li><strong>NOVIDADE!</strong> Corinthians observa Estevão para 2027</li>
            </ul>
        </section>

        <section class="box" id="box-imprensa">
            <h2>Imprensa</h2>
            <ul class="noticias imprensa-lista">
                <li><strong>Diretoria aprova</strong> orçamento extra para a base de treinamento</li>
                <li><strong>Torcida elogia</strong> atuação do time na última rodada</li>
                <li><strong>Técnico é elogiado</strong> pela imprensa após sequência invicta</li>
                <li><strong>Clube anuncia</strong> nova parceria de patrocínio master</li>
                <li><strong>Ídolo do clube</strong> comenta sobre o momento da equipe</li>
            </ul>
        </section>

    </div>
</main>
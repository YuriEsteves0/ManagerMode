<link rel="stylesheet" href="assets/css/inicio.css">

<?php
$estado = $_SESSION['estado_jogo'] ?? null;

$idLiga         = (int)($estado->liga ?? 0);
$idClubeJogador = (int)($estado->clube->id ?? 0);

$apiService     = new ApiService();
$classificacao  = [];
$jogadores      = [];
$imprensas      = [];
$transferencias = [];

if ($idLiga > 0 && $idClubeJogador > 0) {
    $classificacao = $apiService->getClassificacaoProxima($idLiga, $idClubeJogador, 5);

    $jogadores      = $apiService->get("/jogadores/clube/{$idClubeJogador}") ?? [];
    $imprensas      = $apiService->get("/noticias", ["categoria" => "IMPRENSA", "idClube" => $idClubeJogador]) ?? [];
    $transferencias = $apiService->get("/noticias", ["categoria" => "MERCADO"]) ?? [];
}

function formatarTitulo(string $titulo, int $qtdDestaque, int $limite = 10): array
{
    $palavras = explode(' ', trim($titulo));
    $cortado  = count($palavras) > $limite;

    if ($cortado) {
        $palavras = array_slice($palavras, 0, $limite);
    }

    $destaque = array_splice($palavras, 0, $qtdDestaque);
    $resto    = $palavras ? ' ' . implode(' ', $palavras) : '';

    if ($cortado) {
        $resto .= '...';
    }

    return [
        htmlspecialchars(implode(' ', $destaque)),
        htmlspecialchars($resto),
    ];
}
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
                    <?php foreach ($classificacao as $i => $clube):
                        $ehJogador = (int)$clube['clube_idClube'] === $idClubeJogador;
                    ?>
                        <tr class="<?= $ehJogador ? 'destaque' : '' ?>">
                            <td class="pos"><?= $i + 1 ?>º</td>
                            <td><?= htmlspecialchars($clube['nomeClube'] ?? 'Clube ' . $clube['clube_idClube']) ?></td>
                            <td class="num"><?= (int)$clube['pontos'] ?></td>
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
                <?php foreach ($transferencias as $n):
                    [$destaque, $resto] = formatarTitulo($n['titulo'] ?? '', 1);
                ?>
                    <li><strong><?= $destaque ?></strong><?= $resto ?></li>
                <?php endforeach; ?>
            </ul>
        </section>

        <section class="box" id="box-imprensa">
            <h2>Imprensa</h2>
            <ul class="noticias imprensa-lista">
                <?php foreach ($imprensas as $n):
                    [$destaque, $resto] = formatarTitulo($n['titulo'] ?? '', 2);
                ?>
                    <li><strong><?= $destaque ?></strong><?= $resto ?></li>
                <?php endforeach; ?>
            </ul>
        </section>

    </div>
</main>
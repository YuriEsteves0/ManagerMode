<link rel="stylesheet" href="assets/css/inicio.css">

<?php
$estado = $_SESSION['estado_jogo'] ?? null;

$idLiga          = (int)($estado->liga ?? 0);
$idClubeJogador  = (int)($estado->clube->id ?? 0);

$apiService      = new ApiService();
$classificacao   = [];
$jogadores       = [];
$imprensas       = [];
$transferencias  = [];
$partidasFuturas = [];


if ($idLiga > 0 && $idClubeJogador > 0) {
    $classificacao = $apiService->getClassificacaoProxima($idLiga, $idClubeJogador, 5);

    $jogadores                = $apiService->get("/jogadores/clube/{$idClubeJogador}?todos=false") ?? [];
    $imprensas                = $apiService->get("/noticias", ["categoria" => "IMPRENSA", "idClube" => $idClubeJogador]) ?? [];
    $transferencias           = $apiService->get("/noticias", ["categoria" => "MERCADO"]) ?? [];
    $dataPartidaFormatada = $estado->dataInicio ? $estado->dataInicio->format('Y-m-d') : null;

    $partidasFuturas = $apiService->get("/partidas/clube/{$idClubeJogador}/proximosJogos", ["dataPartida" => $dataPartidaFormatada]) ?? [];

    $estatistica = $apiService->get("/jogador/competicao/{$idLiga}/estatistica");
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
                <?php foreach ($partidasFuturas as $jogo):
                    $ehMandante = (int)$jogo['mandanteIdClube'] === $idClubeJogador;
                    $adversario = $ehMandante ? $jogo['nomeVisitante'] : $jogo['nomeMandante'];
                    $mando      = $ehMandante ? 'Casa' : 'Fora';
                    $data       = (new DateTime($jogo['dataPartida']))->format('d/m');
                    $hora       = substr($jogo['horario'], 0, 2) . 'h';
                ?>
                    <div class="jogo-item">
                        <strong>Rodada <?= (int)$jogo['rodada'] ?> — vs <?= htmlspecialchars($adversario) ?></strong>
                        <span><?= $mando ?> • <?= $data ?>, <?= $hora ?></span>
                    </div>
                <?php endforeach; ?>
            </div>
        </section>

        <section class="box" id="box-artilharia">
            <h2>Artilharia</h2>
            <ul class="lista-num">
                <?php

                foreach ($estatistica as $jogadorEstatistica) {
                ?>
                    <li><span class="nome"><?= $jogadorEstatistica['nomeJogador'] ?></span><span class="valor"><?= $jogadorEstatistica['gols'] ?> gols</span></li>
                <?php
                }

                ?>
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
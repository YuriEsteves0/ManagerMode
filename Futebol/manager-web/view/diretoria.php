<link rel="stylesheet" href="assets/css/diretoria.css">

<?php
$estadoJogo = $_SESSION['estado_jogo'];
$apiService = new ApiService();
$idClube = $estadoJogo->clube->id;
$dadosClube = $apiService->get("/clubes/{$idClube}");

$confianca = (int)($dadosClube['confiancaDiretoria'] ?? 0);
$confianca = max(0, min(100, $confianca));

function h($v)
{
    return htmlspecialchars((string)$v, ENT_QUOTES, 'UTF-8');
}

$textosStatus = [
    'ESTAVEL'  => 'Confiança estável',
    'ALTA'     => 'Confiança alta',
    'BAIXA'    => 'Confiança baixa',
    'CRITICA'  => 'Confiança crítica',
];

$statusConfianca = $dadosClube['statusConfianca'] ?? '';
$textoConfianca = $textosStatus[$statusConfianca] ?? ucfirst(strtolower(str_replace('_', ' ', $statusConfianca)));

$metasDaTemporada = $apiService->get("/clubes/{$idClube}/metaTemporada");

$noticiasDiretoria = $apiService->get("/clubes/{$idClube}/noticiasDiretoria");

$acoesDiretoria = $apiService->get("/clubes/{$idClube}/acaoDiretoria");

function extrairConfiancaMinima($requisito)
{
    if (preg_match('/(\d+)\s*%/', (string)$requisito, $m)) {
        return (int)$m[1];
    }
    return 0; // sem exigência
}


?>

<main>

    <h1 class="titulo">Diretoria</h1>

    <div class="layout">

        <div class="coluna-esquerda">

            <section class="box">
                <div class="clube-cabecalho">
                    <img src="assets/<?= $dadosClube['foto'] ?>" alt="" style="width: 40px; height: 48px;">
                    <div><strong><?= $dadosClube['nomeClube'] ?></strong><span>Brasileirão Série A</span></div>
                </div>

                <div class="orcamento-linha"><span>Orçamento disponível</span><span>R$ <?= formatarNumero($dadosClube['orcamento']) ?></span></div>

                <div class="confianca-bloco">
                    <div class="confianca-topo"><strong><?= $confianca ?>%</strong><span><?= h($textoConfianca) ?></span></div>
                    <div class="confianca-barra"><i style="width:<?= $confianca ?>%"></i></div>
                </div>

                <span class="evento-atual">● Boa gestão</span>

                <div>
                    <h2>Metas da Temporada</h2>
                    <ul class="metas" style="margin-top:6px;">
                        <?php

                        foreach ($metasDaTemporada as $meta) {
                            $status = "";

                            switch ($meta['status']) {
                                case "DENTRO_DO_ESPERADO":
                                    $status = "<strong>DENTRO DO ESPERADO</strong>";
                                    break;
                                case "ABAIXO_DO_ESPERADO":
                                    $status = "<strong>ABAIXO DO ESPERADO</strong>";
                                    break;
                                case "FALHOU":
                                    $status = "<strong>FALHOU</strong>";
                                    break;
                                case "CONCLUIDO":
                                    $status = "<strong>CONCLUIDO</strong>";
                                    break;
                            }
                        ?>

                            <li><?= $meta['metaTemporada']['descricao'] ?> - <?= $status ?></li>

                        <?php
                        }

                        ?>
                    </ul>
                </div>
            </section>

            <section class="box">
                <h2>Recados da Diretoria</h2>
                <div class="recados">
                    <?php

                    if (count($noticiasDiretoria) == 0) {
                    ?>
                        <div><span style="font-size: 15px; color: var(--roxoTextoMaisClaro);">Não há noticias no momento!</span></div>

                        <?php
                    } else {


                        foreach ($noticiasDiretoria as $noticia) {
                            $tipoModificador = ($noticia['tipoModificador'] == "SOMA") ? "+" : "-";
                            $classModificador = ($noticia['tipoModificador'] == "SOMA") ? "pos" : "neg";
                        ?>
                            <div class="recado"><span class="delta <?= $classModificador ?>"><?= $tipoModificador . $noticia['modificador'] ?>%</span><span><?= $noticia['texto'] ?></span></div>
                    <?php
                        }
                    }
                    ?>
                </div>
            </section>

        </div>

        <div class="coluna-direita">
            <section class="box">
    <h2>Ações de Carreira</h2>
    <div class="acoes-lista rolavel">

        <?php if (empty($acoesDiretoria)) { ?>
            <div><span style="font-size: 15px; color: var(--roxoTextoMaisClaro);">Não há ações disponíveis no momento!</span></div>
        <?php } else {
            foreach ($acoesDiretoria as $item) {
                $acao = $item['acaoDiretoria'];
                $confiancaMinima = extrairConfiancaMinima($acao['requisito']);
                $statusAcao = $item['statusAcao'];

                // Define o estado visual e o texto do botão
                if ($statusAcao === 'EM_ANALISE') {
                    $classeStatus = 'analise';
                    $textoStatus  = 'Em Análise';
                    $textoBotao   = 'Aguardando resposta';
                    $desabilitado = true;
                } elseif ($statusAcao === 'CONCLUIDO') {
                    $classeStatus = 'bloqueado';
                    $textoStatus  = 'Concluído';
                    $textoBotao   = 'Já utilizada';
                    $desabilitado = true;
                } elseif ($confianca <= $confiancaMinima && $confiancaMinima > 0) {
                    // DISPONIVEL no banco, mas confiança insuficiente
                    $classeStatus = 'bloqueado';
                    $textoStatus  = 'Bloqueado';
                    $textoBotao   = 'Solicitar à Diretoria';
                    $desabilitado = true;
                } else {
                    $classeStatus = 'disponivel';
                    $textoStatus  = 'Disponível';
                    $textoBotao   = 'Solicitar à Diretoria';
                    $desabilitado = false;
                }
        ?>
                <div class="acao-item">
                    <div class="acao-topo">
                        <strong><?= h($acao['titulo']) ?></strong>
                        <span class="status-tag <?= $classeStatus ?>"><?= $textoStatus ?></span>
                    </div>
                    <p><?= h($acao['requisito']) ?></p>
                    <p>Efeito: <strong><?= h($acao['efeito']) ?></strong></p>
                    <div class="acao-rodape">
                        <button class="btn-acao"
                                data-id-acao="<?= (int)$acao['idAcaoDiretoria'] ?>"
                                <?= $desabilitado ? 'disabled' : '' ?>>
                            <?= $textoBotao ?>
                        </button>
                    </div>
                </div>
        <?php
            }
        } ?>

    </div>
</section>
        </div>

    </div>

</main>

<script src="assets/js/animations/diretoria.js"></script>
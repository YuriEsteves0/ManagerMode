<?php
$estadoJogo = $_SESSION['estado_jogo'];
$apiService = new ApiService();
$idClube    = $estadoJogo->clube->id;

if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_SERVER['HTTP_X_TROCA_ESCALACAO'] ?? '') === '1') {
    $dados   = json_decode(file_get_contents('php://input'), true);
    $idA     = filter_var($dados['a']['id'] ?? null, FILTER_VALIDATE_INT);
    $idB     = filter_var($dados['b']['id'] ?? null, FILTER_VALIDATE_INT);
    $novoA   = $dados['a']['titular'] ?? null;
    $novoB   = $dados['b']['titular'] ?? null;
    $validos = [0, 1, 2];

    $ok     = false;
    $codigo = 400;

    if ($idA && $idB && $idA !== $idB && in_array($novoA, $validos, true) && in_array($novoB, $validos, true)) {
        $resA = $apiService->put("/jogador/{$idA}", ['titular' => $novoA]);

        if ($resA === null) {
            $codigo = 502;
        } else {
            $resB = $apiService->put("/jogador/{$idB}", ['titular' => $novoB]);

            if ($resB === null) {
                $apiService->put("/jogador/{$idA}", ['titular' => $novoB]);
                $codigo = 502;
            } else {
                $ok     = true;
                $codigo = 200;
            }
        }
    }

    while (ob_get_level() > 0) {
        ob_end_clean();
    }
    if (!headers_sent()) {
        header('Content-Type: application/json');
        http_response_code($codigo);
    }
    echo json_encode(['ok' => $ok]);
    exit;
}

$jogadores = $apiService->get("/jogadores/clube/{$idClube}?todos=true") ?? [];

if (!function_exists('h')) {
    function h($v)
    {
        return htmlspecialchars((string)$v, ENT_QUOTES, 'UTF-8');
    }
}

const ESCALACAO_TITULAR         = 0;
const ESCALACAO_RESERVA         = 1;
const ESCALACAO_NAO_RELACIONADO = 2;

$nomesPosicao = [
    'GOL' => 'Goleiro', 'ZAG' => 'Zagueiro', 'LD' => 'Lateral', 'LE' => 'Lateral',
    'VOL' => 'Volante', 'MC'  => 'Meia',     'PD' => 'Ponta',   'PE' => 'Ponta',
    'ATA' => 'Atacante',
];

function nomeCurto($nome)
{
    $nome = trim((string)$nome);
    if (mb_strlen($nome) <= 12) {
        return $nome;
    }
    $partes = explode(' ', $nome);
    return mb_substr($partes[0], 0, 1) . '. ' . end($partes);
}

$titulares = $reservas = $naoRelacionados = [];
foreach ($jogadores as $j) {
    switch ((int)$j['titular']) {
        case ESCALACAO_TITULAR:         $titulares[]       = $j; break;
        case ESCALACAO_RESERVA:         $reservas[]        = $j; break;
        case ESCALACAO_NAO_RELACIONADO: $naoRelacionados[] = $j; break;
    }
}

usort($reservas, fn($a, $b) => $b['overall'] <=> $a['overall']);
usort($naoRelacionados, fn($a, $b) => $b['overall'] <=> $a['overall']);

$linhas = [
    'GOL' => ['left' => 8,  'jogadores' => []],
    'DEF' => ['left' => 28, 'jogadores' => []],
    'MEI' => ['left' => 52, 'jogadores' => []],
    'ATA' => ['left' => 80, 'jogadores' => []],
];
$mapaLinha = [
    'GOL' => 'GOL',
    'ZAG' => 'DEF', 'LD' => 'DEF', 'LE' => 'DEF',
    'VOL' => 'MEI', 'MC' => 'MEI',
    'PE'  => 'ATA', 'PD' => 'ATA', 'ATA' => 'ATA',
];

foreach ($titulares as $j) {
    $linha = $mapaLinha[$j['posicaoPrincipal']] ?? 'MEI';
    $linhas[$linha]['jogadores'][] = $j;
}

$formacao = count($linhas['DEF']['jogadores']) . '-' .
            count($linhas['MEI']['jogadores']) . '-' .
            count($linhas['ATA']['jogadores']);

$qtdTitulares = count($titulares);
?>

<link rel="stylesheet" href="assets/css/clube_equipe.css">

<style>
    .selecionavel { cursor: pointer; }
    .item-jogador.selecionado { outline: 2px solid #f5c542; outline-offset: 2px; }
    .pos-jogador.selecionado .bolinha { outline: 3px solid #f5c542; outline-offset: 2px; }
    .trocando { opacity: .6; pointer-events: none; }
</style>

<main>

    <div class="topo">
        <div>
            <h1>Escalação</h1>
            <p>Clique em dois jogadores para trocá-los de lugar</p>
        </div>
        <div class="contador"><strong><?= $qtdTitulares ?>/11</strong> titulares definidos</div>
    </div>

    <?php if ($qtdTitulares !== 11) { ?>
        <p style="font-size:14px; color: var(--roxoTextoMaisClaro);">
            Atenção: a escalação precisa ter exatamente 11 titulares (atualmente <?= $qtdTitulares ?>).
        </p>
    <?php } ?>

    <div class="layout">

        <section class="box">
            <h2>Titulares <span class="qtd"><?= h($formacao) ?></span></h2>
            <div class="campo">
                <div class="area-gol esq"></div>
                <div class="area-gol dir"></div>

                <?php
                foreach ($linhas as $linha) {
                    $grupo = $linha['jogadores'];
                    usort($grupo, fn($a, $b) => $a['posicaoX'] <=> $b['posicaoX']);
                    $total = count($grupo);

                    foreach ($grupo as $i => $j) {
                        $top = round((($i + 1) / ($total + 1)) * 100, 1);
                ?>
                        <div class="pos-jogador selecionavel"
                             data-id="<?= (int)$j['idJogador'] ?>"
                             data-status="<?= ESCALACAO_TITULAR ?>"
                             style="left:<?= $linha['left'] ?>%; top:<?= $top ?>%;"
                             title="<?= h($j['nomeJogador']) ?> - <?= h($j['posicaoPrincipal']) ?> (<?= (int)$j['overall'] ?>)">
                            <div class="bolinha"><?= (int)$j['numeroCamisa'] ?></div>
                            <span><?= h(nomeCurto($j['nomeJogador'])) ?></span>
                        </div>
                <?php
                    }
                }
                ?>
            </div>
        </section>

        <div class="coluna-direita">

            <section class="box">
                <h2>Reservas <span class="qtd"><?= count($reservas) ?></span></h2>
                <div class="lista-jogadores">
                    <?php if (empty($reservas)) { ?>
                        <span style="font-size:15px; color: var(--roxoTextoMaisClaro);">Não há reservas.</span>
                    <?php } else {
                        foreach ($reservas as $j) { ?>
                            <div class="item-jogador selecionavel"
                                 data-id="<?= (int)$j['idJogador'] ?>"
                                 data-status="<?= ESCALACAO_RESERVA ?>">
                                <div class="bolinha-mini"><?= (int)$j['numeroCamisa'] ?></div>
                                <div class="info">
                                    <strong><?= h($j['nomeJogador']) ?></strong>
                                    <span><?= h($nomesPosicao[$j['posicaoPrincipal']] ?? $j['posicaoPrincipal']) ?> · OVR <?= (int)$j['overall'] ?></span>
                                </div>
                            </div>
                    <?php }
                    } ?>
                </div>
            </section>

            <section class="box nao-relacionados">
                <h2>Não Relacionados <span class="qtd"><?= count($naoRelacionados) ?></span></h2>
                <div class="lista-jogadores">
                    <?php if (empty($naoRelacionados)) { ?>
                        <span style="font-size:15px; color: var(--roxoTextoMaisClaro);">Nenhum jogador fora da lista.</span>
                    <?php } else {
                        foreach ($naoRelacionados as $j) { ?>
                            <div class="item-jogador selecionavel"
                                 data-id="<?= (int)$j['idJogador'] ?>"
                                 data-status="<?= ESCALACAO_NAO_RELACIONADO ?>">
                                <div class="bolinha-mini"><?= (int)$j['numeroCamisa'] ?></div>
                                <div class="info">
                                    <strong><?= h($j['nomeJogador']) ?></strong>
                                    <span><?= h($nomesPosicao[$j['posicaoPrincipal']] ?? $j['posicaoPrincipal']) ?> · OVR <?= (int)$j['overall'] ?></span>
                                </div>
                            </div>
                    <?php }
                    } ?>
                </div>
            </section>

        </div>
    </div>

</main>

<script>
    let primeiro = null;
    let ocupado = false;

    function limparSelecao() {
        if (primeiro) {
            primeiro.classList.remove('selecionado');
        }
        primeiro = null;
    }

    async function trocarJogadores(a, b) {
        ocupado = true;
        document.querySelector('main').classList.add('trocando');

        const corpo = {
            a: { id: parseInt(a.dataset.id), titular: parseInt(b.dataset.status) },
            b: { id: parseInt(b.dataset.id), titular: parseInt(a.dataset.status) }
        };

        try {
            const resposta = await fetch(window.location.href, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-Troca-Escalacao': '1'
                },
                body: JSON.stringify(corpo)
            });
            const texto = await resposta.text();
            const inicio = texto.lastIndexOf('{"ok"');
            const dados = JSON.parse(texto.slice(inicio));
            if (dados.ok) {
                location.reload();
                return;
            }
        } catch (e) {}

        alert('Não foi possível trocar os jogadores.');
        location.reload();
    }

    document.querySelectorAll('.selecionavel').forEach(function (el) {
        el.addEventListener('click', function () {
            if (ocupado) {
                return;
            }

            if (!primeiro) {
                primeiro = el;
                el.classList.add('selecionado');
                return;
            }

            if (primeiro === el) {
                limparSelecao();
                return;
            }

            const a = primeiro;
            limparSelecao();

            if (a.dataset.status === el.dataset.status) {
                return;
            }

            trocarJogadores(a, el);
        });
    });
</script>

<script src="assets/js/animations/clube_equipe.js"></script>
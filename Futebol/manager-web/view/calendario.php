<link rel="stylesheet" href="assets/css/calendario.css">

<?php
$estadoJogo = $_SESSION['estado_jogo'];
$apiService = new ApiService();
$idClube    = (int)$estadoJogo->clube->id;
$hoje       = $estadoJogo->dataAtual->format('Y-m-d');
$BASE_IMG = 'assets/';

/* ---------- 1. Busca e organiza os jogos ---------- */
$resposta = $apiService->get("/partidas/clube/{$idClube}/proximosJogosCalendario?dataPartida={$hoje}");
$jogos = json_decode(json_encode($resposta), true);
if (!is_array($jogos)) $jogos = [];

usort($jogos, fn($a, $b) => strcmp($a['dataPartida'] . $a['horario'], $b['dataPartida'] . $b['horario']));

/* ---------- 2. Jogo de hoje; se não tiver, o próximo ---------- */
$jogo = null;
$ehHoje = false;
foreach ($jogos as $j) {
    if ($j['dataPartida'] === $hoje) { $jogo = $j; $ehHoje = true; break; }
}
if (!$jogo) {
    foreach ($jogos as $j) {
        if ($j['dataPartida'] > $hoje) { $jogo = $j; break; }
    }
}

/* ---------- 3. Funções de apoio ---------- */
function sigla(string $nome): string {
    return mb_strtoupper(mb_substr(preg_replace('/\s+/', '', $nome), 0, 3));
}

function escudo(array $clube, bool $meu, string $classe, string $base): string {
    $cor   = $meu ? ['--verdeBrilho', '--verde'] : ['--roxoBrilho', '--roxoTexto'];
    $sigla = htmlspecialchars(sigla($clube['nomeClube']));
    $svg = '<svg class="' . $classe . '" style="display:none" viewBox="0 0 64 72" xmlns="http://www.w3.org/2000/svg">'
         . '<path d="M32 2 L60 12 V34 C60 52 48 64 32 70 C16 64 4 52 4 34 V12 Z" fill="var(' . $cor[0] . ')" stroke="var(' . $cor[1] . ')" stroke-width="2.5"/>'
         . '<text x="32" y="42" text-anchor="middle" font-family="Inter, sans-serif" font-weight="800" font-size="16" fill="var(--branco)">' . $sigla . '</text></svg>';

    if (empty($clube['foto'])) {
        return str_replace('display:none', 'display:block', $svg);
    }
    $src = htmlspecialchars($base . $clube['foto']);
    $alt = htmlspecialchars($clube['nomeClube']);
    return '<img class="' . $classe . '" src="' . $src . '" alt="Escudo do ' . $alt . '" '
         . 'onerror="this.style.display=\'none\';this.nextElementSibling.style.display=\'block\'">' . $svg;
}

function diaSemana(DateTime $d): string {
    return ['domingo','segunda-feira','terça-feira','quarta-feira','quinta-feira','sexta-feira','sábado'][(int)$d->format('w')];
}
function nomeMes(DateTime $d): string {
    return ['janeiro','fevereiro','março','abril','maio','junho','julho','agosto','setembro','outubro','novembro','dezembro'][(int)$d->format('n') - 1];
}
function horaHumana(string $h): string {
    [$hh, $mm] = explode(':', $h);
    return $mm === '00' ? (int)$hh . 'h' : (int)$hh . 'h' . $mm;
}
function quandoHumano(int $dias): string {
    if ($dias === 0) return 'Hoje tem jogo!';
    if ($dias === 1) return 'Amanhã tem jogo';
    return "Seu próximo jogo é daqui a {$dias} dias";
}

/* Retorna [% mandante, % empate, % visitante] */
function calcularEnquete(int $forcaMandante, int $forcaVisitante): array {
    $diff = ($forcaMandante + 5) - $forcaVisitante;           // +5 = fator casa
    $vitMandanteRel = 1 / (1 + pow(10, -$diff / 40));         // chance sem contar empate
    $empate = 0.30 - 0.15 * min(abs($diff) / 50, 1);          // de 30% a 15%
    $restante = 1 - $empate;

    $pMandante  = (int)round($restante * $vitMandanteRel * 100);
    $pVisitante = (int)round($restante * (1 - $vitMandanteRel) * 100);
    $pEmpate    = 100 - $pMandante - $pVisitante;
    return [$pMandante, $pEmpate, $pVisitante];
}

/* ---------- 4. Dados do jogo em destaque ---------- */
if ($jogo) {
    $mand = $jogo['clubeMandante'];
    $visi = $jogo['clubeVisitante'];
    $souMandante = ((int)$mand['id'] === $idClube);

    [$pM, $pE, $pV] = calcularEnquete((int)$mand['reputacao'], (int)$visi['reputacao']);

    $dataJogo = new DateTime($jogo['dataPartida']);
    $dias     = (int)(new DateTime($hoje))->diff($dataJogo)->format('%r%a');

    $dataExtenso = diaSemana($dataJogo) . ', ' . $dataJogo->format('j') . ' de ' . nomeMes($dataJogo);
    $horario     = horaHumana($jogo['horario']);
    $adversario  = $souMandante ? $visi : $mand;

    // Frase da enquete
    if (abs($pM - $pV) <= 8)      $veredito = 'Jogo parelho: pode cair para qualquer lado.';
    elseif ($pM > $pV)            $veredito = 'A torcida aposta no ' . $mand['nomeClube'] . '.';
    else                          $veredito = 'A torcida aposta no ' . $visi['nomeClube'] . '.';

    // Próximos jogos depois do em destaque (até 3)
    $depois = [];
    foreach ($jogos as $j) {
        if ($j['idPartida'] !== $jogo['idPartida'] && $j['dataPartida'] > $jogo['dataPartida']) $depois[] = $j;
        if (count($depois) === 3) break;
    }
}

/* Dias com jogo, com dica ao passar o mouse */
$jogosPorDia = [];
foreach ($jogos as $j) {
    $emCasa = ((int)$j['mandanteIdClube'] === $idClube);
    $adv    = $emCasa ? $j['clubeVisitante']['nomeClube'] : $j['clubeMandante']['nomeClube'];
    $jogosPorDia[$j['dataPartida']] = ($emCasa ? 'Em casa contra ' : 'Fora contra ') . $adv . ' às ' . horaHumana($j['horario']);
}
?>

<style>
    .dia.jogo { box-shadow: inset 0 0 0 2px var(--amareloBrilho); cursor: help; }
    .dia.jogo-alvo { background: var(--amareloBrilho); color: #000; font-weight: 700; }
    .manchete { font-size: 1.05rem; margin: 4px 0 2px; }
    .subdata { opacity: .75; margin-bottom: 14px; text-transform: capitalize; }
    .tag-voce { display: inline-block; font-size: .7rem; padding: 1px 8px; border-radius: 99px; background: var(--verdeBrilho); color: var(--branco); margin-top: 4px; }
    .veredito { margin-top: 10px; font-size: .9rem; opacity: .85; }
    .depois { margin-top: 18px; }
    .depois ul { list-style: none; padding: 0; margin: 8px 0 0; }
    .depois li { display: flex; justify-content: space-between; padding: 6px 0; border-bottom: 1px solid rgba(255,255,255,.08); font-size: .9rem; }
    .escudo, .mini-escudo { object-fit: contain; }
</style>

<main>
<h1 class="titulo">Calendário</h1>

<div class="layout">

    <section class="box">
        <div class="cal-topo">
            <div class="mes-ano" id="mesAno"></div>
            <div class="cal-nav">
                <button onclick="mudarMes(-1)">‹</button>
                <button onclick="mudarMes(1)">›</button>
            </div>
        </div>
        <div class="cal-semana">
            <span>Dom</span><span>Seg</span><span>Ter</span><span>Qua</span><span>Qui</span><span>Sex</span><span>Sáb</span>
        </div>
        <div class="cal-grid" id="calGrid"></div>
        <div class="legenda-cal">
            <span><i class="ic-hoje"></i> Hoje</span>
            <span><i class="ic-passado"></i> Dias que já passaram</span>
            <span><i style="display:inline-block;width:12px;height:12px;box-shadow:inset 0 0 0 2px var(--amareloBrilho);border-radius:3px"></i> Dia de jogo</span>
        </div>
    </section>

    <section class="box">
        <?php if (!$jogo): ?>
            <h2>Próximo Jogo</h2>
            <p>Não há nenhum jogo marcado por enquanto.</p>
        <?php else: ?>
            <h2 class="manchete"><?= quandoHumano($dias) ?></h2>
            <div class="subdata"><?= $dataExtenso ?> · <?= $horario ?></div>

            <div class="confronto">
                <div class="time">
                    <?= escudo($mand, $souMandante, 'escudo', $BASE_IMG) ?>
                    <strong><?= htmlspecialchars($mand['nomeClube']) ?></strong>
                    <?php if ($souMandante): ?><span class="tag-voce">Seu clube</span><?php endif; ?>
                </div>
                <div class="x">X</div>
                <div class="time">
                    <?= escudo($visi, !$souMandante, 'escudo', $BASE_IMG) ?>
                    <strong><?= htmlspecialchars($visi['nomeClube']) ?></strong>
                    <?php if (!$souMandante): ?><span class="tag-voce">Seu clube</span><?php endif; ?>
                </div>
            </div>

            <div class="info-jogo">
                <div class="linha"><span>Quando</span><span><?= $dataJogo->format('d/m/Y') ?> às <?= $horario ?></span></div>
                <div class="linha"><span>Rodada</span><span><?= (int)$jogo['rodada'] ?>ª rodada</span></div>
                <div class="linha"><span>Onde</span><span><?= htmlspecialchars($jogo['local']) ?> (<?= number_format((int)$mand['capacidadeEstadio'], 0, ',', '.') ?> lugares)</span></div>
                <div class="linha"><span>Seu time joga</span><span><?= $souMandante ? 'em casa, com a torcida' : 'fora de casa' ?></span></div>
            </div>

            <div>
                <h2>Quem vencerá?</h2>
                <div class="enquete" style="margin-top:8px;">
                    <div class="enquete-opcao">
                        <?= escudo($mand, $souMandante, 'mini-escudo', $BASE_IMG) ?>
                        <span class="rotulo"><?= htmlspecialchars($mand['nomeClube']) ?></span>
                        <div class="barra"><i style="width:<?= $pM ?>%"></i></div>
                        <span class="pct"><?= $pM ?>%</span>
                    </div>
                    <div class="enquete-opcao empate">
                        <div class="mini-escudo" style="display:flex; align-items:center; justify-content:center; font-family:'Inter',sans-serif; font-weight:800; color:var(--roxoTextoMaisClaro);">X</div>
                        <span class="rotulo">Empate</span>
                        <div class="barra"><i style="width:<?= $pE ?>%"></i></div>
                        <span class="pct"><?= $pE ?>%</span>
                    </div>
                    <div class="enquete-opcao">
                        <?= escudo($visi, !$souMandante, 'mini-escudo', $BASE_IMG) ?>
                        <span class="rotulo"><?= htmlspecialchars($visi['nomeClube']) ?></span>
                        <div class="barra"><i style="width:<?= $pV ?>%"></i></div>
                        <span class="pct"><?= $pV ?>%</span>
                    </div>
                </div>
                <p class="veredito"><?= htmlspecialchars($veredito) ?></p>
            </div>

            <?php if ($depois): ?>
            <div class="depois">
                <h2>Depois disso</h2>
                <ul>
                    <?php foreach ($depois as $d):
                        $dd = new DateTime($d['dataPartida']);
                        $emCasa = ((int)$d['mandanteIdClube'] === $idClube);
                        $adv = $emCasa ? $d['clubeVisitante']['nomeClube'] : $d['clubeMandante']['nomeClube'];
                    ?>
                    <li>
                        <span><?= ($emCasa ? 'vs ' : '@ ') . htmlspecialchars($adv) ?></span>
                        <span><?= $dd->format('d/m') ?> · <?= horaHumana($d['horario']) ?></span>
                    </li>
                    <?php endforeach; ?>
                </ul>
            </div>
            <?php endif; ?>
        <?php endif; ?>
    </section>

</div>
</main>

<script>
var MESES = ['janeiro','fevereiro','março','abril','maio','junho','julho','agosto','setembro','outubro','novembro','dezembro'];
var HOJE = {
    ano: <?= $estadoJogo->dataAtual->format('Y') ?>,
    mes: <?= (int)$estadoJogo->dataAtual->format('n') - 1 ?>,
    dia: <?= (int)$estadoJogo->dataAtual->format('j') ?>
};
var JOGOS_POR_DIA = <?= json_encode($jogosPorDia, JSON_UNESCAPED_UNICODE | JSON_FORCE_OBJECT) ?>;
var DIA_ALVO = <?= json_encode($jogo['dataPartida'] ?? null) ?>;
var visao = { ano: HOJE.ano, mes: HOJE.mes };

function chave(ano, mes, dia) {
    return ano + '-' + String(mes + 1).padStart(2, '0') + '-' + String(dia).padStart(2, '0');
}

function mudarMes(delta) {
    visao.mes += delta;
    if (visao.mes < 0)  { visao.mes = 11; visao.ano--; }
    if (visao.mes > 11) { visao.mes = 0;  visao.ano++; }
    renderizar();
}

function renderizar() {
    document.getElementById('mesAno').textContent = MESES[visao.mes] + ' de ' + visao.ano;
    var grid = document.getElementById('calGrid');
    grid.innerHTML = '';

    var primeiroDiaSemana = new Date(visao.ano, visao.mes, 1).getDay();
    var totalDias = new Date(visao.ano, visao.mes + 1, 0).getDate();

    for (var i = 0; i < primeiroDiaSemana; i++) {
        var vazio = document.createElement('div');
        vazio.className = 'dia vazio';
        grid.appendChild(vazio);
    }

    for (var d = 1; d <= totalDias; d++) {
        var cel = document.createElement('div');
        cel.className = 'dia';
        cel.textContent = d;

        var k = chave(visao.ano, visao.mes, d);
        var ehHoje = (visao.ano === HOJE.ano && visao.mes === HOJE.mes && d === HOJE.dia);
        var ehPassado = (visao.ano < HOJE.ano) ||
                        (visao.ano === HOJE.ano && visao.mes < HOJE.mes) ||
                        (visao.ano === HOJE.ano && visao.mes === HOJE.mes && d < HOJE.dia);

        if (ehHoje) cel.classList.add('hoje');
        else if (ehPassado) cel.classList.add('passado');

        if (JOGOS_POR_DIA[k]) {
            cel.classList.add('jogo');
            cel.title = JOGOS_POR_DIA[k];
        }
        if (k === DIA_ALVO) cel.classList.add('jogo-alvo');

        grid.appendChild(cel);
    }
}
renderizar();
</script>

<script src="assets/js/animations/calendario.js"></script>
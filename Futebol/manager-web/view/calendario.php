<link rel="stylesheet" href="assets/css/calendario.css"> 

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
            <span><i class="ic-passado"></i> Dias já jogados/passados</span>
        </div>
    </section>

    <section class="box">
        <h2>Próximo Jogo</h2>
        <div class="confronto">
            <div class="time">
                <svg class="escudo" viewBox="0 0 64 72" xmlns="http://www.w3.org/2000/svg">
                    <path d="M32 2 L60 12 V34 C60 52 48 64 32 70 C16 64 4 52 4 34 V12 Z" fill="var(--verdeBrilho)" stroke="var(--verde)" stroke-width="2.5"/>
                    <text x="32" y="42" text-anchor="middle" font-family="Inter, sans-serif" font-weight="800" font-size="18" fill="var(--amareloBrilho)">FC</text>
                </svg>
                <strong>Seu Clube</strong>
            </div>
            <div class="x">X</div>
            <div class="time">
                <svg class="escudo" viewBox="0 0 64 72" xmlns="http://www.w3.org/2000/svg">
                    <path d="M32 2 L60 12 V34 C60 52 48 64 32 70 C16 64 4 52 4 34 V12 Z" fill="var(--roxoBrilho)" stroke="var(--roxoTexto)" stroke-width="2.5"/>
                    <text x="32" y="42" text-anchor="middle" font-family="Inter, sans-serif" font-weight="800" font-size="16" fill="var(--branco)">PAL</text>
                </svg>
                <strong>Palmeiras</strong>
            </div>
        </div>

        <div class="info-jogo">
            <div class="linha"><span>Horário</span><span>12/10/2026 — 16h00</span></div>
            <div class="linha"><span>Transmissão</span><span>CazeTV</span></div>
            <div class="linha"><span>Local</span><span>Estádio Monumental, São Paulo</span></div>
        </div>

        <div class="ingressos">
            <div class="barra"><i style="width:82%"></i></div>
            <div class="legenda"><span>Ingressos vendidos</span><span>38.240 / 46.500</span></div>
        </div>

        <div>
            <h2>Quem vencerá?</h2>
            <div class="enquete" style="margin-top:8px;">
                <div class="enquete-opcao">
                    <svg class="mini-escudo" viewBox="0 0 64 72" xmlns="http://www.w3.org/2000/svg"><path d="M32 2 L60 12 V34 C60 52 48 64 32 70 C16 64 4 52 4 34 V12 Z" fill="var(--verdeBrilho)" stroke="var(--verde)" stroke-width="3"/></svg>
                    <span class="rotulo">Seu Clube</span>
                    <div class="barra"><i style="width:47%"></i></div>
                    <span class="pct">47%</span>
                </div>
                <div class="enquete-opcao empate">
                    <div class="mini-escudo" style="display:flex; align-items:center; justify-content:center; font-family:'Inter',sans-serif; font-weight:800; color:var(--roxoTextoMaisClaro);">X</div>
                    <span class="rotulo">Empate</span>
                    <div class="barra"><i style="width:21%"></i></div>
                    <span class="pct">21%</span>
                </div>
                <div class="enquete-opcao">
                    <svg class="mini-escudo" viewBox="0 0 64 72" xmlns="http://www.w3.org/2000/svg"><path d="M32 2 L60 12 V34 C60 52 48 64 32 70 C16 64 4 52 4 34 V12 Z" fill="var(--roxoBrilho)" stroke="var(--roxoTexto)" stroke-width="3"/></svg>
                    <span class="rotulo">Palmeiras</span>
                    <div class="barra"><i style="width:32%"></i></div>
                    <span class="pct">32%</span>
                </div>
            </div>
        </div>
    </section>

</div>


</main>


<script>
var MESES = ['janeiro','fevereiro','março','abril','maio','junho','julho','agosto','setembro','outubro','novembro','dezembro'];
/* "hoje" fixado na data do jogo (calendário do universo do jogo) */
var HOJE = { ano: 2026, mes: 9, dia: 12 }; // mes: 0-indexado (9 = outubro)
var visao = { ano: HOJE.ano, mes: HOJE.mes };

function mudarMes(delta) {
    visao.mes += delta;
    if (visao.mes < 0) { visao.mes = 11; visao.ano--; }
    if (visao.mes > 11) { visao.mes = 0; visao.ano++; }
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

        var ehHoje = (visao.ano === HOJE.ano && visao.mes === HOJE.mes && d === HOJE.dia);
        var ehPassado = (visao.ano < HOJE.ano) ||
                         (visao.ano === HOJE.ano && visao.mes < HOJE.mes) ||
                         (visao.ano === HOJE.ano && visao.mes === HOJE.mes && d < HOJE.dia);

        if (ehHoje) cel.classList.add('hoje');
        else if (ehPassado) cel.classList.add('passado');

        grid.appendChild(cel);
    }
}
renderizar();
</script>

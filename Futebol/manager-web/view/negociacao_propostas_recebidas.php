<link rel="stylesheet" href="assets/css/negociacao_propostas_recebidas.css"> 


<main>
<h1 class="titulo">Propostas Recebidas</h1>

<div class="layout">

    <section class="box">
        <h2>Meus Jogadores <span style="color:var(--roxoTexto); font-weight:400; text-transform:none;">(6 propostas)</span></h2>
        <div class="lista rolavel">

            <div class="proposta-linha selecionado" onclick="selecionar(this)">
                <span class="posicao">PE</span>
                <div class="info">
                    <span class="nome-linha">🔥 Rayan</span>
                    <span class="sub">Proposta de Chelsea • Premier League</span>
                </div>
                <div class="direita"><div class="overall">82</div><div class="valor">R$ 210M</div></div>
            </div>

            <div class="proposta-linha" onclick="selecionar(this)">
                <span class="posicao">CA</span>
                <div class="info">
                    <span class="nome-linha">🔥 Pedro</span>
                    <span class="sub">Proposta de Al-Hilal • Liga Saudita</span>
                </div>
                <div class="direita"><div class="overall">85</div><div class="valor">R$ 180M</div></div>
            </div>

            <div class="proposta-linha" onclick="selecionar(this)">
                <span class="posicao">MEI</span>
                <div class="info">
                    <span class="nome-linha">Gerson</span>
                    <span class="sub">Proposta de Fluminense • Brasileirão A</span>
                </div>
                <div class="direita"><div class="overall">84</div><div class="valor">R$ 40M</div></div>
            </div>

            <div class="proposta-linha" onclick="selecionar(this)">
                <span class="posicao">ZG</span>
                <div class="info">
                    <span class="nome-linha">Léo Ortiz</span>
                    <span class="sub">Proposta de Galatasaray • Süper Lig</span>
                </div>
                <div class="direita"><div class="overall">83</div><div class="valor">R$ 35M</div></div>
            </div>

            <div class="proposta-linha" onclick="selecionar(this)">
                <span class="posicao">LE</span>
                <div class="info">
                    <span class="nome-linha">🔥 Filipe Luís</span>
                    <span class="sub">Proposta de Vasco da Gama • Brasileirão A</span>
                </div>
                <div class="direita"><div class="overall">81</div><div class="valor">R$ 20M</div></div>
            </div>

            <div class="proposta-linha" onclick="selecionar(this)">
                <span class="posicao">PE</span>
                <div class="info">
                    <span class="nome-linha">🔥 Estevão</span>
                    <span class="sub">Proposta de Real Madrid • La Liga</span>
                </div>
                <div class="direita"><div class="overall">80</div><div class="valor">R$ 260M</div></div>
            </div>
        </div>
    </section>

    <section class="box">
        <div class="detalhe-cabecalho">
            <div class="time-info">
                <strong>Chelsea</strong>
                <span>Premier League</span>
            </div>
            <button class="btn-lixeira" title="Recusar proposta">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="3 6 5 6 21 6"></polyline><path d="M19 6l-1 14a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2L5 6"></path><path d="M10 11v6"></path><path d="M14 11v6"></path><path d="M9 6V4a1 1 0 0 1 1-1h4a1 1 0 0 1 1 1v2"></path></svg>
            </button>
        </div>

        <div class="detalhe-corpo rolavel">

            <div class="mini-stats">
                <div class="item"><span>Valor da proposta</span><strong>R$ 210M</strong></div>
                <div class="item"><span>Jogador</span><strong>Rayan</strong></div>
                <div class="item"><span>Overall</span><strong>82</strong></div>
                <div class="item"><span>Posição</span><strong>PE</strong></div>
                <div class="item"><span>Idade</span><strong>19 anos</strong></div>
                <div class="item"><span>Status</span><strong class="on-fire">On fire</strong></div>
                <div class="item"><span>Tipo de contratação</span><strong>Definitiva</strong></div>
                <div class="item"><span>Rescisão oferecida</span><strong>R$ 250M</strong></div>
            </div>

            <div class="observacoes">
                <strong>Observações:</strong> difícil efetivação — o jogador não deseja sair do clube neste momento.
            </div>

            <div>
                <h2>Premier League</h2>
                <table class="tabela-liga" style="margin-top:6px;">
                    <thead><tr><th>Time</th><th class="num">Pts</th><th class="num">GF</th><th class="num">GS</th><th class="num">SG</th></tr></thead>
                    <tbody>
                        <tr><td>Manchester City</td><td class="num">58</td><td class="num">44</td><td class="num">18</td><td class="num">+26</td></tr>
                        <tr><td>Arsenal</td><td class="num">54</td><td class="num">39</td><td class="num">20</td><td class="num">+19</td></tr>
                        <tr class="destaque"><td>Chelsea</td><td class="num">51</td><td class="num">37</td><td class="num">22</td><td class="num">+15</td></tr>
                        <tr><td>Liverpool</td><td class="num">49</td><td class="num">35</td><td class="num">23</td><td class="num">+12</td></tr>
                        <tr><td>Aston Villa</td><td class="num">45</td><td class="num">31</td><td class="num">25</td><td class="num">+6</td></tr>
                    </tbody>
                </table>
            </div>

            <div class="acoes">
                <button class="btn-contraproposta" type="button" onclick="abrirModal()">Contraproposta</button>
                <button class="btn-aceitar" type="button">Aceitar Termos</button>
            </div>
        </div>
    </section>

</div>

<!-- MODAL DE CONTRAPROPOSTA -->
<div class="overlay" id="overlayContraproposta">
    <div class="modal">
        <div class="modal-topo">
            <h2>Enviar Contraproposta</h2>
            <button class="modal-fechar" onclick="fecharModal()">✕</button>
        </div>

        <div class="campo">
            <label>Nome do jogador</label>
            <div class="valor-fixo">Rayan</div>
        </div>

        <div class="campo">
            <label>Valor do jogador (mercado)</label>
            <div class="valor-fixo">R$ 45M</div>
        </div>

        <div class="campo">
            <label>Tipo de negociação</label>
            <div class="tipo-toggle">
                <input type="radio" name="tipo-neg" id="tipo-definitiva" checked onchange="atualizarTipo()">
                <label for="tipo-definitiva">Definitiva</label>
                <input type="radio" name="tipo-neg" id="tipo-emprestimo" onchange="atualizarTipo()">
                <label for="tipo-emprestimo">Empréstimo</label>
            </div>
        </div>

        <div class="campo" id="linhaDuracao" style="display:none;">
            <label>Tempo de contrato do empréstimo: <span class="slider-valor" id="valorDuracao">1 ano</span></label>
            <div class="slider-linha">
                <input type="range" id="sliderDuracao" min="0" max="3" step="1" value="1" oninput="atualizarDuracao(this.value)">
                <div class="slider-legenda"><span>6 meses</span><span>1 ano</span><span>2 anos</span><span>3 anos</span></div>
            </div>
        </div>

        <div class="checkbox-linha">
            <input type="checkbox" id="opcaoCompra">
            <label for="opcaoCompra">Empréstimo com opção de compra</label>
        </div>

        <div class="campo">
            <label>Valor de transferência oferecido</label>
            <input type="number" placeholder="Ex: 220000000">
        </div>

        <div class="campo">
            <label>Salário atual do jogador</label>
            <div class="valor-fixo">R$ 180 mil / mês</div>
        </div>

        <div class="campo">
            <label>Divisão do salário: <span class="slider-valor" id="valorDivisao">Seu clube 60% / Chelsea 40%</span></label>
            <div class="slider-linha">
                <input type="range" id="sliderDivisao" min="0" max="100" step="5" value="60" oninput="atualizarDivisao(this.value)">
            </div>
        </div>

        <div class="campo">
            <label>Orçamento disponível do seu clube</label>
            <div class="valor-fixo">R$ 22,4M</div>
        </div>

        <div class="campo">
            <label>Clube interessado</label>
            <div class="clube-interessado">
                <div class="logo-mini">CFC</div>
                <div class="info"><strong>Chelsea</strong><span>Premier League</span></div>
            </div>
        </div>

        <div class="campo">
            <label>Valor pedido originalmente pelo clube interessado</label>
            <div class="valor-fixo">R$ 210M</div>
        </div>

        <button class="btn-enviar" type="button" onclick="fecharModal()">Enviar Proposta</button>
    </div>
</div>
</main>

<script>
function selecionar(el) {
    document.querySelectorAll('.proposta-linha').forEach(function(i){ i.classList.remove('selecionado'); });
    el.classList.add('selecionado');
}
function abrirModal() { document.getElementById('overlayContraproposta').classList.add('aberto'); }
function fecharModal() { document.getElementById('overlayContraproposta').classList.remove('aberto'); }
document.getElementById('overlayContraproposta').addEventListener('click', function(e){
    if (e.target === this) fecharModal();
});

var duracoes = ['6 meses', '1 ano', '2 anos', '3 anos'];
function atualizarDuracao(v) { document.getElementById('valorDuracao').textContent = duracoes[v]; }

function atualizarDivisao(v) {
    document.getElementById('valorDivisao').textContent = 'Seu clube ' + v + '% / Chelsea ' + (100 - v) + '%';
}

function atualizarTipo() {
    var emprestimo = document.getElementById('tipo-emprestimo').checked;
    document.getElementById('linhaDuracao').style.display = emprestimo ? 'flex' : 'none';
    document.getElementById('opcaoCompra').disabled = !emprestimo;
}
</script>

<link rel="stylesheet" href="assets/css/negociacao_propostas_enviadas.css"> 

<main>
    
<h1 class="titulo">Propostas Enviadas</h1>

<div class="layout">

    <section class="box">
        <h2>Alvos do Mercado <span style="color:var(--roxoTexto); font-weight:400; text-transform:none;">(5)</span></h2>
        <div class="lista rolavel">

            <div class="jogador-linha" onclick="selecionar(this)">
                <span class="posicao">ZG</span>
                <div class="info"><strong>Kaique Vitória</strong><span>Overall (?): 62–78</span></div>
                <span class="clube">Grêmio</span>
                <span class="valor">R$ 18M</span>
                <span class="contrato">1a 4m</span>
            </div>

            <div class="jogador-linha" onclick="selecionar(this)">
                <span class="posicao">CA</span>
                <div class="info"><strong>Matheus Dallas</strong><span>Overall (?): 70–86</span></div>
                <span class="clube">Internacional</span>
                <span class="valor">R$ 32M</span>
                <span class="contrato">2a</span>
            </div>

            <div class="jogador-linha" onclick="selecionar(this)">
                <span class="posicao">MEI</span>
                <div class="info"><strong>Vitor Aquino</strong><span>Overall (?): 60–75</span></div>
                <span class="clube">Cruzeiro</span>
                <span class="valor">R$ 21M</span>
                <span class="contrato">3a</span>
            </div>

            <div class="jogador-linha selecionado" onclick="selecionar(this)">
                <span class="posicao">PE</span>
                <div class="info"><strong>Igor Trindade</strong><span>Overall (?): 68–84</span></div>
                <span class="clube">Corinthians</span>
                <span class="valor">R$ 27M</span>
                <span class="contrato">2a 6m</span>
            </div>

            <div class="jogador-linha" onclick="selecionar(this)">
                <span class="posicao">LD</span>
                <div class="info"><strong>Bruno Kelvin</strong><span>Overall (?): 55–74</span></div>
                <span class="clube">Bahia</span>
                <span class="valor">R$ 9M</span>
                <span class="contrato">6m</span>
            </div>
        </div>
    </section>

    <section class="box">
        <div class="ficha-topo">
            <div class="nome-idade">
                <strong>Igor Trindade</strong>
                <span>PE • 24 anos • Brasileiro</span>
            </div>
            <span class="tag-status aceita">Proposta Aceita</span>
        </div>

        <div class="ficha-corpo rolavel">

            <div class="mini-stats">
                <div class="item"><span>Valor enviado</span><strong>R$ 27M</strong></div>
                <div class="item"><span>Salário oferecido</span><strong>R$ 210 mil</strong></div>
                <div class="item"><span>Contrato restante (Corinthians)</span><strong>2 anos e 6 meses</strong></div>
                <div class="item"><span>Overall (?)</span><strong>68–84</strong></div>
            </div>

            <div>
                <h2>Atributos</h2>
                <div class="atributos" style="margin-top:8px;">
                    <div class="atributo-linha"><span class="label">Velocidade</span><div class="barra"><i style="width:82%"></i></div><span class="num">82</span></div>
                    <div class="atributo-linha"><span class="label">Força</span><div class="barra"><i style="width:60%"></i></div><span class="num">60</span></div>
                    <div class="atributo-linha"><span class="label">Inteligência (?)</span><div class="barra"><i class="faixa" style="left:38%; width:30%"></i></div><span class="num oculto">58–79</span></div>
                    <div class="atributo-linha"><span class="label">Finalização (?)</span><div class="barra"><i class="faixa" style="left:42%; width:35%"></i></div><span class="num oculto">65–88</span></div>
                    <div class="atributo-linha"><span class="label">Marcação</span><div class="barra"><i style="width:45%"></i></div><span class="num">45</span></div>
                    <div class="atributo-linha"><span class="label">Passe</span><div class="barra"><i style="width:74%"></i></div><span class="num">74</span></div>
                    <div class="atributo-linha"><span class="label">Moral (?)</span><div class="barra"><i class="faixa" style="left:40%; width:40%"></i></div><span class="num oculto">50–90</span></div>
                </div>
            </div>

            <div>
                <h2>Lesões</h2>
                <ul class="lesoes" style="margin-top:6px;"><li>Nenhuma</li></ul>
            </div>

            <div>
                <h2>Estatísticas na Temporada</h2>
                <table class="stats-jogos" style="margin-top:6px;">
                    <thead><tr><th>Competição</th><th class="num">J</th><th class="num">G</th><th class="num">A</th></tr></thead>
                    <tbody>
                        <tr><td>Brasileirão Série A</td><td class="num">21</td><td class="num">6</td><td class="num">8</td></tr>
                        <tr><td>Copa do Brasil</td><td class="num">4</td><td class="num">1</td><td class="num">2</td></tr>
                        <tr><td>Amistoso</td><td class="num">2</td><td class="num">0</td><td class="num">1</td></tr>
                    </tbody>
                </table>
            </div>

            <button class="btn-formalizar" type="button" onclick="abrirModal()">Formalizar Contratação</button>
        </div>
    </section>

</div>

<!-- MODAL DE FORMALIZAÇÃO -->
<div class="overlay" id="overlayFormalizar">
    <div class="modal">
        <div class="modal-topo">
            <h2>Formalizar Contratação — Igor Trindade</h2>
            <button class="modal-fechar" onclick="fecharModal()">✕</button>
        </div>

        <div class="campo">
            <label>Salário oferecido ao jogador</label>
            <input type="number" placeholder="Ex: 210000" value="210000">
        </div>

        <div class="campo">
            <label>Tempo de contrato oferecido</label>
            <select>
                <option>1 ano</option>
                <option>2 anos</option>
                <option selected>3 anos</option>
                <option>4 anos</option>
                <option>5 anos</option>
            </select>
        </div>

        <div class="campo">
            <label>Valor de rescisão</label>
            <input type="number" placeholder="Ex: 90000000" value="90000000">
        </div>

        <div class="campo">
            <label>Moral do jogador no clube atual</label>
            <div class="moral-gauge">
                <div class="barra"><i style="width:82%"></i></div>
                <div class="legenda"><span>Quer sair</span><span>82 / 100</span><span>Feliz no clube</span></div>
            </div>
        </div>

        <div class="aviso">
            Contratação dificultada pois o jogador não deseja sair do clube atual.
        </div>

        <button class="btn-enviar" type="button" onclick="fecharModal()">Enviar Proposta</button>
    </div>
</div>

</main>


<script>
function selecionar(el) {
    document.querySelectorAll('.jogador-linha').forEach(function(i){ i.classList.remove('selecionado'); });
    el.classList.add('selecionado');
}
function abrirModal() { document.getElementById('overlayFormalizar').classList.add('aberto'); }
function fecharModal() { document.getElementById('overlayFormalizar').classList.remove('aberto'); }
document.getElementById('overlayFormalizar').addEventListener('click', function(e){
    if (e.target === this) fecharModal();
});
</script>
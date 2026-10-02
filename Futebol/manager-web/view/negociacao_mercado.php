<link rel="stylesheet" href="assets/css/negociacao_mercado.css"> 

<main>
    
<h1 class="titulo">Comprar Jogadores</h1>

<div class="layout">

    <section class="box">
        <div class="topo-busca">
            <div class="orcamento">Orçamento disponível: <strong>R$ 22,4M</strong></div>
            <div class="busca-linha">
                <input type="text" placeholder="Buscar jogador ou clube...">
                <details class="filtro-wrap">
                    <summary title="Filtros">⚙</summary>
                    <div class="filtro-painel">
                        <div class="filtro-campo">
                            <label>Posição</label>
                            <select><option>Todas</option><option>GL</option><option>ZG</option><option>LD</option><option>LE</option><option>VOL</option><option>MEI</option><option>PE</option><option>PD</option><option>CA</option></select>
                        </div>
                        <div class="filtro-campo">
                            <label>Nacionalidade</label>
                            <select><option>Todas</option><option>Brasileiro</option><option>Português</option><option>Espanhol</option></select>
                        </div>
                        <div class="filtro-campo">
                            <label>Idade</label>
                            <div class="filtro-faixa"><input type="number" placeholder="Mín"><input type="number" placeholder="Máx"></div>
                        </div>
                        <div class="filtro-campo">
                            <label>Valor de mercado (R$M)</label>
                            <div class="filtro-faixa"><input type="number" placeholder="Mín"><input type="number" placeholder="Máx"></div>
                        </div>
                        <div class="filtro-campo">
                            <label>Disponível para empréstimo</label>
                            <select><option>Indiferente</option><option>Sim</option><option>Não</option></select>
                        </div>
                        <button class="filtro-aplicar" type="button">Aplicar filtros</button>
                    </div>
                </details>
            </div>
        </div>

        <div class="lista-jogadores rolavel">
            <div class="jogador-linha selecionado"><span class="posicao">ZG</span><span class="nome">Kaique Vitória</span><span class="clube">Grêmio</span><span class="valor">R$ 18M</span><span class="contrato">1a 4m</span></div>
            <div class="jogador-linha"><span class="posicao">CA</span><span class="nome">Matheus Dallas</span><span class="clube">Internacional</span><span class="valor">R$ 32M</span><span class="contrato">2a</span></div>
            <div class="jogador-linha"><span class="posicao">MEI</span><span class="nome">Vitor Aquino</span><span class="clube">Cruzeiro</span><span class="valor">R$ 21M</span><span class="contrato">3a</span></div>
            <div class="jogador-linha"><span class="posicao">LD</span><span class="nome">Bruno Kelvin</span><span class="clube">Bahia</span><span class="valor">R$ 9M</span><span class="contrato">6m</span></div>
            <div class="jogador-linha"><span class="posicao">PE</span><span class="nome">Igor Trindade</span><span class="clube">Corinthians</span><span class="valor">R$ 27M</span><span class="contrato">2a 6m</span></div>
            <div class="jogador-linha"><span class="posicao">GL</span><span class="nome">Rafael Sodré</span><span class="clube">Santos</span><span class="valor">R$ 6M</span><span class="contrato">1a</span></div>
            <div class="jogador-linha"><span class="posicao">VOL</span><span class="nome">Denis Cavani</span><span class="clube">Atlético-MG</span><span class="valor">R$ 15M</span><span class="contrato">1a 8m</span></div>
            <div class="jogador-linha"><span class="posicao">LE</span><span class="nome">Thiaguinho Reis</span><span class="clube">Vasco da Gama</span><span class="valor">R$ 11M</span><span class="contrato">2a</span></div>
            <div class="jogador-linha"><span class="posicao">PD</span><span class="nome">Caio Nascimento</span><span class="clube">Botafogo</span><span class="valor">R$ 24M</span><span class="contrato">3a 2m</span></div>
            <div class="jogador-linha"><span class="posicao">ZG</span><span class="nome">Vinícius Rocha</span><span class="clube">Fortaleza</span><span class="valor">R$ 13M</span><span class="contrato">1a 2m</span></div>
            <div class="jogador-linha"><span class="posicao">CA</span><span class="nome">Lucas Peralta</span><span class="clube">Athletico-PR</span><span class="valor">R$ 19M</span><span class="contrato">2a</span></div>
            <div class="jogador-linha"><span class="posicao">MEI</span><span class="nome">Otávio Brumana</span><span class="clube">Red Bull Bragantino</span><span class="valor">R$ 17M</span><span class="contrato">1a 6m</span></div>
        </div>
    </section>

    <section class="box">
        <div class="ficha-topo">
            <span class="posicao-grande">ZG</span>
            <div>
                <strong>Kaique Vitória</strong>
                <span>22 anos • Brasileiro</span>
            </div>
        </div>

        <div class="ficha-corpo rolavel">

            <div class="mini-stats">
                <div class="item"><span>Valor de mercado</span><strong>R$ 18M</strong></div>
                <div class="item"><span>Salário mensal</span><strong>R$ 180 mil</strong></div>
                <div class="item"><span>Contrato restante (Grêmio)</span><strong>1 ano e 4 meses</strong></div>
                <div class="item"><span>Overall (?)</span><strong>62–78</strong></div>
                <div class="item"><span>Disponível p/ empréstimo</span><strong class="nao">Não</strong></div>
            </div>

            <div>
                <h2>Atributos</h2>
                <div class="atributos" style="margin-top:8px;">
                    <div class="atributo-linha"><span class="label">Velocidade</span><div class="barra"><i style="width:71%"></i></div><span class="num">71</span></div>
                    <div class="atributo-linha"><span class="label">Força</span><div class="barra"><i style="width:80%"></i></div><span class="num">80</span></div>
                    <div class="atributo-linha"><span class="label">Inteligência (?)</span><div class="barra"><i class="faixa" style="left:45%; width:28%"></i></div><span class="num oculto">55–83</span></div>
                    <div class="atributo-linha"><span class="label">Finalização (?)</span><div class="barra"><i class="faixa" style="left:20%; width:22%"></i></div><span class="num oculto">30–52</span></div>
                    <div class="atributo-linha"><span class="label">Marcação</span><div class="barra"><i style="width:85%"></i></div><span class="num">85</span></div>
                    <div class="atributo-linha"><span class="label">Passe</span><div class="barra"><i style="width:68%"></i></div><span class="num">68</span></div>
                    <div class="atributo-linha"><span class="label">Moral (?)</span><div class="barra"><i class="faixa" style="left:50%; width:35%"></i></div><span class="num oculto">60–95</span></div>
                </div>
            </div>

            <div>
                <h2>Lesões</h2>
                <ul class="lesoes" style="margin-top:6px;">
                    <li><strong>Entorse no tornozelo</strong> — retorno em 12 dias</li>
                </ul>
            </div>

            <div>
                <h2>Estatísticas na Temporada</h2>
                <table class="stats-jogos" style="margin-top:6px;">
                    <thead><tr><th>Competição</th><th class="num">J</th><th class="num">G</th><th class="num">A</th></tr></thead>
                    <tbody>
                        <tr><td>Brasileirão Série B</td><td class="num">17</td><td class="num">2</td><td class="num">1</td></tr>
                        <tr><td>Copa do Brasil</td><td class="num">2</td><td class="num">0</td><td class="num">0</td></tr>
                        <tr><td>Amistoso</td><td class="num">1</td><td class="num">0</td><td class="num">0</td></tr>
                    </tbody>
                </table>
            </div>

        </div>
    </section>

</div>

</main>
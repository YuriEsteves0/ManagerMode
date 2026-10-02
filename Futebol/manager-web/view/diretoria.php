<link rel="stylesheet" href="assets/css/diretoria.css"> 

<main>
    
<h1 class="titulo">Diretoria</h1>

<div class="layout">

    <div class="coluna-esquerda">

        <section class="box">
            <div class="clube-cabecalho">
                <svg class="escudo" viewBox="0 0 64 72" xmlns="http://www.w3.org/2000/svg">
                    <path d="M32 2 L60 12 V34 C60 52 48 64 32 70 C16 64 4 52 4 34 V12 Z" fill="var(--verdeBrilho)" stroke="var(--verde)" stroke-width="2.5"/>
                    <text x="32" y="42" text-anchor="middle" font-family="Inter, sans-serif" font-weight="800" font-size="18" fill="var(--amareloBrilho)">FC</text>
                </svg>
                <div><strong>Seu Clube</strong><span>Brasileirão Série A</span></div>
            </div>

            <div class="orcamento-linha"><span>Orçamento disponível</span><span>R$ 22,4M</span></div>

            <div class="confianca-bloco">
                <div class="confianca-topo"><strong>57%</strong><span>Confiança estável</span></div>
                <div class="confianca-barra"><i style="width:57%"></i></div>
            </div>

            <span class="evento-atual">● Boa gestão</span>

            <div>
                <h2>Metas da Temporada</h2>
                <ul class="metas" style="margin-top:6px;">
                    <li>Classificar para a Libertadores</li>
                    <li>Chegar às quartas de final da Copa do Brasil</li>
                    <li>Manter o orçamento positivo</li>
                    <li>Vender ao menos 1 jogador da base</li>
                </ul>
            </div>
        </section>

        <section class="box">
            <h2>Recados da Diretoria</h2>
            <div class="recados">
                <div class="recado"><span class="delta pos">+3%</span><span>A diretoria está satisfeita com a liderança no campeonato.</span></div>
                <div class="recado"><span class="delta neg">-8%</span><span>A eliminação na Copa do Brasil gerou desgaste na gestão.</span></div>
                <div class="recado"><span class="delta pos">+5%</span><span>O aumento no valor do elenco impressionou os conselheiros.</span></div>
                <div class="recado"><span class="delta neg">-4%</span><span>Salários atrasados preocupam a torcida e o conselho.</span></div>
            </div>
        </section>

    </div>

    <div class="coluna-direita">
        <section class="box">
            <h2>Ações de Carreira</h2>
            <div class="acoes-lista rolavel">

                <div class="acao-item">
                    <div class="acao-topo"><strong>Pedir Reforço no Orçamento</strong><span class="status-tag bloqueado">Bloqueado</span></div>
                    <p>Exigência: <strong>confiança acima de 60%</strong></p>
                    <p>Efeito: <strong>+R$ 5M no orçamento disponível</strong></p>
                    <p class="custo">Custo de confiança: -10%</p>
                    <div class="acao-rodape"><button class="btn-acao" disabled>Solicitar à Diretoria</button></div>
                </div>

                <div class="acao-item">
                    <div class="acao-topo"><strong>Pedir Aumento de Salário</strong><span class="status-tag disponivel">Disponível</span></div>
                    <p>Exigência: <strong>confiança acima de 50%</strong></p>
                    <p>Efeito: <strong>+20% no salário mensal</strong></p>
                    <p class="custo">Custo de confiança: -5%</p>
                    <div class="acao-rodape"><button class="btn-acao">Solicitar à Diretoria</button></div>
                </div>

                <div class="acao-item">
                    <div class="acao-topo"><strong>Solicitar Investimento no Elenco</strong><span class="status-tag analise">Em Análise</span></div>
                    <p>Exigência: <strong>confiança acima de 55%</strong></p>
                    <p>Efeito: <strong>libera verba extra para contratações</strong></p>
                    <p class="custo">Custo de confiança: -8%</p>
                    <div class="acao-rodape"><button class="btn-acao" disabled>Aguardando resposta (2 dias)</button></div>
                </div>

                <div class="acao-item">
                    <div class="acao-topo"><strong>Solicitar Demissão de Diretor</strong><span class="status-tag bloqueado">Bloqueado</span></div>
                    <p>Exigência: <strong>confiança acima de 75%</strong></p>
                    <p>Efeito: <strong>substitui um membro da diretoria</strong></p>
                    <p class="custo">Custo de confiança: -15%</p>
                    <div class="acao-rodape"><button class="btn-acao" disabled>Solicitar à Diretoria</button></div>
                </div>

                <div class="acao-item">
                    <div class="acao-topo"><strong>Solicitar Melhoria no Estádio</strong><span class="status-tag bloqueado">Bloqueado</span></div>
                    <p>Exigência: <strong>confiança acima de 65%</strong></p>
                    <p>Efeito: <strong>acelera a expansão do estádio</strong></p>
                    <p class="custo">Custo de confiança: -6%</p>
                    <div class="acao-rodape"><button class="btn-acao" disabled>Solicitar à Diretoria</button></div>
                </div>

                <div class="acao-item">
                    <div class="acao-topo"><strong>Renovar Contrato Automaticamente</strong><span class="status-tag disponivel">Disponível</span></div>
                    <p>Exigência: <strong>nenhuma</strong></p>
                    <p>Efeito: <strong>renova seu contrato por mais 2 anos</strong></p>
                    <p class="custo">Custo de confiança: nenhum</p>
                    <div class="acao-rodape"><button class="btn-acao">Solicitar à Diretoria</button></div>
                </div>

                <div class="acao-item">
                    <div class="acao-topo"><strong>Negociar Novo Contrato</strong><span class="status-tag bloqueado">Bloqueado</span></div>
                    <p>Exigência: <strong>contrato com menos de 6 meses restantes</strong></p>
                    <p>Efeito: <strong>renegocia salário e tempo de contrato</strong></p>
                    <p class="custo">Custo de confiança: nenhum</p>
                    <div class="acao-rodape"><button class="btn-acao" disabled>Solicitar à Diretoria</button></div>
                </div>

                <div class="acao-item">
                    <div class="acao-topo"><strong>Pedir Demissão Voluntária</strong><span class="status-tag disponivel">Disponível</span></div>
                    <p>Exigência: <strong>nenhuma</strong></p>
                    <p>Efeito: <strong>encerra o contrato antes do prazo</strong></p>
                    <p class="custo">Custo: multa de rescisão aplicada</p>
                    <div class="acao-rodape"><button class="btn-acao">Solicitar à Diretoria</button></div>
                </div>

            </div>
        </section>
    </div>

</div>

</main>
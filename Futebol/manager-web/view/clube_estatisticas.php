<link rel="stylesheet" href="assets/css/clube_estatisticas.css"> 

<main>

    <h1 class="titulo">Estatísticas do Clube</h1>
    
    <div class="layout">
        
        <section class="box">
            <div class="clube-cabecalho">
                <svg class="escudo" viewBox="0 0 64 72" xmlns="http://www.w3.org/2000/svg">
                    <path d="M32 2 L60 12 V34 C60 52 48 64 32 70 C16 64 4 52 4 34 V12 Z" fill="var(--verdeBrilho)" stroke="var(--verde)" stroke-width="2.5"/>
                    <path d="M32 12 L52 19 V34 C52 47 43 56 32 61 C21 56 12 47 12 34 V19 Z" fill="var(--background)" stroke="var(--amarelo)" stroke-width="1.5"/>
                    <text x="32" y="42" text-anchor="middle" font-family="Inter, sans-serif" font-weight="800" font-size="22" fill="var(--amareloBrilho)">FC</text>
                </svg>
                <div>
                    <strong>Nome do Clube</strong><br>
                    <span>Brasileirão Série A</span>
                </div>
            </div>
            
            <div class="stats-grid">
                <div class="stat-item"><span>Valor do clube</span><strong>R$ 184M</strong></div>
                <div class="stat-item"><span>Torcedores</span><strong>2,4M</strong></div>
                <div class="stat-item"><span>Reputação</span><strong>78 / 100</strong></div>
                <div class="stat-item"><span>Orçamento</span><strong>R$ 22M</strong></div>
                <div class="stat-item"><span>Receita mensal</span><strong>R$ 6,1M</strong></div>
                <div class="stat-item"><span>Patrocinador</span><strong>Vulcano Seguros</strong></div>
            </div>
            
            <h2>Últimas Temporadas</h2>
            <table class="historico">
                <thead>
                    <tr><th>Ano</th><th>J</th><th>V</th><th>E</th><th>D</th><th>GP</th><th>GC</th></tr>
                </thead>
                <tbody>
                    <tr><td class="ano">2026</td><td>14</td><td>8</td><td>4</td><td>2</td><td>26</td><td>15</td></tr>
                    <tr><td class="ano">2025</td><td>38</td><td>19</td><td>10</td><td>9</td><td>58</td><td>41</td></tr>
                    <tr><td class="ano">2024</td><td>38</td><td>17</td><td>12</td><td>9</td><td>52</td><td>44</td></tr>
                </tbody>
            </table>
        </section>
        
        <section class="box">
            <h2>Melhorias do Clube</h2>
            <div class="upgrades">
                
                <div class="upgrade">
                    <div class="upgrade-topo">
                        <strong>Departamento Médico</strong>
                        <div class="nivel"><span>Nível 2/5</span><div class="pontos">
                            <div class="ponto on"></div><div class="ponto on"></div><div class="ponto"></div><div class="ponto"></div><div class="ponto"></div>
                        </div></div>
                    </div>
                    <p class="efeito">Atual: <strong>reduz chance de lesões em 15%</strong></p>
                    <p class="proximo">Próximo nível: redução de 30% em fadiga pós-jogo</p>
                    <div class="upgrade-rodape"><span class="preco">R$ 3,2M</span><button class="btn-melhorar">Melhorar</button></div>
                </div>
                
                <div class="upgrade">
                    <div class="upgrade-topo">
                        <strong>Centro de Treinamento</strong>
                        <div class="nivel"><span>Nível 3/5</span><div class="pontos">
                            <div class="ponto on"></div><div class="ponto on"></div><div class="ponto on"></div><div class="ponto"></div><div class="ponto"></div>
                        </div></div>
                    </div>
                    <p class="efeito">Atual: <strong>evolução de jovens +10% mais rápida</strong></p>
                    <p class="proximo">Próximo nível: +20% na evolução de jovens</p>
                    <div class="upgrade-rodape"><span class="preco">R$ 5,8M</span><button class="btn-melhorar">Melhorar</button></div>
                </div>
                
                <div class="upgrade">
                    <div class="upgrade-topo">
                        <strong>Rede de Scouting</strong>
                        <div class="nivel"><span>Nível 1/5</span><div class="pontos">
                            <div class="ponto on"></div><div class="ponto"></div><div class="ponto"></div><div class="ponto"></div><div class="ponto"></div>
                        </div></div>
                    </div>
                    <p class="efeito">Atual: <strong>acesso a 2 regiões de olheiros</strong></p>
                    <p class="proximo">Próximo nível: acesso a mais 2 regiões e relatórios detalhados</p>
                    <div class="upgrade-rodape"><span class="preco">R$ 2,1M</span><button class="btn-melhorar">Melhorar</button></div>
                </div>

                <div class="upgrade">
                    <div class="upgrade-topo">
                        <strong>Estádio</strong>
                        <div class="nivel"><span>Nível 4/5</span><div class="pontos">
                            <div class="ponto on"></div><div class="ponto on"></div><div class="ponto on"></div><div class="ponto on"></div><div class="ponto"></div>
                        </div></div>
                    </div>
                    <p class="efeito">Atual: <strong>capacidade de 42 mil lugares</strong></p>
                    <p class="proximo">Próximo nível: capacidade de 55 mil e +12% de receita em bilheteria</p>
                    <div class="upgrade-rodape"><span class="preco">R$ 14,5M</span><button class="btn-melhorar">Melhorar</button></div>
                </div>
                
                <div class="upgrade">
                    <div class="upgrade-topo">
                        <strong>Marketing &amp; Patrocínio</strong>
                        <div class="nivel"><span>Nível 5/5</span><div class="pontos">
                            <div class="ponto on"></div><div class="ponto on"></div><div class="ponto on"></div><div class="ponto on"></div><div class="ponto on"></div>
                        </div></div>
                    </div>
                    <p class="efeito">Atual: <strong>+25% em receita de patrocínio</strong></p>
                    <p class="proximo">Nível máximo atingido</p>
                    <div class="upgrade-rodape"><span class="preco">—</span><button class="btn-melhorar" disabled>Máximo</button></div>
                </div>

            </div>
        </section>
        
    </div>

</main>
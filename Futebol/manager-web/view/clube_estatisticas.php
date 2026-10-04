<link rel="stylesheet" href="assets/css/clube_estatisticas.css"> 

<?php 

$clube = $_SESSION['estado_jogo'] ?? null;
$apiService = new ApiService();

$clubeAPI = $apiService->get("/clubes/{$clube->clube->id}");
$ligaInfo = $apiService->get("/competicoes/{$clube->liga}");

// 1. Bilheteria (2.5 jogos por mês em casa, 70% de público médio, ingresso R$ 50)
$capacidadeEstadio = $clubeAPI['capacidadeEstadio'] ?? 0;
$bilheteriaMensal = ($capacidadeEstadio * 0.70) * 50 * 2.5;

// 2. Venda de Camisas (Dividido por 12 meses, lucro líquido de R$ 40 por peça)
$camisasVendidas = $clubeAPI['camisasVendidas'] ?? 0;
$receitaCamisasMensal = ($camisasVendidas / 12) * 40;

// 3. Sócio-Torcedor (0.5% dos torcedores como sócios pagando R$ 40/mês)
$qntTorcedores = $clubeAPI['qntTorcedores'] ?? 0;
$receitaSociosMensal = ($qntTorcedores * 0.005) * 40;

// 4. Mídia/Patrocínio base (15% do orçamento total dividido em 12 meses)
$orcamento = $clubeAPI['orcamento'] ?? 0;
$receitaMidiaPatrocinio = ($orcamento * 0.15) / 12;

$receitaMensalTotal = $bilheteriaMensal + $receitaCamisasMensal + $receitaSociosMensal + $receitaMidiaPatrocinio;

// $patrocinador = ($clubeAPI['nomePatrocinador'] != null) ? $clubeAPI['nomePatrocinador'] : "Sem patrocínio";
$patrocinadorAPI = $apiService->get("/clubes/{$clube->clube->id}/patrocinador");
$patrocinador = $patrocinadorAPI['nomePatrocinador'] ?? 'Sem patrocínio';
?>

<main>

    <h1 class="titulo">Estatísticas do Clube</h1>
    
    <div class="layout">
        
        <section class="box">
            <div class="clube-cabecalho">
                <img src="assets/<?= htmlspecialchars($clubeAPI['foto'] ?? '') ?>" alt="" style="width: 54px; height: 54px; object-fit: contain;">
                
                <div>
                    <strong><?= htmlspecialchars($clubeAPI['nomeClube'] ?? '') ?></strong><br>
                    <span><?= htmlspecialchars($ligaInfo['nomeCompeticao'] ?? '') ?></span>
                </div>
            </div>
            
            <div class="stats-grid">
                <div class="stat-item"><span>Valor do clube</span><strong>R$ <?= formatarNumero($clubeAPI['valorClube']) ?></strong></div>
                <div class="stat-item"><span>Torcedores</span><strong><?= formatarNumero($clubeAPI['qntTorcedores']) ?></strong></div>
                <div class="stat-item"><span>Reputação</span><strong><?= $clubeAPI['reputacao'] ?> / 100</strong></div>
                <div class="stat-item"><span>Orçamento</span><strong>R$ <?= formatarNumero($clubeAPI['orcamento']) ?></strong></div>
                
                <div class="stat-item"><span>Receita mensal</span><strong>R$ <?= formatarNumero($receitaMensalTotal) ?></strong></div>
                
                <div class="stat-item"><span>Patrocinador</span><strong><?= $patrocinador ?></strong></div>
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
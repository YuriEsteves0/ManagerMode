<style>
/* NAV */
header {
    position: sticky;
    top: 0;
    padding-top: env(safe-area-inset-top, 0px);
    background: var(--background);
    border-bottom: 1px solid var(--roxo50P);
    z-index: 20;
}
.nav-wrap {
    display: flex;
    align-items: center;
    gap: 28px;
    padding: 14px clamp(16px, 4vw, 40px);
}

nav { 
    display: flex; 
    gap: 4px; 
    flex: 1; 
}

.marca {
    font-family: 'Inter', sans-serif;
    font-weight: 800;
    font-size: 16px;
    letter-spacing: -0.02em;
    white-space: nowrap;
    text-decoration: none;
    color: var(--branco);
}
.marca span { color: var(--verde); }

.nav-item { position: relative; }
.nav-item:hover { z-index: 30; }

/* Estilizando tanto <button> quanto <a> do menu principal */
.nav-item > button,
.nav-item > a {
    display: inline-block;
    text-decoration: none;
    font-family: 'Roboto', sans-serif;
    font-weight: 500;
    font-size: 12.5px;
    letter-spacing: 0.03em;
    color: var(--roxoTextoMaisClaro);
    background: transparent;
    border: none;
    padding: 8px 12px;
    border-radius: 6px;
    cursor: pointer;
    white-space: nowrap;
    transition: color 0.15s ease, background 0.15s ease;
}

.nav-item > button:hover,
.nav-item > a:hover,
.nav-item:focus-within > button,
.nav-item:focus-within > a { 
    color: var(--branco); 
    background: var(--fundoMeioTransparente); 
}

.nav-item.ativo > button,
.nav-item.ativo > a { color: var(--branco); }

.nav-item.ativo > button::after,
.nav-item.ativo > a::after {
    content: "";
    display: block;
    height: 2px;
    background: var(--verde);
    margin-top: 6px;
    border-radius: 2px;
}

.dropdown {
    position: absolute;
    top: calc(100% + 6px);
    left: 0;
    min-width: 200px;
    background: var(--fundoMeioTransparente);
    border: 1px solid var(--roxo50P);
    border-radius: 8px;
    padding: 6px;
    display: none;
    flex-direction: column;
    gap: 2px;
    z-index: 100;
}
.nav-item:hover .dropdown,
.nav-item:focus-within .dropdown { display: flex; }
.dropdown a {
    font-size: 13px;
    color: var(--roxoTextoMaisClaro);
    text-decoration: none;
    padding: 9px 12px;
    border-radius: 6px;
}
.dropdown a:hover { color: var(--branco); background: var(--roxoBrilho); }

/* ÁREA DIREITA DO HEADER (CLUBE + BOTÃO JOGAR) */
.header-actions {
    display: flex;
    align-items: center;
    gap: 16px;
    margin-left: auto;
}

.clube-atual {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 6px 12px;
    background: var(--fundoMeioTransparente);
    border: 1px solid var(--roxo50P);
    border-radius: 8px;
    text-decoration: none;
}

.clube-atual .escudo-nav {
    width: 24px;
    height: 27px;
    flex-shrink: 0;
}

.clube-atual .info-clube {
    display: flex;
    flex-direction: column;
    text-align: left;
}

.clube-atual .nome-clube {
    font-family: 'Inter', sans-serif;
    font-weight: 700;
    font-size: 13px;
    color: var(--branco);
    line-height: 1.2;
}

.clube-atual .liga-clube {
    font-family: 'Roboto', sans-serif;
    font-size: 11px;
    color: var(--roxoTextoMaisClaro);
}

.btn-jogar-header {
    font-family: 'Inter', sans-serif;
    font-weight: 700;
    font-size: 13px;
    letter-spacing: 0.04em;
    color: var(--branco);
    background: var(--verde);
    border: none;
    border-radius: 6px;
    padding: 9px 18px;
    cursor: pointer;
    text-decoration: none;
    transition: background 0.15s ease;
    white-space: nowrap;
}

.btn-jogar-header:hover {
    background: var(--verdeBrilho);
}
</style>
<?php
$pagina_atual = isset($_GET['pag']) ? $_GET['pag'] : 'inicio';

$paginas_clube = ['equipe', 'estatisticas', 'patrocinios', 'central-elenco'];
$paginas_negociacao = ['mercado', 'meus-atletas', 'propostas-enviadas', 'propostas-recebidas'];


?>

<header>
    <div class="nav-wrap">
        <a href="index.php?pag=inicio" class="marca">MANAGER<span>MODE</span>.COM</a>
        
        <nav>
            <div class="nav-item <?= ($pagina_atual == 'inicio') ? 'ativo' : '' ?>">
                <a href="index.php?pag=inicio">INÍCIO</a>
            </div>

            <div class="nav-item <?= in_array($pagina_atual, $paginas_clube) ? 'ativo' : '' ?>">
                <button type="button">CLUBE</button>
                <div class="dropdown">
                    <a href="index.php?pag=equipe">Equipe</a>
                    <a href="index.php?pag=estatisticas">Estatísticas do Clube</a>
                    <a href="index.php?pag=patrocinios">Patrocínios</a>
                    <a href="index.php?pag=central_elenco">Central do Elenco</a>
                </div>
            </div>

            <div class="nav-item <?= in_array($pagina_atual, $paginas_negociacao) ? 'ativo' : '' ?>">
                <button type="button">NEGOCIAÇÃO</button>
                <div class="dropdown">
                    <a href="index.php?pag=mercado">Comprar</a>
                    <a href="index.php?pag=propostas_recebidas">Propostas Recebidas</a>
                    <a href="index.php?pag=propostas_enviadas">Propostas Enviadas</a>
                </div>
            </div>

            <div class="nav-item <?= ($pagina_atual == 'calendario') ? 'ativo' : '' ?>">
                <a href="index.php?pag=calendario">CALENDÁRIO</a>
            </div>

            <div class="nav-item <?= ($pagina_atual == 'treino') ? 'ativo' : '' ?>">
                <a href="index.php?pag=treino">TREINO</a>
            </div>

            <div class="nav-item <?= ($pagina_atual == 'diretoria') ? 'ativo' : '' ?>">
                <a href="index.php?pag=diretoria">DIRETORIA</a>
            </div>

            <div class="nav-item <?= ($pagina_atual == 'carreira') ? 'ativo' : '' ?>">
                <a href="index.php?pag=carreira">CARREIRA</a>
            </div>
        </nav>
        
        <div class="header-actions">
            <a href="index.php?pag=diretoria" class="clube-atual">
                <img src="assets/<?= htmlspecialchars($_SESSION['carreira']['clube']['foto']) ?>" alt="" style="width: 24px; height: 24px; object-fit: contain;">
                <div class="info-clube">
                    <span class="nome-clube"><?= htmlspecialchars($_SESSION['carreira']['clube']['nomeClube'] ?? 'Sem Clube') ?></span>
                </div>
            </a>

            <a href="index.php?pag=partida" class="btn-jogar-header">JOGAR</a>
        </div>
    </div>
</header>
<link rel="stylesheet" href="assets/css/carreira.css"> 

<main>
    
<!-- Escudo genérico reutilizável (brasão sem logo real) -->
<svg width="0" height="0" style="position:absolute">
  <defs>
    <symbol id="escudo-generico" viewBox="0 0 48 54">
      <path d="M24 2 L44 9 V25 C44 39 35 48 24 52 C13 48 4 39 4 25 V9 Z" />
    </symbol>
  </defs>
</svg>

<div class="pagina">
  <div>
    <h1 class="titulo">Carreira</h1>
    <p class="subtitulo">Gerencie sua trajetória, seu vínculo atual e as propostas recebidas.</p>
  </div>

  <div class="layout-carreira">

    <!-- ===================== CAIXA ESQUERDA — TÉCNICO ===================== -->
    <section class="box" id="box-tecnico">
      <h2>Ficha do técnico</h2>
      <div class="rolavel">

        <div class="perfil-tecnico">
          <div class="avatar-tecnico">CM</div>
          <div>
            <div class="nome">Carlos Mendes</div>
            <div class="clube-atual">
              <svg class="escudo-mini" viewBox="0 0 48 54" fill="var(--roxoBrilho)" stroke="var(--roxo50P)"><use href="#escudo-generico"/></svg>
              Estrela do Vale FC
            </div>
            <div class="badges-perfil">
              <span class="tag nacionalidade">🇧🇷 Brasileiro</span>
              <span class="tag contrato">Contrato até 2034</span>
              <span class="tag reputacao">Renomado</span>
            </div>
          </div>
        </div>

        <div>
          <h2>Títulos conquistados</h2>
          <div class="lista-titulos">
            <div class="titulo-item">
              <svg class="icone-troféu" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6"><path d="M7 4h10v4a5 5 0 0 1-10 0V4Z"/><path d="M7 5H4a3 3 0 0 0 3 4"/><path d="M17 5h3a3 3 0 0 1-3 4"/><path d="M12 13v3"/><path d="M9 20h6"/><path d="M10 16h4l1 4H9l1-4Z"/></svg>
              <span class="nome-titulo">Liga Nacional</span>
              <span class="qtd">3</span>
            </div>
            <div class="titulo-item">
              <svg class="icone-troféu" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6"><path d="M7 4h10v4a5 5 0 0 1-10 0V4Z"/><path d="M7 5H4a3 3 0 0 0 3 4"/><path d="M17 5h3a3 3 0 0 1-3 4"/><path d="M12 13v3"/><path d="M9 20h6"/><path d="M10 16h4l1 4H9l1-4Z"/></svg>
              <span class="nome-titulo">Copa Continental</span>
              <span class="qtd">1</span>
            </div>
            <div class="titulo-item">
              <svg class="icone-troféu" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6"><path d="M7 4h10v4a5 5 0 0 1-10 0V4Z"/><path d="M7 5H4a3 3 0 0 0 3 4"/><path d="M17 5h3a3 3 0 0 1-3 4"/><path d="M12 13v3"/><path d="M9 20h6"/><path d="M10 16h4l1 4H9l1-4Z"/></svg>
              <span class="nome-titulo">Supercopa Regional</span>
              <span class="qtd">2</span>
            </div>
          </div>
        </div>

        <div>
          <h2>Histórico de clubes</h2>
          <div style="display:flex; flex-direction:column; gap:8px;">
            <div class="historico-clube">
              <svg class="escudo-mini" viewBox="0 0 48 54" fill="var(--roxo50P)" stroke="var(--roxoTexto)"><use href="#escudo-generico"/></svg>
              <span class="nome-clube-hist">Estrela do Vale FC</span>
              <span class="periodo">2024 – atual</span>
            </div>
            <div class="historico-clube">
              <svg class="escudo-mini" viewBox="0 0 48 54" fill="var(--roxo50P)" stroke="var(--roxoTexto)"><use href="#escudo-generico"/></svg>
              <span class="nome-clube-hist">Porto Alto SC</span>
              <span class="periodo">2021 – 2024</span>
            </div>
            <div class="historico-clube">
              <svg class="escudo-mini" viewBox="0 0 48 54" fill="var(--roxo50P)" stroke="var(--roxoTexto)"><use href="#escudo-generico"/></svg>
              <span class="nome-clube-hist">Atlético Serra</span>
              <span class="periodo">2019 – 2021</span>
            </div>
          </div>
        </div>

        <div>
          <h2>Desempenho por temporada</h2>
          <table>
            <thead>
              <tr>
                <th>Ano</th>
                <th class="num">Jogos</th>
                <th class="num">V</th>
                <th class="num">E</th>
                <th class="num">D</th>
              </tr>
            </thead>
            <tbody>
              <tr class="destaque">
                <td class="destaque-coluna">2026</td>
                <td class="num">124</td>
                <td class="num">72</td>
                <td class="num">28</td>
                <td class="num">24</td>
              </tr>
              <tr>
                <td>2025</td>
                <td class="num">118</td>
                <td class="num">65</td>
                <td class="num">30</td>
                <td class="num">23</td>
              </tr>
              <tr>
                <td>2024</td>
                <td class="num">96</td>
                <td class="num">50</td>
                <td class="num">26</td>
                <td class="num">20</td>
              </tr>
              <tr>
                <td>2023</td>
                <td class="num">88</td>
                <td class="num">44</td>
                <td class="num">25</td>
                <td class="num">19</td>
              </tr>
            </tbody>
          </table>
        </div>

      </div>
    </section>

    <!-- ===================== CAIXA DIREITA — MERCADO/PROPOSTAS ===================== -->
    <section class="box" id="box-mercado">
      <h2>Mercado de trabalho</h2>
      <div class="rolavel">

        <div class="bloco-demissao">
          <button class="btn-secundario perigo">Pedir demissão do clube atual</button>
        </div>

        <div style="display:flex; flex-direction:column; gap:10px;">
          <div class="item-linha proposta">
            <svg class="escudo-clube" viewBox="0 0 48 54" fill="var(--verdeBrilho)" stroke="var(--roxo50P)"><use href="#escudo-generico"/></svg>
            <div class="dados-clube">
              <span class="nome-clube">Real Serrano</span>
              <span class="liga-clube">Liga Nacional</span>
            </div>
            <div class="salario">R$ 180.000<span>por mês</span></div>
            <button class="btn-primario pequeno">Aceitar</button>
          </div>

          <div class="item-linha proposta">
            <svg class="escudo-clube" viewBox="0 0 48 54" fill="var(--amarelo15p)" stroke="var(--amarelo)"><use href="#escudo-generico"/></svg>
            <div class="dados-clube">
              <span class="nome-clube">Seleção do Peru</span>
              <span class="liga-clube">Seleção nacional</span>
            </div>
            <div class="salario">R$ 220.000<span>por mês</span></div>
            <button class="btn-primario pequeno">Aceitar</button>
          </div>

          <div class="item-linha proposta">
            <svg class="escudo-clube" viewBox="0 0 48 54" fill="var(--roxoBrilho)" stroke="var(--roxo50P)"><use href="#escudo-generico"/></svg>
            <div class="dados-clube">
              <span class="nome-clube">Foz United</span>
              <span class="liga-clube">Premier Continental</span>
            </div>
            <div class="salario">€ 95.000<span>por mês</span></div>
            <button class="btn-primario pequeno">Aceitar</button>
          </div>

          <div class="item-linha proposta">
            <svg class="escudo-clube" viewBox="0 0 48 54" fill="var(--roxo50P)" stroke="var(--roxoTexto)"><use href="#escudo-generico"/></svg>
            <div class="dados-clube">
              <span class="nome-clube">Porto Alto SC</span>
              <span class="liga-clube">Liga Nacional</span>
            </div>
            <div class="salario">R$ 150.000<span>por mês</span></div>
            <button class="btn-primario pequeno">Aceitar</button>
          </div>

          <div class="item-linha proposta">
            <svg class="escudo-clube" viewBox="0 0 48 54" fill="var(--cinza)" stroke="var(--roxo50P)"><use href="#escudo-generico"/></svg>
            <div class="dados-clube">
              <span class="nome-clube">Atlético Serra</span>
              <span class="liga-clube">Liga Nacional</span>
            </div>
            <div class="salario">R$ 132.000<span>por mês</span></div>
            <button class="btn-primario pequeno">Aceitar</button>
          </div>
        </div>

      </div>
    </section>

  </div>
</div>

</main>
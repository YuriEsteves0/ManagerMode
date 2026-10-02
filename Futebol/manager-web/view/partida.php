<link rel="stylesheet" href="assets/css/partida.css"> 

<main>
    
<!-- Escudo genérico reutilizável (brasão sem logo real) -->
<svg width="0" height="0" style="position:absolute">
  <defs>
    <symbol id="escudo-generico" viewBox="0 0 48 54">
      <path d="M24 2 L44 9 V25 C44 39 35 48 24 52 C13 48 4 39 4 25 V9 Z" />
    </symbol>
    <symbol id="icone-bola" viewBox="0 0 24 24">
      <circle cx="12" cy="12" r="9" fill="none" stroke="currentColor" stroke-width="1.6"/>
      <path d="M12 7l3.5 2.5-1.3 4h-4.4l-1.3-4Z" fill="currentColor"/>
    </symbol>
  </defs>
</svg>

<section class="box">

  <div class="placar">
    <div class="time-placar">
      <svg class="escudo-placar" viewBox="0 0 48 54" fill="var(--verdeBrilho)" stroke="var(--roxo50P)"><use href="#escudo-generico"/></svg>
      <span class="nome-time">Estrela do Vale FC</span>
    </div>

    <div class="centro-placar">
      <span class="resultado">2 — 1</span>
      <span class="tempo">90:00</span>
    </div>

    <div class="time-placar">
      <svg class="escudo-placar" viewBox="0 0 48 54" fill="var(--roxoBrilho)" stroke="var(--roxo50P)"><use href="#escudo-generico"/></svg>
      <span class="nome-time">Foz United</span>
    </div>
  </div>

  <div class="acontecimentos">
    <h2>Acontecimentos da partida</h2>
    <div class="rolavel">

      <div class="evento gol mandante">
        <svg class="icone-evento" viewBox="0 0 24 24"><use href="#icone-bola"/></svg>
        <span class="jogador">P. Coutinho</span>
        <span class="minuto">12'</span>
      </div>

      <div class="evento visitante">
        <svg class="icone-evento" viewBox="0 0 24 24"><use href="#icone-bola"/></svg>
        <span class="jogador">R. Almeida</span>
        <span class="minuto">45'</span>
      </div>

      <div class="evento mandante">
        <svg class="icone-evento" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6"><rect x="7" y="4" width="10" height="14" rx="1.5"/></svg>
        <span class="jogador">Hugo Moura</span>
        <span class="minuto">63'</span>
        <span class="cartao amarelo-cartao"></span>
      </div>

      <div class="evento gol mandante">
        <svg class="icone-evento" viewBox="0 0 24 24"><use href="#icone-bola"/></svg>
        <span class="jogador">P. Coutinho</span>
        <span class="minuto">78'</span>
      </div>

      <div class="evento mandante">
        <svg class="icone-evento" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6"><rect x="7" y="4" width="10" height="14" rx="1.5"/></svg>
        <span class="jogador">Hugo Moura</span>
        <span class="minuto">82'</span>
        <span class="cartao"></span>
      </div>

    </div>
  </div>

  <a href="index.php?pag=imprensa">
    <button class="btn-primario">Próximo</button>
  </a>

</section>
</main>
// Animações exclusivas da tela de calendário. Usa as funções de geral.js.
// Roda em DOMContentLoaded, depois do script da página, que já desenhou o calendário.
document.addEventListener('DOMContentLoaded', function () {
    if (!window.Anim) return;

    var reduzir = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    var EASE = 'cubic-bezier(0.2, 0.7, 0.2, 1)';

    // ---------- Helpers locais (só esta tela usa) ----------

    // Enche barras a partir da esquerda (o Anim.encher, sozinho, cresce do centro)
    function encherDaEsquerda(elementos, opcoes) {
        Array.prototype.forEach.call(elementos, function (el) {
            el.style.transformOrigin = 'left center';
        });
        Anim.encher(elementos, opcoes);
    }

    // Pequeno "quique" ao passar o mouse num dia de jogo
    function quique(el) {
        if (reduzir || !el) return;
        el.animate(
            [
                { transform: 'scale(1)' },
                { transform: 'scale(1.18)' },
                { transform: 'scale(1)' }
            ],
            { duration: 300, easing: EASE }
        );
    }

    // Conta as porcentagens da enquete (0 -> valor)
    function contarTodos(elementos, opcoes) {
        Array.prototype.forEach.call(elementos, function (el) {
            Anim.contador(el, opcoes);
        });
    }

    // ---------- Destaques do calendário (hoje e dia do próximo jogo) ----------

    function destacarDias(atraso) {
        var grid = document.getElementById('calGrid');
        if (!grid) return;

        var alvo = grid.querySelector('.dia.jogo-alvo');
        var hoje = grid.querySelector('.dia.hoje');

        // Dia do próximo jogo fica brilhando devagar, sem parar
        if (alvo) Anim.pulsar(alvo, { atraso: atraso, duracao: 1800, vezes: Infinity });
        // Hoje pulsa duas vezes (se já não for o dia do jogo)
        if (hoje && hoje !== alvo) Anim.pulsar(hoje, { atraso: atraso, duracao: 700, vezes: 2 });
    }

    // ---------- 1. ENTRADA DA PÁGINA ----------
    Anim.entrada(document.querySelectorAll('h1.titulo'), { y: 10 });
    Anim.entrada(document.querySelectorAll('.layout > .box'), { atraso: 150, y: 14, intervalo: 120 });

    var grid = document.getElementById('calGrid');
    var mesAno = document.getElementById('mesAno');

    // Calendário (esquerda)
    Anim.entrada(document.querySelectorAll('.cal-topo'), { atraso: 350, y: 8, duracao: 300 });
    Anim.entrada(document.querySelectorAll('.cal-semana span'), { atraso: 400, intervalo: 25, y: 6, duracao: 280 });
    if (grid) {
        // Os dias aparecem em "onda", um depois do outro
        Anim.entrada(grid.querySelectorAll('.dia:not(.vazio)'), { atraso: 450, intervalo: 10, y: 6, duracao: 280 });
        Anim.pop(grid.querySelectorAll('.dia.jogo'), { atraso: 950, intervalo: 70, duracao: 380 });
    }
    Anim.entrada(document.querySelectorAll('.legenda-cal span'), { atraso: 1000, intervalo: 60, y: 6, duracao: 280 });
    destacarDias(1300);

    // Próximo jogo (direita)
    var direita = document.querySelectorAll('.layout > .box')[1];
    if (direita) {
        var q = function (sel) { return direita.querySelectorAll(sel); };

        Anim.revelar(q('.manchete'), { atraso: 450, duracao: 550 });
        Anim.entrada(q('.subdata'), { atraso: 550, y: 6, duracao: 300 });

        // Confronto: os dois times entram de lados opostos e o X aparece no meio
        var times = q('.confronto .time');
        if (times[0]) Anim.deslizar([times[0]], { x: -30, atraso: 650, intervalo: 0, duracao: 420 });
        if (times[1]) Anim.deslizar([times[1]], { x: 30, atraso: 650, intervalo: 0, duracao: 420 });
        Anim.pop(q('.confronto .x'), { atraso: 800, duracao: 400 });
        Anim.pop(q('.tag-voce'), { atraso: 1050, duracao: 350 });

        // Informações do jogo
        Anim.entrada(q('.info-jogo .linha'), { atraso: 850, intervalo: 60, y: 8, duracao: 300 });

        // Enquete: linhas deslizam, barras enchem e as porcentagens contam
        Anim.deslizar(q('.enquete-opcao'), { x: -16, atraso: 1150, intervalo: 90, duracao: 350 });
        encherDaEsquerda(q('.enquete-opcao .barra i'), { atraso: 1300, intervalo: 90, duracao: 700 });
        contarTodos(q('.enquete-opcao .pct'), { atraso: 1300, duracao: 700 });
        Anim.entrada(q('.veredito'), { atraso: 1650, y: 6, duracao: 300 });

        // Próximos jogos
        Anim.entrada(q('.depois h2'), { atraso: 1700, y: 6, duracao: 280 });
        Anim.deslizar(q('.depois li'), { x: 16, atraso: 1750, intervalo: 80, duracao: 320 });
    }

    // ---------- 2. TROCA DE MÊS ----------
    // renderizar() reescreve #mesAno e recria todos os dias do grid.
    // O observer roda depois dessa função terminar, então os dias novos já existem.
    var direcao = 1;

    // Captura o clique ANTES do onclick inline para saber se foi ‹ (volta) ou › (avança)
    var nav = document.querySelector('.cal-nav');
    if (nav) {
        nav.addEventListener('click', function (e) {
            var botoes = nav.querySelectorAll('button');
            var botao = e.target.closest('button');
            if (!botao) return;
            direcao = Array.prototype.indexOf.call(botoes, botao) === 0 ? -1 : 1;
        }, true);
    }

    if (mesAno && grid) {
        new MutationObserver(function () {
            // O nome do mês e o grid deslizam na direção da navegação
            Anim.deslizar([mesAno], { x: direcao * 18, intervalo: 0, duracao: 300 });
            Anim.deslizar([grid], { x: direcao * 28, intervalo: 0, duracao: 320 });
            Anim.entrada(grid.querySelectorAll('.dia:not(.vazio)'), { atraso: 60, intervalo: 8, y: 6, duracao: 260 });

            // Dias de jogo aparecem com pop logo depois
            Anim.pop(grid.querySelectorAll('.dia.jogo'), { atraso: 300, intervalo: 60, duracao: 380 });
            destacarDias(500);
        }).observe(mesAno, { childList: true, characterData: true, subtree: true });

        // ---------- 3. HOVER NOS DIAS DE JOGO ----------
        // Delegação: os dias são recriados a cada mês, então o listener fica no grid
        grid.addEventListener('mouseover', function (e) {
            var dia = e.target.closest('.dia.jogo');
            if (!dia || dia === e.relatedTarget) return;
            quique(dia);
        });
    }

    // ---------- 4. BOTÕES DE NAVEGAÇÃO ----------
    // Os botões ‹ › dão um pequeno "pop" ao clicar
    document.querySelectorAll('.cal-nav button').forEach(function (btn) {
        btn.addEventListener('click', function () {
            Anim.pop([btn], { duracao: 300 });
        });
    });
});
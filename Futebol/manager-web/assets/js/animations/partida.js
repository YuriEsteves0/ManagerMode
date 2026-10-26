// Animações exclusivas da tela de partida (resultado final). Usa as funções de geral.js.
// A página é estática (sem script próprio), então tudo aqui é entrada, hover e clique.
document.addEventListener('DOMContentLoaded', function () {
    if (!window.Anim) return;

    var reduzir = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    var EASE = 'cubic-bezier(0.2, 0.7, 0.2, 1)';

    var box = document.querySelector('.box');
    if (!box) return;

    var q = function (sel) { return box.querySelectorAll(sel); };

    // ---------- Helpers locais (só esta tela usa) ----------

    // O placar é "2 — 1": cada número é envolvido num span para poder contar separado
    function prepararPlacar(el) {
        if (!el || el.querySelector('.gol-num')) return [];
        var partes = el.textContent.split(/(\d+)/);
        el.textContent = '';
        var numeros = [];
        partes.forEach(function (p) {
            if (/^\d+$/.test(p)) {
                var s = document.createElement('span');
                s.className = 'gol-num';
                s.style.display = 'inline-block';
                s.textContent = p;
                el.appendChild(s);
                numeros.push(s);
            } else if (p) {
                el.appendChild(document.createTextNode(p));
            }
        });
        return numeros;
    }

    // Bola gira ao passar o mouse na linha de gol
    function girar(el) {
        if (reduzir || !el) return;
        el.animate(
            [
                { transform: 'rotate(0deg) scale(1)' },
                { transform: 'rotate(360deg) scale(1.3)' },
                { transform: 'rotate(360deg) scale(1)' }
            ],
            { duration: 600, easing: EASE }
        );
    }

    // ---------- 1. ENTRADA DA PÁGINA ----------
    Anim.entrada([box], { y: 16, duracao: 380 });

    // Placar: os dois times entram de lados opostos e o centro aparece com pop
    var times = q('.time-placar');
    if (times[0]) Anim.deslizar([times[0]], { x: -30, atraso: 250, intervalo: 0, duracao: 420 });
    if (times[1]) Anim.deslizar([times[1]], { x: 30, atraso: 250, intervalo: 0, duracao: 420 });
    Anim.pop(q('.escudo-placar'), { atraso: 400, intervalo: 120, duracao: 450 });

    var resultado = box.querySelector('.resultado');
    Anim.pop(q('.resultado'), { atraso: 450, duracao: 450 });
    var numeros = prepararPlacar(resultado);
    numeros.forEach(function (n, i) {
        Anim.contador(n, { atraso: 500 + i * 150, duracao: 800 });
    });

    // Tempo ("90:00") aparece e brilha uma vez
    Anim.pop(q('.tempo'), { atraso: 700, duracao: 400 });
    Anim.pulsar(box.querySelector('.tempo'), { atraso: 1200, duracao: 800 });

    // Acontecimentos: título e eventos deslizam em cascata,
    // mandante entra pela esquerda e visitante pela direita
    Anim.entrada(q('.acontecimentos h2'), { atraso: 800, y: 6, duracao: 280 });
    var eventos = q('.evento');
    Array.prototype.forEach.call(eventos, function (ev, i) {
        var visitante = ev.classList.contains('visitante');
        Anim.deslizar([ev], {
            x: visitante ? 20 : -20,
            atraso: 900 + i * 90,
            intervalo: 0,
            duracao: 340
        });
    });

    // Ícones, minutos e cartões aparecem com pop logo depois de cada linha
    Array.prototype.forEach.call(eventos, function (ev, i) {
        var itens = ev.querySelectorAll('.icone-evento, .cartao');
        Anim.pop(itens, { atraso: 1000 + i * 90, intervalo: 0, duracao: 380 });
    });

    // Gols: a linha brilha uma vez, em sequência, depois que tudo entrou
    var gols = q('.evento.gol');
    Array.prototype.forEach.call(gols, function (g, i) {
        Anim.pulsar(g, { atraso: 1500 + i * 250, duracao: 700 });
    });

    // Botão "Próximo" sobe por último
    Anim.entrada(q('.btn-primario'), { atraso: 900 + eventos.length * 90 + 100, y: 10, duracao: 320 });

    // ---------- 2. HOVER ----------
    // Bola gira ao passar o mouse numa linha de gol
    Array.prototype.forEach.call(gols, function (g) {
        g.addEventListener('mouseenter', function () {
            girar(g.querySelector('.icone-evento'));
        });
    });

    // Cartões dão um pequeno "pulo" ao passar o mouse na linha
    Array.prototype.forEach.call(eventos, function (ev) {
        var cartao = ev.querySelector('.cartao');
        if (!cartao) return;
        ev.addEventListener('mouseenter', function () { Anim.pop([cartao], { duracao: 320 }); });
    });

    // ---------- 3. CLIQUE ----------
    var btn = box.querySelector('.btn-primario');
    if (btn) {
        btn.addEventListener('click', function () {
            if (!btn.disabled) Anim.pop([btn], { duracao: 300 });
        });
    }
});
// Animações exclusivas da tela de diretoria. Usa as funções de geral.js.
// A página é toda renderizada pelo PHP (sem script próprio), então tudo aqui é só entrada e hover.
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

    // Leve "respiro" no card ao passar o mouse
    function erguer(el) {
        if (reduzir || !el) return;
        el.animate(
            [
                { transform: 'translateY(0)' },
                { transform: 'translateY(-3px)' },
                { transform: 'translateY(0)' }
            ],
            { duration: 320, easing: EASE }
        );
    }

    // ---------- 1. ENTRADA DA PÁGINA ----------
    Anim.entrada(document.querySelectorAll('h1.titulo'), { y: 10 });

    var caixas = document.querySelectorAll('.layout .box');
    Anim.entrada(caixas, { atraso: 150, y: 14, intervalo: 120 });

    // Caixa 1: clube, orçamento, confiança e metas
    var cabecalho = document.querySelectorAll('.clube-cabecalho');
    Anim.entrada(cabecalho, { atraso: 350, y: 8, duracao: 300 });
    Anim.pop(document.querySelectorAll('.clube-cabecalho img'), { atraso: 400, duracao: 400 });
    Anim.entrada(document.querySelectorAll('.orcamento-linha'), { atraso: 450, y: 8, duracao: 300 });

    // Confiança: o número conta de 0 até o valor e a barra enche junto
    Anim.entrada(document.querySelectorAll('.confianca-bloco'), { atraso: 500, y: 8, duracao: 300 });
    Anim.contador(document.querySelector('.confianca-topo strong'), { atraso: 650, duracao: 900 });
    encherDaEsquerda(document.querySelectorAll('.confianca-barra i'), { atraso: 650, duracao: 900 });

    // Evento atual (selo verde) aparece com pop e brilha uma vez
    var evento = document.querySelector('.evento-atual');
    Anim.pop(document.querySelectorAll('.evento-atual'), { atraso: 950, duracao: 400 });
    Anim.pulsar(evento, { atraso: 1400, duracao: 800 });

    // Metas deslizam em cascata
    Anim.entrada(document.querySelectorAll('.coluna-esquerda .box:first-child h2'), { atraso: 1000, y: 6, duracao: 280 });
    Anim.deslizar(document.querySelectorAll('.metas li'), { x: -16, atraso: 1050, intervalo: 70, duracao: 330 });

    // Caixa 2: recados
    Anim.entrada(document.querySelectorAll('.coluna-esquerda .box:last-child h2'), { atraso: 500, y: 6, duracao: 280 });
    var recados = document.querySelectorAll('.recado');
    Anim.deslizar(recados, { x: -16, atraso: 650, intervalo: 80, duracao: 340 });
    // Os selos de +% / -% aparecem com pop logo depois de cada recado
    Anim.pop(document.querySelectorAll('.recado .delta'), { atraso: 800, intervalo: 80, duracao: 380 });

    // Caixa 3: ações de carreira (coluna da direita)
    Anim.entrada(document.querySelectorAll('.coluna-direita .box h2'), { atraso: 450, y: 6, duracao: 280 });
    Anim.pop(document.querySelectorAll('.acao-item'), { atraso: 550, intervalo: 80, duracao: 380 });
    Anim.pop(document.querySelectorAll('.status-tag'), { atraso: 800, intervalo: 80, duracao: 350 });

    // Ações que podem ser solicitadas: o botão pulsa uma vez para chamar atenção
    var botoesLivres = document.querySelectorAll('.btn-acao:not(:disabled)');
    Array.prototype.forEach.call(botoesLivres, function (b, i) {
        Anim.pulsar(b, { atraso: 1300 + i * 150, duracao: 700 });
    });

    // Ações "Em Análise": o selo respira devagar, indicando que está aguardando
    Array.prototype.forEach.call(document.querySelectorAll('.status-tag.analise'), function (tag) {
        Anim.respirar(tag, { duracao: 2200 });
    });

    // ---------- 2. HOVER ----------
    // Cards de ação e recados dão um pequeno "erguer" ao passar o mouse
    document.querySelectorAll('.acao-item').forEach(function (card) {
        card.addEventListener('mouseenter', function () { erguer(card); });
    });

    // Botão desabilitado: navegadores não disparam click nele, então o "tremer"
    // é feito ao passar o mouse, avisando que a ação não está liberada.
    document.querySelectorAll('.btn-acao:disabled').forEach(function (btn) {
        btn.addEventListener('mouseenter', function () { Anim.tremer(btn); });
    });

    // ---------- 3. CLIQUE NUM BOTÃO LIBERADO ----------
    document.querySelectorAll('.btn-acao').forEach(function (btn) {
        btn.addEventListener('click', function () {
            if (!btn.disabled) Anim.pop([btn], { duracao: 320 });
        });
    });
});
// Animações exclusivas da tela de configurações. Usa as funções de geral.js.
// Roda em DOMContentLoaded, depois do script da página, que já aplicou as configurações salvas.
document.addEventListener('DOMContentLoaded', function () {
    if (!window.Anim) return;

    var reduzir = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    var EASE = 'cubic-bezier(0.2, 0.7, 0.2, 1)';

    var form = document.getElementById('form-config');
    if (!form) return;

    var q = function (sel) { return form.querySelectorAll(sel); };

    // ---------- Helper local (só esta tela usa) ----------

    // Dá um "quique" na bolinha do toggle ao ligar/desligar.
    // A bolinha é o ::after do <i>, que não dá para animar via JS,
    // então o quique vai no próprio <i> (o trilho do switch).
    function quique(el) {
        if (reduzir || !el) return;
        el.animate(
            [
                { transform: 'scale(1)' },
                { transform: 'scale(1.15)' },
                { transform: 'scale(1)' }
            ],
            { duration: 280, easing: EASE }
        );
    }

    // ---------- 1. ENTRADA DA PÁGINA ----------
    Anim.entrada(document.querySelectorAll('h1.titulo'), { y: 10 });

    // Caixas: coluna da esquerda e da direita sobem em cascata
    var colunas = q('.cfg-col');
    if (colunas[0]) Anim.entrada(colunas[0].querySelectorAll('.cfg-box'), { atraso: 150, y: 14, intervalo: 110 });
    if (colunas[1]) Anim.entrada(colunas[1].querySelectorAll('.cfg-box'), { atraso: 250, y: 14, intervalo: 110 });

    // Títulos das caixas e linhas de configuração
    Anim.entrada(q('.cfg-box h2'), { atraso: 400, intervalo: 60, y: 6, duracao: 280 });
    Anim.deslizar(q('.cfg-linha'), { x: -16, atraso: 450, intervalo: 55, duracao: 330 });

    // Toggles aparecem com pop logo depois das linhas
    Anim.pop(q('.switch'), { atraso: 650, intervalo: 45, duracao: 380 });

    // Resumo do jogo: escudo com pop e linhas de informação em sequência
    Anim.pop(q('.jogo-cabecalho img'), { atraso: 500, duracao: 420 });
    Anim.entrada(q('.jogo-cabecalho > div'), { atraso: 560, y: 8, duracao: 300 });
    Anim.entrada(q('.info-linha'), { atraso: 650, intervalo: 60, y: 6, duracao: 300 });

    // Botões do card e do rodapé
    Anim.pop(q('.btn-cfg'), { atraso: 800, intervalo: 60, duracao: 380 });
    Anim.entrada(q('.cfg-rodape'), { atraso: 900, y: 10, duracao: 300 });

    // ---------- 2. TOGGLES ----------
    // O input fica invisível por cima do trilho; o evento "change" dispara
    // tanto no clique quanto pelo teclado
    form.addEventListener('change', function (e) {
        var input = e.target;
        if (!input || input.type !== 'checkbox') return;
        var trilho = input.parentElement.querySelector('i');
        quique(trilho);
        // A linha inteira brilha de leve para confirmar a mudança
        var linha = input.closest('.cfg-linha');
        if (linha) Anim.pulsar(linha, { duracao: 450 });
    });

    // ---------- 3. AVISO DE SALVAR ----------
    // O script da página troca o texto e adiciona a classe "visivel" no #cfg-aviso.
    // Só o texto novo precisa de movimento: o fade já é feito pelo CSS (opacity).
    var aviso = document.getElementById('cfg-aviso');
    if (aviso) {
        new MutationObserver(function () {
            if (!aviso.classList.contains('visivel')) return;
            Anim.entrada([aviso], { y: 6, duracao: 280 });
        }).observe(aviso, { attributes: true, attributeFilter: ['class'], childList: true, characterData: true, subtree: true });
    }

    // ---------- 4. BOTÕES ----------
    // Feedback de clique: pop em todos, e o botão de perigo treme (ação séria)
    Array.prototype.forEach.call(q('.btn-cfg'), function (btn) {
        btn.addEventListener('click', function () {
            if (btn.classList.contains('perigo')) Anim.tremer(btn);
            else Anim.pop([btn], { duracao: 300 });
        });
    });

    // Botão de perigo também treme ao passar o mouse, avisando que é uma zona sensível
    var perigo = form.querySelector('.btn-cfg.perigo');
    if (perigo) {
        perigo.addEventListener('mouseenter', function () { Anim.tremer(perigo); });
    }

    // Caixa de perigo respira devagar para sinalizar cuidado
    Anim.respirar(form.querySelector('.box-perigo h2'), { duracao: 2600 });
});
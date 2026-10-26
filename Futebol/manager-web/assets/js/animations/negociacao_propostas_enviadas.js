// Animações exclusivas da tela de propostas enviadas. Usa as funções de geral.js.
// Roda em DOMContentLoaded, depois do script da página, que já preencheu a ficha.
document.addEventListener('DOMContentLoaded', function () {
    if (!window.Anim) return;

    // ---------- Funções reutilizadas na entrada e nas atualizações ----------

    function animarFicha(atraso) {
        atraso = atraso || 0;
        Anim.entrada(document.querySelectorAll('.ficha-topo'), { atraso: atraso, y: 8, duracao: 300 });
        Anim.pop(document.querySelectorAll('.mini-stats .item'), { atraso: atraso + 80, intervalo: 45, duracao: 350 });

        // Atributos: a linha sobe e a barra enche
        var linhas = document.querySelectorAll('#ficha-atributos .atributo-linha');
        Anim.entrada(linhas, { atraso: atraso + 350, intervalo: 40, y: 8, duracao: 300 });
        Anim.encher(document.querySelectorAll('#ficha-atributos .barra i'),
            { atraso: atraso + 400, intervalo: 60, duracao: 600 });

        // Lesões e estatísticas
        Anim.entrada(document.querySelectorAll('#ficha-lesoes li'),
            { atraso: atraso + 600, intervalo: 40, y: 6, duracao: 280 });
        Anim.entrada(document.querySelectorAll('#ficha-estatisticas tr'),
            { atraso: atraso + 650, intervalo: 40, y: 6, duracao: 280 });

        Anim.entrada(document.querySelectorAll('.btn-formalizar'), { atraso: atraso + 700, y: 8, duracao: 300 });
    }

    // ---------- 1. ENTRADA DA PÁGINA ----------
    Anim.entrada(document.querySelectorAll('h1.titulo'), { y: 10 });
    Anim.entrada(document.querySelectorAll('.layout > .box'), { atraso: 150, y: 14, intervalo: 120 });

    // Lista da esquerda: propostas deslizam em cascata
    Anim.deslizar(document.querySelectorAll('.jogador-linha'), { x: -16, atraso: 400, intervalo: 70, duracao: 350 });

    // Ficha da direita
    animarFicha(450);

    // Tag de status aparece com "pop"
    Anim.pop(document.querySelectorAll('#ficha-tag'), { atraso: 700, duracao: 400 });

    // Botão de formalizar pulsa uma vez, só se a proposta foi aceita
    var btnFormalizar = document.getElementById('btn-formalizar');
    if (btnFormalizar && !btnFormalizar.disabled) {
        Anim.pulsar(btnFormalizar, { atraso: 1500 });
    }

    // ---------- 2. TROCA DE PROPOSTA ----------
    // O script da página reescreve o texto de #ficha-nome a cada seleção.
    // (mesmo que o nome seja igual, o texto é reescrito e o observer ainda dispara)
    var fichaNome = document.getElementById('ficha-nome');
    if (fichaNome) {
        new MutationObserver(function () {
            animarFicha(0);
            Anim.pop(document.querySelectorAll('#ficha-tag'), { atraso: 100, duracao: 350 });

            // Botão habilitado (proposta aceita) chama atenção
            var btn = document.getElementById('btn-formalizar');
            if (btn && !btn.disabled) Anim.pulsar(btn, { atraso: 900 });
        }).observe(fichaNome, { childList: true, characterData: true, subtree: true });
    }

    // A linha clicada pulsa
    document.querySelectorAll('.jogador-linha').forEach(function (linha) {
        linha.addEventListener('click', function () {
            Anim.pulsar(linha, { duracao: 450 });
        });
    });

    // Botão desabilitado treme se o usuário tentar clicar
    if (btnFormalizar) {
        btnFormalizar.addEventListener('click', function () {
            if (btnFormalizar.disabled) Anim.tremer(btnFormalizar);
        });
    }

    // ---------- 3. MODAL ----------
    var overlay = document.getElementById('overlayFormalizar');
    if (overlay) {
        new MutationObserver(function () {
            if (!overlay.classList.contains('aberto')) return;
            Anim.entrada(overlay.querySelectorAll('.modal'), { y: 16, duracao: 300 });
            Anim.entrada(overlay.querySelectorAll('.modal .campo'),
                { atraso: 120, intervalo: 40, y: 8, duracao: 280 });

            // Barra de moral enche
            Anim.encher(overlay.querySelectorAll('.moral-gauge .barra i'), { atraso: 350, duracao: 700 });

            // Aviso aparece só se estiver visível
            var aviso = document.getElementById('mod-aviso');
            if (aviso && aviso.style.display !== 'none') {
                Anim.entrada([aviso], { atraso: 450, y: 8, duracao: 300 });
                Anim.pulsar(aviso, { atraso: 750, duracao: 700 });
            }

            Anim.entrada(overlay.querySelectorAll('.btn-enviar'), { atraso: 500, y: 8, duracao: 300 });
        }).observe(overlay, { attributes: true, attributeFilter: ['class'] });
    }
});
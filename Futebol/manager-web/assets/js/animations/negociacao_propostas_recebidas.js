// Animações exclusivas da tela de propostas recebidas. Usa as funções de geral.js.
// Roda em DOMContentLoaded, depois do script da página, que já preencheu o detalhe.
document.addEventListener('DOMContentLoaded', function () {
    if (!window.Anim) return;

    // ---------- Funções reutilizadas na entrada e nas atualizações ----------

    function animarDetalhe(atraso) {
        atraso = atraso || 0;
        Anim.entrada(document.querySelectorAll('.detalhe-cabecalho'), { atraso: atraso, y: 8, duracao: 300 });
        Anim.pop(document.querySelectorAll('.mini-stats .item'), { atraso: atraso + 80, intervalo: 45, duracao: 350 });
        Anim.entrada(document.querySelectorAll('#det-obs'), { atraso: atraso + 400, y: 8, duracao: 300 });
        Anim.entrada(document.querySelectorAll('.acoes'), { atraso: atraso + 450, y: 8, duracao: 300 });
    }

    // ---------- 1. ENTRADA DA PÁGINA ----------
    Anim.entrada(document.querySelectorAll('h1.titulo'), { y: 10 });
    Anim.entrada(document.querySelectorAll('.layout > .box'), { atraso: 150, y: 14, intervalo: 120 });

    // Lista da esquerda: propostas deslizam em cascata
    Anim.deslizar(document.querySelectorAll('.proposta-linha'), { x: -16, atraso: 400, intervalo: 70, duracao: 350 });

    // Detalhe da direita
    animarDetalhe(450);

    // Botão de contraproposta pulsa uma vez para chamar atenção
    Anim.pulsar(document.querySelector('.btn-aceitar'), { atraso: 1300 });

    // ---------- 2. TROCA DE PROPOSTA ----------
    // O script da página altera o texto de #det-valor-prop a cada seleção.
    // (se a proposta nova tiver o mesmo valor, o texto é reescrito e o observer ainda dispara)
    var valorProp = document.getElementById('det-valor-prop');
    if (valorProp) {
        new MutationObserver(function () {
            animarDetalhe(0);
        }).observe(valorProp, { childList: true, characterData: true, subtree: true });
    }

    // A linha clicada pulsa
    document.querySelectorAll('.proposta-linha').forEach(function (linha) {
        linha.addEventListener('click', function () {
            Anim.pulsar(linha, { duracao: 450 });
        });
    });

    // ---------- 3. LIXEIRA: balança ao passar o mouse ----------
    var lixeira = document.querySelector('.btn-lixeira');
    if (lixeira) {
        lixeira.addEventListener('mouseenter', function () { Anim.tremer(lixeira); });
    }

    // ---------- 4. MODAL ----------
    var overlay = document.getElementById('overlayContraproposta');
    if (overlay) {
        new MutationObserver(function () {
            if (!overlay.classList.contains('aberto')) return;
            Anim.entrada(overlay.querySelectorAll('.modal'), { y: 16, duracao: 300 });
            Anim.entrada(overlay.querySelectorAll('.modal .campo, .modal .checkbox-linha'),
                { atraso: 120, intervalo: 35, y: 8, duracao: 280 });
            Anim.pop(overlay.querySelectorAll('.clube-interessado'), { atraso: 300, duracao: 400 });
            Anim.entrada(overlay.querySelectorAll('.btn-enviar'), { atraso: 450, y: 8, duracao: 300 });
        }).observe(overlay, { attributes: true, attributeFilter: ['class'] });

        // Trocar entre Definitiva/Empréstimo: os campos que aparecem sobem
        document.querySelectorAll('input[name="tipo-neg"]').forEach(function (radio) {
            radio.addEventListener('change', function () {
                var visiveis = Array.prototype.filter.call(
                    overlay.querySelectorAll('.so-definitiva, .so-emprestimo'),
                    function (el) { return el.style.display !== 'none'; }
                );
                Anim.entrada(visiveis, { intervalo: 50, y: 8, duracao: 280 });
            });
        });
    }
});
// Animações exclusivas da tela de treino. Usa as funções de geral.js.
// Roda em DOMContentLoaded, depois do script da página, que já montou a grade de treinos.
document.addEventListener('DOMContentLoaded', function () {
    if (!window.Anim) return;

    var reduzir = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    var EASE = 'cubic-bezier(0.2, 0.7, 0.2, 1)';

    var grade = document.getElementById('gradeTreinos');
    var contador = document.getElementById('contador');
    var qtd = document.getElementById('qtd');
    var dica = document.getElementById('dicaRodape');
    var btn = document.getElementById('btnConfirmar');

    // ---------- Helper local (só esta tela usa) ----------

    // Balanço leve do ícone quando o mouse entra no card
    function balancar(el) {
        if (reduzir || !el) return;
        el.animate(
            [
                { transform: 'rotate(0deg) scale(1)' },
                { transform: 'rotate(-8deg) scale(1.1)' },
                { transform: 'rotate(6deg) scale(1.1)' },
                { transform: 'rotate(0deg) scale(1)' }
            ],
            { duration: 400, easing: EASE }
        );
    }

    // transform não funciona em elementos inline, então o número do contador vira inline-block
    if (qtd) qtd.style.display = 'inline-block';

    // ---------- 1. ENTRADA DA PÁGINA ----------
    var cards = grade ? grade.querySelectorAll('.treino') : [];

    Anim.entrada(document.querySelectorAll('.topo h1'), { y: 10 });
    Anim.pop(document.querySelectorAll('.contador'), { atraso: 150, duracao: 400 });

    // Cards aparecem em cascata
    Anim.pop(cards, { atraso: 250, intervalo: 35, duracao: 380 });

    // Barra inferior sobe da borda da tela
    Anim.entrada(document.querySelectorAll('.barra-inferior'), { atraso: 400, y: 24, duracao: 350 });

    // Treinos já escolhidos antes: o marcador (✓) aparece depois que todos os cards entraram
    var tempoCards = 250 + cards.length * 35 + 300;
    var preSelecionados = grade ? grade.querySelectorAll('.treino.selecionado .marcador') : [];
    Anim.pop(preSelecionados, { atraso: tempoCards, intervalo: 80, duracao: 400 });

    // ---------- 2. SELECIONAR / DESSELECIONAR ----------
    // O script da página só troca a classe "selecionado" no card.
    // Um observer no grid (com subtree) pega os cards, que já existem desde o início.
    if (grade) {
        new MutationObserver(function (registros) {
            registros.forEach(function (r) {
                var card = r.target;
                var antes = (r.oldValue || '').split(' ');
                var passouASelecionado = antes.indexOf('selecionado') === -1 &&
                                         card.classList.contains('selecionado');
                if (!passouASelecionado) return;

                Anim.pop([card.querySelector('.marcador')], { duracao: 380 });
                Anim.pulsar(card, { duracao: 450 });
            });
        }).observe(grade, { attributes: true, attributeFilter: ['class'], attributeOldValue: true, subtree: true });

        // Clique em card não selecionado com o limite cheio: o card treme.
        // Este listener roda depois do onclick do card, então o estado já foi atualizado.
        grade.addEventListener('click', function (e) {
            var card = e.target.closest('.treino');
            if (!card) return;
            var recusado = !card.classList.contains('selecionado') && contador.classList.contains('cheio');
            if (recusado) {
                Anim.tremer(card);
                Anim.tremer(contador);
            }
        });

        // Hover: o ícone do card balança (delegação, evita disparar ao mover entre filhos)
        grade.addEventListener('mouseover', function (e) {
            var card = e.target.closest('.treino');
            if (!card || card.contains(e.relatedTarget)) return;
            balancar(card.querySelector('.icone'));
        });
    }

    // ---------- 3. CONTADOR ----------
    // atualizarContador() reescreve #qtd a cada clique (mesmo que o valor não mude)
    if (qtd) {
        new MutationObserver(function () {
            Anim.pop([qtd], { duracao: 350 });
        }).observe(qtd, { childList: true, characterData: true, subtree: true });
    }

    // Quando o limite é atingido (classe "cheio" é adicionada), o contador pulsa
    if (contador) {
        new MutationObserver(function (registros) {
            registros.forEach(function (r) {
                var antes = (r.oldValue || '').split(' ');
                if (antes.indexOf('cheio') === -1 && contador.classList.contains('cheio')) {
                    Anim.pulsar(contador, { duracao: 600, vezes: 2 });
                }
            });
        }).observe(contador, { attributes: true, attributeFilter: ['class'], attributeOldValue: true });
    }

    // ---------- 4. DICA DO RODAPÉ ----------
    // O texto é reescrito a cada clique; só anima quando realmente muda
    if (dica) {
        var ultimoTexto = dica.textContent;
        new MutationObserver(function () {
            if (dica.textContent === ultimoTexto) return;
            ultimoTexto = dica.textContent;
            Anim.entrada([dica], { y: 6, duracao: 280 });
        }).observe(dica, { childList: true, characterData: true, subtree: true });
    }

    // ---------- 5. BOTÃO CONFIRMAR ----------
    if (btn) {
        var estavaDesabilitado = btn.disabled;

        // Ao habilitar (primeiro treino selecionado), o botão chama atenção
        new MutationObserver(function () {
            if (estavaDesabilitado && !btn.disabled) {
                Anim.pop([btn], { duracao: 380 });
                Anim.pulsar(btn, { atraso: 350, duracao: 700 });
            }
            estavaDesabilitado = btn.disabled;
        }).observe(btn, { attributes: true, attributeFilter: ['disabled'] });

        // Feedback ao confirmar
        btn.addEventListener('click', function () {
            if (!btn.disabled) Anim.pop([btn], { duracao: 320 });
        });
    }
});
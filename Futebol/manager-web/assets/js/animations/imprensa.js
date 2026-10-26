// Animações exclusivas da tela de imprensa. Usa as funções de geral.js.
// A página é estática (sem script próprio), então tudo aqui é entrada, digitação, hover e clique.
document.addEventListener('DOMContentLoaded', function () {
    if (!window.Anim) return;

    var reduzir = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    var EASE = 'cubic-bezier(0.2, 0.7, 0.2, 1)';

    var box = document.querySelector('.box');
    if (!box) return;

    var q = function (sel) { return box.querySelectorAll(sel); };

    // ---------- Helpers locais (só esta tela usa) ----------

    // O .box é centralizado com transform: translate(-50%, -50%).
    // O Anim.entrada sobrescreveria esse transform e a caixa "pularia" de lugar,
    // então a entrada dela mantém o translate de centralização nos dois keyframes.
    function entrarCaixa(el) {
        if (reduzir) return;
        el.animate(
            [
                { opacity: 0, transform: 'translate(-50%, calc(-50% + 16px))' },
                { opacity: 1, transform: 'translate(-50%, -50%)' }
            ],
            { duration: 380, easing: EASE, fill: 'backwards' }
        );
    }

    // Efeito de digitação. O texto que ainda não apareceu continua ocupando espaço
    // (visibility: hidden), então a caixa não muda de altura enquanto digita.
    // Retorna a duração total em ms.
    function digitar(el, atraso) {
        if (reduzir || !el) return 0;
        var texto = el.textContent;
        var n = texto.length;
        if (!n) return 0;

        var passo = Math.min(22, 2200 / n);
        var visivel = document.createElement('span');
        var oculto = document.createElement('span');
        oculto.style.visibility = 'hidden';
        oculto.textContent = texto;
        el.textContent = '';
        el.appendChild(visivel);
        el.appendChild(oculto);

        var i = 0;
        setTimeout(function () {
            var timer = setInterval(function () {
                i++;
                visivel.textContent = texto.slice(0, i);
                oculto.textContent = texto.slice(i);
                if (i >= n) {
                    clearInterval(timer);
                    // junta tudo de volta num único texto
                    el.textContent = texto;
                }
            }, passo);
        }, atraso);

        return atraso + n * passo;
    }

    // Pequeno "quique" na opção escolhida
    function quique(el) {
        if (reduzir || !el) return;
        el.animate(
            [
                { transform: 'scale(1)' },
                { transform: 'scale(1.03)' },
                { transform: 'scale(1)' }
            ],
            { duration: 280, easing: EASE }
        );
    }

    // ---------- 1. ENTRADA DA PÁGINA ----------
    entrarCaixa(box);

    // Repórter: avatar com pop, rótulo sobe e a pergunta é "digitada"
    Anim.pop(q('.avatar-reporter'), { atraso: 300, duracao: 450 });
    Anim.entrada(q('.pergunta-reporter .rotulo'), { atraso: 450, y: 6, duracao: 280 });

    var fimDigitacao = digitar(box.querySelector('.texto-pergunta'), 650);
    if (fimDigitacao === 0) fimDigitacao = 650;

    // Avatar pulsa enquanto o repórter "fala"
    Anim.pulsar(box.querySelector('.avatar-reporter'), { atraso: 650, duracao: 700, vezes: 3 });

    // Opções deslizam em cascata só depois que a pergunta termina de aparecer
    Anim.deslizar(q('.opcao-resposta'), { x: -16, atraso: fimDigitacao + 150, intervalo: 90, duracao: 340 });

    // Botão sobe por último
    Anim.entrada(q('.btn-primario'), { atraso: fimDigitacao + 150 + 3 * 90 + 100, y: 10, duracao: 320 });

    // ---------- 2. ESCOLHA DA RESPOSTA ----------
    // Os radios ficam escondidos (opacity: 0), então a animação vai na label ligada a eles
    var opcoes = box.querySelector('.opcoes-resposta');
    if (opcoes) {
        opcoes.addEventListener('change', function (e) {
            var radio = e.target;
            if (!radio || radio.type !== 'radio') return;
            var label = opcoes.querySelector('label[for="' + radio.id + '"]');
            if (!label) return;
            quique(label);
            Anim.pulsar(label, { duracao: 450 });
        });
    }

    // ---------- 3. CLIQUE ----------
    var btn = box.querySelector('.btn-primario');
    if (btn) {
        btn.addEventListener('click', function () {
            if (!btn.disabled) Anim.pop([btn], { duracao: 300 });
        });
    }
});
// Funções genéricas de animação. Não conhecem nenhuma página específica.
window.Anim = (function () {
    var EASE = 'cubic-bezier(0.2, 0.7, 0.2, 1)';
    var reduzir = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

    // Faz uma lista de elementos aparecer subindo, um depois do outro
    function entrada(elementos, opcoes) {
        if (reduzir) return;
        opcoes = opcoes || {};
        var y = opcoes.y !== undefined ? opcoes.y : 10;
        var duracao = opcoes.duracao || 350;
        var atraso = opcoes.atraso || 0;
        var intervalo = opcoes.intervalo !== undefined ? opcoes.intervalo : 50;

        Array.prototype.forEach.call(elementos, function (el, i) {
            el.animate(
                [
                    { opacity: 0, transform: 'translateY(' + y + 'px)' },
                    { opacity: 1, transform: 'translateY(0)' }
                ],
                { duration: duracao, delay: atraso + i * intervalo, easing: EASE, fill: 'backwards' }
            );
        });
    }

    // Aparece crescendo (de 0.6 até 1), com leve "pulo" no final
    function pop(elementos, opcoes) {
        if (reduzir) return;
        opcoes = opcoes || {};
        var atraso = opcoes.atraso || 0;
        var intervalo = opcoes.intervalo !== undefined ? opcoes.intervalo : 30;

        Array.prototype.forEach.call(elementos, function (el, i) {
            el.animate(
                [
                    { opacity: 0, transform: 'scale(0.6)' },
                    { opacity: 1, transform: 'scale(1.08)', offset: 0.7 },
                    { opacity: 1, transform: 'scale(1)' }
                ],
                { duration: opcoes.duracao || 420, delay: atraso + i * intervalo, easing: EASE, fill: 'backwards' }
            );
        });
    }

    // Desliza na horizontal (x negativo = vem da esquerda, positivo = da direita)
    function deslizar(elementos, opcoes) {
        if (reduzir) return;
        opcoes = opcoes || {};
        var x = opcoes.x !== undefined ? opcoes.x : -16;
        var atraso = opcoes.atraso || 0;
        var intervalo = opcoes.intervalo !== undefined ? opcoes.intervalo : 60;

        Array.prototype.forEach.call(elementos, function (el, i) {
            el.animate(
                [
                    { opacity: 0, transform: 'translateX(' + x + 'px)' },
                    { opacity: 1, transform: 'translateX(0)' }
                ],
                { duration: opcoes.duracao || 380, delay: atraso + i * intervalo, easing: EASE, fill: 'backwards' }
            );
        });
    }

    // Revela o elemento da esquerda para a direita (efeito marca-texto)
    function revelar(elementos, opcoes) {
        if (reduzir) return;
        opcoes = opcoes || {};
        var atraso = opcoes.atraso || 0;
        var intervalo = opcoes.intervalo !== undefined ? opcoes.intervalo : 80;

        Array.prototype.forEach.call(elementos, function (el, i) {
            el.animate(
                [
                    { clipPath: 'inset(0 100% 0 0)' },
                    { clipPath: 'inset(0 0 0 0)' }
                ],
                { duration: opcoes.duracao || 500, delay: atraso + i * intervalo, easing: EASE, fill: 'backwards' }
            );
        });
    }

    // Conta de 0 até o número que já está escrito no elemento ("12 gols" -> 0..12)
    function contador(el, opcoes) {
        if (reduzir) return;
        var texto = el.textContent;
        var m = texto.match(/\d+/);
        if (!m) return;

        opcoes = opcoes || {};
        var alvo = parseInt(m[0], 10);
        var duracao = opcoes.duracao || 700;
        var atraso = opcoes.atraso || 0;
        var antes = texto.slice(0, m.index);
        var depois = texto.slice(m.index + m[0].length);
        var inicio = null;

        el.textContent = antes + '0' + depois;

        function passo(t) {
            if (inicio === null) inicio = t;
            var p = Math.min((t - inicio) / duracao, 1);
            var suave = 1 - Math.pow(1 - p, 3); // easeOutCubic
            el.textContent = antes + Math.round(alvo * suave) + depois;
            if (p < 1) requestAnimationFrame(passo);
        }
        setTimeout(function () { requestAnimationFrame(passo); }, atraso);
    }

    // Chama atenção de um elemento (brilho que pulsa)
    function pulsar(el, opcoes) {
        if (reduzir || !el) return;
        opcoes = opcoes || {};
        el.animate(
            [
                { filter: 'brightness(1)' },
                { filter: 'brightness(1.8)' },
                { filter: 'brightness(1)' }
            ],
            { duration: opcoes.duracao || 900, delay: opcoes.atraso || 0, easing: 'ease-in-out', iterations: opcoes.vezes || 1 }
        );
    }

    // Fica "respirando" (opacidade vai e volta) para sempre
    function respirar(el, opcoes) {
        if (reduzir || !el) return;
        opcoes = opcoes || {};
        el.animate(
            [{ opacity: 1 }, { opacity: 0.45 }, { opacity: 1 }],
            { duration: opcoes.duracao || 2000, iterations: Infinity, easing: 'ease-in-out' }
        );
    }

    function tremer(el) {
        if (reduzir || !el) return;
        el.animate(
            [
                { transform: 'translateX(0)' },
                { transform: 'translateX(-6px)' },
                { transform: 'translateX(6px)' },
                { transform: 'translateX(-4px)' },
                { transform: 'translateX(4px)' },
                { transform: 'translateX(0)' }
            ],
            { duration: 350, easing: 'ease-in-out' }
        );
    }

    // Enche uma barra de 0% até a largura que ela já tem (barra de progresso)
    function encher(elementos, opcoes) {
        if (reduzir) return;
        opcoes = opcoes || {};
        var atraso = opcoes.atraso || 0;
        var intervalo = opcoes.intervalo !== undefined ? opcoes.intervalo : 80;

        Array.prototype.forEach.call(elementos, function (el, i) {
            el.animate(
                [
                    { transform: 'scaleX(0)' },
                    { transform: 'scaleX(1)' }
                ],
                { duration: opcoes.duracao || 700, delay: atraso + i * intervalo, easing: EASE, fill: 'backwards' }
            );
        });
    }

    return {
        entrada: entrada,
        pop: pop,
        deslizar: deslizar,
        revelar: revelar,
        contador: contador,
        pulsar: pulsar,
        respirar: respirar,
        tremer: tremer,
        encher: encher
    };
})();
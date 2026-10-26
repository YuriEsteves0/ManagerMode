// Animações exclusivas da tela de cadastro (etapa 1). Usa as funções de geral.js.
(function () {
    if (!window.Anim) return;

    // LADO ESQUERDO: título sobe, o destaque (em) é revelado como marca-texto
    Anim.entrada(document.querySelectorAll('.lado-texto h1'), { y: 16, duracao: 500 });
    Anim.revelar(document.querySelectorAll('.lado-texto h1 em'), { atraso: 500, duracao: 600 });
    Anim.entrada(document.querySelectorAll('.lado-texto > p'), { atraso: 200, y: 12 });

    // ESTATÍSTICAS: estouram em sequência e os números contam de 0
    Anim.pop(document.querySelectorAll('.stats > div'), { atraso: 450, intervalo: 120 });
    document.querySelectorAll('.stats strong').forEach(function (el, i) {
        Anim.contador(el, { atraso: 450 + i * 120, duracao: 800 });
    });

    // CARD: desliza da direita
    Anim.deslizar(document.querySelectorAll('.card'), { x: 28, atraso: 200, duracao: 500 });

        // CAMPOS: sobem em cascata depois do card (agora inclui o bloco "Modo de jogo")
    Anim.entrada(document.querySelectorAll('.card h2, .card .campo, .card .modos'), { atraso: 500, intervalo: 80, y: 8 });

    // MODOS DE JOGO: as duas opções estouram logo depois do rótulo aparecer
    Anim.pop(document.querySelectorAll('.modo-opcao'), { atraso: 850, intervalo: 120 });

    
    // BOTÃO: aparece por último e pulsa uma vez para chamar atenção
    Anim.entrada(document.querySelectorAll('.btn-iniciar'), { atraso: 950, y: 8 });
    Anim.pulsar(document.querySelector('.btn-iniciar'), { atraso: 1500 });

    // INTERAÇÃO: ao escolher um modo, o rótulo dá um pequeno "pulo"
    document.querySelectorAll('.modo-opcao input').forEach(function (radio) {
        radio.addEventListener('change', function () {
            Anim.pop([radio.nextElementSibling], { duracao: 300 });
        });
    });

    // INTERAÇÃO: campo obrigatório vazio balança ao tentar enviar
    var form = document.querySelector('form.card');
    if (form) {
        form.addEventListener('invalid', function (e) {
            Anim.tremer(e.target);
        }, true); // 'invalid' não borbulha, por isso captura
    }
})();
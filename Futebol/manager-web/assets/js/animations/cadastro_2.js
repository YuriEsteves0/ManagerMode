// Animações exclusivas da tela de escolha de liga (cadastro etapa 2). Usa as funções de geral.js.
(function () {
    if (!window.Anim) return;

    // CARD: sobe suavemente
    Anim.entrada(document.querySelectorAll('.card'), { y: 20, duracao: 500 });

    // TÍTULO e subtítulo entram em sequência
    Anim.entrada(document.querySelectorAll('.card h1, .card p.sub'), { atraso: 250, intervalo: 100, y: 10 });

    // LIGAS: cada opção estoura, uma depois da outra
    Anim.pop(document.querySelectorAll('.liga-opcao'), { atraso: 500, intervalo: 90 });

    // BOTÃO: aparece por último e pulsa uma vez
    // (o atraso do botão considera quantas ligas existem, para ele vir depois da última)
    var qtd = document.querySelectorAll('.liga-opcao').length;
    var atrasoBotao = 500 + qtd * 90 + 150;
    Anim.entrada(document.querySelectorAll('.btn-jogar'), { atraso: atrasoBotao, y: 8 });
    Anim.pulsar(document.querySelector('.btn-jogar'), { atraso: atrasoBotao + 500 });

    // INTERAÇÃO: ao escolher uma liga, o rótulo dá um pequeno "pulo"
    document.querySelectorAll('.liga-opcao input').forEach(function (radio) {
        radio.addEventListener('change', function () {
            Anim.pop([radio.nextElementSibling], { duracao: 300 });
        });
    });
})();
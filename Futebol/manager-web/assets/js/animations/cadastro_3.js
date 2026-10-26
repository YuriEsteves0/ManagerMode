// Animações exclusivas da tela de sorteio do clube (cadastro etapa 3). Usa as funções de geral.js.
(function () {
    if (!window.Anim) return;

    // CARD: sobe suavemente
    Anim.entrada(document.querySelectorAll('.card'), { y: 20, duracao: 500 });

    // TÍTULO: entra logo depois
    Anim.entrada(document.querySelectorAll('.card h1'), { atraso: 250, y: 10 });

    // CAIXA DO CLUBE: estoura como "revelação do sorteio"
    Anim.pop(document.querySelectorAll('.clube'), { atraso: 500, duracao: 550 });

    // ESCUDO: dá um pop próprio, um pouco depois da caixa
    Anim.pop(document.querySelectorAll('.clube img'), { atraso: 700, duracao: 600 });

    // NOME e ORÇAMENTO: sobem em sequência
    Anim.entrada(document.querySelectorAll('.clube-nome strong, .clube-nome span'), { atraso: 850, intervalo: 120, y: 8 });

    // ORÇAMENTO: o número conta de 0 até o valor
    // (só anima se o texto tiver dígitos; formatos como "R$ 300 mi" mantêm o texto ao redor)
    var orcamento = document.querySelector('.clube-nome span');
    if (orcamento) Anim.contador(orcamento, { atraso: 1000, duracao: 900 });

    // BOTÃO: aparece por último, pulsa e depois "respira" chamando para o clique
    var botao = document.querySelector('.btn-jogar');
    if (botao) {
        Anim.entrada([botao], { atraso: 1300, y: 8 });
        Anim.pulsar(botao, { atraso: 1800 });
    }
})();
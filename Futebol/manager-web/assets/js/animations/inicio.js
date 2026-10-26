// Animações exclusivas da página inicial. Usa as funções de geral.js.
(function () {
    if (!window.Anim) return;

    // 0. Tabela: mostra só 5 linhas e centraliza no seu clube (antes das animações)
    var wrap   = document.querySelector('#box-tabela .tabela-scroll');
    var meu    = document.querySelector('#box-tabela tr.destaque');
    var linhas = document.querySelectorAll('#box-tabela tbody tr');
    var cab    = document.querySelector('#box-tabela thead');

    if (wrap && linhas.length > 5) {
        var altLinha = linhas[0].offsetHeight;
        wrap.style.maxHeight = (cab.offsetHeight + altLinha * 5) + 'px';

        if (meu) {
            var topo = meu.getBoundingClientRect().top - wrap.getBoundingClientRect().top + wrap.scrollTop;
            // deixa 2 linhas acima do seu clube, abaixo do cabeçalho fixo
            wrap.scrollTop = topo - cab.offsetHeight - altLinha * 2;
        }
    }

    // 1. Os boxes entram em sequência
    Anim.entrada(document.querySelectorAll('.grid > .box'), { y: 14, intervalo: 80 });

    // 2. ELENCO: bolinhas estouram em sequência
    Anim.pop(document.querySelectorAll('#box-elenco .jogador'), { atraso: 300, intervalo: 25 });

    // 3. PRÓXIMOS JOGOS: deslizam da esquerda; o primeiro (próximo jogo) pisca depois
    Anim.deslizar(document.querySelectorAll('#box-jogos .jogo-item'), { x: -18, atraso: 350, intervalo: 80 });
    var proximo = document.querySelector('#box-jogos .jogo-item');
    if (proximo) Anim.pulsar(proximo, { atraso: 900 });

    // 4. ARTILHARIA: deslizam da direita e os gols contam de 0 até o valor
    Anim.deslizar(document.querySelectorAll('#box-artilharia .lista-num li'), { x: 18, atraso: 400, intervalo: 70 });
    document.querySelectorAll('#box-artilharia .valor').forEach(function (el, i) {
        Anim.contador(el, { atraso: 400 + i * 70 });
    });

    // 5. TABELA: linhas deslizam da esquerda; a do seu clube pisca
    Anim.deslizar(document.querySelectorAll('#box-tabela tbody tr'), { x: -14, atraso: 450, intervalo: 50 });
    if (meu) Anim.pulsar(meu, { atraso: 1000 });

    // 6. TRANSFERÊNCIAS: deslizam da direita; a tag "Janela aberta" respira
    Anim.deslizar(document.querySelectorAll('#box-transf .noticias li'), { x: 18, atraso: 500, intervalo: 70 });
    Anim.respirar(document.querySelector('#box-transf .tag-janela'));

    // 7. IMPRENSA: itens sobem e o trecho em negrito é revelado como marca-texto
    Anim.entrada(document.querySelectorAll('#box-imprensa .noticias li'), { atraso: 550, intervalo: 70, y: 6 });
    Anim.revelar(document.querySelectorAll('#box-imprensa .noticias li strong'), { atraso: 800, intervalo: 120 });
})();
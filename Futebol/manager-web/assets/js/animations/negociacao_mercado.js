// Animações exclusivas da tela de mercado. Usa as funções de geral.js.
// Roda em DOMContentLoaded, depois do script da página, que já montou lista e ficha.
document.addEventListener('DOMContentLoaded', function () {
    if (!window.Anim) return;

    var lista = document.getElementById('lista-jogadores');

    // ---------- Funções reutilizadas na entrada e nas atualizações ----------

    function animarLista(atraso) {
        Anim.deslizar(lista.querySelectorAll('.jogador-linha'),
            { x: -14, atraso: atraso || 0, intervalo: 22, duracao: 300 });
    }

    function animarFicha(atraso) {
        atraso = atraso || 0;
        Anim.pop(document.querySelectorAll('#ficha-posicao'), { atraso: atraso, duracao: 400 });
        Anim.entrada(document.querySelectorAll('#ficha-nome, #ficha-sub'),
            { atraso: atraso + 50, intervalo: 60, y: 8, duracao: 300 });
        Anim.pop(document.querySelectorAll('.mini-stats .item'),
            { atraso: atraso + 120, intervalo: 50, duracao: 350 });
        Anim.deslizar(document.querySelectorAll('.atributo-linha'),
            { x: 14, atraso: atraso + 300, intervalo: 50, duracao: 320 });
        Anim.encher(document.querySelectorAll('.atributo-linha .barra i'),
            { atraso: atraso + 350, intervalo: 50, duracao: 600 });
        Anim.entrada(document.querySelectorAll('#ficha-lesoes li'),
            { atraso: atraso + 500, intervalo: 60, y: 6, duracao: 300 });
    }

    function animarEstatisticas() {
        Anim.entrada(document.querySelectorAll('#ficha-estatisticas tr'),
            { intervalo: 60, y: 6, duracao: 300 });
    }

    // ---------- 1. ENTRADA DA PÁGINA ----------
    Anim.entrada(document.querySelectorAll('h1.titulo'), { y: 10 });
    Anim.entrada(document.querySelectorAll('.layout > .box'), { atraso: 150, y: 14, intervalo: 120 });

    // Orçamento: o número conta de 0 (ex.: "R$ 22,4M")
    var orc = document.querySelector('.orcamento strong');
    if (orc) Anim.contador(orc, { atraso: 400, duracao: 800 });

    Anim.entrada(document.querySelectorAll('.busca-linha, .ordenar-linha, .resultado-info'),
        { atraso: 350, intervalo: 80, y: 8 });

    animarLista(500);
    Anim.entrada(document.querySelectorAll('.paginacao'), { atraso: 700, y: 8 });
    animarFicha(550);

    // Botão "Fazer proposta" pulsa uma vez para chamar atenção
    Anim.pulsar(document.getElementById('btn-proposta'), { atraso: 1300 });

    // ---------- 2. ATUALIZAÇÕES (busca, filtro, ordem, página, clique) ----------
    // A lista foi refeita: anima as linhas novas
    new MutationObserver(function () { animarLista(0); })
        .observe(lista, { childList: true });

    // A ficha foi refeita (os atributos são recriados a cada seleção)
    new MutationObserver(function () { animarFicha(0); })
        .observe(document.getElementById('ficha-atributos'), { childList: true });

    // Estatísticas chegaram da API ("Carregando..." -> dados)
    new MutationObserver(animarEstatisticas)
        .observe(document.getElementById('ficha-estatisticas'), { childList: true });

    // Clique em uma linha: ela pulsa (a lista não é refeita no clique)
    lista.addEventListener('click', function (e) {
        var linha = e.target.closest('.jogador-linha');
        if (linha) Anim.pulsar(linha, { duracao: 450 });
    });

    // ---------- 3. PAINEL DE FILTROS ----------
    var filtro = document.querySelector('.filtro-wrap');
    if (filtro) {
        filtro.addEventListener('toggle', function () {
            if (!filtro.open) return;
            Anim.entrada(filtro.querySelectorAll('.filtro-painel'), { y: -8, duracao: 250 });
            Anim.pop(filtro.querySelectorAll('.filtro-chips label'), { atraso: 80, intervalo: 25, duracao: 300 });
        });
    }

    // ---------- 4. MODAL DE PROPOSTA ----------
    var modal = document.getElementById('proposta-modal');
    if (modal) {
        new MutationObserver(function () {
            if (!modal.open) return;
            Anim.entrada([modal], { y: 16, duracao: 300 });
            Anim.pop(modal.querySelectorAll('.proposta-ref .item'), { atraso: 120, intervalo: 70, duracao: 350 });
        }).observe(modal, { attributes: true, attributeFilter: ['open'] });
    }
});
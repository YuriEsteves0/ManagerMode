// Animações exclusivas da Central do Elenco. Usa as funções de geral.js.
// Roda em DOMContentLoaded, depois do script da página, que já preencheu a ficha.
document.addEventListener('DOMContentLoaded', function () {
    if (!window.Anim) return;

    // 1. ENTRADA DA PÁGINA
    Anim.entrada(document.querySelectorAll('h1.titulo'), { y: 10 });
    Anim.entrada(document.querySelectorAll('.layout > .box'), { atraso: 150, y: 14, intervalo: 120 });

    // Lista da esquerda: linhas deslizam em cascata (intervalo curto, pois a lista é grande)
    Anim.deslizar(document.querySelectorAll('.jogador-linha'), { x: -16, atraso: 400, intervalo: 25, duracao: 320 });

    // 2. FICHA: anima o conteúdo (usado na entrada e a cada clique)
    function animarFicha(atraso, primeiraVez) {
        atraso = atraso || 0;

        // cabeçalho: posição estoura, nome e OVR entram
        Anim.pop(document.querySelectorAll('#ficha-posicao'), { atraso: atraso, duracao: 400 });
        Anim.entrada(document.querySelectorAll('#ficha-nome, #ficha-sub'), { atraso: atraso + 50, intervalo: 60, y: 8, duracao: 300 });
        Anim.pop(document.querySelectorAll('.overall-grande'), { atraso: atraso + 100, duracao: 450 });

        // OVR conta de 0 até o valor do jogador
        var ovr = document.getElementById('ficha-overall');
        if (ovr) Anim.contador(ovr, { atraso: atraso + 150, duracao: 600 });

        // mini cards estouram
        Anim.pop(document.querySelectorAll('.mini-stats .item'), { atraso: atraso + 150, intervalo: 50, duracao: 350 });

        // barras de atributos: linhas deslizam e as barras enchem
        Anim.deslizar(document.querySelectorAll('.atributo-linha'), { x: 14, atraso: atraso + 300, intervalo: 50, duracao: 320 });
        Anim.encher(document.querySelectorAll('.atributo-linha .barra i'), { atraso: atraso + 350, intervalo: 50, duracao: 600 });

        // lesões e estatísticas
        Anim.entrada(document.querySelectorAll('#ficha-lesoes li'), { atraso: atraso + 500, intervalo: 60, y: 6, duracao: 300 });
        Anim.entrada(document.querySelectorAll('#ficha-estatisticas tr'), { atraso: atraso + 550, intervalo: 60, y: 6, duracao: 300 });

        // títulos das seções só animam na primeira vez (o texto deles não muda)
        if (primeiraVez) {
            Anim.entrada(document.querySelectorAll('.ficha-corpo h2'), { atraso: atraso + 300, intervalo: 120, y: 6, duracao: 300 });
        }
    }

    animarFicha(450, true);

    // 3. CLIQUE: a ficha anima de novo e a linha clicada pulsa
    // Este listener é registrado depois do da página, então a ficha já está atualizada.
    document.querySelectorAll('.jogador-linha[data-jogador]').forEach(function (linha) {
        linha.addEventListener('click', function () {
            animarFicha(0);
            Anim.pulsar(linha, { duracao: 450 });
        });
    });
});
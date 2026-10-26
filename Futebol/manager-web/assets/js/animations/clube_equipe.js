// Animações exclusivas da tela de escalação. Usa as funções de geral.js.
(function () {
    if (!window.Anim) return;

    // 1. TOPO: título e contador entram
    Anim.entrada(document.querySelectorAll('.topo > div'), { y: 10, intervalo: 100 });

    // 2. BOXES: entram em sequência
    Anim.entrada(document.querySelectorAll('.layout .box'), { atraso: 150, y: 14, intervalo: 120 });

    // 3. CAMPO: jogadores estouram por linha tática (goleiro -> defesa -> meio -> ataque)
    // Os elementos já vêm ordenados por linha no HTML, então basta um intervalo
    // maior entre eles para criar a sensação de "time entrando em campo".
    Anim.pop(document.querySelectorAll('.campo .pos-jogador'), { atraso: 500, intervalo: 70, duracao: 450 });

    // 4. CONTADOR: o número de titulares conta de 0 (ex.: 11/11)
    var contagem = document.querySelector('.contador strong');
    if (contagem) Anim.contador(contagem, { atraso: 300, duracao: 700 });

    // 5. RESERVAS: deslizam da direita
    Anim.deslizar(document.querySelectorAll('.coluna-direita .box:not(.nao-relacionados) .item-jogador'),
        { x: 18, atraso: 600, intervalo: 50 });

    // 6. NÃO RELACIONADOS: deslizam da direita, depois dos reservas
    Anim.deslizar(document.querySelectorAll('.nao-relacionados .item-jogador'),
        { x: 18, atraso: 850, intervalo: 50 });

    // 7. AVISO de escalação incompleta chama atenção
    var aviso = document.querySelector('main > p');
    if (aviso) Anim.respirar(aviso, { duracao: 2200 });
})();
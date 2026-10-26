// Animações exclusivas da tela de patrocínios. Usa as funções de geral.js.
// Roda em DOMContentLoaded, depois do script da página, que já preencheu o painel.
document.addEventListener('DOMContentLoaded', function () {
    if (!window.Anim) return;

    // 1. ENTRADA DA PÁGINA
    Anim.entrada(document.querySelectorAll('h1.titulo'), { y: 10 });
    Anim.entrada(document.querySelectorAll('.layout > .box'), { atraso: 150, y: 14, intervalo: 120 });

    // Lista da direita: cartões deslizam um depois do outro
    Anim.deslizar(document.querySelectorAll('.patrocinador-item'), { x: 18, atraso: 450, intervalo: 80 });

    // 2. PAINEL DE DETALHE: anima o conteúdo (usado na entrada e a cada clique)
        function animarDetalhe(atraso) {
        atraso = atraso || 0;
        Anim.pop(document.querySelectorAll('#detalhe-logo > *'), { atraso: atraso, duracao: 450 });

        // nome + "Proposta selecionada" entram juntos, em sequência
        Anim.entrada(document.querySelectorAll('#detalhe-nome, .detalhe-topo span'),
            { atraso: atraso + 50, intervalo: 70, y: 8, duracao: 300 });

        Anim.pop(document.querySelectorAll('.stat-item'), { atraso: atraso + 100, intervalo: 70, duracao: 380 });

        // "Sobre a empresa" (título) + descrição entram em sequência
        Anim.entrada(document.querySelectorAll('#painel-detalhe h2, #detalhe-descricao'),
            { atraso: atraso + 250, intervalo: 80, y: 8, duracao: 300 });
    }

    animarDetalhe(400);
    Anim.entrada(document.querySelectorAll('.btn-assinar'), { atraso: 900, y: 8 });
    Anim.pulsar(document.querySelector('.btn-assinar'), { atraso: 1400 });

    // 3. CLIQUE: o painel anima de novo com o patrocinador escolhido
    // Este listener é registrado depois do da página, então o painel já está atualizado.
    document.querySelectorAll('.patrocinador-item[data-id]').forEach(function (item) {
        item.addEventListener('click', function () {
            animarDetalhe(0);
            Anim.pulsar(item, { duracao: 500 });
            Anim.pulsar(document.querySelector('.btn-assinar'), { atraso: 300 });
        });
    });
});
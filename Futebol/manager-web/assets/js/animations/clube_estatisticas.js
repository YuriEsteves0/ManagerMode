// Animações exclusivas da tela de estatísticas do clube. Usa as funções de geral.js.
(function () {
    if (!window.Anim) return;

    // 1. TÍTULO e BOXES entram em sequência
    Anim.entrada(document.querySelectorAll('h1.titulo'), { y: 10 });
    Anim.entrada(document.querySelectorAll('.layout > .box'), { atraso: 150, y: 14, intervalo: 120 });

    // 2. CABEÇALHO do clube: escudo estoura, nome desliza
    Anim.pop(document.querySelectorAll('.clube-cabecalho img'), { atraso: 350, duracao: 550 });
    Anim.deslizar(document.querySelectorAll('.clube-cabecalho > div'), { x: -14, atraso: 450 });

    // 3. CARDS de estatísticas: estouram em sequência
    Anim.pop(document.querySelectorAll('.stat-item'), { atraso: 500, intervalo: 70 });

    // 4. Números dos cards contam de 0 (valor do clube, torcedores, reputação...)
    // O "contador" lê o primeiro número do texto; textos sem dígitos (patrocinador) são ignorados.
    document.querySelectorAll('.stat-item strong').forEach(function (el, i) {
        Anim.contador(el, { atraso: 550 + i * 70, duracao: 800 });
    });

    // 5. HISTÓRICO: linhas deslizam da esquerda; a temporada mais recente pisca
    Anim.deslizar(document.querySelectorAll('table.historico tbody tr'), { x: -14, atraso: 800, intervalo: 60 });
    Anim.pulsar(document.querySelector('table.historico tbody tr'), { atraso: 1300 });

    // 6. UPGRADES: cartões deslizam da direita e as barras de nível enchem
    Anim.deslizar(document.querySelectorAll('.upgrade'), { x: 18, atraso: 500, intervalo: 90 });
    Anim.encher(document.querySelectorAll('.barra-preenchida'), { atraso: 800, intervalo: 90 });

    // 7. Botões "Melhorar" disponíveis pulsam uma vez para chamar atenção
    document.querySelectorAll('.btn-melhorar:not(:disabled)').forEach(function (btn, i) {
        Anim.pulsar(btn, { atraso: 1400 + i * 120 });
    });
})();
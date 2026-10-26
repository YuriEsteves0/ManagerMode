// Animações exclusivas da tela de carreira. Usa as funções de geral.js.
// A página é toda renderizada pelo PHP (sem script próprio), então tudo aqui é entrada e hover.
document.addEventListener('DOMContentLoaded', function () {
    if (!window.Anim) return;

    var reduzir = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    var EASE = 'cubic-bezier(0.2, 0.7, 0.2, 1)';

    var boxTecnico = document.getElementById('box-tecnico');
    var boxMercado = document.getElementById('box-mercado');
    if (!boxTecnico || !boxMercado) return;

    var t = function (sel) { return boxTecnico.querySelectorAll(sel); };
    var m = function (sel) { return boxMercado.querySelectorAll(sel); };

    // ---------- Helpers locais (só esta tela usa) ----------

    // Pequeno "balanço" do troféu ao passar o mouse na linha do título
    function balancar(el) {
        if (reduzir || !el) return;
        el.animate(
            [
                { transform: 'rotate(0deg) scale(1)' },
                { transform: 'rotate(-14deg) scale(1.2)' },
                { transform: 'rotate(10deg) scale(1.2)' },
                { transform: 'rotate(0deg) scale(1)' }
            ],
            { duration: 450, easing: EASE }
        );
    }

    // Leve "erguer" ao passar o mouse
    function erguer(el) {
        if (reduzir || !el) return;
        el.animate(
            [
                { transform: 'translateY(0)' },
                { transform: 'translateY(-3px)' },
                { transform: 'translateY(0)' }
            ],
            { duration: 320, easing: EASE }
        );
    }

    // ---------- 1. ENTRADA DA PÁGINA ----------
    Anim.entrada(document.querySelectorAll('h1.titulo'), { y: 10 });
    Anim.entrada(document.querySelectorAll('.subtitulo'), { atraso: 80, y: 8, duracao: 300 });
    Anim.entrada(document.querySelectorAll('.layout-carreira > .box'), { atraso: 200, y: 14, intervalo: 120 });

    // ----- Caixa esquerda: ficha do técnico -----
    Anim.entrada(t(':scope > h2'), { atraso: 400, y: 6, duracao: 280 });

    // Perfil: avatar com pop, textos sobem, tags aparecem em sequência
    Anim.pop(t('.avatar-tecnico'), { atraso: 450, duracao: 450 });
    Anim.entrada(t('.perfil-tecnico .nome'), { atraso: 550, y: 8, duracao: 300 });
    Anim.entrada(t('.perfil-tecnico .clube-atual'), { atraso: 620, y: 8, duracao: 300 });
    Anim.pop(t('.perfil-tecnico .escudo-mini'), { atraso: 700, duracao: 380 });
    Anim.pop(t('.badges-perfil .tag'), { atraso: 750, intervalo: 80, duracao: 380 });

    // Títulos conquistados: deslizam em cascata e o ano conta de 0 até o valor
    Anim.entrada(t('.rolavel > div:nth-child(2) > h2'), { atraso: 800, y: 6, duracao: 280 });
    Anim.deslizar(t('.titulo-item'), { x: -16, atraso: 850, intervalo: 60, duracao: 330 });
    Anim.pop(t('.titulo-item .icone-troféu'), { atraso: 950, intervalo: 60, duracao: 400 });
    Array.prototype.forEach.call(t('.titulo-item .qtd'), function (el, i) {
        Anim.contador(el, { atraso: 950 + i * 60, duracao: 700 });
    });

    // Histórico de clubes
    Anim.entrada(t('.rolavel > div:nth-child(3) > h2'), { atraso: 1000, y: 6, duracao: 280 });
    Anim.deslizar(t('.historico-clube'), { x: -16, atraso: 1050, intervalo: 70, duracao: 330 });

    // O clube atual (período termina em "Atual") brilha uma vez
    Array.prototype.forEach.call(t('.historico-clube .periodo'), function (el) {
        if (/Atual/i.test(el.textContent)) {
            Anim.pulsar(el.parentElement, { atraso: 1500, duracao: 800 });
        }
    });

    // Desempenho por temporada
    Anim.entrada(t('.rolavel > div:nth-child(4) > h2'), { atraso: 1150, y: 6, duracao: 280 });
    Anim.entrada(t('table thead th'), { atraso: 1200, intervalo: 40, y: 6, duracao: 280 });
    Anim.entrada(t('table tbody tr'), { atraso: 1300, intervalo: 60, y: 6, duracao: 300 });

    // ----- Caixa direita: mercado de trabalho -----
    Anim.entrada(m(':scope > h2'), { atraso: 450, y: 6, duracao: 280 });
    Anim.entrada(m('.bloco-demissao'), { atraso: 550, y: 8, duracao: 300 });

    // Propostas: cada linha desliza da direita, escudo e salário aparecem com pop
    var propostas = m('.item-linha.proposta');
    Anim.deslizar(propostas, { x: 20, atraso: 700, intervalo: 90, duracao: 350 });
    Anim.pop(m('.item-linha.proposta img'), { atraso: 800, intervalo: 90, duracao: 380 });
    Anim.pop(m('.item-linha.proposta .btn-primario'), { atraso: 950, intervalo: 90, duracao: 380 });

    // O primeiro botão "Aceitar" pulsa uma vez para chamar atenção
    var primeiroAceitar = boxMercado.querySelector('.item-linha.proposta .btn-primario');
    if (primeiroAceitar) Anim.pulsar(primeiroAceitar, { atraso: 1500, duracao: 800 });

    // ---------- 2. HOVER ----------
    // Troféu balança quando o mouse entra na linha do título
    document.querySelectorAll('.titulo-item').forEach(function (item) {
        item.addEventListener('mouseenter', function () {
            balancar(item.querySelector('.icone-troféu'));
        });
    });

    // Linhas de histórico e de proposta dão um pequeno "erguer"
    document.querySelectorAll('.historico-clube, .item-linha.proposta').forEach(function (el) {
        el.addEventListener('mouseenter', function () { erguer(el); });
    });

    // Botão de demissão treme ao passar o mouse, avisando que é uma ação séria
    var btnDemissao = boxMercado.querySelector('.btn-secundario.perigo');
    if (btnDemissao) {
        btnDemissao.addEventListener('mouseenter', function () { Anim.tremer(btnDemissao); });
    }

    // ---------- 3. CLIQUE ----------
    document.querySelectorAll('.btn-primario, .btn-secundario').forEach(function (btn) {
        btn.addEventListener('click', function () {
            if (!btn.disabled) Anim.pop([btn], { duracao: 320 });
        });
    });
});
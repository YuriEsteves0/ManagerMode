// Animações da tela de partida. Usa as funções de geral.js (window.Anim).
// A mesma página mostra dois estados, e cada um tem sua animação:
//   1. Sem jogo hoje (.dias-passando): dias trocando até o dia da partida
//   2. Dia de jogo (.placar): partida ao vivo (tempo, placar e eventos)
document.addEventListener('DOMContentLoaded', function () {
    if (!window.Anim) return;

    var reduzir = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    var EASE = 'cubic-bezier(0.2, 0.7, 0.2, 1)';

    var box = document.querySelector('.box');
    if (!box) return;

    // Escolhe a animação conforme o que o PHP renderizou
    if (box.classList.contains('dias-passando')) {
        animarDias(box);
    } else if (box.querySelector('.placar')) {
        animarPlacar(box);
    }

    // =====================================================
    // ESTADO 1: DIAS PASSANDO ("dia 02 -> dia 03 -> ...")
    // =====================================================
    function animarDias(box) {
        var dias = JSON.parse(box.dataset.dias);
        var texto = box.querySelector('.dia-atual');
        var rotulo = box.querySelector('.dias-rotulo');
        var link = box.querySelector('.link-avancar');
        if (!texto || !link) return;

        // Entrada: rótulo desce suave e o primeiro dia aparece com pop
        Anim.entrada([box], { y: 16, duracao: 380 });
        Anim.entrada([rotulo], { atraso: 200, y: 6, duracao: 300 });
        Anim.pop([texto], { atraso: 350, duracao: 420 });

        // Rótulo "respira" enquanto os dias passam
        Anim.respirar(rotulo, { duracao: 1800 });

        // Quanto mais dias, mais rápido passa (máx. ~5s no total, mín. 250ms por dia)
        var intervalo = Math.max(250, Math.min(700, 5000 / dias.length));
        var i = 0;

        // Chegou no dia do jogo: texto brilha e botão aparece
        function terminar() {
            Anim.pulsar(texto, { vezes: 2 });
            link.hidden = false;
            Anim.entrada([link], { atraso: 300, y: 10, duracao: 320 });

            var btn = link.querySelector('.btn-primario');
            if (btn) {
                btn.addEventListener('click', function () {
                    Anim.pop([btn], { duracao: 300 });
                });
            }
        }

        // Só 1 dia: não tem o que trocar
        if (dias.length <= 1) {
            setTimeout(terminar, 800);
            return;
        }

        // Começa a trocar depois da entrada terminar
        setTimeout(function () {
            var timer = setInterval(function () {
                i++;
                texto.textContent = 'dia ' + dias[i];
                Anim.pop([texto], { duracao: 300 });

                if (i >= dias.length - 1) {
                    clearInterval(timer);
                    terminar();
                }
            }, intervalo);
        }, 800);
    }

    // =====================================================
    // ESTADO 2: DIA DE JOGO (PARTIDA AO VIVO)
    // =====================================================
    function animarPlacar(box) {
        var TEMPO_POR_MINUTO = 100; // ms reais para cada minuto de jogo (90 min = ~9s)
        var DURACAO_JOGO = 90;

        var eventos = JSON.parse(box.dataset.eventos);

        var tempo = box.querySelector('.tempo');
        var lista = box.querySelector('.rolavel');
        var btnPular = box.querySelector('.btn-pular');
        var link = box.querySelector('.link-proximo');
        var golsEl = {
            mandante: box.querySelector('.gols-mandante'),
            visitante: box.querySelector('.gols-visitante')
        };
        var gols = { mandante: 0, visitante: 0 };

        var q = function (sel) { return box.querySelectorAll(sel); };

        // ---------- Helpers locais (só o placar usa) ----------

        // Bola gira ao passar o mouse na linha de gol
        function girar(el) {
            if (reduzir || !el) return;
            el.animate(
                [
                    { transform: 'rotate(0deg) scale(1)' },
                    { transform: 'rotate(360deg) scale(1.3)' },
                    { transform: 'rotate(360deg) scale(1)' }
                ],
                { duration: 600, easing: EASE }
            );
        }

        // "5" -> "05"
        function dois(n) {
            return (n < 10 ? '0' : '') + n;
        }

        // Soma 1 gol no placar
        function marcarGol(lado, animar) {
            gols[lado]++;
            golsEl[lado].textContent = gols[lado];
            if (animar) Anim.pop([golsEl[lado]], { duracao: 450 });
        }

        // Cria a linha do evento na lista
        function criarEvento(ev, animar) {
            var ehGol = ev.tipo === 'gol';
            var visitante = ev.lado === 'visitante';

            var linha = document.createElement('div');
            linha.className = 'evento ' + ev.lado + (ehGol ? ' gol' : '');

            var icone = ehGol
                ? '<svg class="icone-evento" viewBox="0 0 24 24"><use href="#icone-bola"/></svg>'
                : '<svg class="icone-evento" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6"><rect x="7" y="4" width="10" height="14" rx="1.5"/></svg>';

            var cartao = '';
            if (ev.tipo === 'amarelo') cartao = '<span class="cartao amarelo-cartao"></span>';
            if (ev.tipo === 'vermelho') cartao = '<span class="cartao"></span>';

            linha.innerHTML = icone + '<span class="jogador"></span><span class="minuto"></span>' + cartao;
            linha.querySelector('.jogador').textContent = ev.jogador; // textContent = seguro contra HTML
            linha.querySelector('.minuto').textContent = ev.minuto + "'";

            lista.appendChild(linha);
            lista.scrollTop = lista.scrollHeight; // rola até o último evento

            // Hover (a linha é criada agora, então o listener também)
            if (ehGol) {
                linha.addEventListener('mouseenter', function () {
                    girar(linha.querySelector('.icone-evento'));
                });
            }
            var c = linha.querySelector('.cartao');
            if (c) {
                linha.addEventListener('mouseenter', function () { Anim.pop([c], { duracao: 320 }); });
            }

            if (!animar) return;

            Anim.deslizar([linha], { x: visitante ? 20 : -20, intervalo: 0, duracao: 340 });
            Anim.pop(linha.querySelectorAll('.icone-evento, .cartao'), { intervalo: 0, duracao: 380 });
            if (ehGol) Anim.pulsar(linha, { atraso: 300, duracao: 700 });
        }

        // Tudo que acontece em UM minuto de jogo
        function processarMinuto(m, animar) {
            tempo.textContent = dois(m) + ':00';

            eventos.forEach(function (ev) {
                if (ev.minuto !== m) return;
                criarEvento(ev, animar);
                if (ev.tipo === 'gol') marcarGol(ev.lado, animar);
            });
        }

        // ---------- 1. ENTRADA DA PÁGINA ----------
        Anim.entrada([box], { y: 16, duracao: 380 });

        var times = q('.time-placar');
        if (times[0]) Anim.deslizar([times[0]], { x: -30, atraso: 250, intervalo: 0, duracao: 420 });
        if (times[1]) Anim.deslizar([times[1]], { x: 30, atraso: 250, intervalo: 0, duracao: 420 });

        Anim.pop(q('.resultado'), { atraso: 450, duracao: 450 });
        Anim.pop(q('.tempo'), { atraso: 700, duracao: 400 });
        Anim.entrada(q('.acontecimentos h2'), { atraso: 800, y: 6, duracao: 280 });
        Anim.entrada([btnPular], { atraso: 900, y: 10, duracao: 320 });

        // ---------- 2. O RELÓGIO ----------
        var minuto = 0;
        var timer = null;
        var terminou = false;

        function terminar() {
            if (terminou) return;
            terminou = true;

            btnPular.hidden = true;
            Anim.pulsar(tempo, { vezes: 2 });
            Anim.pulsar(q('.resultado')[0], { atraso: 200, duracao: 900 });

            link.hidden = false;
            Anim.entrada([link], { atraso: 400, y: 10, duracao: 320 });

            var btn = link.querySelector('.btn-primario');
            if (btn) {
                btn.addEventListener('click', function () { Anim.pop([btn], { duracao: 300 }); });
            }
        }

        // Começa o relógio depois da entrada terminar
        var inicio = setTimeout(function () {
            timer = setInterval(function () {
                minuto++;
                processarMinuto(minuto, true);

                if (minuto >= DURACAO_JOGO) {
                    clearInterval(timer);
                    terminar();
                }
            }, TEMPO_POR_MINUTO);
        }, 1200);

        // ---------- 3. CLIQUE: PULAR PARTIDA ----------
        // Para o relógio e joga todos os minutos restantes de uma vez, sem animação
        btnPular.addEventListener('click', function () {
            clearTimeout(inicio);
            clearInterval(timer);

            for (var m = minuto + 1; m <= DURACAO_JOGO; m++) {
                processarMinuto(m, false);
            }
            minuto = DURACAO_JOGO;
            terminar();
        });
    }
});
<link rel="stylesheet" href="assets/css/configuracoes.css">

<?php
$estadoJogo = $_SESSION['estado_jogo'] ?? null;

function hc($v)
{
    return htmlspecialchars((string)$v, ENT_QUOTES, 'UTF-8');
}

$nomeManager  = $estadoJogo->nome ?? '—';
$nomeClube    = $estadoJogo->clube->nomeClube ?? '—';
$fotoClube    = $estadoJogo->clube->foto ?? '';
$ligaJogo     = $estadoJogo->liga ?? '';
$modoJogo     = $estadoJogo->modo ?? '';
$dataInicio   = isset($estadoJogo->dataInicio) ? $estadoJogo->dataInicio->format('d/m/Y') : '—';
$dataAtual    = isset($estadoJogo->dataAtual) ? $estadoJogo->dataAtual->format('d/m/Y') : '—';
?>

<main>

    <h1 class="titulo">Configurações</h1>

    <form id="form-config" onsubmit="return false;">
        <div class="cfg-layout">

            <div class="cfg-col">

                <!-- PARTIDA -->
                <section class="cfg-box">
                    <h2>Partida</h2>

                    <div class="cfg-linha">
                        <div class="cfg-texto">
                            <strong>Pular direto para o resultado</strong>
                            <span>Simula as partidas sem acompanhar os lances e mostra o resumo no final.</span>
                        </div>
                        <label class="switch"><input type="checkbox" name="pular_partida"><i></i></label>
                    </div>
                </section>

                <!-- GESTÃO -->
                <section class="cfg-box">
                    <h2>Gestão</h2>

                    <div class="cfg-linha">
                        <div class="cfg-texto">
                            <strong>Confirmar ações irreversíveis</strong>
                            <span>Pede confirmação antes de vender, dispensar ou aceitar uma proposta.</span>
                        </div>
                        <label class="switch"><input type="checkbox" name="confirmar_acoes" checked><i></i></label>
                    </div>

                    <div class="cfg-linha">
                        <div class="cfg-texto">
                            <strong>Escalação automática</strong>
                            <span>Completa a escalação sozinho caso falte algum titular (lesão ou suspensão).</span>
                        </div>
                        <label class="switch"><input type="checkbox" name="escalacao_auto"><i></i></label>
                    </div>
                </section>

                <!-- NOTIFICAÇÕES -->
                <section class="cfg-box">
                    <h2>Notificações</h2>

                    <div class="cfg-linha">
                        <div class="cfg-texto">
                            <strong>Propostas recebidas</strong>
                            <span>Avisa quando outro clube fizer uma oferta por um atleta seu.</span>
                        </div>
                        <label class="switch"><input type="checkbox" name="notif_propostas" checked><i></i></label>
                    </div>

                    <div class="cfg-linha">
                        <div class="cfg-texto">
                            <strong>Imprensa e diretoria</strong>
                            <span>Notícias, cobranças e recados sobre a confiança da diretoria.</span>
                        </div>
                        <label class="switch"><input type="checkbox" name="notif_imprensa" checked><i></i></label>
                    </div>

                    <div class="cfg-linha">
                        <div class="cfg-texto">
                            <strong>Lesões e suspensões</strong>
                            <span>Avisa quando um jogador ficar indisponível.</span>
                        </div>
                        <label class="switch"><input type="checkbox" name="notif_lesoes" checked><i></i></label>
                    </div>
                </section>

            </div>

            <div class="cfg-col">

                <!-- MEU JOGO -->
                <section class="cfg-box">
                    <h2>Meu jogo</h2>

                    <div class="jogo-cabecalho">
                        <?php if ($fotoClube !== ''): ?>
                            <img src="assets/<?= hc($fotoClube) ?>" alt="">
                        <?php endif; ?>
                        <div>
                            <strong><?= hc($nomeManager) ?></strong>
                            <span><?= hc($nomeClube) ?><?= $ligaJogo !== '' ? ' · ' . hc($ligaJogo) : '' ?></span>
                        </div>
                    </div>

                    <?php if ($modoJogo !== ''): ?>
                        <div class="info-linha"><span>Modo de jogo</span><span><?= hc(ucfirst(strtolower(str_replace('_', ' ', $modoJogo)))) ?></span></div>
                    <?php endif; ?>
                    <div class="info-linha"><span>Início da carreira</span><span><?= hc($dataInicio) ?></span></div>
                    <div class="info-linha"><span>Data atual no jogo</span><span><?= hc($dataAtual) ?></span></div>

                    <div class="cfg-linha" style="margin-top: 6px;">
                        <div class="cfg-texto">
                            <strong>Exportar jogo</strong>
                            <span>Baixe um arquivo com o seu progresso para guardar ou levar para outro dispositivo.</span>
                        </div>
                        <button type="button" class="btn-cfg secundario" id="btn-exportar">EXPORTAR</button>
                    </div>
                </section>

                <!-- ZONA DE PERIGO -->
                <section class="cfg-box box-perigo">
                    <h2>Zona de perigo</h2>

                    <div class="cfg-linha">
                        <div class="cfg-texto">
                            <strong>Reiniciar carreira</strong>
                            <span>Apaga o progresso atual e volta para a criação de manager.</span>
                        </div>
                        <button type="button" class="btn-cfg perigo" id="btn-reiniciar">REINICIAR</button>
                    </div>
                </section>

            </div>
        </div>

        <div class="cfg-rodape">
            <span class="cfg-aviso" id="cfg-aviso" role="status">Configurações salvas ✓</span>
            <button type="button" class="btn-cfg secundario" id="btn-padrao">RESTAURAR PADRÃO</button>
            <button type="button" class="btn-cfg" id="btn-salvar">SALVAR</button>
        </div>
    </form>

</main>

<script>
    (function() {
        var CHAVE = 'managermode_config';
        var form = document.getElementById('form-config');
        var aviso = document.getElementById('cfg-aviso');

        function ler() {
            var dados = {};
            Array.prototype.forEach.call(form.elements, function(el) {
                if (!el.name) return;
                if (el.type === 'checkbox') dados[el.name] = el.checked;
                else if (el.type === 'radio') {
                    if (el.checked) dados[el.name] = el.value;
                }
            });
            return dados;
        }

        function aplicar(dados) {
            Array.prototype.forEach.call(form.elements, function(el) {
                if (!el.name || !(el.name in dados)) return;
                if (el.type === 'checkbox') el.checked = !!dados[el.name];
                else if (el.type === 'radio') el.checked = (el.value === dados[el.name]);
            });
        }

        var padrao = ler();

        try {
            var salvo = JSON.parse(localStorage.getItem(CHAVE) || 'null');
            if (salvo) aplicar(salvo);
        } catch (e) {}

        function mostrarAviso(texto) {
            aviso.textContent = texto;
            aviso.classList.add('visivel');
            clearTimeout(mostrarAviso.t);
            mostrarAviso.t = setTimeout(function() { aviso.classList.remove('visivel'); }, 2200);
        }

        document.getElementById('btn-salvar').addEventListener('click', function() {
            try {
                localStorage.setItem(CHAVE, JSON.stringify(ler()));
                mostrarAviso('Configurações salvas ✓');
            } catch (e) {
                mostrarAviso('Não foi possível salvar neste navegador');
            }
        });

        document.getElementById('btn-padrao').addEventListener('click', function() {
            aplicar(padrao);
            mostrarAviso('Padrão restaurado — clique em salvar para confirmar');
        });

        document.getElementById('btn-exportar').addEventListener('click', function() {
            mostrarAviso('Exportação em breve');
        });
        document.getElementById('btn-reiniciar').addEventListener('click', function() {
            mostrarAviso('Reinício de carreira em breve');
        });
    })();
</script>

<script src="assets/js/animations/configuracoes.js"></script>
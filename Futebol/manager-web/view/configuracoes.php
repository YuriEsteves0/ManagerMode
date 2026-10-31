<?php

if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['acao'] ?? '') === 'reiniciar') {
    while (ob_get_level()) {
        ob_end_clean();
    }

    $_SESSION = [];
    session_destroy();

    header('Content-Type: application/json; charset=utf-8');
    echo json_encode(['ok' => true]);
    exit;
}

// Pedido de ajuda enviado pelo modal: o servidor repassa para o Apito (o token nunca vai para o navegador)
if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['acao'] ?? '') === 'solicitar_ajuda') {
    while (ob_get_level()) {
        ob_end_clean();
    }

    require_once __DIR__ . '/../services/AjudaService.php';
    $resultado = (new AjudaService())->enviarPedido($_POST);

    http_response_code($resultado['status']);
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode(['ok' => $resultado['ok'], 'erro' => $resultado['erro']]);
    exit;
}
?>

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

                <!-- AJUDA -->
                <section class="cfg-box">
                    <h2>Ajuda</h2>

                    <div class="cfg-linha">
                        <div class="cfg-texto">
                            <strong>Pedir ajuda</strong>
                            <span>Encontrou um erro, tem uma dúvida ou uma sugestão? Envie um pedido para a gente analisar.</span>
                        </div>
                        <button type="button" class="btn-cfg secundario" id="btn-ajuda">SOLICITAR AJUDA</button>
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

<!-- MODAL: SOLICITAR AJUDA -->
<div class="ajuda-fundo" id="ajuda-fundo" aria-hidden="true">
    <div class="ajuda-modal" role="dialog" aria-modal="true" aria-labelledby="ajuda-titulo">
        <div class="ajuda-topo">
            <h2 id="ajuda-titulo">Solicitar ajuda</h2>
            <button type="button" class="ajuda-fechar" id="ajuda-fechar" aria-label="Fechar">&times;</button>
        </div>

        <form id="form-ajuda" novalidate>
            <p class="ajuda-sub">Conte o que aconteceu. Vamos analisar o seu pedido e responder pelo e-mail informado.</p>

            <label class="ajuda-campo">
                <span>Tipo</span>
                <select name="categoria">
                    <option value="Erro">Erro no jogo</option>
                    <option value="Dúvida">Dúvida</option>
                    <option value="Sugestão">Sugestão</option>
                    <option value="Outro">Outro</option>
                </select>
            </label>

            <label class="ajuda-campo" id="ajuda-campo-tela">
                <span>Tela onde ocorreu o erro</span>
                <select name="tela">
                    <option value="">Selecione…</option>
                    <option>Criação de manager</option>
                    <option>Início</option>
                    <option>Equipe</option>
                    <option>Estatísticas</option>
                    <option>Patrocínios</option>
                    <option>Central de elenco</option>
                    <option>Mercado</option>
                    <option>Propostas recebidas</option>
                    <option>Propostas enviadas</option>
                    <option>Calendário</option>
                    <option>Treino</option>
                    <option>Diretoria</option>
                    <option>Carreira</option>
                    <option>Partida</option>
                    <option>Imprensa</option>
                    <option>Configurações</option>
                    <option>Outra</option>
                </select>
            </label>

            <label class="ajuda-campo">
                <span>Assunto</span>
                <input type="text" name="titulo" maxlength="140" placeholder="Resuma em uma frase" autocomplete="off">
            </label>

            <label class="ajuda-campo">
                <span>Descrição</span>
                <textarea name="descricao" rows="5" maxlength="2000" placeholder="O que você estava fazendo? O que esperava que acontecesse?"></textarea>
            </label>

            <label class="ajuda-campo">
                <span>Seu e-mail para contato</span>
                <input type="email" name="email" maxlength="120" placeholder="voce@email.com" autocomplete="email">
            </label>

            <div class="ajuda-erro" id="ajuda-erro" role="alert"></div>

            <div class="ajuda-acoes">
                <button type="button" class="btn-cfg secundario" id="ajuda-cancelar">CANCELAR</button>
                <button type="submit" class="btn-cfg" id="ajuda-enviar">ENVIAR</button>
            </div>
        </form>

        <div class="ajuda-ok" id="ajuda-ok">
            <div class="ajuda-ok-icone">&#10003;</div>
            <strong>Pedido enviado!</strong>
            <span>Obrigado. Vamos analisar e, se precisar, falamos com você pelo e-mail informado.</span>
            <button type="button" class="btn-cfg" id="ajuda-concluir">FECHAR</button>
        </div>
    </div>
</div>

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
            mostrarAviso.t = setTimeout(function() {
                aviso.classList.remove('visivel');
            }, 2200);
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

        document.getElementById('btn-reiniciar').addEventListener('click', async function() {
            if (!confirm('Isso apaga todo o progresso atual. Deseja continuar?')) return;

            try {
                var resposta = await fetch('index.php?pag=configuracoes', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: 'acao=reiniciar'
                });
                if (!resposta.ok) throw new Error('Falha ao reiniciar');

                try {
                    localStorage.removeItem(CHAVE);
                } catch (e) {}

                window.location.href = 'index.php?pag=cadastro_1';
            } catch (erro) {
                console.error(erro);
                mostrarAviso('Não foi possível reiniciar a carreira');
            }
        });
    })();
</script>
<script>
    (function() {
        var fundo = document.getElementById('ajuda-fundo');
        var modal = fundo.querySelector('.ajuda-modal');
        var form = document.getElementById('form-ajuda');
        var erro = document.getElementById('ajuda-erro');
        var ok = document.getElementById('ajuda-ok');
        var botaoEnviar = document.getElementById('ajuda-enviar');
        var botaoAbrir = document.getElementById('btn-ajuda');
        var campoTela = document.getElementById('ajuda-campo-tela');
        var enviando = false;

        function aberto() {
            return fundo.classList.contains('aberto');
        }

        function mostrarErro(texto) {
            erro.textContent = texto || '';
            erro.classList.toggle('visivel', !!texto);
        }

        // o campo "Tela onde ocorreu o erro" só aparece quando o tipo é "Erro"
        function atualizarCampoTela() {
            campoTela.style.display = form.elements.categoria.value === 'Erro' ? '' : 'none';
        }

        function abrir() {
            form.hidden = false;
            ok.classList.remove('visivel');
            mostrarErro('');
            atualizarCampoTela();
            fundo.classList.add('aberto');
            fundo.setAttribute('aria-hidden', 'false');
            document.body.style.overflow = 'hidden';
            setTimeout(function() { form.elements.titulo.focus(); }, 60);
        }

        function fechar() {
            if (enviando) return;
            fundo.classList.remove('aberto');
            fundo.setAttribute('aria-hidden', 'true');
            document.body.style.overflow = '';
            botaoAbrir.focus();
        }

        function validar() {
            var d = form.elements;
            if (d.categoria.value === 'Erro' && !d.tela.value) return 'Informe a tela onde ocorreu o erro.';
            if (d.titulo.value.trim().length < 3) return 'Informe um assunto.';
            if (d.descricao.value.trim().length < 10) return 'Descreva melhor o que aconteceu (mínimo de 10 caracteres).';
            if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(d.email.value.trim())) return 'Informe um e-mail válido para contato.';
            return '';
        }

        form.elements.categoria.addEventListener('change', atualizarCampoTela);

        botaoAbrir.addEventListener('click', abrir);
        document.getElementById('ajuda-fechar').addEventListener('click', fechar);
        document.getElementById('ajuda-cancelar').addEventListener('click', fechar);
        document.getElementById('ajuda-concluir').addEventListener('click', fechar);

        // fecha ao clicar no fundo borrado (só se o clique começou e terminou ali)
        var cliqueNoFundo = false;
        fundo.addEventListener('mousedown', function(e) { cliqueNoFundo = (e.target === fundo); });
        fundo.addEventListener('click', function(e) {
            if (e.target === fundo && cliqueNoFundo) fechar();
        });

        document.addEventListener('keydown', function(e) {
            if (!aberto()) return;
            if (e.key === 'Escape') { fechar(); return; }
            if (e.key !== 'Tab') return;
            // mantém o foco dentro do modal
            var focaveis = Array.prototype.filter.call(
                modal.querySelectorAll('button, input, select, textarea'),
                function(el) { return !el.disabled && el.offsetParent !== null; }
            );
            if (!focaveis.length) return;
            var primeiro = focaveis[0], ultimo = focaveis[focaveis.length - 1];
            if (e.shiftKey && document.activeElement === primeiro) { e.preventDefault(); ultimo.focus(); }
            else if (!e.shiftKey && document.activeElement === ultimo) { e.preventDefault(); primeiro.focus(); }
        });

        form.addEventListener('submit', function(e) {
            e.preventDefault();
            if (enviando) return;

            var problema = validar();
            mostrarErro(problema);
            if (problema) return;

            var corpo = new URLSearchParams();
            corpo.set('acao', 'solicitar_ajuda');
            ['categoria', 'tela', 'titulo', 'descricao', 'email'].forEach(function(nome) {
                corpo.set(nome, form.elements[nome].value.trim());
            });

            enviando = true;
            botaoEnviar.disabled = true;
            botaoEnviar.textContent = 'ENVIANDO…';

            fetch('index.php?pag=configuracoes', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: corpo.toString()
                })
                .then(function(resposta) {
                    return resposta.json().catch(function() { return {}; }).then(function(dados) {
                        if (!resposta.ok || !dados.ok) throw new Error(dados.erro || 'Não consegui enviar agora. Tente de novo.');
                    });
                })
                .then(function() {
                    form.reset();
                    atualizarCampoTela();
                    form.hidden = true;
                    ok.classList.add('visivel');
                    document.getElementById('ajuda-concluir').focus();
                })
                .catch(function(err) {
                    mostrarErro(err.message);
                })
                .then(function() {
                    enviando = false;
                    botaoEnviar.disabled = false;
                    botaoEnviar.textContent = 'ENVIAR';
                });
        });
    })();
</script>

<script src="assets/js/animations/configuracoes.js"></script>
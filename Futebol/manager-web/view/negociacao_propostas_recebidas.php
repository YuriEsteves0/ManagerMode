<link rel="stylesheet" href="assets/css/negociacao_propostas_recebidas.css">

<?php

$estadoJogo = $_SESSION['estado_jogo'];
$apiService = new ApiService();
$idClube = $estadoJogo->clube->id;

$propostas = $apiService->get("/clubes/{$idClube}/transferencias?tipoTransferencia=recebida") ?? [];

function moeda($v): string
{
    return 'R$ ' . formatarNumero((int) ($v ?? 0));
}

foreach ($propostas as &$p) {
    $j = $p['jogador'];
    $p['fmt'] = [
        'valor'    => moeda($p['valorOferecido']),
        'rescisao' => moeda($j['valorRescisao'] ?? 0),
        'mercado'  => moeda($j['valor'] ?? 0),
        'salario'  => moeda($j['salario'] ?? 0) . ' / mês',
    ];
}
unset($p);

$orcamentoClube = $estadoJogo->clube->orcamento ?? null;
$orcamentoFmt = $orcamentoClube !== null ? moeda($orcamentoClube) : '—';

?>

<style>
    /* painel da contraproposta (análise do clube interessado) */
    .proposta-contra {
        border: 1px solid rgba(160, 120, 255, .45);
        background: rgba(160, 120, 255, .08);
        border-radius: 10px;
        padding: 12px;
        margin: 12px 0;
        display: flex;
        flex-direction: column;
        gap: 10px;
    }

    .proposta-contra[hidden] {
        display: none;
    }

    .contra-selo {
        align-self: flex-start;
        font-size: 11px;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: .05em;
        padding: 2px 8px;
        border-radius: 999px;
        background: rgba(160, 120, 255, .25);
    }

    .contra-msg {
        margin: 0;
        font-size: 14px;
    }

    .contra-linha {
        display: grid;
        grid-template-columns: 1fr auto 1fr;
        align-items: center;
        gap: 8px;
    }

    .contra-rotulo {
        grid-column: 1 / -1;
        font-size: 12px;
        opacity: .75;
        margin-top: 4px;
    }

    .contra-item {
        display: flex;
        flex-direction: column;
        gap: 2px;
        font-size: 12px;
    }

    .contra-item strong {
        font-size: 15px;
    }

    .contra-item.destaque strong {
        color: #3ddc84;
    }

    .contra-acoes {
        display: flex;
        gap: 8px;
    }

    .contra-acoes button {
        flex: 1;
        padding: 9px 12px;
        border-radius: 8px;
        border: 1px solid rgba(255, 255, 255, .2);
        background: transparent;
        color: inherit;
        font-weight: 600;
        cursor: pointer;
    }

    .contra-acoes button.primario {
        background: #7c4dff;
        border-color: #7c4dff;
        color: #fff;
    }

    .contra-erro {
        color: #ff6b6b;
        font-size: 13px;
        margin: 8px 0 0;
    }

    .contra-erro[hidden] {
        display: none;
    }
</style>

<main>
    <h1 class="titulo">Propostas Recebidas</h1>

    <div class="layout">

        <section class="box">
            <h2>Meus Jogadores
                <span style="color:var(--roxoTexto); font-weight:400; text-transform:none;">
                    (<?= count($propostas) ?> propostas)
                </span>
            </h2>
            <div class="lista rolavel">
                <?php foreach ($propostas as $i => $proposta) {
                    $j = $proposta['jogador'];
                    $nomeJogador = $j['onfire'] ? "🔥 " . $j['nomeJogador'] : $j['nomeJogador'];
                ?>
                    <div class="proposta-linha <?= $i === 0 ? 'selecionado' : '' ?>" onclick="selecionar(this, <?= $i ?>)">
                        <span class="posicao"><?= htmlspecialchars($j['posicaoPrincipal']) ?></span>
                        <div class="info">
                            <span class="nome-linha"><?= htmlspecialchars($nomeJogador) ?></span>
                            <span class="sub">Proposta enviada pelo clube: <?= htmlspecialchars($proposta['clubeExterior']['nomeClube']) ?></span>
                        </div>
                        <div class="direita">
                            <div class="overall"><?= $j['overall'] ?></div>
                            <div class="valor"><?= $proposta['fmt']['valor'] ?></div>
                        </div>
                    </div>
                <?php } ?>

                <?php if (empty($propostas)) { ?>
                    <p style="padding:12px;">Nenhuma proposta recebida.</p>
                <?php } ?>
            </div>
        </section>

        <section class="box">
            <div class="detalhe-cabecalho">
                <div class="time-info">
                    <strong id="det-clube">Informações da Transferência</strong>
                </div>
                <button class="btn-lixeira" title="Recusar proposta">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <polyline points="3 6 5 6 21 6"></polyline>
                        <path d="M19 6l-1 14a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2L5 6"></path>
                        <path d="M10 11v6"></path>
                        <path d="M14 11v6"></path>
                        <path d="M9 6V4a1 1 0 0 1 1-1h4a1 1 0 0 1 1 1v2"></path>
                    </svg>
                </button>
            </div>

            <div class="detalhe-corpo rolavel">

                <div class="mini-stats">
                    <div class="item"><span>Valor da proposta</span><strong id="det-valor-prop"></strong></div>
                    <div class="item"><span>Valor Jogador</span><strong id="det-valor"></strong></div>
                    <div class="item"><span>Overall</span><strong id="det-overall"></strong></div>
                    <div class="item"><span>Posição</span><strong id="det-posicao"></strong></div>
                    <div class="item"><span>Idade</span><strong id="det-idade"></strong></div>
                    <div class="item"><span>Status</span><strong id="det-status"></strong></div>
                    <div class="item"><span>Tipo de contratação</span><strong id="det-tipo">Definitiva</strong></div>
                    <div class="item"><span>Rescisão do jogador</span><strong id="det-rescisao"></strong></div>
                </div>

                <div class="observacoes" id="det-obs"></div>

                <div class="acoes">
                    <button class="btn-contraproposta" type="button" onclick="abrirModal()">Contraproposta</button>
                    <button class="btn-aceitar" type="button">Aceitar Termos</button>
                </div>
            </div>
        </section>

    </div>

    <!-- MODAL DE CONTRAPROPOSTA -->
    <div class="overlay" id="overlayContraproposta">
        <div class="modal">
            <div class="modal-topo">
                <h2>Enviar Contraproposta</h2>
                <button class="modal-fechar" onclick="fecharModal()">✕</button>
            </div>

            <div class="campo">
                <label>Nome do jogador</label>
                <div class="valor-fixo" id="mod-nome"></div>
            </div>

            <div class="campo">
                <label>Valor do jogador (mercado)</label>
                <div class="valor-fixo" id="mod-valor"></div>
            </div>

            <div class="campo">
                <label>Tipo de negociação</label>
                <div class="tipo-toggle">
                    <input type="radio" name="tipo-neg" id="tipo-definitiva" checked onchange="atualizarTipo()">
                    <label for="tipo-definitiva">Definitiva</label>
                    <input type="radio" name="tipo-neg" id="tipo-emprestimo" onchange="atualizarTipo()">
                    <label for="tipo-emprestimo">Empréstimo</label>
                </div>
            </div>

            <!-- SOMENTE DEFINITIVA -->
            <div class="campo so-definitiva">
                <label>Valor de transferência pedido</label>
                <input type="number" id="ct-valor" placeholder="Ex: 220000000" oninput="aoMudarCampo()">
            </div>

            <!-- SOMENTE EMPRÉSTIMO -->
            <div class="campo so-emprestimo" id="linhaDuracao">
                <label>Tempo de contrato do empréstimo: <span class="slider-valor" id="valorDuracao">1 ano</span></label>
                <div class="slider-linha">
                    <input type="range" id="sliderDuracao" min="0" max="3" step="1" value="1" oninput="atualizarDuracao(this.value)">
                    <div class="slider-legenda"><span>6 meses</span><span>1 ano</span><span>2 anos</span><span>3 anos</span></div>
                </div>
            </div>

            <div class="campo so-emprestimo">
                <label>Taxa de empréstimo pedida</label>
                <input type="number" id="ct-taxa" placeholder="Ex: 5000000" oninput="aoMudarCampo()">
            </div>

            <div class="checkbox-linha so-emprestimo">
                <input type="checkbox" id="opcaoCompra" onchange="atualizarOpcaoCompra(); aoMudarCampo()">
                <label for="opcaoCompra">Empréstimo com opção de compra</label>
            </div>

            <div class="campo so-emprestimo" id="linhaValorCompra">
                <label>Valor da opção de compra</label>
                <input type="number" id="ct-opcao" placeholder="Ex: 150000000" oninput="aoMudarCampo()">
            </div>

            <div class="campo">
                <label>Salário atual do jogador</label>
                <div class="valor-fixo" id="mod-salario"></div>
            </div>

            <div class="campo so-emprestimo">
                <label>Divisão do salário: <span class="slider-valor" id="valorDivisao"></span></label>
                <div class="slider-linha">
                    <input type="range" id="sliderDivisao" min="0" max="100" step="5" value="60" oninput="atualizarDivisao(this.value)">
                </div>
            </div>

            <div class="campo">
                <label>Orçamento disponível do seu clube</label>
                <div class="valor-fixo"><?= $orcamentoFmt ?></div>
            </div>

            <div class="campo">
                <label>Clube interessado</label>
                <div class="clube-interessado">
                    <img id="mod-escudo" src="" alt="Escudo" width="36" height="36" style="object-fit:contain;">
                    <div class="info"><strong id="mod-clube"></strong></div>
                </div>
            </div>

            <div class="campo">
                <label>Valor enviado originalmente pelo clube interessado</label>
                <div class="valor-fixo" id="mod-pedido"></div>
            </div>

            <!-- PAINEL DA ANÁLISE DO CLUBE (contraproposta) -->
            <div class="proposta-contra" id="proposta-contra" hidden>
                <span class="contra-selo">Contraproposta do clube</span>
                <p class="contra-msg" id="contra-msg"></p>
                <div class="contra-linha" id="contra-linhas"></div>
                <div class="contra-acoes">
                    <button type="button" id="contra-ajustar">Ajustar pedido</button>
                    <button type="button" class="primario" id="contra-aceitar">Fechar negócio</button>
                </div>
            </div>

            <p class="contra-erro" id="contra-erro" hidden></p>

            <button class="btn-enviar" type="button" id="btn-enviar-contra" onclick="enviarContraproposta()">Enviar Proposta</button>
        </div>
    </div>
</main>

<script>
    const propostas = <?= json_encode($propostas, JSON_UNESCAPED_UNICODE) ?>;
    let clubeAtual = '';
    let indiceAtual = 0;
    let contraAtual = null; // contraproposta do clube em aberto

    // ===== limites da análise (razão = pedido / valor justo) =====
    const TOLERANCIA_ACEITE = 1.10; // até 10% acima do valor justo: clube aceita
    const LIMITE_RECUSA = 1.40; // mais de 40% acima: clube recusa
    const MESES = [6, 12, 24, 36];

    function set(id, texto) {
        const el = document.getElementById(id);
        if (el) el.textContent = texto;
    }

    function dinheiro(v) {
        return 'R$ ' + Math.round(Number(v) || 0).toLocaleString('pt-BR');
    }

    function arredondar10mil(v) {
        return Math.ceil(v / 10000) * 10000;
    }

    function preencherDetalhe(i) {
        const p = propostas[i];
        if (!p) return;
        indiceAtual = i;
        const j = p.jogador;
        clubeAtual = p.clubeExterior.nomeClube;

        // painel da direita

        set('det-valor-prop', p.fmt.valor);
        set('det-valor', p.fmt.mercado);
        set('det-overall', j.overall);
        set('det-posicao', j.posicaoPrincipal);
        set('det-idade', j.idade + ' anos');
        set('det-rescisao', p.fmt.rescisao);

        const status = document.getElementById('det-status');
        status.textContent = j.onfire ? 'On fire' : 'Normal';
        status.classList.toggle('on-fire', !!j.onfire);

        // observações (regra de exemplo: ajuste ao seu jogo)
        let texto = 'proposta dentro da faixa de mercado.';
        if (p.valorOferecido < j.valor) texto = 'valor abaixo do mercado do jogador.';
        else if (j.satisfacao != null && j.satisfacao < 50) texto = 'o jogador está insatisfeito e aceitaria sair.';
        document.getElementById('det-obs').innerHTML = '<strong>Observações:</strong> ' + texto;

        // modal
        set('mod-nome', j.nomeJogador);
        set('mod-valor', p.fmt.mercado);
        set('mod-salario', p.fmt.salario);
        const escudo = document.getElementById('mod-escudo');
        escudo.src = 'assets/' + p.clubeExterior.foto;
        escudo.alt = 'Escudo do ' + clubeAtual;
        set('mod-clube', clubeAtual);
        set('mod-pedido', p.fmt.valor);
        atualizarDivisao(document.getElementById('sliderDivisao').value);

        esconderContra();
        limparErro();
    }

    function selecionar(el, i) {
        document.querySelectorAll('.proposta-linha').forEach(l => l.classList.remove('selecionado'));
        el.classList.add('selecionado');
        preencherDetalhe(i);
    }

    function abrirModal() {
        esconderContra();
        limparErro();
        document.getElementById('overlayContraproposta').classList.add('aberto');
    }

    function fecharModal() {
        document.getElementById('overlayContraproposta').classList.remove('aberto');
    }
    document.getElementById('overlayContraproposta').addEventListener('click', function(e) {
        if (e.target === this) fecharModal();
    });

    var duracoes = ['6 meses', '1 ano', '2 anos', '3 anos'];

    function atualizarDuracao(v) {
        set('valorDuracao', duracoes[v]);
        aoMudarCampo();
    }

    function atualizarDivisao(v) {
        set('valorDivisao', 'Seu clube ' + v + '% / ' + clubeAtual + ' ' + (100 - v) + '%');
        esconderContra();
    }

    function atualizarTipo() {
        var emprestimo = document.getElementById('tipo-emprestimo').checked;

        // mostra/esconde cada grupo de campos conforme o tipo escolhido
        document.querySelectorAll('.so-definitiva').forEach(function(el) {
            el.style.display = emprestimo ? 'none' : '';
        });
        document.querySelectorAll('.so-emprestimo').forEach(function(el) {
            el.style.display = emprestimo ? '' : 'none';
        });

        atualizarOpcaoCompra();
        aoMudarCampo();
    }

    function atualizarOpcaoCompra() {
        var emprestimo = document.getElementById('tipo-emprestimo').checked;
        var comOpcao = document.getElementById('opcaoCompra').checked;
        // o valor da opção de compra só aparece no empréstimo com o checkbox marcado
        document.getElementById('linhaValorCompra').style.display = (emprestimo && comOpcao) ? '' : 'none';
    }

    /* ===== ANÁLISE DA CONTRAPROPOSTA ===== */

    function numCampo(id) {
        var e = document.getElementById(id);
        return e && e.value !== '' ? Number(e.value) : 0;
    }

    function mostrarErro(msg) {
        var e = document.getElementById('contra-erro');
        e.textContent = msg;
        e.hidden = false;
    }

    function limparErro() {
        var e = document.getElementById('contra-erro');
        e.textContent = '';
        e.hidden = true;
    }

    function esconderContra() {
        contraAtual = null;
        var painel = document.getElementById('proposta-contra');
        if (painel) painel.hidden = true;
    }

    // qualquer mudança nos campos invalida a contraproposta em aberto
    function aoMudarCampo() {
        limparErro();
        esconderContra();
    }

    // valor justo do jogador na visão do clube interessado
    function valorJusto(j) {
        var preco = Number(j.valor) || 0;
        var contrato = Number(j.tempoContrato) || 0;
        var idade = Number(j.idade) || 0;
        var pot = Number(j.potencial) || 0;
        var ovr = Number(j.overall) || 0;
        var multa = Number(j.valorRescisao) || 0;

        if (contrato > 0 && contrato <= 6) preco *= 0.85;
        else if (contrato > 36) preco *= 1.10;

        if (idade >= 32) preco *= 0.90;
        else if (idade > 0 && idade <= 21 && (pot - ovr) >= 8) preco *= 1.15;

        if (j.onfire) preco *= 1.10;

        if (multa > 0 && preco > multa) preco = multa;

        return Math.round(preco);
    }

    // devolve { resultado, razao, contra: {...} | null }
    function avaliarContraproposta(p, pedido) {
        var j = p.jogador;
        var preco = valorJusto(j);
        var teto = Math.round(preco * TOLERANCIA_ACEITE);
        var original = Number(p.valorOferecido) || 0;

        // ---------- DEFINITIVA ----------
        if (pedido.tipo === 'definitiva') {
            // pediu menos (ou igual) ao que o clube já ofereceu, ou dentro do que ele paga
            if (pedido.valor <= Math.max(original, teto)) {
                return { resultado: 'ACEITA', razao: pedido.valor / preco, contra: null };
            }

            var razao = pedido.valor / preco;
            if (razao > LIMITE_RECUSA) {
                return { resultado: 'RECUSADA', razao: razao, contra: null };
            }

            // ponto médio entre a oferta original e o pedido, limitado ao teto do clube
            var teta = Math.max(teto, original);
            var meio = arredondar10mil((original + pedido.valor) / 2);
            if (meio > teta) meio = teta;
            if (meio < original) meio = original;

            if (meio >= pedido.valor) {
                return { resultado: 'ACEITA', razao: razao, contra: null };
            }
            return { resultado: 'CONTRAPROPOSTA', razao: razao, contra: { valor: meio } };
        }

        // ---------- EMPRÉSTIMO ----------
        var refTaxa = (Number(j.valor) || 0) * 0.10 * (pedido.meses / 12);
        var tetoTaxa = Math.round(refTaxa * 1.20);
        var tetoOpcao = teto;

        var rTaxa = tetoTaxa > 0 ? pedido.taxa / tetoTaxa : 0;
        var rOpcao = (pedido.opcaoCompra && tetoOpcao > 0) ? pedido.opcao / tetoOpcao : 0;
        var pior = Math.max(rTaxa, rOpcao);

        if (pior <= 1) {
            return { resultado: 'ACEITA', razao: pior, contra: null };
        }
        if (pior > LIMITE_RECUSA) {
            return { resultado: 'RECUSADA', razao: pior, contra: null };
        }

        var contra = {
            taxa: Math.min(pedido.taxa, arredondar10mil(tetoTaxa))
        };
        if (pedido.opcaoCompra) contra.opcao = Math.min(pedido.opcao, arredondar10mil(tetoOpcao));

        return { resultado: 'CONTRAPROPOSTA', razao: pior, contra: contra };
    }

    // lê o que o usuário preencheu no modal
    function lerPedido() {
        var emprestimo = document.getElementById('tipo-emprestimo').checked;
        if (!emprestimo) {
            return {
                tipo: 'definitiva',
                valor: numCampo('ct-valor')
            };
        }
        return {
            tipo: 'emprestimo',
            meses: MESES[Number(document.getElementById('sliderDuracao').value)],
            taxa: numCampo('ct-taxa'),
            opcaoCompra: document.getElementById('opcaoCompra').checked,
            opcao: numCampo('ct-opcao'),
            divisao: Number(document.getElementById('sliderDivisao').value)
        };
    }

    function linhaContra(rotulo, pedido, clube) {
        return '<span class="contra-rotulo">' + rotulo + '</span>' +
            '<div class="contra-item"><span>Você pediu</span><strong>' + dinheiro(pedido) + '</strong></div>' +
            '<span>→</span>' +
            '<div class="contra-item destaque"><span>O clube paga</span><strong>' + dinheiro(clube) + '</strong></div>';
    }

    function mostrarContra(analise, pedido) {
        contraAtual = { pedido: pedido, contra: analise.contra };

        var html = '';
        var diferenca = 0;

        if (pedido.tipo === 'definitiva') {
            html = linhaContra('Valor de transferência', pedido.valor, analise.contra.valor);
            diferenca = pedido.valor - analise.contra.valor;
        } else {
            html = linhaContra('Taxa de empréstimo', pedido.taxa, analise.contra.taxa);
            diferenca = pedido.taxa - analise.contra.taxa;
            if (pedido.opcaoCompra) {
                html += linhaContra('Opção de compra', pedido.opcao, analise.contra.opcao);
                diferenca += pedido.opcao - analise.contra.opcao;
            }
        }

        set('contra-msg', clubeAtual + ' está interessado, mas só fecha se você abrir mão de ' +
            dinheiro(diferenca) + '.');
        document.getElementById('contra-linhas').innerHTML = html;
        document.getElementById('proposta-contra').hidden = false;
    }

    function toast(tipo, msg) {
        if (typeof Toast !== 'undefined' && Toast[tipo]) Toast[tipo](msg);
        else alert(msg);
    }

    // TODO: trocar por fetch na sua API quando o endpoint de contraproposta existir
    function finalizarNegocio(status, pedidoFinal) {
        var p = propostas[indiceAtual];
        // exemplo do que enviar:
        // fetch(API_URL + '/contraproposta', { method: 'POST', headers: {'Content-Type': 'application/json'},
        //   body: JSON.stringify({ idTransferencia: p.id, statusProposta: status, ...pedidoFinal }) })

        fecharModal();
        if (status === 'ACEITA') {
            toast('sucesso', clubeAtual + ' aceitou os termos!');
        } else {
            toast('erro', clubeAtual + ' recusou a contraproposta: o pedido foi muito alto.');
        }
    }

    function enviarContraproposta() {
        var p = propostas[indiceAtual];
        if (!p) return;
        limparErro();

        var pedido = lerPedido();

        if (pedido.tipo === 'definitiva' && pedido.valor <= 0) {
            mostrarErro('Informe o valor de transferência pedido.');
            return;
        }
        if (pedido.tipo === 'emprestimo') {
            if (pedido.taxa <= 0) {
                mostrarErro('Informe a taxa de empréstimo pedida.');
                return;
            }
            if (pedido.opcaoCompra && pedido.opcao <= 0) {
                mostrarErro('Informe o valor da opção de compra.');
                return;
            }
        }

        var analise = avaliarContraproposta(p, pedido);

        if (analise.resultado === 'CONTRAPROPOSTA') {
            // não envia nada ainda, só mostra o que o clube topa pagar
            mostrarContra(analise, pedido);
            return;
        }

        finalizarNegocio(analise.resultado, pedido);
    }

    // "Ajustar pedido": joga o valor do clube nos campos pra você editar
    document.getElementById('contra-ajustar').addEventListener('click', function() {
        var c = contraAtual;
        esconderContra();
        if (!c) return;
        if (c.pedido.tipo === 'definitiva') {
            document.getElementById('ct-valor').value = c.contra.valor;
        } else {
            document.getElementById('ct-taxa').value = c.contra.taxa;
            if (c.contra.opcao != null) document.getElementById('ct-opcao').value = c.contra.opcao;
        }
    });

    // "Fechar negócio": aceita o valor que o clube propôs
    document.getElementById('contra-aceitar').addEventListener('click', function() {
        if (!contraAtual) return;
        finalizarNegocio('ACEITA', contraAtual.contra);
    });

    preencherDetalhe(0);
    atualizarTipo();
</script>

<script src="assets/js/animations/negociacao_propostas_recebidas.js"></script>
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

                <!-- <div>
                    <h2>Premier League</h2>
                    <table class="tabela-liga" style="margin-top:6px;">
                        <thead>
                            <tr>
                                <th>Time</th>
                                <th class="num">Pts</th>
                                <th class="num">GF</th>
                                <th class="num">GS</th>
                                <th class="num">SG</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Manchester City</td>
                                <td class="num">58</td>
                                <td class="num">44</td>
                                <td class="num">18</td>
                                <td class="num">+26</td>
                            </tr>
                            <tr>
                                <td>Arsenal</td>
                                <td class="num">54</td>
                                <td class="num">39</td>
                                <td class="num">20</td>
                                <td class="num">+19</td>
                            </tr>
                            <tr class="destaque">
                                <td>Chelsea</td>
                                <td class="num">51</td>
                                <td class="num">37</td>
                                <td class="num">22</td>
                                <td class="num">+15</td>
                            </tr>
                            <tr>
                                <td>Liverpool</td>
                                <td class="num">49</td>
                                <td class="num">35</td>
                                <td class="num">23</td>
                                <td class="num">+12</td>
                            </tr>
                            <tr>
                                <td>Aston Villa</td>
                                <td class="num">45</td>
                                <td class="num">31</td>
                                <td class="num">25</td>
                                <td class="num">+6</td>
                            </tr>
                        </tbody>
                    </table>
                </div> -->

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
                <label>Valor de transferência oferecido</label>
                <input type="number" placeholder="Ex: 220000000">
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
                <label>Taxa de empréstimo oferecida</label>
                <input type="number" placeholder="Ex: 5000000">
            </div>

            <div class="checkbox-linha so-emprestimo">
                <input type="checkbox" id="opcaoCompra" onchange="atualizarOpcaoCompra()">
                <label for="opcaoCompra">Empréstimo com opção de compra</label>
            </div>

            <div class="campo so-emprestimo" id="linhaValorCompra">
                <label>Valor da opção de compra</label>
                <input type="number" placeholder="Ex: 150000000">
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

            <button class="btn-enviar" type="button" onclick="fecharModal()">Enviar Proposta</button>
        </div>
    </div>
</main>

<script>
    const propostas = <?= json_encode($propostas, JSON_UNESCAPED_UNICODE) ?>;
    let clubeAtual = '';

    function set(id, texto) {
        const el = document.getElementById(id);
        if (el) el.textContent = texto;
    }

    function preencherDetalhe(i) {
        const p = propostas[i];
        if (!p) return;
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
    }

    function selecionar(el, i) {
        document.querySelectorAll('.proposta-linha').forEach(l => l.classList.remove('selecionado'));
        el.classList.add('selecionado');
        preencherDetalhe(i);
    }

    function abrirModal() {
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
    }

    function atualizarDivisao(v) {
        set('valorDivisao', 'Seu clube ' + v + '% / ' + clubeAtual + ' ' + (100 - v) + '%');
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
    }

    function atualizarOpcaoCompra() {
        var emprestimo = document.getElementById('tipo-emprestimo').checked;
        var comOpcao = document.getElementById('opcaoCompra').checked;
        // o valor da opção de compra só aparece no empréstimo com o checkbox marcado
        document.getElementById('linhaValorCompra').style.display = (emprestimo && comOpcao) ? '' : 'none';
    }

    preencherDetalhe(0);
    atualizarTipo();
</script>

<script src="assets/js/animations/negociacao_propostas_recebidas.js"></script>
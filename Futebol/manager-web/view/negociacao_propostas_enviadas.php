<link rel="stylesheet" href="assets/css/negociacao_propostas_enviadas.css">

<?php

$estadoJogo = $_SESSION['estado_jogo'];
$apiService = new ApiService();
$idClube = $estadoJogo->clube->id;

$propostas = $apiService->get("/clubes/{$idClube}/transferencias?tipoTransferencia=enviada") ?? [];

function moedaEnv($v): string
{
    return 'R$ ' . formatarNumero((int) ($v ?? 0));
}

// Status do banco: PENDENTE, ACEITA_1, RECUSADA, CANCELADA, ACEITA_2, FEITA
// Retorna [classe CSS (.tag-status), rótulo]
function statusProposta($status): array
{
    $s = strtoupper(trim((string) $status));

    switch ($s) {
        case 'ACEITA_1':
            return ['aceita_1', 'Clube Aceitou'];
        case 'ACEITA_2':
            return ['aceita_2', 'Jogador Aceitou'];
        case 'FEITA':
            return ['feita', 'Transação Concluída'];
        case 'RECUSADA':
            return ['recusada', 'Proposta Recusada'];
        case 'CANCELADA':
            return ['recusada', 'Proposta Cancelada'];
        case 'PENDENTE':
        default:
            return ['enviada', 'Proposta Enviada'];
    }
}

// Lesões e estatísticas são buscadas uma vez por clube alvo (evita chamadas repetidas)
$cacheClube = [];
function dadosClubeAlvo(ApiService $api, $idClubeAlvo, int $anoAtual, array &$cache): array
{
    if (!$idClubeAlvo) {
        return ['lesoes' => [], 'stats' => []];
    }
    if (!isset($cache[$idClubeAlvo])) {
        $lesoes = $api->get("/jogadores/clube/{$idClubeAlvo}/lesoes") ?? [];
        $stats  = $api->get("/jogadores/clube/{$idClubeAlvo}/estatisticas") ?? [];

        $l = [];
        foreach ($lesoes as $x) {
            $l[$x['idJogador']][] = $x;
        }
        $s = [];
        foreach ($stats as $x) {
            if ((int) ($x['ano'] ?? 0) !== $anoAtual) continue;
            $s[$x['idJogador']][] = $x;
        }
        $cache[$idClubeAlvo] = ['lesoes' => $l, 'stats' => $s];
    }
    return $cache[$idClubeAlvo];
}

$dataReferencia = $estadoJogo->dataAtual ?? $estadoJogo->dataInicio;
$anoAtual = (int) $dataReferencia->format('Y');

foreach ($propostas as &$p) {
    $j = $p['jogador'] ?? [];
    $clube = $p['clubeExterior'] ?? [];
    [$classe, $rotulo] = statusProposta($p['statusProposta'] ?? $p['status'] ?? '');

    $idJogador = $j['idJogador'] ?? $j['id'] ?? null;
    $idClubeAlvo = $clube['idClube'] ?? $clube['id'] ?? $j['clubeIdClube'] ?? null;
    $dados = dadosClubeAlvo($apiService, $idClubeAlvo, $anoAtual, $cacheClube);

    $p['statusClasse'] = $classe;
    $p['statusRotulo'] = $rotulo;
    $p['jogador']['lesoes'] = $idJogador !== null ? ($dados['lesoes'][$idJogador] ?? []) : [];
    $p['jogador']['estatisticas'] = $idJogador !== null ? ($dados['stats'][$idJogador] ?? []) : [];
    $p['fmt'] = [
        'valor'    => moedaEnv($p['valorOferecido'] ?? 0),
        'mercado'  => moedaEnv($j['valor'] ?? 0),
        'rescisao' => moedaEnv($j['valorRescisao'] ?? 0),
        'salario'  => moedaEnv($j['salario'] ?? 0),
        'contrato' => formatarMesesParaAnos($j['tempoContrato'] ?? 0),
    ];
}
unset($p);
?>

<main>

    <h1 class="titulo">Propostas Enviadas</h1>

    <div class="layout">

        <section class="box">
            <h2>Alvos do Mercado <span style="color:var(--roxoTexto); font-weight:400; text-transform:none;">(<?= count($propostas) ?>)</span></h2>
            <div class="lista rolavel">

                <?php foreach ($propostas as $i => $proposta) {
                    $j = $proposta['jogador'];
                    $nomeJogador = $j['nomeJogador'];
                ?>
                    <div class="jogador-linha <?= $i === 0 ? 'selecionado' : '' ?>" onclick="selecionar(this, <?= $i ?>)">
                        <span class="posicao"><?= htmlspecialchars($j['posicaoPrincipal'] ?? '-') ?></span>
                        <div class="info">
                            <strong><?= htmlspecialchars($nomeJogador) ?></strong>
                            <span>Overall: <?= htmlspecialchars((string) ($j['overall'] ?? '-')) ?> • <?= htmlspecialchars($proposta['statusRotulo']) ?></span>
                        </div>
                        <span class="clube"><?= htmlspecialchars($proposta['clubeExterior']['nomeClube'] ?? '-') ?></span>
                        <span class="valor"><?= $proposta['fmt']['valor'] ?></span>
                        <span class="contrato"><?= $proposta['fmt']['contrato'] ?></span>
                    </div>
                <?php } ?>

                <?php if (empty($propostas)) { ?>
                    <p style="padding:12px;">Nenhuma proposta enviada.</p>
                <?php } ?>
            </div>
        </section>

        <section class="box">
            <div class="ficha-topo">
                <div class="nome-idade">
                    <strong id="ficha-nome">Informações da Proposta</strong>
                    <span id="ficha-sub"></span>
                </div>
                <span class="tag-status" id="ficha-tag"></span>
            </div>

            <div class="ficha-corpo rolavel">

                <div class="mini-stats">
                    <div class="item"><span>Valor enviado</span><strong id="ficha-valor"></strong></div>
                    <div class="item"><span>Valor do jogador</span><strong id="ficha-mercado"></strong></div>
                    <div class="item"><span>Contrato restante (<span id="ficha-clube-contrato">clube</span>)</span><strong id="ficha-contrato"></strong></div>
                    <div class="item"><span>Overall</span><strong id="ficha-overall"></strong></div>
                    <div class="item"><span>Salário atual</span><strong id="ficha-salario"></strong></div>
                    <div class="item"><span>Rescisão</span><strong id="ficha-rescisao"></strong></div>
                </div>

                <div>
                    <h2>Atributos</h2>
                    <div class="atributos" style="margin-top:8px;" id="ficha-atributos"></div>
                </div>

                <div>
                    <h2>Lesões</h2>
                    <ul class="lesoes" style="margin-top:6px;" id="ficha-lesoes"></ul>
                </div>

                <div>
                    <h2>Estatísticas na Temporada</h2>
                    <table class="stats-jogos" style="margin-top:6px;">
                        <thead>
                            <tr><th>Competição</th><th class="num">J</th><th class="num">G</th><th class="num">A</th></tr>
                        </thead>
                        <tbody id="ficha-estatisticas"></tbody>
                    </table>
                </div>

                <button class="btn-formalizar" id="btn-formalizar" type="button">Formalizar Contratação</button>
            </div>
        </section>

    </div>

</main>

<!-- MODAL DE FORMALIZAÇÃO (mesmo padrão do modal de proposta do mercado) -->
<dialog class="proposta-modal" id="modal-formalizar">
    <form class="proposta-form" id="form-formalizar" novalidate>
        <header class="proposta-topo">
            <div class="proposta-id">
                <span class="proposta-pos" id="mod-pos">-</span>
                <div>
                    <h2 id="mod-nome">Formalizar Contratação</h2>
                    <span id="mod-sub">-</span>
                </div>
            </div>
            <button type="button" class="proposta-fechar" id="mod-fechar" aria-label="Fechar">&times;</button>
        </header>

        <div class="proposta-ref">
            <div class="item"><span>Valor acordado</span><strong id="mod-ref-valor">-</strong></div>
            <div class="item"><span>Multa de rescisão</span><strong id="mod-ref-multa">-</strong></div>
            <div class="item"><span>Salário atual</span><strong id="mod-ref-salario">-</strong></div>
            <div class="item"><span>Contrato restante</span><strong id="mod-ref-contrato">-</strong></div>
            <div class="item"><span>Overall</span><strong id="mod-ref-overall">-</strong></div>
            <div class="item"><span>Moral</span><strong id="mod-ref-moral">-</strong></div>
        </div>

        <div class="proposta-campo">
            <label for="mod-salario">Salário oferecido ao jogador (R$)</label>
            <input type="text" id="mod-salario" inputmode="numeric" autocomplete="off" placeholder="Ex: 210.000">
        </div>

        <div class="proposta-campo">
            <label for="mod-contrato">Tempo de contrato oferecido</label>
            <select id="mod-contrato">
                <option value="1">1 ano</option>
                <option value="2">2 anos</option>
                <option value="3" selected>3 anos</option>
                <option value="4">4 anos</option>
                <option value="5">5 anos</option>
            </select>
        </div>

        <div class="proposta-campo">
            <label for="mod-rescisao">Valor de rescisão (R$)</label>
            <input type="text" id="mod-rescisao" inputmode="numeric" autocomplete="off" placeholder="Ex: 90.000.000">
        </div>

        <div class="proposta-campo">
            <label>Satisfação do jogador no clube atual</label>
            <div class="moral-gauge">
                <div class="barra"><i id="mod-moral-barra" style="width:0%"></i></div>
                <div class="legenda"><span>Quer sair</span><span id="mod-moral-texto"></span><span>Feliz no clube</span></div>
            </div>
            <div class="aviso" id="mod-aviso" style="display:none;">
                Contratação dificultada pois o jogador não deseja sair do clube atual.
            </div>
        </div>

        <!-- Achômetro -->
        <div class="proposta-campo">
            <label>Achômetro</label>
            <div id="mod-achometro" style="padding:10px; border-radius:8px; background:var(--fundoMeioTransparente);">
                <div style="display:flex; justify-content:space-between; align-items:baseline; margin-bottom:8px;">
                    <strong id="ach-rotulo" style="font-size:14px;"></strong>
                    <span style="font-size:12px; color:var(--roxoTextoMaisClaro);">É só um palpite</span>
                </div>
                <div style="height:10px; border-radius:5px; background:var(--cinza); overflow:hidden;">
                    <div id="ach-barra" style="height:100%; width:0%; border-radius:5px; transition:width .25s ease, background .25s ease;"></div>
                </div>
                <div style="display:flex; justify-content:space-between; margin-top:6px; font-size:12px; color:var(--roxoTextoMaisClaro);">
                    <span>Dificilmente</span>
                    <span>Com certeza</span>
                </div>
            </div>
        </div>

        <p class="proposta-erro" id="mod-resultado" hidden></p>

        <footer class="proposta-acoes">
            <button type="button" class="btn-secundario" id="mod-cancelar">Cancelar</button>
            <button type="submit" class="btn-proposta" id="mod-enviar">Enviar proposta</button>
        </footer>
    </form>
</dialog>


<script>
    const propostas = <?= json_encode($propostas, JSON_UNESCAPED_UNICODE) ?>;
    let propostaAtual = 0;

    const listaAtributos = [
        ['Velocidade', 'velocidade'],
        ['Força', 'forca'],
        ['Inteligência', 'inteligencia'],
        ['Finalização', 'finalizacao'],
        ['Marcação', 'marcacao'],
        ['Passe', 'passe']
    ];

    // Texto do botão conforme a etapa da negociação
    const textoBotao = {
        aceita_1: 'Formalizar Contratação',
        aceita_2: 'Jogador já aceitou',
        feita: 'Transação concluída',
        enviada: 'Aguardando resposta do clube',
        recusada: 'Proposta encerrada'
    };

    const modal = document.getElementById('modal-formalizar');

    // =====================================================================
    // IA DO JOGADOR
    //
    // avaliarProposta() calcula um score de interesse (0-100) e se a
    // proposta está bloqueada (filtro duro).
    //
    // O ACHÔMETRO mostra uma estimativa borrada desse score (distorção
    // fixa por jogador). A DECISÃO REAL acontece só em enviarProposta(),
    // com uma variação aleatória em cima do score.
    //
    // titular: 0 = titular | 1 = reserva | 2 = não relacionado
    // =====================================================================
    const IA = {
        notaMinima: 60,
        toleranciaReputacao: 15,      // quanto o clube pode estar abaixo da moral do jogador
        bonusToleranciaVeterano: 10,  // jogador 32+ aceita clube menor
        limiteFolhaOrcamento: 0.25,   // salário anual máx. = 25% do orçamento (após pagar a transferência)
        bonusReserva: 5,
        bonusNaoRelacionado: 12,
        ruidoAchometro: 10,           // erro máximo do palpite mostrado (+/-)
        ruidoDecisao: 8               // variação aleatória na decisão real (+/-)
    };

    // Faixas do achômetro: [limite superior, rótulo, cor]
    const FAIXAS_ACHOMETRO = [
        [25,  'Muito improvável', 'var(--vermelho)'],
        [45,  'Improvável',       'var(--laranja)'],
        [60,  'Incerto',          'var(--amarelo)'],
        [80,  'Provável',         'var(--verdeBrilho)'],
        [101, 'Muito provável',   'var(--verde)']
    ];

    function limitar(v, min, max) {
        return Math.max(min, Math.min(max, v));
    }

    // Faixa de contrato que o jogador considera ideal para a idade [min, max] em anos
    function contratoIdeal(idade) {
        if (idade <= 23) return [4, 5];
        if (idade <= 28) return [3, 5];
        if (idade <= 31) return [2, 3];
        return [1, 2];
    }

    function avaliarProposta(p, salario, anos) {
        const j = p.jogador || {};
        const ext = p.clubeExterior || {};
        const intr = p.clubeInterior || {};

        const idade = Number(j.idade) || 25;
        const moral = Number(j.moral) || 0;
        const satisfacao = Number(j.satisfacao ?? 50);
        const repExt = Number(ext.reputacao) || 0;
        const repInt = Number(intr.reputacao) || 0;
        const salarioAtual = Number(j.salario) || 1;

        // ---- 0) o clube externo consegue bancar? ----
        const orcamentoLivre = (Number(ext.orcamento) || 0) - (Number(p.valorOferecido) || 0);
        const folhaAnual = salario * 12;
        if (folhaAnual > orcamentoLivre * IA.limiteFolhaOrcamento) {
            return { bloqueado: true, score: 0 };
        }

        // ---- 1) filtro duro: moral x reputação ----
        const tolerancia = IA.toleranciaReputacao + (idade >= 32 ? IA.bonusToleranciaVeterano : 0);
        if (repExt < moral - tolerancia) {
            return { bloqueado: true, score: 0 };
        }

        let score = 50;

        // ---- 2) reputação relativa (subir/descer de patamar) ----
        score += limitar((repExt - repInt) * 0.5, -20, 20);
        if (repExt > moral + 10) score += 5; // clube de prestígio acima da moral dele

        // ---- 3) salário (comparado ao atual) ----
        const ratio = salario / salarioAtual;
        score += limitar((ratio - 1) * 60, -40, 30);

        // ---- 4) tempo de contrato x idade ----
        const [min, max] = contratoIdeal(idade);
        const desvio = anos < min ? min - anos : (anos > max ? anos - max : 0);
        score += desvio === 0 ? 5 : -desvio * 8;

        // ---- 5) satisfação no clube atual (feliz = mais difícil sair) ----
        score -= (satisfacao - 50) * 0.4;

        // ---- 6) situação no time: 0 = titular | 1 = reserva | 2 = não relacionado ----
        const situacao = Number(j.titular ?? 0);
        if (situacao === 2) score += IA.bonusNaoRelacionado;
        else if (situacao === 1) score += IA.bonusReserva;

        return { bloqueado: false, score: Math.round(limitar(score, 0, 100)) };
    }

    // Lê só os dígitos de um campo com máscara de milhar
    function digitos(id) {
        const v = document.getElementById(id).value.replace(/\D/g, '');
        return v === '' ? 0 : Number(v);
    }

    function formatarMilhar(v) {
        const n = Number(v);
        return n > 0 ? Math.round(n).toLocaleString('pt-BR') : '';
    }

    function dinheiro(v) {
        if (v === null || v === undefined) return '-';
        return 'R$ ' + Number(v).toLocaleString('pt-BR');
    }

    // Lê os campos do modal e avalia a proposta atual
    function avaliarModal() {
        const p = propostas[propostaAtual];
        if (!p) return null;
        const salario = digitos('mod-salario');
        const anos = Number(document.getElementById('mod-contrato').value) || 1;
        return avaliarProposta(p, salario, anos);
    }

    // Palpite mostrado ao usuário: score com distorção fixa por jogador
    function palpiteAchometro(p, r) {
        if (r.bloqueado) return 3;
        const seed = Number(p.jogador && p.jogador.idJogador) || 0;
        const distorcao = ((seed * 37) % (IA.ruidoAchometro * 2 + 1)) - IA.ruidoAchometro;
        return limitar(r.score + distorcao, 0, 100);
    }

    function mostrarResultado(msg) {
        const res = document.getElementById('mod-resultado');
        res.textContent = msg;
        res.hidden = false;
    }

    function esconderResultado() {
        const res = document.getElementById('mod-resultado');
        res.textContent = '';
        res.hidden = true;
    }

    function atualizarAchometro() {
        const p = propostas[propostaAtual];
        const r = avaliarModal();
        if (!p || !r) return null;

        const valor = palpiteAchometro(p, r);
        const faixa = FAIXAS_ACHOMETRO.find(f => valor < f[0]);

        const barra = document.getElementById('ach-barra');
        barra.style.width = Math.max(valor, 3) + '%';
        barra.style.background = faixa[2];

        const rotulo = document.getElementById('ach-rotulo');
        rotulo.textContent = faixa[1];
        rotulo.style.color = faixa[2];

        return r;
    }

    function enviarProposta() {
        const r = atualizarAchometro();
        if (!r) return;

        if (digitos('mod-salario') <= 0) {
            mostrarResultado('Informe o salário oferecido.');
            return;
        }

        // decisão real: score + variação aleatória
        const ruido = (Math.random() * 2 - 1) * IA.ruidoDecisao;
        const aceita = !r.bloqueado && (r.score + ruido) >= IA.notaMinima;

        if (!aceita) {
            mostrarResultado('O jogador recusou a proposta. Ajuste a oferta e tente novamente.');
            return;
        }

        // TODO: chamar a API para mudar o status para ACEITA_2
        // (salário, anos e rescisão: digitos('mod-salario'), #mod-contrato e digitos('mod-rescisao'))
        fecharModal();
    }

    // =====================================================================

    function set(id, texto) {
        const el = document.getElementById(id);
        if (el) el.textContent = texto;
    }

    function valorOuTraco(v, sufixo) {
        return (v === undefined || v === null || v === '') ? '-' : v + (sufixo || '');
    }

    function criarAtributo(nome, valor) {
        const v = Number(valor) || 0;
        const linha = document.createElement('div');
        linha.className = 'atributo-linha';

        const rotulo = document.createElement('span');
        rotulo.className = 'label';
        rotulo.textContent = nome;

        const barra = document.createElement('div');
        barra.className = 'barra';
        const preenchimento = document.createElement('i');
        preenchimento.style.width = v + '%';
        barra.appendChild(preenchimento);

        const num = document.createElement('span');
        num.className = 'num';
        num.textContent = v;

        linha.append(rotulo, barra, num);
        return linha;
    }

    function criarCelula(conteudo, numerico) {
        const td = document.createElement('td');
        if (numerico) td.className = 'num';
        td.textContent = conteudo;
        return td;
    }

    function preencherFicha(i) {
        const p = propostas[i];
        if (!p) return;
        propostaAtual = i;
        const j = p.jogador || {};
        const clube = (p.clubeExterior && p.clubeExterior.nomeClube) || '-';

        set('ficha-nome', j.nomeJogador || '-');
        set('ficha-sub', [j.posicaoPrincipal, j.idade ? j.idade + ' anos' : null, clube].filter(Boolean).join(' • '));

        const tag = document.getElementById('ficha-tag');
        tag.className = 'tag-status ' + p.statusClasse;
        tag.textContent = p.statusRotulo;

        set('ficha-valor', p.fmt.valor);
        set('ficha-mercado', p.fmt.mercado);
        set('ficha-clube-contrato', clube);
        set('ficha-contrato', p.fmt.contrato);
        set('ficha-overall', valorOuTraco(j.overall));
        set('ficha-salario', p.fmt.salario);
        set('ficha-rescisao', p.fmt.rescisao);

        const atributos = document.getElementById('ficha-atributos');
        atributos.innerHTML = '';
        listaAtributos.forEach(a => atributos.appendChild(criarAtributo(a[0], j[a[1]])));

        const lesoes = document.getElementById('ficha-lesoes');
        lesoes.innerHTML = '';
        const listaLesoes = Array.isArray(j.lesoes) ? j.lesoes : [];
        if (listaLesoes.length === 0) {
            const li = document.createElement('li');
            li.textContent = 'Nenhuma';
            lesoes.appendChild(li);
        } else {
            listaLesoes.forEach(l => {
                const li = document.createElement('li');
                li.textContent = l.nomeLesao + ' • ' + l.tempoLesionado + ' dias • ' + l.gravidade;
                lesoes.appendChild(li);
            });
        }

        const corpo = document.getElementById('ficha-estatisticas');
        corpo.innerHTML = '';
        const stats = Array.isArray(j.estatisticas) ? j.estatisticas : [];
        if (stats.length === 0) {
            const tr = document.createElement('tr');
            const td = criarCelula('Sem dados', false);
            td.colSpan = 4;
            tr.appendChild(td);
            corpo.appendChild(tr);
        } else {
            stats.forEach(e => {
                const tr = document.createElement('tr');
                tr.append(
                    criarCelula(e.nomeCompeticao || '-', false),
                    criarCelula(e.jogos ?? 0, true),
                    criarCelula(e.gols ?? 0, true),
                    criarCelula(e.assistencias ?? 0, true)
                );
                corpo.appendChild(tr);
            });
        }

        // botão: só habilita formalizar quando o CLUBE aceitou (ACEITA_1)
        // ACEITA_2 = jogador já aceitou, FEITA = transação concluída
        const btn = document.getElementById('btn-formalizar');
        const podeFormalizar = p.statusClasse === 'aceita_1';
        btn.disabled = !podeFormalizar;
        btn.style.opacity = podeFormalizar ? '' : '0.5';
        btn.style.cursor = podeFormalizar ? '' : 'not-allowed';
        btn.textContent = textoBotao[p.statusClasse] || 'Formalizar Contratação';

        // campos do modal
        document.getElementById('mod-salario').value = formatarMilhar(j.salario);
        document.getElementById('mod-rescisao').value = formatarMilhar(j.valorRescisao);
        document.getElementById('mod-contrato').value = '3';

        // gauge = satisfação do jogador no clube atual
        const satisfacao = Number(j.satisfacao ?? 0);
        document.getElementById('mod-moral-barra').style.width = satisfacao + '%';
        set('mod-moral-texto', satisfacao + ' / 100');
        document.getElementById('mod-aviso').style.display = satisfacao >= 70 ? '' : 'none';

        esconderResultado();
        atualizarAchometro();
    }

    function selecionar(el, i) {
        document.querySelectorAll('.jogador-linha').forEach(l => l.classList.remove('selecionado'));
        el.classList.add('selecionado');
        preencherFicha(i);
    }

    /* ===== MODAL ===== */

    function abrirModal() {
        if (document.getElementById('btn-formalizar').disabled) return;

        const p = propostas[propostaAtual];
        if (!p) return;
        const j = p.jogador || {};
        const clube = (p.clubeExterior && p.clubeExterior.nomeClube) || '-';

        set('mod-pos', valorOuTraco(j.posicaoPrincipal));
        set('mod-nome', j.nomeJogador || 'Formalizar Contratação');
        set('mod-sub', 'Formalizar contratação • ' + (j.idade ? j.idade + ' anos • ' : '') + clube);

        set('mod-ref-valor', p.fmt.valor);
        set('mod-ref-multa', p.fmt.rescisao);
        set('mod-ref-salario', p.fmt.salario);
        set('mod-ref-contrato', p.fmt.contrato);
        set('mod-ref-overall', valorOuTraco(j.overall) + (j.potencial ? ' / ' + j.potencial : ''));
        set('mod-ref-moral', valorOuTraco(j.moral));

        esconderResultado();
        atualizarAchometro();
        modal.showModal();
        document.getElementById('mod-salario').focus();
        document.getElementById('mod-salario').select();
    }

    function fecharModal() {
        modal.close();
    }

    document.getElementById('btn-formalizar').addEventListener('click', abrirModal);
    document.getElementById('mod-fechar').addEventListener('click', fecharModal);
    document.getElementById('mod-cancelar').addEventListener('click', fecharModal);

    modal.addEventListener('click', function(e) {
        if (e.target === modal) fecharModal();
    });

    document.getElementById('form-formalizar').addEventListener('submit', function(e) {
        e.preventDefault();
        enviarProposta();
    });

    // máscara de milhar + achômetro reagindo em tempo real
    function aoMudarOferta() {
        esconderResultado();
        atualizarAchometro();
    }

    ['mod-salario', 'mod-rescisao'].forEach(function(id) {
        document.getElementById(id).addEventListener('input', function() {
            const d = this.value.replace(/\D/g, '');
            this.value = d === '' ? '' : Number(d).toLocaleString('pt-BR');
            aoMudarOferta();
        });
    });
    document.getElementById('mod-contrato').addEventListener('change', aoMudarOferta);

    if (propostas.length > 0) {
        preencherFicha(0);
    } else {
        document.getElementById('btn-formalizar').disabled = true;
    }
</script>

<script src="assets/js/animations/negociacao_propostas_enviadas.js"></script>
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

// Normaliza o status vindo da API para uma das classes do CSS (.tag-status)
function statusProposta($status): array
{
    $s = strtolower(trim((string) $status));
    $s = strtr($s, ['á' => 'a', 'ã' => 'a', 'ç' => 'c', 'é' => 'e', 'í' => 'i', 'ó' => 'o', 'ú' => 'u']);

    if (str_contains($s, 'aceit')) return ['aceita', 'Proposta Aceita'];
    if (str_contains($s, 'recus')) return ['recusada', 'Proposta Recusada'];
    if (str_contains($s, 'cancel')) return ['recusada', 'Proposta Cancelada'];
    if (str_contains($s, 'contra')) return ['contraproposta', 'Contraproposta'];
    return ['enviada', 'Proposta Enviada'];
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
    $idClubeAlvo = $clube['idClube'] ?? $clube['id'] ?? $j['clube_idClube'] ?? null;
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
                    $nomeJogador = !empty($j['onfire']) ? "🔥 " . $j['nomeJogador'] : $j['nomeJogador'];
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

                <button class="btn-formalizar" id="btn-formalizar" type="button" onclick="abrirModal()">Formalizar Contratação</button>
            </div>
        </section>

    </div>

    <!-- MODAL DE FORMALIZAÇÃO -->
    <div class="overlay" id="overlayFormalizar">
        <div class="modal">
            <div class="modal-topo">
                <h2 id="mod-titulo">Formalizar Contratação</h2>
                <button class="modal-fechar" onclick="fecharModal()">✕</button>
            </div>

            <div class="campo">
                <label>Salário oferecido ao jogador</label>
                <input type="number" id="mod-salario" placeholder="Ex: 210000">
            </div>

            <div class="campo">
                <label>Tempo de contrato oferecido</label>
                <select>
                    <option>1 ano</option>
                    <option>2 anos</option>
                    <option selected>3 anos</option>
                    <option>4 anos</option>
                    <option>5 anos</option>
                </select>
            </div>

            <div class="campo">
                <label>Valor de rescisão</label>
                <input type="number" id="mod-rescisao" placeholder="Ex: 90000000">
            </div>

            <div class="campo">
                <label>Moral do jogador no clube atual</label>
                <div class="moral-gauge">
                    <div class="barra"><i id="mod-moral-barra" style="width:0%"></i></div>
                    <div class="legenda"><span>Quer sair</span><span id="mod-moral-texto"></span><span>Feliz no clube</span></div>
                </div>
            </div>

            <div class="aviso" id="mod-aviso" style="display:none;">
                Contratação dificultada pois o jogador não deseja sair do clube atual.
            </div>

            <button class="btn-enviar" type="button" onclick="fecharModal()">Enviar Proposta</button>
        </div>
    </div>

</main>


<script>
    const propostas = <?= json_encode($propostas, JSON_UNESCAPED_UNICODE) ?>;

    const listaAtributos = [
        ['Velocidade', 'velocidade'],
        ['Força', 'forca'],
        ['Inteligência', 'inteligencia'],
        ['Finalização', 'finalizacao'],
        ['Marcação', 'marcacao'],
        ['Passe', 'passe']
    ];

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

        // botão: só habilita formalizar quando a proposta foi aceita
        const btn = document.getElementById('btn-formalizar');
        const aceita = p.statusClasse === 'aceita';
        btn.disabled = !aceita;
        btn.style.opacity = aceita ? '' : '0.5';
        btn.style.cursor = aceita ? '' : 'not-allowed';

        // modal
        set('mod-titulo', 'Formalizar Contratação — ' + (j.nomeJogador || ''));
        document.getElementById('mod-salario').value = j.salario ?? '';
        document.getElementById('mod-rescisao').value = j.valorRescisao ?? '';
        const moral = Number(j.satisfacao ?? j.moral ?? 0);
        document.getElementById('mod-moral-barra').style.width = moral + '%';
        set('mod-moral-texto', moral + ' / 100');
        document.getElementById('mod-aviso').style.display = moral >= 50 ? '' : 'none';
    }

    function selecionar(el, i) {
        document.querySelectorAll('.jogador-linha').forEach(l => l.classList.remove('selecionado'));
        el.classList.add('selecionado');
        preencherFicha(i);
    }

    function abrirModal() {
        if (document.getElementById('btn-formalizar').disabled) return;
        document.getElementById('overlayFormalizar').classList.add('aberto');
    }

    function fecharModal() {
        document.getElementById('overlayFormalizar').classList.remove('aberto');
    }

    document.getElementById('overlayFormalizar').addEventListener('click', function(e) {
        if (e.target === this) fecharModal();
    });

    if (propostas.length > 0) {
        preencherFicha(0);
    } else {
        document.getElementById('btn-formalizar').disabled = true;
    }
</script>
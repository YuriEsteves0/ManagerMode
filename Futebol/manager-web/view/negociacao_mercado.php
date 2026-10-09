<link rel="stylesheet" href="assets/css/negociacao_mercado.css">

<?php

$apiService = new ApiService();
$jogadores = $apiService->get("/jogadores/overall") ?? [];

$nomesClubes = [];

function nomeDoClube(array $jogador, array $nomesClubes): string
{
    if (!empty($jogador['nomeClube'])) {
        return $jogador['nomeClube'];
    }
    $id = $jogador['clubeIdClube'] ?? null;
    return $nomesClubes[$id] ?? ('Clube ' . $id);
}

$lista = [];
$clubesFiltro = [];
$nacionalidadesFiltro = [];

foreach ($jogadores as $j) {
    $nomeClube = nomeDoClube($j, $nomesClubes);
    $clubesFiltro[$j['clubeIdClube']] = $nomeClube;
    if (!empty($j['nacionalidade'])) {
        $nacionalidadesFiltro[$j['nacionalidade']] = true;
    }

    $lista[] = [
        'id'          => $j['idJogador'],
        'nome'        => $j['nomeJogador'],
        'pos'         => $j['posicaoPrincipal'],
        'idade'       => (int) ($j['idade'] ?? 0),
        'ovr'         => (int) ($j['overall'] ?? 0),
        'pot'         => (int) ($j['potencial'] ?? 0),
        'vel'         => (int) ($j['velocidade'] ?? 0),
        'for'         => (int) ($j['forca'] ?? 0),
        'int'         => (int) ($j['inteligencia'] ?? 0),
        'fin'         => (int) ($j['finalizacao'] ?? 0),
        'mar'         => (int) ($j['marcacao'] ?? 0),
        'pas'         => (int) ($j['passe'] ?? 0),
        'moral'       => (int) ($j['moral'] ?? 0),
        'nac'         => $j['nacionalidade'] ?? '',
        'emp'         => !empty($j['dispEmprestimo']) ? 1 : 0,
        'fire'        => !empty($j['onfire']) ? 1 : 0,
        'valor'       => (float) ($j['valor'] ?? 0),
        'multa'       => (float) ($j['valorRescisao'] ?? 0),
        'salario'     => (float) ($j['salario'] ?? 0),
        'contrato'    => (int) ($j['tempoContrato'] ?? 0),
        'clubeId'     => $j['clubeIdClube'],
        'clube'       => $nomeClube,
        'valorFmt'    => formatarNumero($j['valor'] ?? 0),
        'contratoFmt' => formatarMesesParaAnos($j['tempoContrato'] ?? 0),
    ];
}

asort($clubesFiltro);
$nacionalidadesFiltro = array_keys($nacionalidadesFiltro);
sort($nacionalidadesFiltro);

?>

<main>

    <h1 class="titulo">Comprar Jogadores</h1>

    <div class="layout">

        <section class="box">
            <div class="topo-busca">
                <div class="orcamento">Orçamento disponível: <strong>R$ 22,4M</strong></div>

                <div class="busca-linha">
                    <input type="text" id="busca" placeholder="Buscar jogador ou clube...">
                    <details class="filtro-wrap">
                        <summary title="Filtros">⚙<span class="filtro-badge" id="filtro-badge">0</span></summary>
                        <div class="filtro-painel rolavel">

                            <div class="filtro-secao">
                                <label class="titulo-campo">Posição</label>
                                <div class="filtro-chips" id="f-posicoes">
                                    <label><input type="checkbox" name="pos" value="GOL"><span>GOL</span></label>
                                    <label><input type="checkbox" name="pos" value="ZAG"><span>ZAG</span></label>
                                    <label><input type="checkbox" name="pos" value="LD"><span>LD</span></label>
                                    <label><input type="checkbox" name="pos" value="LE"><span>LE</span></label>
                                    <label><input type="checkbox" name="pos" value="VOL"><span>VOL</span></label>
                                    <label><input type="checkbox" name="pos" value="MC"><span>MC</span></label>
                                    <label><input type="checkbox" name="pos" value="MEI"><span>MEI</span></label>
                                    <label><input type="checkbox" name="pos" value="PD"><span>PD</span></label>
                                    <label><input type="checkbox" name="pos" value="PE"><span>PE</span></label>
                                    <label><input type="checkbox" name="pos" value="ATA"><span>ATA</span></label>
                                </div>
                            </div>

                            <div class="filtro-grid">
                                <div class="filtro-campo">
                                    <label>Status no mercado</label>
                                    <select id="f-status">
                                        <option value="">Todos</option>
                                        <option value="emprestimo">Listado p/ empréstimo</option>
                                        <option value="nao-listado">Não listado</option>
                                        <option value="contrato-fim">Contrato terminando (≤ 6m)</option>
                                    </select>
                                </div>
                                <div class="filtro-campo">
                                    <label>Contrato restante</label>
                                    <select id="f-contrato">
                                        <option value="">Qualquer</option>
                                        <option value="6">Até 6 meses</option>
                                        <option value="12">Até 1 ano</option>
                                        <option value="24">Até 2 anos</option>
                                        <option value="25+">Mais de 2 anos</option>
                                    </select>
                                </div>
                                <div class="filtro-campo">
                                    <label>Clube</label>
                                    <select id="f-clube">
                                        <option value="">Todos</option>
                                        <?php foreach ($clubesFiltro as $idClube => $nomeClube) { ?>
                                            <option value="<?= htmlspecialchars((string) $idClube) ?>"><?= htmlspecialchars($nomeClube) ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                                <div class="filtro-campo">
                                    <label>Nacionalidade</label>
                                    <select id="f-nac">
                                        <option value="">Todas</option>
                                        <?php foreach ($nacionalidadesFiltro as $nac) { ?>
                                            <option><?= htmlspecialchars($nac) ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>

                            <div class="filtro-grid">
                                <div class="filtro-campo">
                                    <label>Idade</label>
                                    <div class="filtro-faixa"><input type="number" id="f-idade-min" placeholder="Mín"><input type="number" id="f-idade-max" placeholder="Máx"></div>
                                </div>
                                <div class="filtro-campo">
                                    <label>Overall</label>
                                    <div class="filtro-faixa"><input type="number" id="f-ovr-min" placeholder="Mín"><input type="number" id="f-ovr-max" placeholder="Máx"></div>
                                </div>
                                <div class="filtro-campo">
                                    <label>Valor de mercado (R$M)</label>
                                    <div class="filtro-faixa"><input type="number" id="f-valor-min" placeholder="Mín"><input type="number" id="f-valor-max" placeholder="Máx"></div>
                                </div>
                            </div>

                            <button class="filtro-limpar" type="button" id="f-limpar">Limpar filtros</button>
                        </div>
                    </details>
                </div>

                <div class="ordenar-linha">
                    <span>Ordenar por</span>
                    <select id="f-ordem">
                        <option value="">Padrão</option>
                        <option value="ovr">Overall</option>
                        <option value="pot">Potencial</option>
                        <option value="valor">Valor</option>
                        <option value="idade">Idade</option>
                        <option value="contrato">Contrato restante</option>
                        <option value="nome">Nome</option>
                    </select>
                    <button type="button" id="f-direcao" title="Inverter ordem">↓</button>
                </div>
                <div class="resultado-info" id="resultado-info"></div>
            </div>

            <div class="lista-jogadores rolavel" id="lista-jogadores">
                <div class="sem-resultado" id="sem-resultado">Nenhum jogador encontrado com esses filtros.</div>
            </div>

            <div class="paginacao" id="paginacao">
                <span class="paginacao-info" id="paginacao-info"></span>
                <div class="paginacao-botoes" id="paginacao-botoes"></div>
            </div>
        </section>

        <section class="box">
            <div class="ficha-topo">
                <span class="posicao-grande" id="ficha-posicao">-</span>
                <div>
                    <strong id="ficha-nome">Selecione um jogador</strong>
                    <span id="ficha-sub">-</span>
                </div>
            </div>

            <div class="ficha-corpo rolavel">

                <div class="mini-stats">
                    <div class="item"><span>Valor de mercado</span><strong id="ficha-valor">-</strong></div>
                    <div class="item"><span>Salário mensal</span><strong id="ficha-salario">-</strong></div>
                    <div class="item"><span id="ficha-contrato-label">Contrato restante</span><strong id="ficha-contrato">-</strong></div>
                    <div class="item"><span>Overall / Potencial</span><strong id="ficha-overall">-</strong></div>
                    <div class="item"><span>Multa de rescisão</span><strong id="ficha-multa">-</strong></div>
                    <div class="item"><span>Disponível p/ empréstimo</span><strong id="ficha-emprestimo">-</strong></div>
                </div>

                <div>
                    <h2>Atributos</h2>
                    <div class="atributos" style="margin-top:8px;" id="ficha-atributos"></div>
                </div>

                <div>
                    <h2>Lesões</h2>
                    <ul class="lesoes sem" style="margin-top:6px;" id="ficha-lesoes"></ul>
                </div>

                <div>
                    <h2>Estatísticas na Temporada</h2>
                    <table class="stats-jogos" style="margin-top:6px;">
                        <thead>
                            <tr>
                                <th>Competição</th>
                                <th class="num">J</th>
                                <th class="num">G</th>
                                <th class="num">A</th>
                            </tr>
                        </thead>
                        <tbody id="ficha-estatisticas"></tbody>
                    </table>
                </div>

            </div>

            <div class="ficha-acoes">
                <button type="button" class="btn-proposta" id="btn-proposta" disabled>Fazer proposta</button>
            </div>
        </section>

    </div>

</main>

<dialog class="proposta-modal" id="proposta-modal">
    <form class="proposta-form" id="proposta-form" novalidate>
        <header class="proposta-topo">
            <div>
                <h2>Fazer proposta</h2>
                <span id="proposta-jogador">-</span>
            </div>
            <button type="button" class="proposta-fechar" id="proposta-fechar" aria-label="Fechar">×</button>
        </header>

        <div class="proposta-ref">
            <div class="item"><span>Valor de mercado</span><strong id="proposta-ref-valor">-</strong></div>
            <div class="item"><span>Multa de rescisão</span><strong id="proposta-ref-multa">-</strong></div>
            <div class="item"><span>Clube do jogador</span><strong id="proposta-ref-clube">-</strong></div>
        </div>

        <div class="proposta-campo">
            <label for="proposta-valor">Valor oferecido (R$)</label>
            <input type="text" id="proposta-valor" inputmode="numeric" autocomplete="off" placeholder="0">
            <small id="proposta-valor-info"></small>
        </div>

        <p class="proposta-erro" id="proposta-erro" hidden></p>

        <footer class="proposta-acoes">
            <button type="button" class="btn-secundario" id="proposta-cancelar">Cancelar</button>
            <button type="submit" class="btn-proposta">Enviar proposta</button>
        </footer>
    </form>
</dialog>

<script>
    var JOGADORES = <?= json_encode($lista, JSON_UNESCAPED_UNICODE | JSON_HEX_TAG | JSON_HEX_AMP) ?>;

    var API_URL = 'http://localhost:8080';

    document.addEventListener('DOMContentLoaded', function() {
        var POR_PAGINA = 15;

        var lista = document.getElementById('lista-jogadores');
        var semResultado = document.getElementById('sem-resultado');
        var busca = document.getElementById('busca');
        var badge = document.getElementById('filtro-badge');
        var info = document.getElementById('resultado-info');
        var ordem = document.getElementById('f-ordem');
        var direcao = document.getElementById('f-direcao');
        var paginacaoInfo = document.getElementById('paginacao-info');
        var paginacaoBotoes = document.getElementById('paginacao-botoes');

        var desc = true;
        var pagina = 1;
        var filtrados = [];
        var selecionadoId = null;
        var cacheEstatisticas = {};
        var jogadorAtual = null;

        JOGADORES.forEach(function(j, i) {
            j._i = i;
        });

        var atributos = ['vel', 'for', 'int', 'fin', 'mar', 'pas'];

        function campo(id) {
            return document.getElementById(id);
        }

        function valorNum(id) {
            var e = campo(id);
            if (!e || e.value === '') return null;
            return Number(e.value);
        }

        function valorTxt(id) {
            var e = campo(id);
            return e ? e.value : '';
        }

        function entre(valor, min, max) {
            if (min !== null && valor < min) return false;
            if (max !== null && valor > max) return false;
            return true;
        }

        function aplicar() {
            var q = busca.value.trim().toLowerCase();
            var posicoes = Array.prototype.map.call(
                document.querySelectorAll('input[name="pos"]:checked'),
                function(i) {
                    return i.value;
                }
            );
            var status = valorTxt('f-status');
            var contrato = valorTxt('f-contrato');
            var clube = valorTxt('f-clube');
            var nac = valorTxt('f-nac');
            var fireEl = campo('f-fire');
            var fire = fireEl ? fireEl.checked : false;

            var idadeMin = valorNum('f-idade-min'),
                idadeMax = valorNum('f-idade-max');
            var ovrMin = valorNum('f-ovr-min'),
                ovrMax = valorNum('f-ovr-max');
            var potMin = valorNum('f-pot-min'),
                potMax = valorNum('f-pot-max');
            var valMin = valorNum('f-valor-min'),
                valMax = valorNum('f-valor-max');
            var attrMin = {};
            var ativos = 0;

            atributos.forEach(function(a) {
                attrMin[a] = valorNum('f-' + a);
                if (attrMin[a] !== null) ativos++;
            });

            [posicoes.length > 0, status, contrato, clube, nac, fire,
                idadeMin !== null || idadeMax !== null,
                ovrMin !== null || ovrMax !== null,
                potMin !== null || potMax !== null,
                valMin !== null || valMax !== null
            ].forEach(function(f) {
                if (f) ativos++;
            });

            filtrados = JOGADORES.filter(function(j) {
                if (q && (j.nome + ' ' + j.clube).toLowerCase().indexOf(q) === -1) return false;
                if (posicoes.length && posicoes.indexOf(j.pos) === -1) return false;
                if (clube && String(j.clubeId) !== clube) return false;
                if (nac && j.nac !== nac) return false;
                if (fire && j.fire !== 1) return false;

                if (status === 'emprestimo' && j.emp !== 1) return false;
                if (status === 'nao-listado' && j.emp !== 0) return false;
                if (status === 'contrato-fim' && j.contrato > 6) return false;

                if (contrato) {
                    if (contrato === '25+') {
                        if (j.contrato <= 24) return false;
                    } else if (j.contrato > Number(contrato)) return false;
                }

                if (!entre(j.idade, idadeMin, idadeMax)) return false;
                if (!entre(j.ovr, ovrMin, ovrMax)) return false;
                if (!entre(j.pot, potMin, potMax)) return false;
                if (!entre(j.valor / 1000000, valMin, valMax)) return false;

                for (var k = 0; k < atributos.length; k++) {
                    var a = atributos[k];
                    if (attrMin[a] !== null && j[a] < attrMin[a]) return false;
                }
                return true;
            });

            ordenar();

            info.textContent = filtrados.length === JOGADORES.length ?
                JOGADORES.length + ' jogadores' :
                filtrados.length + ' de ' + JOGADORES.length + ' jogadores';
            badge.textContent = ativos;
            badge.style.display = ativos > 0 ? 'inline-block' : 'none';

            pagina = 1;
            renderizar();

            var aindaVisivel = filtrados.some(function(j) {
                return j.id === selecionadoId;
            });
            if (filtrados.length && !aindaVisivel) selecionar(filtrados[0]);
        }

        function ordenar() {
            var chave = ordem.value;
            filtrados.sort(function(a, b) {
                if (!chave) return a._i - b._i;
                if (chave === 'nome') {
                    var r = a.nome.localeCompare(b.nome, 'pt-BR');
                    return desc ? r : -r;
                }
                var diff = b[chave] - a[chave];
                return desc ? diff : -diff;
            });
        }

        function criarLinha(j) {
            var div = document.createElement('div');
            div.className = 'jogador-linha' + (j.id === selecionadoId ? ' selecionado' : '');
            div.dataset.id = j.id;

            [
                ['posicao', j.pos],
                ['nome', j.nome],
                ['clube', j.clube],
                ['valor', 'R$ ' + j.valorFmt],
                ['contrato', j.contratoFmt]
            ].forEach(function(c) {
                var s = document.createElement('span');
                s.className = c[0];
                s.textContent = c[1];
                div.appendChild(s);
            });

            div.addEventListener('click', function() {
                selecionar(j);
            });
            return div;
        }

        function totalPaginas() {
            return Math.max(1, Math.ceil(filtrados.length / POR_PAGINA));
        }

        function renderizar() {
            var inicio = (pagina - 1) * POR_PAGINA;
            var fim = Math.min(inicio + POR_PAGINA, filtrados.length);

            lista.innerHTML = '';
            if (filtrados.length === 0) {
                semResultado.style.display = 'block';
                lista.appendChild(semResultado);
            } else {
                var frag = document.createDocumentFragment();
                filtrados.slice(inicio, fim).forEach(function(j) {
                    frag.appendChild(criarLinha(j));
                });
                lista.appendChild(frag);
            }
            lista.scrollTop = 0;

            paginacaoInfo.textContent = filtrados.length === 0 ?
                '0 jogadores' :
                (inicio + 1) + '–' + fim + ' de ' + filtrados.length;

            renderizarPaginacao();
        }

        function criarBotaoPagina(rotulo, alvo, opcoes) {
            var b = document.createElement('button');
            b.type = 'button';
            b.textContent = rotulo;
            if (opcoes && opcoes.ativo) b.className = 'ativo';
            if (opcoes && opcoes.desabilitado) b.disabled = true;
            b.addEventListener('click', function() {
                irParaPagina(alvo);
            });
            return b;
        }

        function renderizarPaginacao() {
            var total = totalPaginas();
            paginacaoBotoes.innerHTML = '';
            if (total <= 1) return;

            paginacaoBotoes.appendChild(criarBotaoPagina('‹', pagina - 1, {
                desabilitado: pagina === 1
            }));

            var numeros = [1, total, pagina - 1, pagina, pagina + 1].filter(function(n, i, arr) {
                return n >= 1 && n <= total && arr.indexOf(n) === i;
            }).sort(function(a, b) {
                return a - b;
            });

            var anterior = 0;
            numeros.forEach(function(n) {
                if (n - anterior > 1) {
                    var r = document.createElement('span');
                    r.className = 'reticencias';
                    r.textContent = '…';
                    paginacaoBotoes.appendChild(r);
                }
                paginacaoBotoes.appendChild(criarBotaoPagina(n, n, {
                    ativo: n === pagina
                }));
                anterior = n;
            });

            paginacaoBotoes.appendChild(criarBotaoPagina('›', pagina + 1, {
                desabilitado: pagina === total
            }));
        }

        function irParaPagina(n) {
            var total = totalPaginas();
            if (n < 1 || n > total || n === pagina) return;
            pagina = n;
            renderizar();
        }

        function limpar() {
            document.querySelectorAll('.filtro-painel input[type="number"]').forEach(function(i) {
                i.value = '';
            });
            document.querySelectorAll('.filtro-painel input[type="checkbox"]').forEach(function(i) {
                i.checked = false;
            });
            document.querySelectorAll('.filtro-painel select').forEach(function(s) {
                s.selectedIndex = 0;
            });
            aplicar();
        }

        document.querySelectorAll('.filtro-painel input, .filtro-painel select').forEach(function(el) {
            el.addEventListener('input', aplicar);
            el.addEventListener('change', aplicar);
        });

        busca.addEventListener('input', aplicar);
        ordem.addEventListener('change', aplicar);
        direcao.addEventListener('click', function() {
            desc = !desc;
            direcao.textContent = desc ? '↓' : '↑';
            aplicar();
        });
        campo('f-limpar').addEventListener('click', limpar);

        var el = {
            posicao: campo('ficha-posicao'),
            nome: campo('ficha-nome'),
            sub: campo('ficha-sub'),
            valor: campo('ficha-valor'),
            salario: campo('ficha-salario'),
            contratoLabel: campo('ficha-contrato-label'),
            contrato: campo('ficha-contrato'),
            overall: campo('ficha-overall'),
            multa: campo('ficha-multa'),
            emprestimo: campo('ficha-emprestimo'),
            atributos: campo('ficha-atributos'),
            lesoes: campo('ficha-lesoes'),
            estatisticas: campo('ficha-estatisticas'),
            proposta: campo('btn-proposta')
        };

        var listaAtributos = [
            ['Velocidade', 'vel'],
            ['Força', 'for'],
            ['Inteligência', 'int'],
            ['Finalização', 'fin'],
            ['Marcação', 'mar'],
            ['Passe', 'pas'],
            ['Moral', 'moral']
        ];

        function texto(valor, sufixo) {
            if (valor === undefined || valor === null || valor === '') return '-';
            return valor + (sufixo || '');
        }

        function dinheiro(valor) {
            if (valor === null || valor === undefined) return '-';
            return 'R$ ' + Number(valor).toLocaleString('pt-BR');
        }

        function criarAtributo(nome, valor) {
            var v = Number(valor) || 0;
            var linha = document.createElement('div');
            linha.className = 'atributo-linha';

            var rotulo = document.createElement('span');
            rotulo.className = 'label';
            rotulo.textContent = nome;

            var barra = document.createElement('div');
            barra.className = 'barra';
            var preenchimento = document.createElement('i');
            preenchimento.style.width = Math.min(v, 100) + '%';
            barra.appendChild(preenchimento);

            var num = document.createElement('span');
            num.className = 'num';
            num.textContent = v;

            linha.appendChild(rotulo);
            linha.appendChild(barra);
            linha.appendChild(num);
            return linha;
        }

        function criarCelula(conteudo, numerico) {
            var td = document.createElement('td');
            if (numerico) td.className = 'num';
            td.textContent = conteudo;
            return td;
        }

        function mensagemEstatisticas(msg) {
            el.estatisticas.innerHTML = '';
            var tr = document.createElement('tr');
            var td = criarCelula(msg, false);
            td.colSpan = 4;
            tr.appendChild(td);
            el.estatisticas.appendChild(tr);
        }

        function desenharEstatisticas(estatisticas) {
            if (!Array.isArray(estatisticas) || estatisticas.length === 0) {
                mensagemEstatisticas('Sem dados');
                return;
            }
            el.estatisticas.innerHTML = '';
            estatisticas.forEach(function(e) {
                var tr = document.createElement('tr');
                tr.appendChild(criarCelula(e.nomeCompeticao || '-', false));
                tr.appendChild(criarCelula(e.jogos ?? 0, true));
                tr.appendChild(criarCelula(e.gols ?? 0, true));
                tr.appendChild(criarCelula(e.assistencias ?? 0, true));
                el.estatisticas.appendChild(tr);
            });
        }

        function carregarEstatisticas(j) {
            var id = j.id;

            if (cacheEstatisticas[id]) {
                desenharEstatisticas(cacheEstatisticas[id]);
                return;
            }

            mensagemEstatisticas('Carregando...');

            fetch(API_URL + '/jogador/' + encodeURIComponent(id) + '/estatistica')
                .then(function(r) {
                    if (!r.ok) throw new Error('HTTP ' + r.status);
                    return r.json();
                })
                .then(function(dados) {
                    cacheEstatisticas[id] = dados;
                    if (id === selecionadoId) desenharEstatisticas(dados);
                })
                .catch(function() {
                    if (id === selecionadoId) mensagemEstatisticas('Erro ao carregar estatísticas');
                });
        }

        var pr = {
            jogador: campo('proposta-jogador'),
            refValor: campo('proposta-ref-valor'),
            refMulta: campo('proposta-ref-multa'),
            refClube: campo('proposta-ref-clube'),
            valor: campo('proposta-valor'),
            valorInfo: campo('proposta-valor-info'),
            erro: campo('proposta-erro')
        };

        var modalProposta = campo('proposta-modal');

        function valorDigitado() {
            var digitos = pr.valor.value.replace(/\D/g, '');
            return digitos === '' ? 0 : Number(digitos);
        }

        function mostrarErro(msg) {
            pr.erro.textContent = msg;
            pr.erro.hidden = false;
        }

        function limparErro() {
            pr.erro.textContent = '';
            pr.erro.hidden = true;
        }

        function atualizarInfoValor() {
            var v = valorDigitado();
            if (!jogadorAtual || v <= 0) {
                pr.valorInfo.textContent = '';
                return;
            }
            var partes = [];
            if (jogadorAtual.valor > 0) {
                partes.push(Math.round(v / jogadorAtual.valor * 100) + '% do valor de mercado');
            }
            if (jogadorAtual.multa > 0 && v >= jogadorAtual.multa) {
                partes.push('igual ou acima da multa de rescisão');
            }
            pr.valorInfo.textContent = partes.join(' • ');
        }

        function abrirProposta(j) {
            pr.jogador.textContent = j.nome + ' • ' + j.pos + ' • ' + j.clube;
            pr.refValor.textContent = 'R$ ' + j.valorFmt;
            pr.refMulta.textContent = dinheiro(j.multa);
            pr.refClube.textContent = texto(j.clube);

            pr.valor.value = j.valor > 0 ? Math.round(j.valor).toLocaleString('pt-BR') : '';

            limparErro();
            atualizarInfoValor();
            modalProposta.showModal();
            pr.valor.focus();
            pr.valor.select();
        }

        function enviarProposta(proposta) {
        }

        pr.valor.addEventListener('input', function() {
            var digitos = pr.valor.value.replace(/\D/g, '');
            pr.valor.value = digitos === '' ? '' : Number(digitos).toLocaleString('pt-BR');
            limparErro();
            atualizarInfoValor();
        });

        campo('proposta-fechar').addEventListener('click', function() {
            modalProposta.close();
        });

        campo('proposta-cancelar').addEventListener('click', function() {
            modalProposta.close();
        });

        modalProposta.addEventListener('click', function(e) {
            if (e.target === modalProposta) modalProposta.close();
        });

        campo('proposta-form').addEventListener('submit', function(e) {
            e.preventDefault();
            if (!jogadorAtual) return;

            var valor = valorDigitado();

            if (valor <= 0) {
                mostrarErro('Informe o valor oferecido.');
                return;
            }

            enviarProposta({
                idJogador: jogadorAtual.id,
                idClubeVendedor: jogadorAtual.clubeId,
                valorOferecido: valor
            });

            modalProposta.close();
        });

        el.proposta.addEventListener('click', function() {
            if (jogadorAtual) abrirProposta(jogadorAtual);
        });

        function selecionar(j) {
            selecionadoId = j.id;
            jogadorAtual = j;
            el.proposta.disabled = false;

            lista.querySelectorAll('.jogador-linha').forEach(function(l) {
                l.classList.toggle('selecionado', Number(l.dataset.id) === j.id);
            });

            el.posicao.textContent = texto(j.pos);
            el.nome.textContent = texto(j.nome);
            el.sub.textContent = (j.idade ? j.idade + ' anos • ' : '') + texto(j.nac) + ' • ' + texto(j.clube);

            el.valor.textContent = 'R$ ' + j.valorFmt;
            el.salario.textContent = dinheiro(j.salario);
            el.contratoLabel.textContent = 'Contrato restante (' + texto(j.clube) + ')';
            el.contrato.textContent = texto(j.contratoFmt);
            el.overall.textContent = texto(j.ovr) + ' / ' + texto(j.pot);
            el.multa.textContent = dinheiro(j.multa);

            el.emprestimo.textContent = j.emp ? 'Sim' : 'Não';
            el.emprestimo.className = j.emp ? 'sim' : 'nao';

            el.atributos.innerHTML = '';
            listaAtributos.forEach(function(a) {
                el.atributos.appendChild(criarAtributo(a[0], j[a[1]]));
            });

            el.lesoes.innerHTML = '';
            el.lesoes.className = 'lesoes sem';
            var vazio = document.createElement('li');
            vazio.textContent = 'Nenhuma';
            el.lesoes.appendChild(vazio);

            carregarEstatisticas(j);
        }

        aplicar();
    });
</script>
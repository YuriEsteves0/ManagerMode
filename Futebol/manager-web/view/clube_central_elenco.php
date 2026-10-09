<link rel="stylesheet" href="assets/css/clube_central_elenco.css">

<?php
$estado = $_SESSION['estado_jogo'] ?? null;
$apiService = new ApiService();
$jogadoresClube = $apiService->get("/jogadores/clube/{$estado->clube->id}?todos=true") ?? [];
$estatisticasClube = $apiService->get("/jogadores/clube/{$estado->clube->id}/estatisticas") ?? [];
$lesoesClube = $apiService->get("/jogadores/clube/{$estado->clube->id}/lesoes") ?? [];

$dataReferencia = isset($estado->dataAtual) ? $estado->dataAtual : $estado->dataInicio;
$anoAtual = (int) $dataReferencia->format('Y');

$estatisticasPorJogador = [];
foreach ($estatisticasClube as $estatistica) {
    if ((int) $estatistica['ano'] !== $anoAtual) {
        continue;
    }
    $estatisticasPorJogador[$estatistica['idJogador']][] = $estatistica;
}

$lesoesPorJogador = [];
foreach ($lesoesClube as $lesao) {
    $lesoesPorJogador[$lesao['idJogador']][] = $lesao;
}
?>

<main>

    <h1 class="titulo">Central do Elenco</h1>

    <div class="layout">

        <section class="box">
            <h2>Todos os Jogadores <span style="color:var(--roxoTexto); font-weight:400; text-transform:none;">(<?= count($jogadoresClube) ?>)</span></h2>
            <div class="lista-jogadores rolavel">

                <?php
                foreach ($jogadoresClube as $jogador) {
                    $onfire = ($jogador['onfire']) ? "🔥" : "";
                    $dados = $jogador;
                    $dados['valorFormatado'] = formatarNumero($jogador['valor']);
                    $dados['contratoFormatado'] = formatarMesesParaAnos($jogador['tempoContrato']);
                    $dados['estatisticas'] = $estatisticasPorJogador[$jogador['idJogador']] ?? [];
                    $dados['lesoes'] = $lesoesPorJogador[$jogador['idJogador']] ?? [];
                ?>
                    <div class="jogador-linha" data-jogador="<?= htmlspecialchars(json_encode($dados, JSON_UNESCAPED_UNICODE), ENT_QUOTES) ?>">
                        <span class="fogo"><?= $onfire ?></span><span class="posicao"><?= htmlspecialchars($jogador['posicaoPrincipal']) ?></span><span class="nome"><?= htmlspecialchars($jogador['nomeJogador']) ?></span><span class="overall"><?= $jogador['overall'] ?></span><span class="valor">R$ <?= formatarNumero($jogador['valor']) ?></span><span class="contrato"><?= formatarMesesParaAnos($jogador['tempoContrato']) ?></span>
                    </div>
                <?php
                }
                ?>

            </div>
        </section>

        <section class="box">
            <div class="ficha-topo">
                <span class="posicao-grande" id="ficha-posicao">-</span>
                <div>
                    <strong id="ficha-nome">Selecione um jogador</strong>
                    <span id="ficha-sub">-</span>
                </div>
                <div class="overall-grande"><strong id="ficha-overall">-</strong><br><span>OVR</span></div>
            </div>

            <div class="ficha-corpo rolavel">

                <div class="mini-stats">
                    <div class="item"><span>Contrato restante</span><strong id="ficha-contrato">-</strong></div>
                    <div class="item"><span>Salário mensal</span><strong id="ficha-salario">-</strong></div>
                    <div class="item"><span>Multa de rescisão</span><strong id="ficha-multa">-</strong></div>
                    <div class="item"><span>Status</span><strong id="ficha-status">-</strong></div>
                    <div class="item"><span>Moral</span><strong id="ficha-moral">-</strong></div>
                    <div class="item"><span>Satisfação</span><strong id="ficha-satisfacao">-</strong></div>
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
                    <h2>Estatísticas na Temporada (<?= $anoAtual ?>)</h2>
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
        </section>

    </div>
</main>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        var linhas = document.querySelectorAll('.jogador-linha[data-jogador]');

        var el = {
            posicao: document.getElementById('ficha-posicao'),
            nome: document.getElementById('ficha-nome'),
            sub: document.getElementById('ficha-sub'),
            overall: document.getElementById('ficha-overall'),
            contrato: document.getElementById('ficha-contrato'),
            salario: document.getElementById('ficha-salario'),
            multa: document.getElementById('ficha-multa'),
            status: document.getElementById('ficha-status'),
            moral: document.getElementById('ficha-moral'),
            satisfacao: document.getElementById('ficha-satisfacao'),
            atributos: document.getElementById('ficha-atributos'),
            lesoes: document.getElementById('ficha-lesoes'),
            estatisticas: document.getElementById('ficha-estatisticas')
        };

        var listaAtributos = [
            ['Velocidade', 'velocidade'],
            ['Força', 'forca'],
            ['Inteligência', 'inteligencia'],
            ['Finalização', 'finalizacao'],
            ['Marcação', 'marcacao'],
            ['Passe', 'passe']
        ];

        function texto(valor, sufixo) {
            if (valor === undefined || valor === null || valor === '') {
                return '-';
            }
            return valor + (sufixo || '');
        }

        function dinheiro(valor) {
            if (valor === undefined || valor === null || valor === '') {
                return '-';
            }
            return 'R$ ' + Number(valor).toLocaleString('pt-BR');
        }

        function criarAtributo(nome, valor) {
            var v = Number(valor) || 0;
            var linha = document.createElement('div');
            linha.className = 'atributo-linha';

            var rotulo = document.createElement('span');
            rotulo.textContent = nome;

            var barra = document.createElement('div');
            barra.className = 'barra';
            var preenchimento = document.createElement('i');
            preenchimento.style.width = v + '%';
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
            if (numerico) {
                td.className = 'num';
            }
            td.textContent = conteudo;
            return td;
        }

        function selecionar(linha) {
            linhas.forEach(function (l) { l.classList.remove('selecionado'); });
            linha.classList.add('selecionado');

            var j = JSON.parse(linha.dataset.jogador);

            el.posicao.textContent = texto(j.posicaoPrincipal);
            el.nome.textContent = texto(j.nomeJogador);
            el.sub.textContent = (j.idade ? j.idade + ' anos • ' : '') + 'R$ ' + j.valorFormatado;
            el.overall.textContent = texto(j.overall);

            el.contrato.textContent = texto(j.contratoFormatado);
            el.salario.textContent = dinheiro(j.salario);
            el.multa.textContent = dinheiro(j.valorRescisao);

            el.status.textContent = j.onfire ? 'On fire' : 'Normal';
            el.status.className = j.onfire ? 'on-fire' : '';

            el.moral.textContent = texto(j.moral, ' / 100');
            el.satisfacao.textContent = texto(j.satisfacao, ' / 100');

            el.atributos.innerHTML = '';
            listaAtributos.forEach(function (a) {
                el.atributos.appendChild(criarAtributo(a[0], j[a[1]]));
            });

            el.lesoes.innerHTML = '';
            var lesoes = Array.isArray(j.lesoes) ? j.lesoes : [];
            if (lesoes.length === 0) {
                el.lesoes.className = 'lesoes sem';
                var vazio = document.createElement('li');
                vazio.textContent = 'Nenhuma';
                el.lesoes.appendChild(vazio);
            } else {
                el.lesoes.className = 'lesoes';
                lesoes.forEach(function (l) {
                    var li = document.createElement('li');
                    if (typeof l === 'string') {
                        li.textContent = l;
                    } else {
                        li.textContent = l.nomeLesao + ' • ' + l.tempoLesionado + ' dias • ' + l.gravidade;
                    }
                    el.lesoes.appendChild(li);
                });
            }

            el.estatisticas.innerHTML = '';
            var estatisticas = Array.isArray(j.estatisticas) ? j.estatisticas : [];
            if (estatisticas.length === 0) {
                var tr = document.createElement('tr');
                var td = criarCelula('Sem dados', false);
                td.colSpan = 4;
                tr.appendChild(td);
                el.estatisticas.appendChild(tr);
            } else {
                estatisticas.forEach(function (e) {
                    var tr = document.createElement('tr');
                    tr.appendChild(criarCelula(e.nomeCompeticao || '-', false));
                    tr.appendChild(criarCelula(e.jogos ?? 0, true));
                    tr.appendChild(criarCelula(e.gols ?? 0, true));
                    tr.appendChild(criarCelula(e.assistencias ?? 0, true));
                    el.estatisticas.appendChild(tr);
                });
            }
        }

        linhas.forEach(function (linha) {
            linha.style.cursor = 'pointer';
            linha.addEventListener('click', function () {
                selecionar(linha);
            });
        });

        if (linhas.length > 0) {
            selecionar(linhas[0]);
        }
    });
</script>
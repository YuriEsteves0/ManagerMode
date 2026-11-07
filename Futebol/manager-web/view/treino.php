<?php

if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_SERVER['HTTP_X_REQUESTED_WITH'] ?? '') === 'fetch') {

    // Descarta qualquer saída anterior (caso um layout já tenha impresso algo)
    while (ob_get_level() > 0) {
        ob_end_clean();
    }

    if (session_status() !== PHP_SESSION_ACTIVE) {
        session_start();
    }

    header('Content-Type: application/json; charset=utf-8');

    $responder = function (int $codigo, array $dados): void {
        http_response_code($codigo);
        echo json_encode($dados, JSON_UNESCAPED_UNICODE);
        exit;
    };

    $estado = $_SESSION['estado_jogo'] ?? null;
    if (!$estado) {
        $responder(401, ['sucesso' => false, 'erro' => 'Sessão expirada']);
    }
    $idClubePost = (int) $estado->clube->id;

    $entrada = json_decode(file_get_contents('php://input'), true);
    $ids = $entrada['treinos'] ?? null;

    if (!is_array($ids)) {
        $responder(422, ['sucesso' => false, 'erro' => 'Formato inválido']);
    }

    // Normaliza: inteiros positivos, sem repetidos
    $ids = array_values(array_unique(array_filter(array_map('intval', $ids), fn($v) => $v > 0)));

    if (count($ids) < 1 || count($ids) > 4) {
        $responder(422, ['sucesso' => false, 'erro' => 'Selecione de 1 a 4 treinos']);
    }

    // O slot é a ordem da seleção (1 a 4)
    $treinosBody = [];
    foreach ($ids as $i => $idTreino) {
        $treinosBody[] = ['idTreino' => $idTreino, 'slot' => $i + 1];
    }

    // PUT para o Spring
    $ch = curl_init("http://localhost:8080/clubes/{$idClubePost}/treino");
    curl_setopt_array($ch, [
        CURLOPT_CUSTOMREQUEST  => 'PUT',
        CURLOPT_POSTFIELDS     => json_encode(['treinos' => $treinosBody]),
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_TIMEOUT        => 5,
        CURLOPT_HTTPHEADER     => [
            'Accept: application/json',
            'Content-Type: application/json'
        ]
    ]);
    curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    // Qualquer 2xx (200, 204...) conta como sucesso
    if ($httpCode >= 200 && $httpCode < 300) {
        $responder(200, ['sucesso' => true]);
    }

    $responder(502, ['sucesso' => false, 'erro' => "A API respondeu com status {$httpCode}"]);
}

?>
<link rel="stylesheet" href="assets/css/treino.css">

<?php
$estadoJogo = $_SESSION['estado_jogo'];
$apiService = new ApiService();
$idClube = $estadoJogo->clube->id;

$treinosEscolhidosJogador = $apiService->get("/clubes/{$idClube}/treino");
$todosTreinos = $apiService->get("/treinos");

// Garante que seja array
if (is_string($todosTreinos)) {
    $todosTreinos = json_decode($todosTreinos, true);
} else {
    $todosTreinos = json_decode(json_encode($todosTreinos), true);
}
$todosTreinos = $todosTreinos ?: [];

// Ids já escolhidos, ordenados pelo slot
$escolhidos = json_decode(json_encode($treinosEscolhidosJogador), true) ?: [];
usort($escolhidos, fn($a, $b) => ($a['slot'] ?? 0) <=> ($b['slot'] ?? 0));

$idsEscolhidos = array_map(function ($t) {
    return is_array($t) ? ($t['idTreino'] ?? null) : $t;
}, $escolhidos);
$idsEscolhidos = array_values(array_filter($idsEscolhidos, fn($v) => $v !== null));
?>
<main>

<div class="topo">
    <h1>Treino</h1>
    <div class="contador" id="contador">Selecionados: <span id="qtd">0</span>/4</div>
</div>

<div class="grid-treinos" id="gradeTreinos"></div>

<div class="barra-inferior">
    <span id="dicaRodape">Selecione até 4 treinos para a semana.</span>
    <button class="btn-confirmar" id="btnConfirmar" disabled onclick="confirmar()">Confirmar Treino</button>
</div>

</main>

<script>
var TREINOS = <?= json_encode($todosTreinos, JSON_UNESCAPED_UNICODE | JSON_HEX_TAG | JSON_HEX_AMP) ?>;
var JA_ESCOLHIDOS = <?= json_encode($idsEscolhidos) ?>;

var LIMITE = 4;
var selecionados = new Set(); // guarda idTreino, na ordem da seleção

function escapar(txt) {
    var d = document.createElement('div');
    d.textContent = txt == null ? '' : txt;
    return d.innerHTML;
}

function abreviacao(nome) {
    return nome.split(' ').map(function (p) { return p[0]; }).join('').substring(0, 3).toUpperCase();
}

function montarGrade() {
    var grade = document.getElementById('gradeTreinos');

    // Pré-seleciona na ordem dos slots salvos (respeitando o limite)
    JA_ESCOLHIDOS.forEach(function (id) {
        if (selecionados.size < LIMITE) selecionados.add(id);
    });

    TREINOS.forEach(function (t) {
        var card = document.createElement('div');
        card.className = 'treino';
        card.dataset.id = t.idTreino;
        card.onclick = function () { alternar(t.idTreino, card); };
        card.innerHTML =
            '<div class="marcador">✓</div>' +
            '<div class="icone">' + escapar(abreviacao(t.nomeTreino)) + '</div>' +
            '<h3>' + escapar(t.nomeTreino) + '</h3>' +
            '<p>' + escapar(t.descTreino) + '</p>';
        grade.appendChild(card);

        if (selecionados.has(t.idTreino)) {
            card.classList.add('selecionado');
        }
    });
    atualizarContador();
}

function alternar(id, card) {
    if (selecionados.has(id)) {
        selecionados.delete(id);
        card.classList.remove('selecionado');
    } else {
        if (selecionados.size >= LIMITE) return;
        selecionados.add(id);
        card.classList.add('selecionado');
    }
    atualizarContador();
}

function atualizarContador() {
    document.getElementById('qtd').textContent = selecionados.size;
    var contador = document.getElementById('contador');
    var dica = document.getElementById('dicaRodape');
    var btn = document.getElementById('btnConfirmar');
    if (selecionados.size >= LIMITE) {
        contador.classList.add('cheio');
        dica.textContent = 'Limite de 4 treinos atingido.';
    } else {
        contador.classList.remove('cheio');
        dica.textContent = 'Selecione até 4 treinos para a semana.';
    }
    btn.disabled = selecionados.size === 0;
}

function confirmar() {
    var btn = document.getElementById('btnConfirmar');
    var dica = document.getElementById('dicaRodape');
    var ids = Array.from(selecionados);

    if (ids.length < 1 || ids.length > LIMITE) return;

    btn.disabled = true;
    btn.textContent = 'Salvando...';

    fetch(window.location.href, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-Requested-With': 'fetch'
        },
        body: JSON.stringify({ treinos: ids })
    })
        .then(function (resp) {
            return resp.json().then(function (dados) {
                return { ok: resp.ok && dados.sucesso, dados: dados };
            });
        })
        .then(function (r) {
            if (r.ok) {
                Toast.sucesso('Todos os treinos foram salvos!');
                dica.textContent = 'Selecione até 4 treinos para a semana.';
                btn.textContent = 'Confirmar Treino';
                btn.disabled = false;
            } else {
                throw new Error(r.dados.erro || 'Erro ao salvar');
            }
        })
        .catch(function (e) {
            Toast.erro('Erro: ' + e.message);
            btn.textContent = 'Confirmar Treino';
            btn.disabled = false;
        });
}

montarGrade();
</script>

<script src="assets/js/animations/treino.js"></script>
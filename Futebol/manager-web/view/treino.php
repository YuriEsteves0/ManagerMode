<link rel="stylesheet" href="assets/css/treino.css">

<?php
$estadoJogo = $_SESSION['estado_jogo'];
$apiService = new ApiService();
$idClube = $estadoJogo->clube->id;

$treinosEscolhidosJogador = $apiService->get("/clubes/{$idClube}/treino");
$todosTreinos = $apiService->get("/treinos");

// Garante que seja array, caso o ApiService retorne string JSON ou objetos
if (is_string($todosTreinos)) {
    $todosTreinos = json_decode($todosTreinos, true);
} else {
    $todosTreinos = json_decode(json_encode($todosTreinos), true);
}
$todosTreinos = $todosTreinos ?: [];

// Ids já escolhidos (ajuste se o formato do endpoint for outro)
$escolhidos = json_decode(json_encode($treinosEscolhidosJogador), true) ?: [];
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
var selecionados = new Set(); // guarda idTreino

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

        // pré-seleciona o que já estava escolhido (respeitando o limite)
        if (JA_ESCOLHIDOS.indexOf(t.idTreino) !== -1 && selecionados.size < LIMITE) {
            selecionados.add(t.idTreino);
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
    // Ainda não salva nada: só mostra os ids escolhidos
    var ids = Array.from(selecionados);
    console.log('Treinos selecionados:', ids);
    alert('Treino da semana confirmado com ' + ids.length + ' atividade(s).');
}

montarGrade();
</script>

<script src="assets/js/animations/treino.js"></script>
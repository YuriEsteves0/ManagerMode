<link rel="stylesheet" href="assets/css/treino.css"> 

<main>
    
<div class="topo">
    <h1>Treino</h1>
    <div class="contador" id="contador">Selecionados: <span id="qtd">0</span>/4</div>
</div>

<div class="grid-treinos" id="gradeTreinos">
    <!-- cards gerados via JS a partir da lista TREINOS -->
</div>

<div class="barra-inferior">
    <span id="dicaRodape">Selecione até 4 treinos para a semana.</span>
    <button class="btn-confirmar" id="btnConfirmar" disabled onclick="confirmar()">Confirmar Treino</button>
</div>

</main>


<script>
var TREINOS = [
    { nome: 'Resistência Física', efeito: 'Aumenta o fôlego e reduz a fadiga em jogos longos.' },
    { nome: 'Velocidade', efeito: 'Melhora a aceleração e o sprint dos jogadores.' },
    { nome: 'Força', efeito: 'Aumenta a força física nos duelos corporais.' },
    { nome: 'Finalização', efeito: 'Melhora a precisão e a potência dos chutes a gol.' },
    { nome: 'Passe', efeito: 'Aumenta a precisão dos passes curtos e longos.' },
    { nome: 'Marcação', efeito: 'Melhora a capacidade defensiva individual.' },
    { nome: 'Cabeceio', efeito: 'Melhora o desempenho em bolas aéreas.' },
    { nome: 'Cruzamento', efeito: 'Melhora a precisão dos cruzamentos pelas laterais.' },
    { nome: 'Drible', efeito: 'Aumenta a habilidade de finta e condução de bola.' },
    { nome: 'Bola Parada', efeito: 'Melhora cobranças de falta, escanteio e pênalti.' },
    { nome: 'Reflexos (Goleiros)', efeito: 'Melhora o tempo de reação dos goleiros.' },
    { nome: 'Saída de Bola', efeito: 'Melhora a construção de jogo desde a defesa.' },
    { nome: 'Tática Ofensiva', efeito: 'Aumenta a sincronia do time nas jogadas de ataque.' },
    { nome: 'Tática Defensiva', efeito: 'Melhora a organização defensiva coletiva.' },
    { nome: 'Recuperação Física', efeito: 'Reduz o tempo de recuperação de lesões e fadiga.' }
];

var LIMITE = 4;
var selecionados = new Set();

function abreviacao(nome) {
    return nome.split(' ').map(function(p){ return p[0]; }).join('').substring(0,3).toUpperCase();
}

function montarGrade() {
    var grade = document.getElementById('gradeTreinos');
    TREINOS.forEach(function(t, i){
        var card = document.createElement('div');
        card.className = 'treino';
        card.dataset.index = i;
        card.onclick = function(){ alternar(i, card); };
        card.innerHTML =
            '<div class="marcador">✓</div>' +
            '<div class="icone">' + abreviacao(t.nome) + '</div>' +
            '<h3>' + t.nome + '</h3>' +
            '<p>' + t.efeito + '</p>';
        grade.appendChild(card);
    });
}

function alternar(i, card) {
    if (selecionados.has(i)) {
        selecionados.delete(i);
        card.classList.remove('selecionado');
    } else {
        if (selecionados.size >= LIMITE) return;
        selecionados.add(i);
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
    alert('Treino da semana confirmado com ' + selecionados.size + ' atividade(s).');
}

montarGrade();
</script>

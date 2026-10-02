<link rel="stylesheet" href="assets/css/cadastro_1.css"> 
<main>
    <div class="conteudo">
        <div class="lado-texto">
            <h1>Crie sua carreira de técnico e <em>vire referência</em> no futebol mundial.</h1>
            <p>Monte seu elenco, defina a tática e conduza um clube do zero à elite. Cada decisão sua molda a temporada.</p>
            <div class="stats">
                <div><strong>3</strong><span>nacionalidades</span></div>
                <div><strong>2</strong><span>modos de jogo</span></div>
                <div><strong>∞</strong><span>temporadas pela frente</span></div>
            </div>
        </div>

        <form class="card" action="index.php" method="get">
    <!-- Garante que 'pag' vá na URL como ?pag=cadastro_2 -->
    <input type="hidden" name="pag" value="cadastro_2">

    <h2>Criar técnico</h2>

    <div class="campo">
        <label for="nome">Nome do técnico</label>
        <input id="nome" name="nome" type="text" placeholder="Ex: Carlos Mendes" required>
    </div>

    <div class="campo">
        <label for="nacionalidade">Nacionalidade</label>
        <select id="nacionalidade" name="nacionalidade" required>
            <option value="" disabled selected>Selecione</option>
            <option value="brasileiro">Brasileiro</option>
            <option value="portugues">Português</option>
            <option value="espanhol">Espanhol</option>
        </select>
    </div>

    <div class="modos">
        <label>Modo de jogo</label>
        <div class="modos-opcoes">
            <div class="modo-opcao">
                <input type="radio" name="modo" id="modo-normal" value="normal" checked>
                <label for="modo-normal">Normal<small>Para conhecer o jogo</small></label>
            </div>
            <div class="modo-opcao">
                <input type="radio" name="modo" id="modo-pro" value="pro">
                <label for="modo-pro">Pro<small>Sem ajuda da IA</small></label>
            </div>
        </div>
    </div>

    <button class="btn-iniciar" type="submit">Iniciar carreira</button>
</form>
    </div>
</main>
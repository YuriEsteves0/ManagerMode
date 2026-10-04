<link rel="stylesheet" href="assets/css/cadastro_2.css">

<?php

$apiService = new ApiService();
$competicoes = $apiService->get('/competicoes', ['tipo' => 'PONTOS_CORRIDOS']) ?? [];

?>

<form class="card" action="index.php" method="get">

    <input type="hidden" name="pag" value="cadastro_3">

    <input type="hidden" name="nome" value="<?= htmlspecialchars($_GET['nome'] ?? '') ?>">
    <input type="hidden" name="nacionalidade" value="<?= htmlspecialchars($_GET['nacionalidade'] ?? '') ?>">
    <input type="hidden" name="modo" value="<?= htmlspecialchars($_GET['modo'] ?? '') ?>">

    <div>
        <h1>Escolha sua liga</h1>
        <p class="sub">É nela que sua carreira começa.</p>
    </div>

    <div class="ligas">
        <?php

        if (!empty($competicoes)) {
            foreach ($competicoes as $index => $competicao) {
                $idInput = "liga-" . $competicao['id'];
                $checked = ($index === 0) ? 'checked' : '';

        ?>
                <div class="liga-opcao">
                    <input type="radio" name="liga" id="<?= $idInput ?>" value="<?= htmlspecialchars($competicao['id']) ?>" <?= $checked ?>>
                    <label for="<?= $idInput ?>"><?= $competicao['nomeCompeticao'] ?><span class="pais"><?= htmlspecialchars($competicao['nivelCompeticao']) ?></span></label>
                </div>

        <?php
            }
        }else{
            ?>
            <p style="color: #fff;">Nenhuma competição disponível no momento.</p>

            <?php 
        }

        ?>
    </div>
    <button class="btn-jogar" type="submit">Jogar</button>
</form>
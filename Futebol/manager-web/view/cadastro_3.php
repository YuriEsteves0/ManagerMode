<link rel="stylesheet" href="assets/css/cadastro_3.css">

<?php
require_once "controller/Cadastro3Controller.php";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nome = $_POST['nome'] ?? '';
    $nacionalidade = $_POST['nacionalidade'] ?? '';
    $modo = $_POST['modo'] ?? '';
    $liga = $_POST['liga'] ?? '';
    $clubeId = $_POST['clube_id'] ?? '';
    $clubeNome = $_POST['clube_nome'] ?? '';
    $clubeFoto = $_POST['clube_foto'] ?? '';

    $cadastroController = new Cadastro3Controller();
    $cadastroController->salvar([
        'nome'          => $nome,
        'nacionalidade' => $nacionalidade,
        'modo'          => $modo,
        'liga'          => $liga,
        'clube_id'      => $clubeId,
        'clube_nome'    => $clubeNome,
        'clube_foto'    => $clubeFoto,
    ]);

    header('Location: index.php?pag=' . Pagina::INICIO->value);
    exit;
}

$liga = $_GET['liga'] ?? '';

$apiService = new ApiService();
$competicoes = $apiService->get('/competicoes', ['tipo' => 'PONTOS_CORRIDOS']) ?? [];

$clubes = [];
$idsCompeticoes = array_column($competicoes, 'id');

if (!empty($liga) && in_array($liga, $idsCompeticoes)) {
    $clubes = $apiService->get("/competicoes/{$liga}/clubes") ?? [];
}

$clubeSelecionado = null;
if (!empty($clubes)) {
    $indiceAleatorio = array_rand($clubes);
    $clubeSelecionado = $clubes[$indiceAleatorio];
}
?>

<form class="card" action="index.php" method="post">
    <input type="hidden" name="pag" value="cadastro_3">

    <input type="hidden" name="nome" value="<?= htmlspecialchars($_GET['nome'] ?? '') ?>">
    <input type="hidden" name="nacionalidade" value="<?= htmlspecialchars($_GET['nacionalidade'] ?? '') ?>">
    <input type="hidden" name="modo" value="<?= htmlspecialchars($_GET['modo'] ?? '') ?>">
    <input type="hidden" name="liga" value="<?= htmlspecialchars($_GET['liga'] ?? '') ?>">
    <input type="hidden" name="time" value="1">

    <h1>Seu time selecionado foi:</h1>

    <?php if ($clubeSelecionado): ?>
        <div class="clube">
            <img src="assets/<?= htmlspecialchars($clubeSelecionado['foto'] ?? '') ?>" alt="" style="width: 64px; height: 64px; object-fit: contain;">
            <div class="clube-nome">
                <strong><?= htmlspecialchars($clubeSelecionado['nomeClube'] ?? 'nada') ?></strong>
                <span><?= htmlspecialchars("Orçamento: " . formatarNumero($clubeSelecionado['orcamento'] ?? 0)) ?></span>
            </div>
        </div>

        <input type="hidden" name="clube_id" value="<?= htmlspecialchars($clubeSelecionado['idClube'] ?? '') ?>">
        <input type="hidden" name="clube_nome" value="<?= htmlspecialchars($clubeSelecionado['nomeClube'] ?? '') ?>">
        <input type="hidden" name="clube_foto" value="<?= htmlspecialchars($clubeSelecionado['foto'] ?? '') ?>">
    <?php endif; ?>

    <button class="btn-jogar" type="submit">Jogar</button>
</form>
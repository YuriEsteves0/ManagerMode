<link rel="stylesheet" href="assets/css/cadastro_3.css">

<?php
require_once "controller/Cadastro3Controller.php";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $dados = [
        'nome'          => $_POST['nome'] ?? '',
        'nacionalidade' => $_POST['nacionalidade'] ?? '',
        'modo'          => $_POST['modo'] ?? '',
        'liga'          => $_POST['liga'] ?? '',
        'clube_id'      => $_POST['clube_id'] ?? '',
        'clube_nome'    => $_POST['clube_nome'] ?? '',
        'clube_foto'    => $_POST['clube_foto'] ?? '',
    ];

    $cadastroController = new Cadastro3Controller();

    if ($cadastroController->salvar($dados)) {
        header('Location: index.php?pag=' . Pagina::INICIO->value);
        exit;
    }

    header('Location: index.php?pag=cadastro_3&erro=1&' . http_build_query([
        'nome'          => $dados['nome'],
        'nacionalidade' => $dados['nacionalidade'],
        'modo'          => $dados['modo'],
        'liga'          => $dados['liga'],
    ]));
    exit;
}

$liga = $_GET['liga'] ?? '';

$apiService = new ApiService();
$competicoes = $apiService->get('/competicoes', ['tipo' => 'PONTOS_CORRIDOS']) ?? [];

$clubes = [];
$idsCompeticoes = array_column($competicoes, 'idCompeticao');

if (!empty($liga) && in_array((int)$liga, $idsCompeticoes, true)) {
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

<script src="assets/js/animations/cadastro_3.js"></script>
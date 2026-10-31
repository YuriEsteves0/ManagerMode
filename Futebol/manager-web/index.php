<?php
ob_start();
require_once __DIR__ . '/models/EstadoJogo.php';
require_once __DIR__ . '/routes/Pagina.php';

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
$parametro = $_REQUEST['pag'] ?? "cadastro_1";
$pagina = Pagina::tryFrom($parametro);

$temEstadoJogo = isset($_SESSION['estado_jogo']);
$precisaEstadoJogo = ($pagina === null) || $pagina->exigeEstadoJogo();

if (!$temEstadoJogo && $precisaEstadoJogo) {
    header('Location: index.php?pag=' . Pagina::CADASTRO_1->value);
    exit;
}

?>

<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ManagerMode.com</title>
    <link rel="stylesheet" href="assets/css/geral.css">
    <link rel="shortcut icon" href="assets/img/managerModeFavicon.png" type="image/x-icon">
    <script src="assets/js/animations/geral.js"></script>
</head>

<body>
    
    <?php

    require_once "includes/headerHelper.php";
    headerHelper();
    ?>
    <div class="meio-index">
        <?php
        if ($pagina !== null) {
            require_once "services/ApiService.php";
            require_once "services/TextService.php";
            require_once "services/MoneyService.php";
            require_once "services/YearService.php";
            require_once $pagina->getArquivo();
        } else {
            echo "Página não encontrada!";
        }
        ?>
    </div>
</body>

</html>
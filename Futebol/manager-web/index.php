<?php
require_once("routes/Pagina.php");

// 1. Resolve a rota/página no início da execução
$parametro = $_REQUEST['pag'] ?? "cadastro_1";
$pagina = Pagina::tryFrom($parametro);

?>

<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ManagerMode.com</title>
    <link rel="stylesheet" href="assets/css/geral.css">
</head>

<body>
    <?php
    if (session_status() === PHP_SESSION_NONE) {
        session_start();
    }
    require_once "includes/headerHelper.php";
    headerHelper();
    ?>
    <div class="meio-index">
        <?php
        if ($pagina !== null) {
            require_once "services/ApiService.php";
            require_once "services/MoneyService.php";
            require_once $pagina->getArquivo();
        } else {
            echo "Página não encontrada!";
        }
        ?>
    </div>
</body>

</html>
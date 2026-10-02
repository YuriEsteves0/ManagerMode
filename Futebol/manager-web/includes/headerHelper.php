<?php 

function headerHelper(){
    $pagParam = $_REQUEST['pag'] ?? "cadastro_1";

    $paginaAtual = Pagina::tryFrom($pagParam);

    if($paginaAtual === Pagina::CADASTRO_1 || $paginaAtual === Pagina::CADASTRO_2 || $paginaAtual === Pagina::CADASTRO_3){
        require_once("view/components/headerInicial.php");
    }else{
        require_once("view/components/header.php");
    }

}

?>
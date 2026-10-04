<?php 

function formatarNumero(int $numero): string
{
    if ($numero < 1000) {
        return (string) $numero;
    }

    $sufixos = ['', 'k', 'M', 'B', 'T'];
    
    $i = (int) floor(log($numero, 1000)); 
    $valorFormatado = $numero / pow(1000, $i);

    $numeroFinal = ($valorFormatado == floor($valorFormatado)) 
        ? number_format($valorFormatado, 0) 
        : number_format($valorFormatado, 1, '.', '');

    return $numeroFinal . $sufixos[$i];
}

?>
<?php 

function limitarTexto(string $texto, int $limite): string
{
    if (mb_strlen($texto) <= $limite) {
        return $texto;
    }

    return rtrim(mb_substr($texto, 0, $limite)) . '...';
}

?>
<?php 

function formatarMesesParaAnos($totalMeses) {
    $totalMeses = (int) $totalMeses;

    if ($totalMeses <= 0) {
        return '0m';
    }

    $anos = floor($totalMeses / 12);
    $meses = $totalMeses % 12;

    $partes = [];

    if ($anos > 0) {
        $partes[] = "{$anos}a";
    }

    if ($meses > 0) {
        $partes[] = "{$meses}m";
    }

    return implode(' ', $partes);
}

?>
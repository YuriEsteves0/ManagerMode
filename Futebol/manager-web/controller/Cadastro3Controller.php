<?php

class Cadastro3Controller
{
    public function salvar(array $dados)
    {
        $_SESSION['carreira'] = [
            'nome'          => $dados['nome'] ?? '',
            'nacionalidade' => $dados['nacionalidade'] ?? '',
            'modo'          => $dados['modo'] ?? '',
            'liga'          => $dados['liga'] ?? '',
            'clube'         => [
                'id'        => $dados['clube_id'] ?? '',
                'nomeClube' => $dados['clube_nome'] ?? '',
                'foto'      => $dados['clube_foto'] ?? ''
            ]
        ];

        // Sintaxe válida de JS unindo o JSON com texto
        $json = json_encode($_SESSION['carreira']);
        echo "<script>alert('Dados da sessão: ' + JSON.stringify($json));</script>";
    }
}
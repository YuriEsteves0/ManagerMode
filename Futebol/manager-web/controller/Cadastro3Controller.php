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
            'clube_id'      => $dados['clube_id'] ?? '',
            'clube'         => [
                'id'        => $dados['clube_id'] ?? '',
                'nomeClube' => $dados['clube_nome'] ?? '',
                'foto'      => $dados['clube_foto'] ?? ''
            ]
        ];
    }
}

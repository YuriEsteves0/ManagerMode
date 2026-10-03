<?php
require_once __DIR__ . '/../models/EstadoJogo.php';
class Cadastro3Controller
{
    public function salvar(array $dados)
    {

        $dadosRecebidos = [
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

        $_SESSION['estado_jogo'] = new EstadoJogo($dadosRecebidos);

        // $_SESSION['carreira'] = [
        //     'nome'          => $dados['nome'] ?? '',
        //     'nacionalidade' => $dados['nacionalidade'] ?? '',
        //     'modo'          => $dados['modo'] ?? '',
        //     'liga'          => $dados['liga'] ?? '',
        //     'clube'         => [
        //         'id'        => $dados['clube_id'] ?? '',
        //         'nomeClube' => $dados['clube_nome'] ?? '',
        //         'foto'      => $dados['clube_foto'] ?? ''
        //     ]
        // ];

        // Sintaxe válida de JS unindo o JSON com texto
        $json = json_encode($_SESSION['carreira']);
        echo "<script>alert('Dados da sessão: ' + JSON.stringify($json));</script>";
    }
}
?>
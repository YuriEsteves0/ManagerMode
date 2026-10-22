<?php
require_once __DIR__ . '/../models/EstadoJogo.php';

class Cadastro3Controller
{
    public function salvar(array $dados)
    {
        session_start();
        $idManager = 17;

        $dadosRecebidos = [
            'idManager'     => $idManager,
            'nome'          => $dados['nome'] ?? '',
            'nacionalidade' => $dados['nacionalidade'] ?? '',
            'modo'          => $dados['modo'] ?? '',
            'liga'          => $dados['liga'] ?? '',
            'data_inicio'   => '2026-01-01',
            'data_atual'    => '2026-01-01',
            'clube'         => [
                'id'                  => $dados['clube_id'] ?? '',
                'nomeClube'           => $dados['clube_nome'] ?? '',
                'orcamento'           => $dados['orcamento'] ?? 1000000.0,
                'valorClube'          => $dados['valorClube'] ?? 50000000,
                'capacidadeEstadio'   => $dados['capacidadeEstadio'] ?? 30000,
                'nomeEstadio'         => $dados['nomeEstadio'] ?? 'Estádio Municipal',
                'foto'                => $dados['clube_foto'] ?? ''
            ]
        ];

        $_SESSION['estado_jogo'] = new EstadoJogo($dadosRecebidos);

        $json = json_encode($_SESSION['carreira'] ?? $_SESSION['estado_jogo']);
        echo "<script>alert('Dados da sessão: ' + JSON.stringify($json));</script>";
    }
}
?>
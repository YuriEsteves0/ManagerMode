<?php
require_once __DIR__ . '/../models/EstadoJogo.php';

class Cadastro3Controller
{
    public function salvar(array $dados)
    {

        $api = new ApiService();

        $manager = $api->post('/manager/criar', [
            'nomeManager'   => $dados['nome'],
            'nacionalidade' => $dados['nacionalidade'],
            'foto'          => 'img/rostosManagers/padrao.png',
            'reputacao'     => 'INICIANTE',
            'exp'           => 0,
            'contratoFim'   => 2027,
            'idClube'       => (int) $dados['clube_id'],
        ]);

        if($manager === null){
            return false;
        }

        $_SESSION['estado_jogo'] = new EstadoJogo($dados + [
            'idManager'   => $manager['idManager'],
            'data_inicio' => '2026-01-01',
            'data_atual'  => '2026-01-01',
        ]);

        return true;



        // $idManager = 17;

        // $dadosRecebidos = [
        //     'idManager'     => $idManager,
        //     'nome'          => $dados['nome'] ?? '',
        //     'nacionalidade' => $dados['nacionalidade'] ?? '',
        //     'modo'          => $dados['modo'] ?? '',
        //     'liga'          => $dados['liga'] ?? '',
        //     'data_inicio'   => '2026-01-01',
        //     'data_atual'    => '2026-01-01',
        //     'clube'         => [
        //         'id'                  => $dados['clube_id'] ?? '',
        //         'nomeClube'           => $dados['clube_nome'] ?? '',
        //         'orcamento'           => $dados['orcamento'] ?? 1000000.0,
        //         'valorClube'          => $dados['valorClube'] ?? 50000000,
        //         'capacidadeEstadio'   => $dados['capacidadeEstadio'] ?? 30000,
        //         'nomeEstadio'         => $dados['nomeEstadio'] ?? 'Estádio Municipal',
        //         'foto'                => $dados['clube_foto'] ?? ''
        //     ]
        // ];        
    }
}
?>
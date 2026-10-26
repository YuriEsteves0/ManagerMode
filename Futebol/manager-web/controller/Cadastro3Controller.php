<?php
require_once __DIR__ . '/../models/EstadoJogo.php';

class Cadastro3Controller
{
    public function salvar(array $dados)
    {
        $foto = $this->fotoAleatoria();

        $api = new ApiService();

        $manager = $api->post('/manager/criar', [
            'nomeManager'   => $dados['nome'],
            'nacionalidade' => $dados['nacionalidade'],
            'foto'          => "img/rostosManagers/{$foto}",
            'reputacao'     => 'INICIANTE',
            'exp'           => 0,
            'contratoFim'   => 2027,
            'idClube'       => (int) $dados['clube_id'],
        ]);

        if ($manager === null) {
            return false;
        }

        $_SESSION['estado_jogo'] = new EstadoJogo($dados + [
            'idManager'   => $manager['idManager'],
            'data_inicio' => '2026-01-01',
            'data_atual'  => '2026-01-01',
        ]);

        return true;
    }

    private function fotoAleatoria()
    {
        $numero = (int) rand(0, 2);
        $foto = "";
        
        switch ($numero) {
            case 0:
                $foto = "manager-1.jpg";
                break;
            case 1:
                $foto = "manager-2.jpg";
                break;
            case 2:
                $foto = "manager-3.jpg";
                break;
            default:
                $foto = "manager-1.jpg";
                break;
        }
        return $foto;
    }
}
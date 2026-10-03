<?php 

enum Pagina: string{
    case CADASTRO_1 = 'cadastro_1';
    case CADASTRO_2 = 'cadastro_2';
    case CADASTRO_3 = 'cadastro_3';
    case INICIO = 'inicio';
    case EQUIPE = 'equipe';
    case ESTATISTICAS = 'estatisticas';
    case PATROCINIOS = 'patrocinios';
    case CENTRAL_ELENCO = 'central_elenco';
    case MERCADO = 'mercado';
    case PROPOSTAS_RECEBIDAS = 'propostas_recebidas';
    case PROPOSTAS_ENVIADAS = 'propostas_enviadas';
    case CALENDARIO = 'calendario';
    case TREINO = 'treino';
    case DIRETORIA = 'diretoria';
    case CARREIRA = 'carreira';
    case PARTIDA = 'partida';
    case IMPRENSA = 'imprensa';

    public function getArquivo(): string{
        return match($this) {
            self::CADASTRO_1 => 'view/cadastro_1.php',
            self::CADASTRO_2 => 'view/cadastro_2.php',
            self::CADASTRO_3 => 'view/cadastro_3.php',
            self::INICIO => 'view/inicio.php',
            self::EQUIPE => 'view/clube_equipe.php',
            self::ESTATISTICAS => 'view/clube_estatisticas.php',
            self::PATROCINIOS => 'view/clube_patrocinios.php',
            self::CENTRAL_ELENCO => 'view/clube_central_elenco.php',
            self::MERCADO => 'view/negociacao_mercado.php',
            self::PROPOSTAS_RECEBIDAS => 'view/negociacao_propostas_recebidas.php',
            self::PROPOSTAS_ENVIADAS => 'view/negociacao_propostas_enviadas.php',
            self::CALENDARIO => 'view/calendario.php',
            self::TREINO => 'view/treino.php',
            self::DIRETORIA => 'view/diretoria.php',
            self::CARREIRA => 'view/carreira.php',
            self::PARTIDA => 'view/partida.php',
            self::IMPRENSA => 'view/imprensa.php',
        };
    }
}

?>
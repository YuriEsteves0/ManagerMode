-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 28, 2026 at 03:40 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `manager`
--

-- --------------------------------------------------------

--
-- Table structure for table `acao_diretoria`
--

CREATE TABLE `acao_diretoria` (
  `idAcaoDiretoria` int(11) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `requisito` varchar(255) NOT NULL,
  `efeito` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `acao_diretoria`
--

INSERT INTO `acao_diretoria` (`idAcaoDiretoria`, `titulo`, `requisito`, `efeito`) VALUES
(1, 'Solicitar Aumento de Verba para Transferências', 'Exige Confiança acima de 60%', 'Injeta verba extra no orçamento da próxima janela de transferências.'),
(2, 'Pedir Mais Tempo para Cumprir a Meta', 'Exige Confiança acima de 40%', 'Alivia a pressão da diretoria por 5 rodadas em momentos de crise.'),
(3, 'Solicitar Aumento Salarial do Treinador', 'Exige Confiança acima de 70%', 'Aumenta o seu salário anual e garante maior estabilidade no cargo.'),
(4, 'Pedir Liberação para Viagem de Observação no Mercado', 'Exige Confiança acima de 55%', 'Revela relatórios completos e atributos reais de alvos de transferência.'),
(5, 'Solicitar Busca por Jogadores Sem Contrato', 'Exige Confiança acima de 70%', 'Pede aval para assinar com atletas livres no mercado.'),
(6, 'Solicitar Voos Fretados para Jogos Fora', 'Exige Confiança acima de 40%', 'Reduz o cansaço do elenco em viagens longas.'),
(7, 'Solicitar Redução no Preço dos Ingressos', 'Exige Confiança acima de 80%', 'Aumenta a presença de público e o apoio no estádio.'),
(8, 'Solicitar Pacto de Confiança do Presidente', 'Exige Confiança acima de 90%', 'Garanta permanência no cargo até o fim da temporada.');

-- --------------------------------------------------------

--
-- Table structure for table `clube`
--

CREATE TABLE `clube` (
  `idClube` int(11) NOT NULL,
  `nomeClube` varchar(255) NOT NULL,
  `orcamento` float NOT NULL,
  `valorClube` bigint(20) NOT NULL DEFAULT 0,
  `camisasVendidas` int(11) NOT NULL,
  `qntTorcedores` int(11) NOT NULL,
  `reputacao` int(11) NOT NULL,
  `patrocinador_idPatrocinador` int(11) DEFAULT NULL,
  `confiancaDiretoria` int(11) NOT NULL,
  `statusConfianca` enum('PESSIMO','INSTAVEL','ESTAVEL','EXCELENTE') NOT NULL,
  `eventoAtual` varchar(100) DEFAULT NULL,
  `capacidadeEstadio` int(11) NOT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `nomeEstadio` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `clube`
--

INSERT INTO `clube` (`idClube`, `nomeClube`, `orcamento`, `valorClube`, `camisasVendidas`, `qntTorcedores`, `reputacao`, `patrocinador_idPatrocinador`, `confiancaDiretoria`, `statusConfianca`, `eventoAtual`, `capacidadeEstadio`, `foto`, `nomeEstadio`) VALUES
(1, 'Flamengo', 105600000, 845000000, 1200000, 40000000, 60, 1, 85, 'EXCELENTE', 'Boa Gestão', 78838, 'img/escudosClubes/brasileiraoSerieA/flamengo.png', 'Maracanã'),
(2, 'Palmeiras', 107200000, 533000000, 950000, 15000000, 58, 3, 88, 'EXCELENTE', 'Boa Gestão', 43713, 'img/escudosClubes/brasileiraoSerieA/palmeiras.png', 'Allianz Parque'),
(3, 'São Paulo', 37600000, 219400000, 600000, 18000000, 50, 8, 65, 'ESTAVEL', NULL, 66795, 'img/escudosClubes/brasileiraoSerieA/sao_paulo.png', 'MorumBIS'),
(4, 'Corinthians', 72300000, 530400000, 700000, 30000000, 52, 6, 55, 'INSTAVEL', 'Crise Financeira', 47605, 'img/escudosClubes/brasileiraoSerieA/Corinthians.png', 'Neo Química Arena'),
(5, 'Atlético-MG', 47900000, 218200000, 500000, 7000000, 45, 2, 70, 'ESTAVEL', NULL, 47465, 'img/escudosClubes/brasileiraoSerieA/Atletico_mineiro.png', 'Arena MRV'),
(6, 'Botafogo', 53200000, 259400000, 400000, 8000000, 42, 4, 75, 'ESTAVEL', NULL, 44661, 'img/escudosClubes/brasileiraoSerieA/Botafogo.png', 'Estádio Nilton Santos'),
(7, 'Fluminense', 47400000, 235500000, 350000, 7000000, 38, 9, 60, 'ESTAVEL', NULL, 78838, 'img/escudosClubes/brasileiraoSerieA/Fluminense.png', 'Maracanã'),
(8, 'Grêmio', 31100000, 160600000, 380000, 9000000, 40, 7, 68, 'ESTAVEL', NULL, 55662, 'img/escudosClubes/brasileiraoSerieA/gremio.png', 'Arena do Grêmio'),
(9, 'Internacional', 28600000, 144600000, 360000, 8000000, 39, 10, 66, 'ESTAVEL', NULL, 50842, 'img/escudosClubes/brasileiraoSerieA/Internacional.png', 'Beira-Rio'),
(10, 'Cruzeiro', 70600000, 395000000, 300000, 10000000, 36, 5, 72, 'ESTAVEL', NULL, 61927, 'img/escudosClubes/brasileiraoSerieA/cruzeiro.png', 'Mineirão'),
(11, 'Bahia', 43400000, 232500000, 220000, 6000000, 30, NULL, 60, 'ESTAVEL', NULL, 47907, 'img/escudosClubes/brasileiraoSerieA/bahia.png', 'Arena Fonte Nova'),
(12, 'Vasco da Gama', 54400000, 349800000, 250000, 13000000, 32, NULL, 57, 'INSTAVEL', 'Pressão da Torcida', 21880, 'img/escudosClubes/brasileiraoSerieA/vascoDaGama.png', 'São Januário'),
(13, 'Santos', 39200000, 244800000, 400000, 10000000, 28, NULL, 50, 'INSTAVEL', 'Reconstrução Pós-Rebaixamento', 16068, 'img/escudosClubes/brasileiraoSerieA/Santos.png', 'Vila Belmiro'),
(14, 'Bragantino', 33700000, 154000000, 150000, 500000, 27, 3, 78, 'EXCELENTE', 'Boa Gestão', 17000, 'img/escudosClubes/brasileiraoSerieA/RedBullBragantino.png', 'Nabi Abi Chedid'),
(15, 'Athletico Paranaense', 35700000, 178600000, 180000, 2000000, 25, NULL, 62, 'ESTAVEL', NULL, 42372, 'img/escudosClubes/brasileiraoSerieA/cap.png', 'Ligga Arena'),
(16, 'Vitória', 15100000, 85100000, 130000, 3000000, 20, NULL, 55, 'ESTAVEL', NULL, 30240, 'img/escudosClubes/brasileiraoSerieA/vitoria.png', 'Barradão'),
(17, 'Coritiba', 14500000, 79400000, 90000, 1500000, 18, NULL, 80, 'EXCELENTE', 'Acesso à Série A', 40502, 'img/escudosClubes/brasileiraoSerieA/Coritiba.png', 'Couto Pereira'),
(18, 'Chapecoense', 6200000, 35200000, 60000, 1000000, 15, NULL, 74, 'ESTAVEL', 'Acesso à Série A', 22000, 'img/escudosClubes/brasileiraoSerieA/chapecoense.png', 'Arena Condá'),
(19, 'Mirassol', 8300000, 46400000, 50000, 200000, 14, NULL, 70, 'ESTAVEL', NULL, 15632, 'img/escudosClubes/brasileiraoSerieA/mirassol.png', 'Estádio Maião'),
(20, 'Remo', 6500000, 37700000, 70000, 2000000, 16, NULL, 76, 'ESTAVEL', 'Acesso à Série A', 45000, 'img/escudosClubes/brasileiraoSerieA/remo.png', 'Mangueirão');

-- --------------------------------------------------------

--
-- Table structure for table `clube_competicao`
--

CREATE TABLE `clube_competicao` (
  `competicao_idCompeticao` int(11) NOT NULL,
  `clube_idClube` int(11) NOT NULL,
  `pontos` int(11) NOT NULL,
  `faseAtual` enum('OITAVAS','QUARTAS','SEMI','FINAL') DEFAULT NULL,
  `eliminado` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `clube_competicao`
--

INSERT INTO `clube_competicao` (`competicao_idCompeticao`, `clube_idClube`, `pontos`, `faseAtual`, `eliminado`) VALUES
(1, 1, 0, NULL, 0),
(1, 2, 0, NULL, 0),
(1, 3, 0, NULL, 0),
(1, 4, 0, NULL, 0),
(1, 5, 0, NULL, 0),
(1, 6, 0, NULL, 0),
(1, 7, 0, NULL, 0),
(1, 8, 0, NULL, 0),
(1, 9, 0, NULL, 0),
(1, 10, 0, NULL, 0),
(1, 11, 0, NULL, 0),
(1, 12, 0, NULL, 0),
(1, 13, 0, NULL, 0),
(1, 14, 0, NULL, 0),
(1, 15, 0, NULL, 0),
(1, 16, 0, NULL, 0),
(1, 17, 0, NULL, 0),
(1, 18, 0, NULL, 0),
(1, 19, 0, NULL, 0),
(1, 20, 0, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `clube_has_acao_diretoria`
--

CREATE TABLE `clube_has_acao_diretoria` (
  `clube_idClube` int(11) NOT NULL,
  `acao_diretoria_idAcaoDiretoria` int(11) NOT NULL,
  `statusAcao` enum('DISPONIVEL','EM_ANALISE','CONCLUIDO') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `clube_has_acao_diretoria`
--

INSERT INTO `clube_has_acao_diretoria` (`clube_idClube`, `acao_diretoria_idAcaoDiretoria`, `statusAcao`) VALUES
(1, 1, 'DISPONIVEL'),
(1, 2, 'DISPONIVEL'),
(1, 3, 'DISPONIVEL'),
(1, 4, 'DISPONIVEL'),
(1, 5, 'DISPONIVEL'),
(1, 6, 'DISPONIVEL'),
(1, 7, 'DISPONIVEL'),
(1, 8, 'DISPONIVEL'),
(2, 1, 'DISPONIVEL'),
(2, 2, 'DISPONIVEL'),
(2, 3, 'DISPONIVEL'),
(2, 4, 'DISPONIVEL'),
(2, 5, 'DISPONIVEL'),
(2, 6, 'DISPONIVEL'),
(2, 7, 'DISPONIVEL'),
(2, 8, 'DISPONIVEL'),
(3, 1, 'DISPONIVEL'),
(3, 2, 'DISPONIVEL'),
(3, 3, 'DISPONIVEL'),
(3, 4, 'DISPONIVEL'),
(3, 5, 'DISPONIVEL'),
(3, 6, 'DISPONIVEL'),
(3, 7, 'DISPONIVEL'),
(3, 8, 'DISPONIVEL'),
(4, 1, 'DISPONIVEL'),
(4, 2, 'DISPONIVEL'),
(4, 3, 'DISPONIVEL'),
(4, 4, 'DISPONIVEL'),
(4, 5, 'DISPONIVEL'),
(4, 6, 'DISPONIVEL'),
(4, 7, 'DISPONIVEL'),
(4, 8, 'DISPONIVEL'),
(5, 1, 'DISPONIVEL'),
(5, 2, 'DISPONIVEL'),
(5, 3, 'DISPONIVEL'),
(5, 4, 'DISPONIVEL'),
(5, 5, 'DISPONIVEL'),
(5, 6, 'DISPONIVEL'),
(5, 7, 'DISPONIVEL'),
(5, 8, 'DISPONIVEL'),
(6, 1, 'DISPONIVEL'),
(6, 2, 'DISPONIVEL'),
(6, 3, 'DISPONIVEL'),
(6, 4, 'DISPONIVEL'),
(6, 5, 'DISPONIVEL'),
(6, 6, 'DISPONIVEL'),
(6, 7, 'DISPONIVEL'),
(6, 8, 'DISPONIVEL'),
(7, 1, 'DISPONIVEL'),
(7, 2, 'DISPONIVEL'),
(7, 3, 'DISPONIVEL'),
(7, 4, 'DISPONIVEL'),
(7, 5, 'DISPONIVEL'),
(7, 6, 'DISPONIVEL'),
(7, 7, 'DISPONIVEL'),
(7, 8, 'DISPONIVEL'),
(8, 1, 'DISPONIVEL'),
(8, 2, 'DISPONIVEL'),
(8, 3, 'DISPONIVEL'),
(8, 4, 'DISPONIVEL'),
(8, 5, 'DISPONIVEL'),
(8, 6, 'DISPONIVEL'),
(8, 7, 'DISPONIVEL'),
(8, 8, 'DISPONIVEL'),
(9, 1, 'DISPONIVEL'),
(9, 2, 'DISPONIVEL'),
(9, 3, 'DISPONIVEL'),
(9, 4, 'DISPONIVEL'),
(9, 5, 'DISPONIVEL'),
(9, 6, 'DISPONIVEL'),
(9, 7, 'DISPONIVEL'),
(9, 8, 'DISPONIVEL'),
(10, 1, 'DISPONIVEL'),
(10, 2, 'DISPONIVEL'),
(10, 3, 'DISPONIVEL'),
(10, 4, 'DISPONIVEL'),
(10, 5, 'DISPONIVEL'),
(10, 6, 'DISPONIVEL'),
(10, 7, 'DISPONIVEL'),
(10, 8, 'DISPONIVEL'),
(11, 1, 'DISPONIVEL'),
(11, 2, 'DISPONIVEL'),
(11, 3, 'DISPONIVEL'),
(11, 4, 'DISPONIVEL'),
(11, 5, 'DISPONIVEL'),
(11, 6, 'DISPONIVEL'),
(11, 7, 'DISPONIVEL'),
(11, 8, 'DISPONIVEL'),
(12, 1, 'DISPONIVEL'),
(12, 2, 'DISPONIVEL'),
(12, 3, 'DISPONIVEL'),
(12, 4, 'DISPONIVEL'),
(12, 5, 'DISPONIVEL'),
(12, 6, 'DISPONIVEL'),
(12, 7, 'DISPONIVEL'),
(12, 8, 'DISPONIVEL'),
(13, 1, 'DISPONIVEL'),
(13, 2, 'DISPONIVEL'),
(13, 3, 'DISPONIVEL'),
(13, 4, 'DISPONIVEL'),
(13, 5, 'DISPONIVEL'),
(13, 6, 'DISPONIVEL'),
(13, 7, 'DISPONIVEL'),
(13, 8, 'DISPONIVEL'),
(14, 1, 'DISPONIVEL'),
(14, 2, 'DISPONIVEL'),
(14, 3, 'DISPONIVEL'),
(14, 4, 'DISPONIVEL'),
(14, 5, 'DISPONIVEL'),
(14, 6, 'DISPONIVEL'),
(14, 7, 'DISPONIVEL'),
(14, 8, 'DISPONIVEL'),
(15, 1, 'DISPONIVEL'),
(15, 2, 'DISPONIVEL'),
(15, 3, 'DISPONIVEL'),
(15, 4, 'DISPONIVEL'),
(15, 5, 'DISPONIVEL'),
(15, 6, 'DISPONIVEL'),
(15, 7, 'DISPONIVEL'),
(15, 8, 'DISPONIVEL'),
(16, 1, 'DISPONIVEL'),
(16, 2, 'DISPONIVEL'),
(16, 3, 'DISPONIVEL'),
(16, 4, 'DISPONIVEL'),
(16, 5, 'DISPONIVEL'),
(16, 6, 'DISPONIVEL'),
(16, 7, 'DISPONIVEL'),
(16, 8, 'DISPONIVEL'),
(17, 1, 'DISPONIVEL'),
(17, 2, 'DISPONIVEL'),
(17, 3, 'DISPONIVEL'),
(17, 4, 'DISPONIVEL'),
(17, 5, 'DISPONIVEL'),
(17, 6, 'DISPONIVEL'),
(17, 7, 'DISPONIVEL'),
(17, 8, 'DISPONIVEL'),
(18, 1, 'DISPONIVEL'),
(18, 2, 'DISPONIVEL'),
(18, 3, 'DISPONIVEL'),
(18, 4, 'DISPONIVEL'),
(18, 5, 'DISPONIVEL'),
(18, 6, 'DISPONIVEL'),
(18, 7, 'DISPONIVEL'),
(18, 8, 'DISPONIVEL'),
(19, 1, 'DISPONIVEL'),
(19, 2, 'DISPONIVEL'),
(19, 3, 'DISPONIVEL'),
(19, 4, 'DISPONIVEL'),
(19, 5, 'DISPONIVEL'),
(19, 6, 'DISPONIVEL'),
(19, 7, 'DISPONIVEL'),
(19, 8, 'DISPONIVEL'),
(20, 1, 'DISPONIVEL'),
(20, 2, 'DISPONIVEL'),
(20, 3, 'DISPONIVEL'),
(20, 4, 'DISPONIVEL'),
(20, 5, 'DISPONIVEL'),
(20, 6, 'DISPONIVEL'),
(20, 7, 'DISPONIVEL'),
(20, 8, 'DISPONIVEL');

-- --------------------------------------------------------

--
-- Table structure for table `clube_has_meta_temporada`
--

CREATE TABLE `clube_has_meta_temporada` (
  `clube_idClube` int(11) NOT NULL,
  `meta_temporada_idMetaTemporada` int(11) NOT NULL,
  `status` enum('DENTRO_DO_ESPERADO','ABAIXO_DO_ESPERADO','CONCLUIDO','FALHOU') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `clube_has_meta_temporada`
--

INSERT INTO `clube_has_meta_temporada` (`clube_idClube`, `meta_temporada_idMetaTemporada`, `status`) VALUES
(1, 1, 'DENTRO_DO_ESPERADO'),
(1, 5, 'DENTRO_DO_ESPERADO'),
(1, 6, 'DENTRO_DO_ESPERADO'),
(2, 1, 'DENTRO_DO_ESPERADO'),
(2, 5, 'DENTRO_DO_ESPERADO'),
(2, 7, 'DENTRO_DO_ESPERADO'),
(3, 2, 'DENTRO_DO_ESPERADO'),
(3, 5, 'DENTRO_DO_ESPERADO'),
(4, 2, 'ABAIXO_DO_ESPERADO'),
(4, 6, 'ABAIXO_DO_ESPERADO'),
(5, 2, 'DENTRO_DO_ESPERADO'),
(5, 5, 'DENTRO_DO_ESPERADO'),
(6, 2, 'DENTRO_DO_ESPERADO'),
(6, 7, 'DENTRO_DO_ESPERADO'),
(7, 3, 'DENTRO_DO_ESPERADO'),
(7, 6, 'DENTRO_DO_ESPERADO'),
(8, 3, 'DENTRO_DO_ESPERADO'),
(8, 7, 'DENTRO_DO_ESPERADO'),
(9, 2, 'DENTRO_DO_ESPERADO'),
(9, 6, 'DENTRO_DO_ESPERADO'),
(10, 3, 'DENTRO_DO_ESPERADO'),
(10, 7, 'DENTRO_DO_ESPERADO'),
(11, 3, 'DENTRO_DO_ESPERADO'),
(11, 6, 'DENTRO_DO_ESPERADO'),
(12, 4, 'ABAIXO_DO_ESPERADO'),
(12, 6, 'ABAIXO_DO_ESPERADO'),
(13, 3, 'ABAIXO_DO_ESPERADO'),
(13, 6, 'ABAIXO_DO_ESPERADO'),
(14, 3, 'DENTRO_DO_ESPERADO'),
(14, 6, 'DENTRO_DO_ESPERADO'),
(15, 3, 'DENTRO_DO_ESPERADO'),
(15, 6, 'DENTRO_DO_ESPERADO'),
(16, 4, 'ABAIXO_DO_ESPERADO'),
(16, 7, 'ABAIXO_DO_ESPERADO'),
(17, 4, 'DENTRO_DO_ESPERADO'),
(17, 7, 'DENTRO_DO_ESPERADO'),
(18, 4, 'DENTRO_DO_ESPERADO'),
(18, 7, 'DENTRO_DO_ESPERADO'),
(19, 4, 'DENTRO_DO_ESPERADO'),
(19, 7, 'DENTRO_DO_ESPERADO'),
(20, 4, 'DENTRO_DO_ESPERADO'),
(20, 7, 'DENTRO_DO_ESPERADO');

-- --------------------------------------------------------

--
-- Table structure for table `clube_has_treino`
--

CREATE TABLE `clube_has_treino` (
  `clube_idClube` int(11) NOT NULL,
  `treino_idTreino` int(11) NOT NULL,
  `slot` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `clube_has_treino`
--

INSERT INTO `clube_has_treino` (`clube_idClube`, `treino_idTreino`, `slot`) VALUES
(7, 9, 1);

-- --------------------------------------------------------

--
-- Table structure for table `clube_has_upgrade`
--

CREATE TABLE `clube_has_upgrade` (
  `clube_idClube` int(11) NOT NULL,
  `upgrade_idUpgrade` int(11) NOT NULL,
  `nivelAtual` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `clube_has_upgrade`
--

INSERT INTO `clube_has_upgrade` (`clube_idClube`, `upgrade_idUpgrade`, `nivelAtual`) VALUES
(1, 1, 9),
(1, 2, 6),
(1, 3, 11),
(1, 4, 9),
(1, 5, 10),
(2, 1, 11),
(2, 2, 6),
(2, 3, 11),
(2, 4, 8),
(2, 5, 8),
(3, 1, 9),
(3, 2, 6),
(3, 3, 9),
(3, 4, 6),
(3, 5, 6),
(4, 1, 10),
(4, 2, 7),
(4, 3, 8),
(4, 4, 8),
(4, 5, 6),
(5, 1, 10),
(5, 2, 7),
(5, 3, 8),
(5, 4, 6),
(5, 5, 6),
(6, 1, 8),
(6, 2, 6),
(6, 3, 6),
(6, 4, 5),
(6, 5, 8),
(7, 1, 8),
(7, 2, 5),
(7, 3, 8),
(7, 4, 5),
(7, 5, 5),
(8, 1, 10),
(8, 2, 7),
(8, 3, 6),
(8, 4, 6),
(8, 5, 5),
(9, 1, 9),
(9, 2, 5),
(9, 3, 8),
(9, 4, 6),
(9, 5, 5),
(10, 1, 8),
(10, 2, 7),
(10, 3, 8),
(10, 4, 5),
(10, 5, 5),
(11, 1, 7),
(11, 2, 5),
(11, 3, 8),
(11, 4, 4),
(11, 5, 5),
(12, 1, 3),
(12, 2, 4),
(12, 3, 5),
(12, 4, 5),
(12, 5, 4),
(13, 1, 4),
(13, 2, 5),
(13, 3, 6),
(13, 4, 5),
(13, 5, 5),
(14, 1, 6),
(14, 2, 6),
(14, 3, 8),
(14, 4, 3),
(14, 5, 4),
(15, 1, 10),
(15, 2, 7),
(15, 3, 11),
(15, 4, 4),
(15, 5, 4),
(16, 1, 5),
(16, 2, 4),
(16, 3, 5),
(16, 4, 3),
(16, 5, 3),
(17, 1, 5),
(17, 2, 4),
(17, 3, 5),
(17, 4, 3),
(17, 5, 3),
(18, 1, 4),
(18, 2, 4),
(18, 3, 3),
(18, 4, 2),
(18, 5, 2),
(19, 1, 3),
(19, 2, 4),
(19, 3, 5),
(19, 4, 0),
(19, 5, 2),
(20, 1, 4),
(20, 2, 2),
(20, 3, 3),
(20, 4, 2),
(20, 5, 2);

-- --------------------------------------------------------

--
-- Table structure for table `competicao`
--

CREATE TABLE `competicao` (
  `idCompeticao` int(11) NOT NULL,
  `nomeCompeticao` varchar(45) NOT NULL,
  `valorPremio` float NOT NULL,
  `premioPorVitoria` float NOT NULL,
  `tipoCompeticao` enum('PONTOS_CORRIDOS','MATA_MATA','MISTO') NOT NULL,
  `nivelCompeticao` enum('NACIONAL','CONTINENTAL','ESTADUAL') NOT NULL,
  `ano` int(11) NOT NULL,
  `statusCompeticao` enum('NAO_INICIADA','EM_ANDAMENTO','FINALIZADA') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `competicao`
--

INSERT INTO `competicao` (`idCompeticao`, `nomeCompeticao`, `valorPremio`, `premioPorVitoria`, `tipoCompeticao`, `nivelCompeticao`, `ano`, `statusCompeticao`) VALUES
(1, 'Brasileirão Série A', 80000000, 1500000, 'PONTOS_CORRIDOS', 'NACIONAL', 2026, 'EM_ANDAMENTO'),
(5, 'Copa do Brasil', 55000000, 1000000, 'MATA_MATA', 'NACIONAL', 2026, 'EM_ANDAMENTO'),
(6, 'Copa Libertadores', 22000000, 2000000, 'MISTO', 'CONTINENTAL', 2026, 'EM_ANDAMENTO'),
(7, 'Copa Sul-Americana', 12000000, 1200000, 'MISTO', 'CONTINENTAL', 2026, 'EM_ANDAMENTO'),
(8, 'Campeonato Paulista', 8000000, 300000, 'MISTO', 'ESTADUAL', 2026, 'FINALIZADA'),
(9, 'Campeonato Carioca', 7000000, 280000, 'MISTO', 'ESTADUAL', 2026, 'FINALIZADA'),
(10, 'Campeonato Mineiro', 6000000, 250000, 'MISTO', 'ESTADUAL', 2026, 'FINALIZADA'),
(11, 'Campeonato Gaúcho', 5500000, 220000, 'MISTO', 'ESTADUAL', 2026, 'FINALIZADA'),
(12, 'Campeonato Baiano', 3000000, 150000, 'MISTO', 'ESTADUAL', 2026, 'FINALIZADA'),
(13, 'Campeonato Paranaense', 3500000, 160000, 'MISTO', 'ESTADUAL', 2026, 'FINALIZADA'),
(14, 'Campeonato Catarinense', 3000000, 140000, 'MISTO', 'ESTADUAL', 2026, 'FINALIZADA'),
(15, 'Campeonato Pernambucano', 2500000, 130000, 'MISTO', 'ESTADUAL', 2026, 'FINALIZADA'),
(16, 'Campeonato Cearense', 2500000, 130000, 'MISTO', 'ESTADUAL', 2026, 'FINALIZADA'),
(17, 'Campeonato Paraense', 2000000, 110000, 'MISTO', 'ESTADUAL', 2026, 'FINALIZADA'),
(18, 'Campeonato Goiano', 2000000, 100000, 'MISTO', 'ESTADUAL', 2026, 'FINALIZADA'),
(19, 'Campeonato Capixaba', 1200000, 70000, 'MISTO', 'ESTADUAL', 2026, 'FINALIZADA'),
(20, 'Campeonato Sergipano', 1000000, 60000, 'MISTO', 'ESTADUAL', 2026, 'FINALIZADA'),
(21, 'Campeonato Alagoano', 1000000, 60000, 'MISTO', 'ESTADUAL', 2026, 'FINALIZADA'),
(22, 'Campeonato Potiguar', 1000000, 60000, 'MISTO', 'ESTADUAL', 2026, 'FINALIZADA'),
(23, 'Campeonato Paraibano', 1000000, 60000, 'MISTO', 'ESTADUAL', 2026, 'FINALIZADA'),
(24, 'Campeonato Piauiense', 900000, 50000, 'MISTO', 'ESTADUAL', 2026, 'FINALIZADA'),
(25, 'Campeonato Maranhense', 900000, 50000, 'MISTO', 'ESTADUAL', 2026, 'FINALIZADA'),
(26, 'Campeonato Amazonense', 1000000, 55000, 'MISTO', 'ESTADUAL', 2026, 'FINALIZADA'),
(27, 'Campeonato Rondoniense', 600000, 40000, 'MISTO', 'ESTADUAL', 2026, 'FINALIZADA'),
(28, 'Campeonato Acreano', 500000, 35000, 'MISTO', 'ESTADUAL', 2026, 'FINALIZADA'),
(29, 'Campeonato Roraimense', 400000, 30000, 'MISTO', 'ESTADUAL', 2026, 'FINALIZADA'),
(30, 'Campeonato Amapaense', 400000, 30000, 'MISTO', 'ESTADUAL', 2026, 'FINALIZADA'),
(31, 'Campeonato Tocantinense', 500000, 35000, 'MISTO', 'ESTADUAL', 2026, 'FINALIZADA'),
(32, 'Campeonato Mato-Grossense', 800000, 45000, 'MISTO', 'ESTADUAL', 2026, 'FINALIZADA'),
(33, 'Campeonato Sul-Mato-Grossense', 700000, 40000, 'MISTO', 'ESTADUAL', 2026, 'FINALIZADA'),
(34, 'Campeonato Brasiliense', 900000, 50000, 'MISTO', 'ESTADUAL', 2026, 'FINALIZADA');

-- --------------------------------------------------------

--
-- Table structure for table `estatisticas_ano_clube`
--

CREATE TABLE `estatisticas_ano_clube` (
  `idEstatisticasAnoClube` int(11) NOT NULL,
  `ano` int(11) NOT NULL,
  `jogos` int(11) NOT NULL,
  `vitorias` int(11) NOT NULL,
  `empates` int(11) NOT NULL,
  `derrotas` int(11) NOT NULL,
  `golsFeitos` int(11) NOT NULL,
  `golsSofridos` int(11) NOT NULL,
  `clube_idClube` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `estatisticas_ano_clube`
--

INSERT INTO `estatisticas_ano_clube` (`idEstatisticasAnoClube`, `ano`, `jogos`, `vitorias`, `empates`, `derrotas`, `golsFeitos`, `golsSofridos`, `clube_idClube`) VALUES
(1, 2026, 0, 0, 0, 0, 0, 0, 1),
(2, 2026, 0, 0, 0, 0, 0, 0, 2),
(3, 2026, 0, 0, 0, 0, 0, 0, 3),
(4, 2026, 0, 0, 0, 0, 0, 0, 4),
(5, 2026, 0, 0, 0, 0, 0, 0, 5),
(6, 2026, 0, 0, 0, 0, 0, 0, 6),
(7, 2026, 0, 0, 0, 0, 0, 0, 7),
(8, 2026, 0, 0, 0, 0, 0, 0, 8),
(9, 2026, 0, 0, 0, 0, 0, 0, 9),
(10, 2026, 0, 0, 0, 0, 0, 0, 10),
(11, 2026, 0, 0, 0, 0, 0, 0, 11),
(12, 2026, 0, 0, 0, 0, 0, 0, 12),
(13, 2026, 0, 0, 0, 0, 0, 0, 13),
(14, 2026, 0, 0, 0, 0, 0, 0, 14),
(15, 2026, 0, 0, 0, 0, 0, 0, 15),
(16, 2026, 0, 0, 0, 0, 0, 0, 16),
(17, 2026, 0, 0, 0, 0, 0, 0, 17),
(18, 2026, 0, 0, 0, 0, 0, 0, 18),
(19, 2026, 0, 0, 0, 0, 0, 0, 19),
(20, 2026, 0, 0, 0, 0, 0, 0, 20),
(21, 2025, 10, 10, 10, 10, 10, 10, 12),
(22, 2024, 10, 10, 10, 10, 10, 10, 8);

-- --------------------------------------------------------

--
-- Table structure for table `estatisticas_jogador_competicao`
--

CREATE TABLE `estatisticas_jogador_competicao` (
  `jogador_idJogador` int(11) NOT NULL,
  `competicao_idCompeticao` int(11) NOT NULL,
  `ano` int(11) NOT NULL,
  `jogos` int(11) NOT NULL,
  `gols` int(11) NOT NULL,
  `assistencias` int(11) NOT NULL,
  `notaMedia` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exigencia`
--

CREATE TABLE `exigencia` (
  `idExigencia` int(11) NOT NULL,
  `nomeExigencia` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `exigencia`
--

INSERT INTO `exigencia` (`idExigencia`, `nomeExigencia`) VALUES
(1, 'Quantidade de torcedores superior a 5 milhões'),
(2, 'Quantidade de torcedores superior a 10 milhões'),
(3, 'Reputação mínima: Grande'),
(4, 'Reputação mínima: Gigante'),
(5, 'Arquibancada nível 2'),
(6, 'Arquibancada nível 3'),
(7, 'Estar na Série A'),
(8, 'Classificação para competição continental'),
(9, 'Orçamento mínimo de R$ 10.000.000'),
(10, 'Camisas vendidas acima de 100.000/ano');

-- --------------------------------------------------------

--
-- Table structure for table `historico_tecnico`
--

CREATE TABLE `historico_tecnico` (
  `idHistoricoTecnico` int(11) NOT NULL,
  `ano` int(11) NOT NULL,
  `manager_idManager` int(11) NOT NULL,
  `clube_idClube` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jogador`
--

CREATE TABLE `jogador` (
  `idJogador` int(11) NOT NULL,
  `nomeJogador` varchar(45) DEFAULT NULL,
  `numeroCamisa` int(11) NOT NULL,
  `idade` int(11) DEFAULT NULL,
  `posicao_principal` enum('ATA','PD','PE','VOL','MC','MEI','ZAG','LD','LE','GOL') DEFAULT NULL,
  `overall` int(11) DEFAULT NULL,
  `velocidade` int(11) DEFAULT NULL,
  `forca` int(11) DEFAULT NULL,
  `inteligencia` int(11) DEFAULT NULL,
  `finalizacao` int(11) DEFAULT NULL,
  `marcacao` int(11) DEFAULT NULL,
  `passe` int(11) DEFAULT NULL,
  `potencial` int(11) DEFAULT NULL,
  `titular` int(11) NOT NULL DEFAULT 1,
  `moral` int(11) DEFAULT NULL,
  `nacionalidade` varchar(255) DEFAULT NULL,
  `dispEmprestimo` tinyint(4) DEFAULT NULL,
  `satisfacao` int(11) DEFAULT NULL,
  `onfire` tinyint(4) DEFAULT NULL,
  `valor` float DEFAULT NULL,
  `valorRescisao` float DEFAULT NULL,
  `salario` float NOT NULL DEFAULT 0,
  `tempoContrato` int(11) DEFAULT NULL,
  `clube_idClube` int(11) DEFAULT NULL,
  `posicaoX` float DEFAULT NULL,
  `posicaoY` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `jogador`
--

INSERT INTO `jogador` (`idJogador`, `nomeJogador`, `numeroCamisa`, `idade`, `posicao_principal`, `overall`, `velocidade`, `forca`, `inteligencia`, `finalizacao`, `marcacao`, `passe`, `potencial`, `titular`, `moral`, `nacionalidade`, `dispEmprestimo`, `satisfacao`, `onfire`, `valor`, `valorRescisao`, `salario`, `tempoContrato`, `clube_idClube`, `posicaoX`, `posicaoY`) VALUES
(1, 'Gabriel Batista', 1, 27, 'GOL', 73, 43, 77, 69, 19, 61, 57, 74, 0, 50, 'Brasil', 0, 50, 0, 4000000, 28735000, 67250, 48, 6, 50, 90),
(2, 'Warleson', 12, 29, 'GOL', 70, 44, 65, 72, 27, 63, 55, 70, 1, 50, 'Brasil', 0, 50, 0, 2000000, 8110000, 29500, 48, 6, 50, 90),
(3, 'Cristhian Loor', 22, 19, 'GOL', 58, 27, 53, 56, 14, 53, 47, 70, 2, 50, 'Equador', 1, 50, 0, 350000, 1460000, 4250, 36, 6, 50, 90),
(4, 'Arthur Chaves', 3, 24, 'ZAG', 74, 67, 80, 78, 53, 80, 65, 76, 0, 50, 'Brasil', 0, 50, 0, 5000000, 16210000, 84500, 24, 6, 85, 62),
(5, 'Nahuel Ferraresi', 4, 27, 'ZAG', 73, 62, 78, 78, 42, 76, 73, 74, 0, 50, 'Venezuela', 0, 50, 0, 5000000, 20120000, 91250, 48, 6, 50, 74),
(6, 'Kaio', 13, 30, 'ZAG', 73, 59, 80, 82, 56, 77, 63, 73, 1, 50, 'Brasil', 0, 50, 0, 1800000, 5020000, 38500, 30, 6, 50, 74),
(7, 'Lucas Monzón', 14, 24, 'ZAG', 67, 54, 72, 72, 43, 67, 68, 69, 1, 50, 'Uruguai', 1, 50, 0, 1500000, 8630000, 23000, 48, 6, 15, 62),
(8, 'Gabriel Justino', 33, 19, 'ZAG', 66, 63, 72, 58, 45, 70, 60, 74, 2, 50, 'Brasil', 1, 50, 0, 1500000, 4990000, 12750, 35, 6, 50, 74),
(9, 'Anthony', 34, 20, 'ZAG', 62, 62, 70, 61, 37, 72, 60, 67, 2, 50, 'Brasil', 1, 50, 0, 300000, 1440000, 5000, 50, 6, 85, 62),
(10, 'Kawan', 44, 22, 'ZAG', 54, 47, 57, 55, 17, 62, 50, 57, 2, 50, 'Brasil', 1, 50, 0, 100000, 155000, 2500, 12, 6, 15, 62),
(11, 'Alex Telles', 6, 33, 'LE', 74, 69, 69, 79, 60, 70, 80, 74, 0, 50, 'Brasil', 0, 50, 0, 2800000, 9885000, 52500, 36, 6, 50, 74),
(12, 'Paulinho', 26, 30, 'LE', 64, 75, 46, 55, 52, 54, 62, 64, 2, 50, 'Brasil', 0, 50, 0, 400000, 890000, 10250, 36, 6, 50, 74),
(13, 'Marçal', 16, 36, 'LE', 65, 56, 59, 71, 58, 65, 71, 65, 1, 50, 'Brasil', 0, 50, 0, 200000, 185000, 4000, 12, 6, 50, 58),
(14, 'Jhoan Hernández', 36, 19, 'LE', 56, 60, 41, 55, 37, 62, 57, 66, 2, 50, 'Colômbia', 1, 50, 0, 150000, 515000, 2500, 12, 6, 50, 48),
(15, 'Vitinho', 2, 26, 'LD', 74, 78, 68, 74, 61, 75, 66, 75, 0, 50, 'Brasil', 0, 50, 0, 9000000, 40980000, 137250, 48, 6, 50, 35),
(16, 'Mateo Ponte', 23, 22, 'LD', 69, 81, 68, 66, 48, 63, 71, 74, 1, 50, 'Uruguai', 0, 50, 0, 3000000, 10425000, 38250, 30, 6, 50, 35),
(17, 'Kadu Santos', 32, 20, 'LD', 63, 56, 50, 68, 57, 56, 72, 69, 2, 50, 'Brasil', 1, 50, 0, 350000, 770000, 4750, 12, 6, 50, 48),
(18, 'Huguinho', 15, 18, 'VOL', 70, 73, 74, 64, 48, 73, 62, 81, 1, 50, 'Brasil', 1, 50, 0, 3000000, 17245000, 33750, 51, 6, 50, 35),
(19, 'Domingos Andrade', 25, 22, 'VOL', 67, 58, 74, 66, 55, 74, 68, 72, 2, 50, 'Angola', 1, 50, 0, 1500000, 7565000, 20750, 48, 6, 50, 58),
(20, 'Allan', 5, 34, 'VOL', 72, 53, 70, 74, 63, 84, 76, 72, 0, 50, 'Brasil', 0, 50, 0, 1000000, 1410000, 20250, 12, 6, 50, 58),
(21, 'Wallace Davi', 35, 18, 'VOL', 66, 58, 68, 58, 45, 68, 59, 79, 2, 50, 'Brasil', 1, 50, 0, 1000000, 4995000, 10000, 48, 6, 80, 25),
(22, 'Danilo', 8, 24, 'MC', 81, 79, 75, 85, 78, 76, 87, 83, 0, 50, 'Brasil', 0, 50, 0, 32000000, 94495000, 438750, 42, 6, 50, 12),
(23, 'Cristian Medina', 18, 23, 'MC', 78, 77, 74, 77, 67, 68, 79, 82, 1, 50, 'Argentina', 0, 50, 0, 8000000, 35520000, 149250, 48, 6, 20, 25),
(24, 'Edenilson', 20, 36, 'MC', 65, 61, 61, 77, 60, 62, 66, 65, 2, 50, 'Brasil', 0, 50, 0, 250000, 270000, 4750, 12, 6, 20, 25),
(25, 'Jordan Barrera', 10, 19, 'MEI', 66, 65, 53, 67, 66, 40, 71, 76, 0, 50, 'Colômbia', 0, 50, 0, 2500000, 19515000, 26250, 48, 6, 80, 25),
(26, 'Álvaro Montoro', 11, 18, 'PE', 74, 86, 63, 70, 69, 44, 69, 87, 0, 50, 'Argentina', 0, 50, 0, 14000000, 73410000, 148000, 60, 6, 20, 25),
(27, 'Matheus Martins', 21, 22, 'PE', 74, 81, 67, 72, 79, 56, 63, 77, 1, 50, 'Brasil', 0, 50, 0, 6000000, 24185000, 91000, 36, 6, 50, 12),
(28, 'Júnior Santos', 7, 31, 'PD', 74, 77, 68, 69, 85, 63, 75, 74, 0, 50, 'Brasil', 0, 50, 0, 3000000, 7815000, 41250, 12, 6, 50, 90),
(29, 'Hakim Ziyech', 17, 32, 'PD', 72, 81, 67, 66, 73, 46, 64, 72, 1, 50, 'Marrocos', 0, 50, 0, 2200000, 5205000, 40250, 36, 6, 50, 74),
(30, 'Lucas Villalba', 27, 24, 'PD', 66, 78, 54, 71, 69, 46, 65, 68, 2, 50, 'Uruguai', 1, 50, 0, 1500000, 4435000, 21000, 48, 6, 50, 74),
(31, 'Kauan Toledo', 37, 19, 'PD', 64, 76, 54, 61, 54, 41, 57, 76, 2, 50, 'Brasil', 1, 50, 0, 1000000, 4470000, 8250, 48, 6, 85, 62),
(32, 'Arthur Cabral', 9, 27, 'ATA', 76, 76, 86, 78, 83, 46, 65, 77, 0, 50, 'Brasil', 0, 50, 0, 9000000, 50610000, 139000, 36, 6, 15, 62),
(33, 'Kadir Barría', 19, 18, 'ATA', 69, 63, 59, 68, 79, 29, 67, 79, 1, 50, 'Panamá', 1, 50, 0, 2000000, 11400000, 23500, 48, 6, 50, 48),
(34, 'Lucas Emanuel', 29, 16, 'ATA', 64, 73, 59, 62, 70, 29, 54, 77, 1, 50, 'Brasil', 1, 50, 0, 2000000, 7695000, 25000, 54, 6, 50, 48),
(35, 'Danilo', 39, 26, 'ATA', 67, 69, 73, 69, 73, 40, 54, 68, 2, 50, 'Brasil', 1, 50, 0, 1500000, 5715000, 23000, 18, 6, 50, 12),
(36, 'Tiquinho Soares', 99, 34, 'ATA', 69, 65, 69, 74, 81, 47, 62, 69, 1, 50, 'Brasil', 0, 50, 0, 800000, 995000, 15250, 12, 6, 50, 12),
(37, 'Anderson', 1, 27, 'GOL', 64, 30, 64, 70, 15, 51, 48, 65, 0, 50, 'Brasil', 0, 50, 0, 450000, 1485000, 7000, 24, 18, 50, 35),
(38, 'Matheus Aurélio', 12, 26, 'GOL', 60, 30, 55, 63, 15, 44, 56, 61, 1, 50, 'Brasil', 0, 50, 0, 250000, 645000, 3500, 11, 18, 85, 62),
(39, 'Rafael Santos', 22, 36, 'GOL', 58, 25, 47, 66, 8, 46, 48, 58, 2, 50, 'Brasil', 0, 50, 0, 75000, 90000, 2500, 12, 18, 50, 90),
(40, 'Gabriel Werner', 40, 22, 'GOL', 57, 37, 52, 54, 8, 52, 46, 62, 2, 50, 'Brasil', 1, 50, 0, 100000, 350000, 2500, 15, 18, 50, 74),
(41, 'Doma', 3, 27, 'ZAG', 69, 62, 73, 72, 40, 81, 64, 70, 0, 50, 'Brasil', 0, 50, 0, 1200000, 4455000, 16750, 24, 18, 50, 58),
(42, 'João Paulo', 4, 28, 'ZAG', 69, 46, 72, 74, 51, 79, 72, 69, 0, 50, 'Brasil', 0, 50, 0, 600000, 1420000, 11750, 12, 18, 50, 48),
(43, 'Victor Caetano', 13, 28, 'ZAG', 64, 58, 62, 64, 39, 73, 51, 64, 1, 50, 'Brasil', 0, 50, 0, 600000, 2130000, 8250, 23, 18, 50, 12),
(44, 'Kauan Faria', 14, 22, 'ZAG', 62, 46, 60, 65, 39, 65, 58, 67, 1, 50, 'Brasil', 1, 50, 0, 300000, 860000, 4000, 12, 18, 85, 62),
(45, 'Rafael Thyere', 33, 32, 'ZAG', 62, 46, 65, 68, 35, 70, 50, 62, 2, 50, 'Brasil', 0, 50, 0, 250000, 385000, 4000, 12, 18, 15, 62),
(46, 'Vinicius Eduardo', 34, 20, 'ZAG', 55, 51, 56, 50, 27, 67, 36, 63, 2, 50, 'Brasil', 1, 50, 0, 100000, 215000, 2500, 12, 18, 50, 74),
(47, 'Mancha', 26, 24, 'LE', 64, 75, 55, 63, 51, 65, 66, 68, 2, 50, 'Brasil', 1, 50, 0, 500000, 1495000, 5500, 12, 18, 50, 48),
(48, 'Fernando', 6, 26, 'LE', 65, 71, 58, 65, 58, 65, 67, 66, 0, 50, 'Brasil', 0, 50, 0, 400000, 2360000, 4250, 48, 18, 50, 12),
(49, 'Bruno Pacheco', 16, 34, 'LE', 65, 62, 51, 71, 53, 69, 62, 65, 1, 50, 'Brasil', 0, 50, 0, 250000, 225000, 4250, 12, 18, 50, 48),
(50, 'Da Silva', 36, 26, 'LE', 62, 67, 57, 58, 42, 59, 56, 63, 2, 50, 'Brasil', 1, 50, 0, 100000, 225000, 2500, 12, 18, 50, 58),
(51, 'Dudu', 2, 28, 'LD', 66, 78, 67, 55, 48, 56, 58, 67, 0, 50, 'Brasil', 0, 50, 0, 700000, 1460000, 10250, 12, 18, 50, 12),
(52, 'Heitor', 23, 25, 'LD', 64, 69, 53, 63, 48, 61, 63, 65, 1, 50, 'Brasil', 1, 50, 0, 450000, 1000000, 5750, 12, 18, 50, 74),
(53, 'Everton', 27, 30, 'LD', 64, 70, 60, 59, 50, 55, 62, 64, 2, 50, 'Brasil', 1, 50, 0, 300000, 660000, 4000, 12, 18, 50, 48),
(54, 'Carvalheira', 15, 26, 'VOL', 71, 71, 65, 77, 61, 82, 76, 72, 1, 50, 'Brasil', 0, 50, 0, 2500000, 5185000, 21750, 11, 18, 15, 62),
(55, 'Camilo', 5, 26, 'VOL', 72, 59, 73, 77, 71, 78, 80, 73, 0, 50, 'Brasil', 0, 50, 0, 2000000, 3640000, 22250, 12, 18, 50, 90),
(56, 'Vinicius Balieiro', 25, 26, 'VOL', 65, 61, 67, 57, 48, 72, 56, 66, 2, 50, 'Brasil', 1, 50, 0, 400000, 875000, 5250, 12, 18, 50, 90),
(57, 'Rosivan', 35, 25, 'VOL', 58, 39, 50, 65, 42, 62, 66, 59, 2, 50, 'Brasil', 1, 50, 0, 100000, 305000, 2500, 24, 18, 50, 90),
(58, 'Yago Felipe', 8, 30, 'MC', 69, 72, 70, 67, 61, 73, 70, 69, 0, 50, 'Brasil', 0, 50, 0, 1200000, 3385000, 15000, 12, 18, 50, 90),
(59, 'Bruno Matias', 18, 26, 'MC', 63, 59, 69, 68, 47, 68, 67, 64, 1, 50, 'Brasil', 0, 50, 0, 500000, 1245000, 7750, 12, 18, 50, 90),
(60, 'David Antunes', 28, 20, 'MC', 61, 52, 52, 57, 47, 52, 60, 69, 2, 50, 'Brasil', 1, 50, 0, 200000, 860000, 2500, 33, 18, 85, 62),
(61, 'Robert Santos', 10, 22, 'MEI', 69, 71, 52, 70, 66, 49, 80, 72, 0, 50, 'Brasil', 0, 50, 0, 1000000, 3055000, 8500, 12, 18, 85, 62),
(62, 'Max', 20, 24, 'MEI', 66, 69, 50, 70, 66, 39, 64, 69, 1, 50, 'Brasil', 0, 50, 0, 600000, 1335000, 6750, 12, 18, 85, 62),
(63, 'Miguel Carvalho', 70, 20, 'MEI', 62, 55, 51, 63, 66, 47, 64, 71, 2, 50, 'Espanha', 1, 50, 0, 325000, 1770000, 2500, 36, 18, 85, 62),
(64, 'Giovanni Augusto', 30, 36, 'MEI', 63, 57, 52, 62, 59, 40, 54, 63, 2, 50, 'Brasil', 1, 50, 0, 150000, 370000, 2500, 24, 18, 15, 62),
(65, 'Dylan Borrero', 11, 23, 'PE', 66, 75, 49, 76, 75, 43, 71, 69, 0, 50, 'Colômbia', 0, 50, 0, 1000000, 4505000, 14750, 24, 18, 15, 62),
(66, 'Maurício Garcez', 21, 28, 'PE', 66, 77, 62, 66, 55, 37, 62, 66, 1, 50, 'Brasil', 0, 50, 0, 800000, 1700000, 10750, 36, 18, 15, 62),
(67, 'Kevin Ramírez', 31, 31, 'PE', 66, 74, 61, 64, 67, 34, 63, 66, 2, 50, 'Uruguai', 0, 50, 0, 400000, 620000, 7250, 12, 18, 50, 74),
(68, 'Marcinho', 7, 30, 'PD', 69, 77, 58, 70, 67, 42, 63, 69, 0, 50, 'Brasil', 0, 50, 0, 650000, 1575000, 8750, 11, 18, 50, 74),
(69, 'Rubens', 17, 22, 'PD', 66, 75, 61, 62, 65, 47, 63, 70, 1, 50, 'Brasil', 0, 50, 0, 500000, 1590000, 6500, 21, 18, 50, 74),
(70, 'Bruno Tubarão', 37, 30, 'PD', 62, 68, 48, 68, 68, 36, 65, 62, 2, 50, 'Brasil', 0, 50, 0, 400000, 670000, 4750, 12, 18, 50, 74),
(71, 'Tulio Eduardo', 9, 21, 'ATA', 70, 82, 80, 68, 68, 41, 48, 78, 0, 50, 'Brasil', 0, 50, 0, 1500000, 9845000, 17250, 48, 18, 50, 58),
(72, 'Franco Rossi', 19, 23, 'ATA', 68, 70, 70, 66, 72, 30, 54, 72, 1, 50, 'Uruguai', 0, 50, 0, 1500000, 2985000, 14750, 12, 18, 50, 48),
(73, 'Yannick Bolasie', 99, 36, 'ATA', 63, 52, 69, 62, 60, 35, 53, 63, 1, 50, 'RD Congo', 0, 50, 0, 150000, 240000, 3000, 12, 18, 50, 48),
(74, 'Mycael', 1, 21, 'GOL', 75, 45, 76, 80, 25, 66, 64, 81, 0, 50, 'Brasil', 0, 50, 0, 5000000, 21895000, 57750, 36, 15, 50, 48),
(75, 'Santos', 12, 35, 'GOL', 66, 30, 62, 74, 12, 60, 58, 66, 1, 50, 'Brasil', 0, 50, 0, 400000, 525000, 8500, 12, 15, 50, 48),
(76, 'Matheus Soares', 22, 20, 'GOL', 57, 30, 59, 49, 8, 44, 42, 64, 2, 50, 'Brasil', 1, 50, 0, 100000, 445000, 2500, 48, 15, 50, 58),
(77, 'Arthur Dias', 3, 18, 'ZAG', 74, 56, 74, 67, 41, 80, 69, 88, 0, 50, 'Brasil', 0, 50, 0, 15000000, 126665000, 171250, 36, 15, 50, 48),
(78, 'Carlos Terán', 13, 25, 'ZAG', 73, 69, 78, 76, 45, 83, 67, 75, 1, 50, 'Colômbia', 0, 50, 0, 4000000, 9695000, 88250, 12, 15, 50, 58),
(79, 'Juan Felipe Aguirre', 4, 29, 'ZAG', 74, 59, 75, 80, 49, 86, 70, 74, 0, 50, 'Colômbia', 0, 50, 0, 2000000, 5360000, 29500, 24, 15, 50, 48),
(80, 'Léo', 14, 29, 'ZAG', 68, 53, 75, 79, 35, 68, 66, 68, 1, 50, 'Brasil', 0, 50, 0, 1200000, 3955000, 18750, 36, 15, 50, 12),
(81, 'Dantas', 33, 21, 'ZAG', 66, 53, 74, 68, 33, 74, 55, 75, 2, 50, 'Brasil', 1, 50, 0, 700000, 1535000, 7500, 12, 15, 80, 25),
(82, 'Lucas Esquivel', 6, 24, 'LE', 77, 74, 65, 70, 57, 79, 79, 80, 0, 50, 'Argentina', 0, 50, 0, 8000000, 31745000, 160500, 42, 15, 50, 12),
(83, 'Léo Derik', 16, 20, 'LE', 70, 78, 55, 62, 60, 69, 69, 75, 1, 50, 'Brasil', 1, 50, 0, 3000000, 22390000, 38750, 48, 15, 20, 25),
(84, 'Claudinho', 26, 20, 'LE', 54, 62, 45, 51, 42, 53, 52, 61, 2, 50, 'Brasil', 1, 50, 0, 100000, 525000, 2500, 60, 15, 50, 12),
(85, 'Gastón Benavídez', 23, 30, 'LD', 75, 74, 68, 74, 58, 72, 69, 75, 1, 50, 'Argentina', 0, 50, 0, 3500000, 11545000, 60000, 36, 15, 80, 25),
(86, 'Gilberto Junior', 27, 20, 'LD', 70, 71, 62, 71, 64, 67, 74, 77, 1, 50, 'Brasil', 1, 50, 0, 2500000, 5915000, 30500, 12, 15, 50, 12),
(87, 'Gilberto', 2, 32, 'LD', 76, 82, 71, 74, 58, 71, 72, 76, 0, 50, 'Brasil', 0, 50, 0, 2200000, 8690000, 31750, 24, 15, 50, 12),
(88, 'Diogo Riquelme', 5, 20, 'VOL', 67, 53, 60, 70, 54, 73, 66, 73, 0, 50, 'Brasil', 0, 50, 0, 1000000, 4745000, 17500, 36, 15, 50, 12),
(89, 'Luiz Gustavo', 15, 38, 'VOL', 61, 44, 53, 73, 49, 71, 62, 61, 1, 50, 'Brasil', 0, 50, 0, 200000, 190000, 4750, 12, 15, 20, 25),
(90, 'João Cruz', 21, 19, 'MC', 72, 61, 67, 68, 69, 68, 78, 84, 1, 50, 'Brasil', 1, 50, 0, 8000000, 56330000, 88750, 36, 15, 50, 90),
(91, 'Juan Portilla', 8, 27, 'MC', 74, 68, 69, 79, 73, 80, 73, 75, 0, 50, 'Colômbia', 0, 50, 0, 5000000, 22905000, 74000, 36, 15, 50, 90),
(92, 'Felipinho', 28, 24, 'MC', 67, 63, 60, 68, 65, 68, 62, 70, 2, 50, 'Brasil', 1, 50, 0, 1000000, 3970000, 14250, 24, 15, 50, 90),
(93, 'Jádson', 18, 32, 'MC', 73, 63, 79, 74, 78, 80, 78, 73, 1, 50, 'Brasil', 1, 50, 0, 1000000, 1895000, 22000, 12, 15, 50, 90),
(94, 'Alejandro García', 38, 24, 'MC', 64, 59, 54, 67, 61, 64, 74, 66, 2, 50, 'Colômbia', 1, 50, 0, 700000, 1620000, 8750, 36, 15, 50, 74),
(95, 'Dudu', 10, 20, 'MEI', 76, 75, 64, 78, 70, 53, 69, 84, 0, 50, 'Brasil', 0, 50, 0, 7000000, 22855000, 87250, 48, 15, 50, 74),
(96, 'Bruno Zapelli', 20, 23, 'MEI', 75, 86, 67, 78, 78, 52, 78, 77, 1, 50, 'Argentina', 0, 50, 0, 4500000, 12955000, 67500, 24, 15, 50, 74),
(97, 'Chiqueti', 30, 20, 'MEI', 69, 73, 60, 78, 69, 43, 75, 77, 1, 50, 'Brasil', 1, 50, 0, 3000000, 13485000, 40500, 48, 15, 50, 74),
(98, 'Stiven Mendoza', 11, 33, 'PE', 68, 64, 59, 66, 80, 44, 63, 68, 0, 50, 'Colômbia', 0, 50, 0, 600000, 1445000, 12250, 24, 15, 50, 74),
(99, 'Kerwin Vargas', 17, 23, 'PD', 70, 71, 61, 65, 65, 43, 75, 72, 1, 50, 'Colômbia', 1, 50, 0, 3500000, 12915000, 59250, 54, 15, 50, 74),
(100, 'Leozinho', 7, 27, 'PD', 71, 83, 64, 63, 72, 44, 66, 72, 0, 50, 'Brasil', 0, 50, 0, 3000000, 15325000, 55500, 36, 15, 85, 62),
(101, 'Kevin Viveros', 9, 25, 'ATA', 80, 71, 77, 89, 92, 43, 69, 82, 0, 50, 'Colômbia', 0, 50, 0, 20000000, 92245000, 308250, 30, 15, 85, 62),
(102, 'Jorge Rivaldo', 99, 22, 'ATA', 70, 69, 73, 64, 74, 41, 66, 73, 1, 50, 'Colômbia', 1, 50, 0, 2000000, 7575000, 28250, 54, 15, 15, 62),
(103, 'Renan Peixoto', 19, 25, 'ATA', 71, 63, 69, 80, 80, 41, 65, 73, 1, 50, 'Brasil', 0, 50, 0, 1500000, 4970000, 20250, 26, 15, 15, 62),
(104, 'Renan Viana', 29, 22, 'ATA', 59, 61, 67, 61, 66, 20, 44, 63, 2, 50, 'Brasil', 0, 50, 0, 225000, 750000, 3500, 24, 15, 50, 48),
(105, 'Gabriel Delfim', 1, 23, 'GOL', 71, 40, 72, 72, 16, 58, 57, 74, 0, 50, 'Brasil', 0, 50, 0, 3000000, 14580000, 41750, 48, 5, 50, 58),
(106, 'Everson', 12, 35, 'GOL', 68, 38, 68, 77, 8, 54, 55, 68, 1, 50, 'Brasil', 0, 50, 0, 900000, 1870000, 23750, 24, 5, 50, 48),
(107, 'Pedro Cobra', 40, 19, 'GOL', 64, 36, 58, 59, 10, 48, 55, 76, 2, 50, 'Brasil', 1, 50, 0, 600000, 3030000, 6250, 60, 5, 50, 48),
(108, 'Robert', 41, 20, 'GOL', 57, 28, 47, 63, 9, 46, 53, 65, 2, 50, 'Brasil', 1, 50, 0, 100000, 415000, 2500, 48, 5, 50, 48),
(109, 'Lyanco', 4, 28, 'ZAG', 74, 69, 81, 68, 43, 86, 62, 75, 0, 50, 'Brasil', 0, 50, 0, 4500000, 20270000, 69000, 48, 5, 50, 58),
(110, 'Ruan', 3, 26, 'ZAG', 75, 70, 84, 74, 51, 80, 69, 76, 0, 50, 'Brasil', 0, 50, 0, 4000000, 17525000, 71000, 54, 5, 50, 58),
(111, 'Léo Duarte', 13, 29, 'ZAG', 73, 60, 83, 75, 46, 84, 67, 73, 1, 50, 'Brasil', 0, 50, 0, 2000000, 5665000, 32250, 60, 5, 50, 48),
(112, 'Vitão', 33, 17, 'ZAG', 68, 67, 75, 68, 35, 71, 60, 77, 2, 50, 'Brasil', 1, 50, 0, 1500000, 7900000, 16750, 36, 5, 50, 48),
(113, 'Vitor Hugo', 14, 34, 'ZAG', 69, 59, 74, 68, 44, 80, 54, 69, 1, 50, 'Brasil', 0, 50, 0, 500000, 715000, 11000, 36, 5, 50, 58),
(114, 'Renan Lodi', 6, 27, 'LE', 78, 85, 71, 76, 55, 80, 73, 79, 0, 50, 'Brasil', 0, 50, 0, 11000000, 51040000, 174000, 60, 5, 50, 48),
(115, 'Kauã Pascini', 16, 17, 'LE', 66, 78, 55, 57, 55, 69, 63, 75, 1, 50, 'Brasil', 1, 50, 0, 2500000, 16505000, 24250, 60, 5, 50, 48),
(116, 'Natanael', 2, 23, 'LD', 73, 76, 60, 66, 58, 76, 82, 78, 0, 50, 'Brasil', 0, 50, 0, 4500000, 10925000, 71500, 36, 5, 20, 25),
(117, 'Angelo Preciado', 23, 27, 'LD', 73, 67, 62, 83, 58, 74, 76, 74, 1, 50, 'Equador', 1, 50, 0, 3500000, 10320000, 54000, 48, 5, 50, 12),
(118, 'Alexsander', 5, 22, 'VOL', 73, 73, 80, 78, 47, 81, 71, 78, 0, 50, 'Brasil', 0, 50, 0, 5000000, 18900000, 64250, 48, 5, 80, 25),
(119, 'Kevin Castaño', 15, 25, 'VOL', 73, 65, 80, 78, 55, 82, 75, 75, 1, 50, 'Colômbia', 1, 50, 0, 5000000, 15530000, 60000, 18, 5, 50, 12),
(120, 'Tomás Pérez', 17, 20, 'VOL', 69, 72, 69, 64, 40, 71, 67, 74, 2, 50, 'Argentina', 1, 50, 0, 3000000, 6855000, 38500, 12, 5, 50, 12),
(121, 'Victor Hugo', 8, 21, 'MC', 74, 75, 71, 73, 69, 84, 78, 79, 0, 50, 'Brasil', 0, 50, 0, 8000000, 36020000, 126000, 60, 5, 50, 12),
(122, 'Fred', 18, 32, 'MC', 74, 77, 73, 86, 71, 62, 71, 74, 1, 50, 'Brasil', 0, 50, 0, 4500000, 19425000, 85500, 48, 5, 80, 25),
(123, 'Alan Franco', 28, 27, 'MC', 73, 74, 77, 73, 59, 71, 69, 74, 2, 50, 'Equador', 0, 50, 0, 4500000, 13355000, 49250, 24, 5, 50, 12),
(124, 'Mamady Cissé', 22, 18, 'MC', 68, 68, 67, 69, 54, 70, 72, 80, 2, 50, 'Guiné', 1, 50, 0, 2500000, 18705000, 30500, 60, 5, 50, 90),
(125, 'Maycon', 38, 28, 'MC', 73, 67, 67, 85, 68, 74, 79, 73, 2, 50, 'Brasil', 1, 50, 0, 2000000, 7775000, 33250, 36, 5, 50, 90),
(126, 'Índio', 24, 17, 'MC', 54, 56, 54, 54, 37, 48, 61, 68, 2, 50, 'Brasil', 1, 50, 0, 100000, 250000, 2500, 12, 5, 50, 90),
(127, 'Gustavo Scarpa', 10, 31, 'MEI', 77, 67, 65, 85, 69, 50, 85, 77, 0, 50, 'Brasil', 0, 50, 0, 4500000, 11455000, 81250, 24, 5, 50, 90),
(128, 'Reinier', 30, 23, 'MEI', 72, 73, 63, 80, 70, 46, 72, 75, 2, 50, 'Brasil', 1, 50, 0, 4000000, 16610000, 52000, 48, 5, 50, 74),
(129, 'Igor Gomes', 20, 26, 'MEI', 74, 67, 61, 86, 71, 47, 82, 75, 1, 50, 'Brasil', 0, 50, 0, 2500000, 4405000, 41750, 12, 5, 85, 62),
(130, 'Tomás Cuello', 11, 25, 'PE', 73, 85, 58, 64, 72, 52, 71, 75, 0, 50, 'Argentina', 0, 50, 0, 8000000, 30900000, 98000, 36, 5, 50, 74),
(131, 'Dudu', 21, 33, 'PE', 70, 75, 64, 70, 63, 43, 68, 70, 1, 50, 'Brasil', 0, 50, 0, 800000, 1775000, 19000, 24, 5, 50, 74),
(132, 'Bernard', 31, 33, 'PE', 67, 68, 59, 61, 67, 37, 59, 67, 2, 50, 'Brasil', 1, 50, 0, 600000, 990000, 10500, 24, 5, 50, 74),
(133, 'Alan Minda', 7, 22, 'PD', 73, 85, 77, 68, 73, 51, 66, 79, 0, 50, 'Equador', 0, 50, 0, 6000000, 39345000, 81500, 60, 5, 85, 62),
(134, 'Mateo Cassierra', 9, 28, 'ATA', 76, 84, 80, 76, 67, 40, 67, 77, 0, 50, 'Colômbia', 0, 50, 0, 8000000, 37850000, 139750, 48, 5, 50, 74),
(135, 'Thiago Borbas', 19, 23, 'ATA', 70, 73, 79, 72, 72, 41, 62, 73, 1, 50, 'Uruguai', 1, 50, 0, 3500000, 6555000, 60250, 12, 5, 15, 62),
(136, 'Cauã Soares', 99, 17, 'ATA', 66, 62, 73, 59, 65, 29, 49, 75, 1, 50, 'Brasil', 1, 50, 0, 1500000, 8370000, 13750, 24, 5, 15, 62),
(137, 'Ivan', 1, 28, 'GOL', 66, 41, 60, 71, 13, 54, 64, 66, 0, 50, 'Brasil', 0, 50, 0, 700000, 1745000, 7750, 12, 20, 15, 62),
(138, 'Marcelo Rangel', 12, 37, 'GOL', 59, 25, 56, 62, 8, 50, 42, 59, 1, 50, 'Brasil', 0, 50, 0, 50000, 100000, 2500, 12, 20, 85, 62),
(139, 'Ygor Vinhas', 22, 31, 'GOL', 56, 25, 51, 61, 8, 45, 46, 56, 2, 50, 'Brasil', 0, 50, 0, 50000, 100000, 2500, 12, 20, 50, 58),
(140, 'Zé Ivaldo', 3, 28, 'ZAG', 69, 72, 75, 67, 36, 81, 61, 69, 0, 50, 'Brasil', 0, 50, 0, 1500000, 2900000, 16750, 12, 20, 50, 58),
(141, 'Tchamba', 13, 27, 'ZAG', 66, 47, 67, 64, 41, 78, 62, 67, 1, 50, 'Camarões', 0, 50, 0, 1000000, 1610000, 12500, 12, 20, 50, 48),
(142, 'Matheus Felipe', 4, 27, 'ZAG', 67, 60, 77, 68, 28, 76, 61, 68, 0, 50, 'Brasil', 0, 50, 0, 650000, 2065000, 9500, 24, 20, 50, 48),
(143, 'Léo Andrade', 34, 27, 'ZAG', 62, 60, 65, 60, 38, 67, 54, 63, 2, 50, 'Brasil', 1, 50, 0, 350000, 500000, 4000, 12, 20, 50, 58),
(144, 'Marllon', 33, 33, 'ZAG', 63, 53, 63, 73, 46, 66, 57, 63, 2, 50, 'Brasil', 1, 50, 0, 350000, 405000, 5250, 12, 20, 50, 58),
(145, 'Cristian Tassano', 14, 29, 'ZAG', 65, 56, 77, 69, 52, 68, 57, 65, 1, 50, 'Uruguai', 0, 50, 0, 350000, 555000, 6500, 12, 20, 50, 48),
(146, 'Mayk', 6, 26, 'LE', 62, 71, 60, 60, 58, 57, 59, 63, 0, 50, 'Brasil', 0, 50, 0, 400000, 1410000, 5500, 24, 20, 50, 48),
(147, 'Marlon', 16, 31, 'LE', 61, 61, 50, 59, 46, 53, 55, 61, 1, 50, 'Brasil', 0, 50, 0, 300000, 850000, 4500, 12, 20, 50, 48),
(148, 'Edson Kauã', 26, 21, 'LE', 59, 68, 55, 60, 42, 58, 52, 65, 2, 50, 'Brasil', 0, 50, 0, 100000, 190000, 2500, 12, 20, 50, 48),
(149, 'João Lucas', 2, 27, 'LD', 69, 73, 58, 72, 57, 69, 67, 70, 0, 50, 'Brasil', 0, 50, 0, 1000000, 1760000, 9500, 12, 20, 50, 48),
(150, 'Matheus Alexandre', 23, 26, 'LD', 69, 81, 61, 69, 53, 75, 61, 70, 1, 50, 'Brasil', 0, 50, 0, 700000, 1435000, 7250, 12, 20, 20, 25),
(151, 'Marcelinho', 27, 27, 'LD', 65, 67, 56, 63, 55, 65, 69, 66, 2, 50, 'Brasil', 0, 50, 0, 600000, 1305000, 7750, 12, 20, 80, 25),
(152, 'Leonel Picco', 5, 27, 'VOL', 74, 60, 80, 76, 64, 80, 77, 75, 0, 50, 'Argentina', 0, 50, 0, 2500000, 11735000, 18250, 36, 20, 20, 25),
(153, 'Zé Welison', 15, 30, 'VOL', 70, 57, 73, 66, 57, 78, 74, 70, 1, 50, 'Brasil', 0, 50, 0, 1000000, 2420000, 9500, 12, 20, 80, 25),
(154, 'David Braga', 35, 24, 'VOL', 64, 52, 73, 60, 55, 76, 64, 67, 2, 50, 'Brasil', 1, 50, 0, 650000, 2410000, 7250, 24, 20, 50, 12),
(155, 'Zé Ricardo', 25, 26, 'VOL', 65, 54, 64, 68, 57, 65, 64, 66, 2, 50, 'Brasil', 0, 50, 0, 500000, 990000, 5500, 12, 20, 50, 12),
(156, 'Edson Fernando', 28, 27, 'VOL', 62, 63, 63, 62, 45, 71, 52, 63, 2, 50, 'Brasil', 1, 50, 0, 400000, 715000, 5250, 12, 20, 50, 90),
(157, 'Patrick', 8, 33, 'MC', 68, 63, 75, 70, 63, 70, 64, 68, 0, 50, 'Brasil', 0, 50, 0, 400000, 755000, 9000, 12, 20, 50, 90),
(158, 'Franco Catarozzi', 18, 25, 'MC', 63, 53, 54, 61, 58, 62, 62, 65, 1, 50, 'Uruguai', 0, 50, 0, 350000, 1085000, 3250, 12, 20, 50, 90),
(159, 'Vitor Bueno', 10, 31, 'MEI', 72, 68, 66, 77, 69, 47, 73, 72, 0, 50, 'Brasil', 0, 50, 0, 1000000, 5125000, 15750, 24, 20, 15, 62),
(160, 'Jajá', 11, 27, 'PE', 70, 82, 62, 66, 75, 44, 64, 71, 0, 50, 'Brasil', 0, 50, 0, 1500000, 5240000, 15000, 36, 20, 85, 62),
(161, 'Jáderson', 21, 25, 'PE', 68, 80, 69, 64, 64, 47, 69, 70, 1, 50, 'Brasil', 0, 50, 0, 600000, 2120000, 8000, 24, 20, 50, 74),
(162, 'Alef Manga', 31, 31, 'PE', 68, 77, 65, 73, 66, 48, 68, 68, 2, 50, 'Brasil', 1, 50, 0, 600000, 1100000, 7000, 12, 20, 50, 74),
(163, 'Antonio Galeano', 7, 25, 'PD', 72, 82, 56, 67, 72, 42, 67, 74, 0, 50, 'Paraguai', 0, 50, 0, 3000000, 17350000, 31750, 48, 20, 50, 74),
(164, 'Yago Pikachu', 17, 33, 'PD', 66, 72, 62, 65, 54, 39, 54, 66, 1, 50, 'Brasil', 0, 50, 0, 500000, 770000, 8250, 12, 20, 50, 74),
(165, 'Tico', 37, 19, 'PD', 54, 64, 40, 50, 49, 28, 51, 61, 2, 50, 'Brasil', 1, 50, 0, 100000, 370000, 2500, 36, 20, 15, 62),
(166, 'Gabriel Taliari', 9, 28, 'ATA', 68, 57, 67, 68, 74, 39, 58, 69, 0, 50, 'Brasil', 0, 50, 0, 1500000, 5845000, 17500, 36, 20, 50, 74),
(167, 'Gabriel Poveda', 19, 27, 'ATA', 62, 67, 70, 67, 61, 24, 57, 63, 1, 50, 'Brasil', 0, 50, 0, 400000, 1145000, 5250, 12, 20, 50, 74),
(168, 'Eduardo Melo', 99, 24, 'ATA', 56, 50, 54, 66, 68, 27, 50, 58, 1, 50, 'Brasil', 0, 50, 0, 75000, 165000, 2500, 12, 20, 85, 62),
(169, 'Hugo Souza', 1, 26, 'GOL', 76, 55, 79, 65, 23, 62, 58, 77, 0, 50, 'Brasil', 0, 50, 0, 12000000, 61215000, 202500, 60, 4, 85, 62),
(170, 'Kauê', 12, 21, 'GOL', 67, 39, 62, 71, 14, 46, 52, 75, 1, 50, 'Brasil', 1, 50, 0, 1000000, 5330000, 17500, 48, 4, 50, 58),
(171, 'Felipe Longo', 31, 20, 'GOL', 62, 31, 62, 66, 13, 51, 48, 72, 2, 50, 'Brasil', 1, 50, 0, 500000, 1760000, 8250, 38, 4, 50, 48),
(172, 'João Pedro Tchoca', 3, 22, 'ZAG', 73, 74, 81, 76, 33, 85, 60, 77, 0, 50, 'Brasil', 0, 50, 0, 4000000, 21500000, 61500, 60, 4, 50, 58),
(173, 'Iago Machado', 4, 16, 'ZAG', 69, 60, 60, 69, 40, 81, 58, 83, 0, 50, 'Brasil', 0, 50, 0, 3000000, 16345000, 33250, 27, 4, 50, 48),
(174, 'André Ramalho', 13, 33, 'ZAG', 69, 48, 77, 70, 45, 69, 65, 69, 1, 50, 'Brasil', 0, 50, 0, 600000, 660000, 12750, 12, 4, 50, 48),
(175, 'Gustavo Henrique', 14, 32, 'ZAG', 69, 52, 76, 69, 36, 65, 55, 69, 1, 50, 'Brasil', 0, 50, 0, 600000, 1855000, 17750, 24, 4, 50, 48),
(176, 'Gabriel Paulista', 33, 35, 'ZAG', 69, 58, 81, 68, 36, 75, 59, 69, 2, 50, 'Brasil', 1, 50, 0, 500000, 635000, 11500, 24, 4, 50, 58),
(177, 'Renato Santos', 34, 21, 'ZAG', 57, 44, 61, 58, 39, 58, 44, 62, 2, 50, 'Brasil', 1, 50, 0, 100000, 345000, 2500, 19, 4, 50, 58),
(178, 'Matheus Bidu', 6, 26, 'LE', 75, 74, 70, 75, 53, 74, 72, 76, 0, 50, 'Brasil', 0, 50, 0, 8000000, 27310000, 123250, 24, 4, 50, 48),
(179, 'Hugo', 26, 28, 'LE', 65, 67, 50, 69, 55, 59, 66, 66, 2, 50, 'Brasil', 1, 50, 0, 700000, 1305000, 12000, 12, 4, 50, 48),
(180, 'Fabrizio Angileri', 16, 31, 'LE', 67, 67, 57, 70, 49, 66, 67, 67, 1, 50, 'Argentina', 0, 50, 0, 400000, 810000, 9750, 12, 4, 50, 12),
(181, 'Matheuzinho', 2, 25, 'LD', 79, 78, 71, 75, 64, 81, 74, 80, 0, 50, 'Brasil', 0, 50, 0, 10000000, 56635000, 141000, 36, 4, 50, 12),
(182, 'Pedro Milans', 23, 23, 'LD', 68, 79, 70, 56, 50, 66, 63, 73, 1, 50, 'Uruguai', 0, 50, 0, 1500000, 5935000, 25250, 48, 4, 80, 25),
(183, 'Léo Mana', 27, 21, 'LD', 62, 65, 49, 63, 53, 55, 62, 69, 2, 50, 'Brasil', 1, 50, 0, 500000, 3670000, 6500, 48, 4, 20, 25),
(184, 'Raniele', 5, 29, 'VOL', 74, 70, 73, 72, 50, 81, 71, 74, 0, 50, 'Brasil', 0, 50, 0, 4000000, 14480000, 65500, 36, 4, 50, 12),
(185, 'Allan', 15, 28, 'VOL', 74, 73, 82, 75, 59, 79, 67, 75, 1, 50, 'Brasil', 0, 50, 0, 2000000, 4220000, 34750, 12, 4, 80, 25),
(186, 'Charles', 25, 29, 'VOL', 69, 59, 73, 74, 56, 66, 70, 69, 2, 50, 'Brasil', 1, 50, 0, 750000, 2600000, 16000, 36, 4, 20, 25),
(187, 'Breno Bidon', 8, 20, 'MC', 79, 76, 71, 79, 74, 68, 88, 84, 0, 50, 'Brasil', 0, 50, 0, 25000000, 125770000, 379250, 48, 4, 80, 25),
(188, 'André', 18, 19, 'MC', 76, 82, 75, 79, 70, 84, 68, 86, 1, 50, 'Brasil', 1, 50, 0, 16000000, 76580000, 128750, 48, 4, 50, 12),
(189, 'Matheus Pereira', 38, 27, 'MC', 66, 60, 72, 70, 64, 60, 72, 67, 2, 50, 'Brasil', 0, 50, 0, 1500000, 2920000, 25000, 12, 4, 20, 25),
(190, 'Alex Santana', 22, 30, 'MC', 66, 60, 68, 73, 58, 69, 75, 66, 2, 50, 'Brasil', 1, 50, 0, 1000000, 4495000, 19000, 24, 4, 50, 48),
(191, 'André Carrillo', 28, 34, 'MC', 69, 58, 59, 78, 62, 72, 73, 69, 2, 50, 'Peru', 0, 50, 0, 800000, 945000, 17000, 12, 4, 50, 90),
(192, 'Bahia', 24, 19, 'MC', 57, 51, 51, 58, 52, 52, 58, 64, 2, 50, 'Brasil', 1, 50, 0, 100000, 430000, 2500, 21, 4, 50, 90),
(193, 'Rodrigo Garro', 10, 27, 'MEI', 79, 79, 76, 83, 82, 61, 83, 80, 0, 50, 'Argentina', 0, 50, 0, 12000000, 64440000, 192750, 36, 4, 50, 90),
(194, 'Jesse Lingard', 20, 33, 'MEI', 75, 73, 60, 79, 64, 60, 79, 75, 1, 50, 'Inglaterra', 0, 50, 0, 1500000, 1660000, 29250, 12, 4, 50, 74),
(195, 'Zakaria Labyad', 30, 32, 'MEI', 64, 54, 51, 73, 66, 47, 75, 64, 2, 50, 'Marrocos', 0, 50, 0, 400000, 1480000, 5750, 24, 4, 50, 74),
(196, 'Kayke', 21, 21, 'PE', 66, 75, 55, 60, 71, 38, 61, 72, 1, 50, 'Brasil', 1, 50, 0, 1500000, 6180000, 21250, 18, 4, 85, 62),
(197, 'Vitinho', 11, 32, 'PE', 67, 72, 51, 67, 68, 41, 67, 67, 0, 50, 'Brasil', 0, 50, 0, 700000, 1655000, 14750, 12, 4, 15, 62),
(198, 'Kaio César', 7, 21, 'PD', 74, 86, 62, 73, 80, 52, 68, 81, 0, 50, 'Brasil', 0, 50, 0, 5000000, 16265000, 66500, 12, 4, 50, 74),
(199, 'Dieguinho', 17, 18, 'PD', 70, 78, 59, 67, 72, 44, 67, 78, 1, 50, 'Brasil', 1, 50, 0, 5000000, 20070000, 46250, 48, 4, 50, 74),
(200, 'Yuri Alberto', 9, 24, 'ATA', 81, 75, 82, 80, 93, 51, 72, 84, 0, 50, 'Brasil', 0, 50, 0, 23000000, 132495000, 318250, 54, 4, 85, 62),
(201, 'Memphis Depay', 19, 31, 'ATA', 78, 73, 75, 81, 90, 44, 64, 78, 1, 50, 'Holanda', 0, 50, 0, 6000000, 18225000, 102000, 30, 4, 50, 74),
(202, 'Gui Negão', 99, 18, 'ATA', 73, 73, 75, 74, 77, 40, 66, 87, 1, 50, 'Brasil', 0, 50, 0, 6000000, 31340000, 81000, 54, 4, 15, 62),
(203, 'Pedro Raul', 29, 29, 'ATA', 68, 65, 71, 69, 67, 27, 66, 68, 2, 50, 'Brasil', 1, 50, 0, 1500000, 3275000, 21000, 36, 4, 15, 62),
(204, 'Pedro Morisco', 1, 21, 'GOL', 75, 58, 73, 76, 21, 57, 68, 81, 0, 50, 'Brasil', 0, 50, 0, 9000000, 46810000, 104500, 24, 17, 85, 62),
(205, 'Pedro Rangel', 12, 25, 'GOL', 67, 42, 68, 63, 13, 53, 54, 68, 1, 50, 'Brasil', 0, 50, 0, 1000000, 2950000, 17250, 36, 17, 50, 58),
(206, 'Keiller', 22, 29, 'GOL', 63, 38, 58, 66, 9, 50, 47, 63, 2, 50, 'Brasil', 0, 50, 0, 500000, 940000, 6000, 12, 17, 50, 48),
(207, 'Benassi', 30, 22, 'GOL', 54, 37, 60, 52, 8, 48, 34, 60, 2, 50, 'Brasil', 1, 50, 0, 50000, 210000, 2500, 24, 17, 50, 58),
(208, 'Jacy', 3, 28, 'ZAG', 70, 57, 64, 80, 42, 66, 75, 70, 0, 50, 'Brasil', 0, 50, 0, 3000000, 13305000, 38500, 36, 17, 50, 48),
(209, 'Tiago Cóser', 4, 21, 'ZAG', 67, 63, 70, 66, 42, 63, 53, 74, 0, 50, 'Brasil', 0, 50, 0, 1500000, 7530000, 18250, 24, 17, 50, 58),
(210, 'Maicon', 13, 37, 'ZAG', 64, 38, 61, 71, 42, 63, 66, 64, 1, 50, 'Brasil', 0, 50, 0, 100000, 110000, 2500, 12, 17, 80, 25),
(211, 'Rodrigo Moledo', 33, 38, 'ZAG', 59, 50, 65, 68, 36, 71, 44, 59, 2, 50, 'Brasil', 1, 50, 0, 100000, 120000, 2500, 12, 17, 50, 48),
(212, 'Thiago Santos', 14, 36, 'ZAG', 61, 41, 64, 60, 33, 73, 46, 61, 1, 50, 'Brasil', 0, 50, 0, 100000, 100000, 2500, 12, 17, 50, 58),
(213, 'Felipe Jonatan', 6, 27, 'LE', 69, 74, 53, 70, 55, 61, 66, 70, 0, 50, 'Brasil', 0, 50, 0, 2000000, 7500000, 29000, 24, 17, 50, 48),
(214, 'Rodrigo Gelado', 26, 22, 'LE', 60, 69, 54, 54, 38, 50, 52, 65, 2, 50, 'Brasil', 1, 50, 0, 300000, 865000, 3750, 24, 17, 50, 58),
(215, 'Bruno Melo', 16, 33, 'LE', 64, 63, 55, 65, 63, 60, 64, 64, 1, 50, 'Brasil', 0, 50, 0, 250000, 320000, 4500, 12, 17, 80, 25),
(216, 'Fabricio Bustos', 2, 29, 'LD', 71, 68, 54, 72, 57, 69, 66, 71, 0, 50, 'Argentina', 0, 50, 0, 1800000, 3950000, 34000, 12, 17, 50, 12),
(217, 'Lucas Taverna', 27, 18, 'LD', 61, 67, 48, 52, 43, 57, 59, 75, 2, 50, 'Brasil', 1, 50, 0, 500000, 3315000, 5250, 36, 17, 50, 12),
(218, 'Tinga', 23, 32, 'LD', 66, 70, 59, 67, 48, 62, 64, 66, 1, 50, 'Brasil', 0, 50, 0, 450000, 790000, 8250, 12, 17, 20, 25),
(219, 'Nicolás Fonseca', 5, 27, 'VOL', 72, 67, 79, 70, 58, 75, 69, 73, 0, 50, 'Uruguai', 0, 50, 0, 3000000, 15355000, 46750, 20, 17, 20, 25),
(220, 'Tissi', 25, 18, 'VOL', 62, 56, 62, 59, 43, 60, 62, 74, 1, 50, 'Brasil', 1, 50, 0, 600000, 3005000, 5750, 45, 17, 80, 25),
(221, 'Richard', 15, 31, 'VOL', 65, 53, 61, 64, 52, 74, 72, 65, 1, 50, 'Brasil', 1, 50, 0, 500000, 880000, 9000, 12, 17, 50, 12),
(222, 'Sebastián Gómez', 8, 29, 'MC', 72, 67, 64, 76, 70, 63, 83, 72, 0, 50, 'Colômbia', 0, 50, 0, 1800000, 7050000, 27750, 36, 17, 20, 25),
(223, 'Vini Paulista', 18, 24, 'MC', 64, 65, 64, 64, 51, 58, 58, 66, 1, 50, 'Brasil', 1, 50, 0, 400000, 885000, 4750, 24, 17, 50, 90),
(224, 'Gustavo', 10, 23, 'MEI', 65, 69, 56, 69, 59, 46, 65, 70, 0, 50, 'Brasil', 0, 50, 0, 500000, 1545000, 7500, 36, 17, 50, 90),
(225, 'Josué', 20, 35, 'MEI', 65, 49, 55, 77, 60, 47, 76, 65, 1, 50, 'Portugal', 0, 50, 0, 350000, 410000, 5750, 12, 17, 50, 90),
(226, 'Joaquín Lavega', 21, 20, 'PE', 73, 78, 61, 71, 73, 41, 72, 79, 1, 50, 'Uruguai', 1, 50, 0, 6000000, 14650000, 63250, 12, 17, 50, 90),
(227, 'Breno Lopes', 11, 29, 'PE', 74, 86, 71, 72, 68, 42, 70, 74, 0, 50, 'Brasil', 0, 50, 0, 3000000, 14555000, 41500, 48, 17, 15, 62),
(228, 'Brian Ocampo', 51, 26, 'PE', 65, 77, 48, 65, 71, 31, 59, 66, 2, 50, 'Uruguai', 0, 50, 0, 1000000, 3025000, 13000, 42, 17, 80, 25),
(229, 'Keno', 31, 36, 'PE', 67, 73, 58, 64, 65, 36, 59, 67, 2, 50, 'Brasil', 0, 50, 0, 300000, 310000, 6000, 12, 17, 50, 74),
(230, 'Lucas Ronier', 7, 21, 'PD', 75, 82, 64, 73, 87, 46, 77, 82, 0, 50, 'Brasil', 0, 50, 0, 6000000, 31205000, 73750, 24, 17, 50, 74),
(231, 'Fabinho', 17, 26, 'PD', 70, 69, 57, 74, 74, 43, 68, 71, 1, 50, 'Brasil', 0, 50, 0, 1000000, 3785000, 11750, 24, 17, 50, 74),
(232, 'Paulo Roberto', 19, 20, 'ATA', 65, 57, 64, 70, 72, 38, 60, 74, 1, 50, 'Brasil', 1, 50, 0, 1500000, 6990000, 19000, 24, 17, 15, 62),
(233, 'Pedro Rocha', 9, 31, 'ATA', 70, 63, 66, 69, 78, 38, 65, 70, 0, 50, 'Brasil', 0, 50, 0, 1500000, 5020000, 27500, 24, 17, 85, 62),
(234, 'Renato Marques', 99, 22, 'ATA', 64, 67, 67, 67, 76, 25, 58, 70, 1, 50, 'Brasil', 1, 50, 0, 1000000, 3235000, 13000, 12, 17, 15, 62),
(235, 'Rodrigo Rodrigues', 29, 29, 'ATA', 64, 61, 72, 67, 73, 33, 58, 64, 2, 50, 'Brasil', 0, 50, 0, 500000, 1310000, 7250, 18, 17, 85, 62),
(236, 'Éberth', 39, 22, 'ATA', 59, 56, 56, 61, 57, 34, 53, 64, 2, 50, 'Brasil', 1, 50, 0, 250000, 545000, 4000, 12, 17, 50, 74),
(237, 'Otávio', 1, 20, 'GOL', 74, 46, 75, 73, 16, 61, 60, 83, 0, 50, 'Brasil', 0, 50, 0, 10000000, 36495000, 146000, 72, 10, 50, 74),
(238, 'Léo Aragão', 12, 23, 'GOL', 66, 39, 62, 72, 12, 51, 58, 69, 1, 50, 'Brasil', 0, 50, 0, 800000, 1740000, 12000, 24, 10, 50, 58),
(239, 'Cássio', 22, 38, 'GOL', 65, 25, 63, 74, 15, 46, 57, 65, 2, 50, 'Brasil', 1, 50, 0, 250000, 610000, 6250, 17, 10, 50, 58),
(240, 'Jonathan Jesus', 3, 21, 'ZAG', 75, 64, 73, 72, 44, 77, 69, 81, 0, 50, 'Brasil', 0, 50, 0, 12000000, 44455000, 172750, 42, 10, 50, 58),
(241, 'Fabrício Bruno', 4, 29, 'ZAG', 75, 74, 80, 69, 43, 78, 63, 75, 0, 50, 'Brasil', 0, 50, 0, 10000000, 48955000, 200500, 60, 10, 50, 48),
(242, 'João Marcelo', 13, 25, 'ZAG', 73, 63, 81, 77, 55, 85, 64, 75, 1, 50, 'Brasil', 1, 50, 0, 3000000, 9760000, 54250, 36, 10, 50, 58),
(243, 'Lucas Villalba', 14, 31, 'ZAG', 72, 66, 71, 74, 46, 81, 66, 72, 1, 50, 'Argentina', 0, 50, 0, 1700000, 2920000, 29500, 12, 10, 50, 48),
(244, 'Gabriel Rojas', 6, 28, 'LE', 75, 73, 52, 82, 71, 81, 73, 75, 0, 50, 'Argentina', 0, 50, 0, 4000000, 16320000, 56000, 48, 10, 50, 58),
(245, 'Matías Viña', 16, 28, 'LE', 73, 85, 75, 62, 53, 67, 68, 73, 1, 50, 'Uruguai', 0, 50, 0, 2500000, 3970000, 48250, 12, 10, 80, 25),
(246, 'Kauã Moraes', 23, 19, 'LD', 66, 74, 48, 64, 51, 68, 60, 73, 1, 50, 'Brasil', 0, 50, 0, 3000000, 13110000, 33250, 56, 10, 50, 48),
(247, 'William', 2, 30, 'LD', 72, 73, 63, 71, 68, 71, 70, 72, 0, 50, 'Brasil', 0, 50, 0, 2500000, 4520000, 43250, 12, 10, 50, 48),
(248, 'Fagner', 32, 36, 'LD', 65, 67, 57, 69, 53, 52, 56, 65, 2, 50, 'Brasil', 0, 50, 0, 200000, 260000, 4250, 12, 10, 50, 12),
(249, 'Zé Lucas', 5, 17, 'VOL', 73, 68, 63, 75, 60, 77, 76, 82, 0, 50, 'Brasil', 0, 50, 0, 8000000, 64375000, 98500, 66, 10, 50, 12),
(250, 'Lucas Romero', 15, 31, 'VOL', 72, 68, 77, 76, 60, 84, 65, 72, 1, 50, 'Argentina', 0, 50, 0, 2500000, 7290000, 36500, 24, 10, 20, 25),
(251, 'Lucas Silva', 25, 32, 'VOL', 67, 54, 69, 73, 59, 76, 64, 67, 2, 50, 'Brasil', 0, 50, 0, 450000, 1700000, 10000, 24, 10, 20, 25),
(252, 'Gerson', 8, 28, 'MC', 80, 83, 87, 82, 75, 81, 78, 80, 0, 50, 'Brasil', 0, 50, 0, 18000000, 38420000, 244750, 60, 10, 50, 12),
(253, 'Matheus Henrique', 18, 28, 'MC', 77, 75, 80, 78, 65, 81, 76, 77, 1, 50, 'Brasil', 0, 50, 0, 6000000, 16815000, 80000, 42, 10, 80, 25),
(254, 'Fabrizio Peralta', 28, 23, 'MC', 66, 57, 67, 71, 66, 60, 70, 69, 2, 50, 'Paraguai', 1, 50, 0, 800000, 2340000, 11500, 42, 10, 80, 25),
(255, 'Matheus Pereira', 10, 29, 'MEI', 78, 74, 61, 84, 79, 66, 87, 78, 0, 50, 'Brasil', 0, 50, 0, 14000000, 59795000, 221750, 36, 10, 80, 25),
(256, 'Felipe Morais', 20, 17, 'MEI', 66, 63, 44, 67, 69, 42, 73, 74, 1, 50, 'Brasil', 1, 50, 0, 2000000, 8670000, 26250, 39, 10, 50, 90),
(257, 'Luis Sinisterra', 11, 26, 'PE', 78, 90, 67, 76, 76, 59, 67, 79, 0, 50, 'Colômbia', 0, 50, 0, 11000000, 38200000, 187000, 36, 10, 50, 90),
(258, 'Wesley', 21, 20, 'PE', 73, 85, 57, 61, 70, 55, 63, 83, 1, 50, 'Brasil', 0, 50, 0, 4000000, 15325000, 52000, 18, 10, 50, 90),
(259, 'Kaique Kenji', 31, 19, 'PE', 69, 81, 41, 66, 61, 48, 68, 81, 1, 50, 'Brasil', 0, 50, 0, 3000000, 10185000, 40750, 36, 10, 50, 90),
(260, 'Wanderson', 51, 31, 'PE', 72, 84, 57, 78, 79, 51, 66, 72, 2, 50, 'Brasil', 0, 50, 0, 3000000, 6865000, 69000, 24, 10, 15, 62),
(261, 'Bruno Rodrigues', 71, 28, 'PE', 69, 75, 54, 71, 73, 49, 74, 70, 2, 50, 'Brasil', 0, 50, 0, 1200000, 1640000, 23500, 12, 10, 85, 62),
(262, 'Keny Arroyo', 17, 19, 'PD', 76, 84, 64, 71, 70, 46, 74, 84, 1, 50, 'Equador', 1, 50, 0, 12000000, 81265000, 149750, 48, 10, 50, 74),
(263, 'Gabriel Pec', 7, 24, 'PD', 79, 88, 63, 73, 70, 58, 67, 83, 0, 50, 'Brasil', 0, 50, 0, 7000000, 28835000, 122250, 66, 10, 85, 62),
(264, 'Marquinhos', 37, 22, 'PD', 69, 74, 57, 72, 72, 44, 75, 75, 2, 50, 'Brasil', 1, 50, 0, 2500000, 10045000, 45000, 36, 10, 50, 74),
(265, 'João Costa', 27, 20, 'PD', 72, 79, 62, 70, 76, 48, 72, 78, 2, 50, 'Portugal', 1, 50, 0, 2500000, 11950000, 32000, 18, 10, 50, 74),
(266, 'Kaio Jorge', 9, 23, 'ATA', 81, 76, 85, 76, 93, 58, 74, 85, 0, 50, 'Brasil', 0, 50, 0, 25000000, 134185000, 464750, 60, 10, 85, 62),
(267, 'Luciano Rodríguez', 19, 22, 'ATA', 75, 82, 82, 68, 84, 42, 56, 80, 1, 50, 'Uruguai', 0, 50, 0, 9000000, 31445000, 110750, 18, 10, 15, 62),
(268, 'Néiser Villarreal', 99, 20, 'ATA', 71, 74, 67, 77, 74, 41, 55, 76, 1, 50, 'Colômbia', 0, 50, 0, 4000000, 13180000, 77250, 60, 10, 50, 74),
(269, 'Ronaldo', 1, 29, 'GOL', 71, 42, 74, 72, 25, 56, 56, 71, 0, 50, 'Brasil', 0, 50, 0, 2000000, 8370000, 42250, 48, 11, 50, 48),
(270, 'Guido Herrera', 12, 33, 'GOL', 70, 31, 63, 77, 8, 59, 62, 70, 1, 50, 'Argentina', 0, 50, 0, 1500000, 3140000, 27000, 24, 11, 50, 58),
(271, 'Léo Vieira', 22, 35, 'GOL', 62, 38, 69, 62, 8, 43, 48, 62, 2, 50, 'Brasil', 0, 50, 0, 200000, 200000, 5500, 12, 11, 50, 48),
(272, 'Victor', 40, 19, 'GOL', 54, 25, 44, 58, 8, 36, 37, 60, 2, 50, 'Brasil', 1, 50, 0, 100000, 200000, 2500, 12, 11, 50, 48),
(273, 'Kanu', 4, 28, 'ZAG', 69, 49, 68, 74, 46, 79, 63, 69, 0, 50, 'Brasil', 0, 50, 0, 2500000, 10860000, 54250, 24, 11, 50, 48),
(274, 'David Duarte', 3, 30, 'ZAG', 72, 61, 72, 78, 43, 77, 67, 72, 0, 50, 'Brasil', 0, 50, 0, 1500000, 8190000, 31250, 24, 11, 50, 58),
(275, 'Marco Moreno', 13, 24, 'ZAG', 66, 48, 71, 75, 38, 76, 69, 68, 1, 50, 'Espanha', 0, 50, 0, 900000, 4065000, 16750, 66, 11, 50, 58),
(276, 'Luiz Gustavo', 33, 19, 'ZAG', 64, 56, 62, 65, 36, 65, 54, 72, 2, 50, 'Brasil', 1, 50, 0, 600000, 3850000, 5250, 60, 11, 50, 58),
(277, 'Marcos Victor', 14, 24, 'ZAG', 66, 55, 76, 69, 37, 76, 55, 69, 1, 50, 'Brasil', 0, 50, 0, 450000, 1485000, 6750, 48, 11, 50, 48),
(278, 'Fredi Gomes', 34, 19, 'ZAG', 55, 40, 52, 51, 29, 65, 57, 65, 2, 50, 'Brasil', 1, 50, 0, 100000, 385000, 2500, 24, 11, 50, 58),
(279, 'Luciano Juba', 6, 26, 'LE', 76, 88, 78, 64, 54, 65, 62, 77, 0, 50, 'Brasil', 0, 50, 0, 16000000, 91690000, 189750, 48, 11, 50, 48),
(280, 'Zé Guilherme', 16, 20, 'LE', 59, 60, 46, 57, 49, 61, 68, 68, 1, 50, 'Brasil', 1, 50, 0, 400000, 1400000, 4750, 48, 11, 50, 12),
(281, 'Román Gómez', 2, 21, 'LD', 66, 65, 59, 65, 56, 55, 61, 74, 0, 50, 'Argentina', 0, 50, 0, 1500000, 6430000, 26250, 60, 11, 80, 25),
(282, 'Nicolás Acevedo', 15, 26, 'VOL', 74, 68, 81, 72, 61, 74, 76, 75, 1, 50, 'Uruguai', 0, 50, 0, 10000000, 30550000, 108250, 72, 11, 80, 25),
(283, 'Caio Alexandre', 5, 26, 'VOL', 77, 74, 89, 77, 55, 89, 69, 78, 0, 50, 'Brasil', 0, 50, 0, 7000000, 32980000, 114750, 36, 11, 20, 25),
(284, 'Erick', 25, 28, 'VOL', 72, 67, 73, 76, 52, 69, 65, 72, 2, 50, 'Brasil', 0, 50, 0, 5000000, 15140000, 60000, 48, 11, 50, 12),
(285, 'Lautaro López', 35, 20, 'VOL', 62, 60, 58, 67, 50, 63, 67, 68, 2, 50, 'Argentina', 1, 50, 0, 400000, 1130000, 7250, 12, 11, 50, 12),
(286, 'Jean Lucas', 8, 27, 'MC', 79, 74, 70, 82, 65, 83, 85, 80, 0, 50, 'Brasil', 0, 50, 0, 15000000, 68935000, 194500, 36, 11, 80, 25),
(287, 'Rodrigo Nestor', 18, 25, 'MC', 79, 80, 78, 82, 69, 81, 73, 81, 1, 50, 'Brasil', 0, 50, 0, 9000000, 28785000, 131250, 60, 11, 50, 90),
(288, 'Everton Ribeiro', 10, 36, 'MEI', 73, 56, 56, 85, 85, 41, 85, 73, 0, 50, 'Brasil', 0, 50, 0, 1000000, 1350000, 25250, 12, 11, 50, 90),
(289, 'David Martins', 20, 18, 'MEI', 65, 68, 52, 66, 61, 39, 72, 76, 1, 50, 'Brasil', 1, 50, 0, 1000000, 2830000, 9250, 12, 11, 50, 90),
(290, 'Roger Gabriel', 30, 18, 'MEI', 55, 47, 34, 52, 65, 28, 67, 63, 2, 50, 'Brasil', 1, 50, 0, 100000, 370000, 2500, 13, 11, 50, 90),
(291, 'Erick Pulga', 11, 25, 'PE', 77, 85, 69, 73, 83, 46, 80, 79, 0, 50, 'Brasil', 0, 50, 0, 13000000, 72035000, 183750, 48, 11, 50, 74),
(292, 'Ruan Pablo', 21, 17, 'PE', 74, 73, 58, 68, 78, 49, 68, 83, 1, 50, 'Brasil', 1, 50, 0, 8000000, 36935000, 84500, 60, 11, 85, 62),
(293, 'Mateo Sanabria', 31, 21, 'PE', 66, 78, 65, 62, 68, 47, 62, 73, 1, 50, 'Argentina', 0, 50, 0, 2000000, 9405000, 30250, 60, 11, 85, 62),
(294, 'Cristian Olivera', 7, 23, 'PD', 73, 85, 68, 70, 72, 42, 69, 76, 0, 50, 'Uruguai', 0, 50, 0, 5000000, 14735000, 81500, 12, 11, 15, 62),
(295, 'Kauê Furquim', 27, 16, 'PD', 69, 81, 57, 59, 71, 46, 58, 85, 1, 50, 'Brasil', 1, 50, 0, 3500000, 16970000, 33750, 36, 11, 85, 62),
(296, 'Michel Araújo', 37, 29, 'PD', 70, 73, 64, 69, 72, 41, 68, 70, 2, 50, 'Uruguai', 0, 50, 0, 2500000, 6960000, 30250, 36, 11, 50, 74),
(297, 'Ademir', 17, 30, 'PD', 71, 83, 69, 57, 62, 47, 63, 71, 1, 50, 'Brasil', 0, 50, 0, 1200000, 2105000, 23500, 12, 11, 15, 62),
(298, 'Alejo Veliz', 9, 22, 'ATA', 72, 65, 67, 81, 81, 36, 67, 77, 0, 50, 'Argentina', 0, 50, 0, 7000000, 47425000, 112250, 72, 11, 50, 74),
(299, 'Dell', 19, 17, 'ATA', 72, 69, 67, 68, 77, 44, 65, 87, 1, 50, 'Brasil', 0, 50, 0, 4000000, 21735000, 39000, 36, 11, 50, 74),
(300, 'Willian José', 99, 34, 'ATA', 70, 60, 63, 75, 70, 50, 60, 70, 1, 50, 'Brasil', 0, 50, 0, 1200000, 945000, 22500, 12, 11, 50, 74),
(301, 'Everaldo', 29, 34, 'ATA', 67, 53, 65, 70, 75, 38, 61, 67, 2, 50, 'Brasil', 1, 50, 0, 350000, 585000, 6500, 12, 11, 50, 74),
(302, 'Lucas Arcanjo', 1, 27, 'GOL', 72, 54, 79, 76, 25, 61, 57, 73, 0, 50, 'Brasil', 0, 50, 0, 4000000, 16720000, 45500, 36, 16, 50, 74),
(303, 'Fintelman', 12, 24, 'GOL', 58, 25, 58, 56, 8, 46, 49, 60, 1, 50, 'Brasil', 1, 50, 0, 100000, 430000, 2500, 24, 16, 50, 58),
(304, 'Yuri Sena', 22, 24, 'GOL', 58, 36, 63, 48, 8, 44, 48, 61, 2, 50, 'Brasil', 1, 50, 0, 100000, 205000, 2500, 12, 16, 50, 48),
(305, 'Riccieli', 13, 27, 'ZAG', 66, 53, 66, 69, 42, 76, 61, 67, 1, 50, 'Brasil', 0, 50, 0, 1800000, 3120000, 27750, 12, 16, 50, 48),
(306, 'Cacá', 3, 26, 'ZAG', 68, 65, 80, 64, 38, 78, 50, 69, 0, 50, 'Brasil', 0, 50, 0, 1500000, 2840000, 23000, 12, 16, 50, 58),
(307, 'Zé Marcos', 33, 27, 'ZAG', 65, 49, 67, 71, 43, 77, 68, 66, 2, 50, 'Brasil', 0, 50, 0, 1000000, 3130000, 16500, 24, 16, 50, 58),
(308, 'Edu Ribeiro', 14, 25, 'ZAG', 66, 59, 78, 70, 39, 66, 62, 68, 1, 50, 'Brasil', 0, 50, 0, 800000, 1630000, 13500, 36, 16, 50, 48),
(309, 'Emanuel Brítez', 4, 33, 'ZAG', 68, 57, 71, 76, 34, 75, 69, 68, 0, 50, 'Argentina', 0, 50, 0, 500000, 960000, 11250, 18, 16, 50, 48),
(310, 'Edenilson', 44, 20, 'ZAG', 62, 64, 74, 54, 29, 70, 43, 70, 2, 50, 'Brasil', 1, 50, 0, 500000, 2055000, 6250, 36, 16, 50, 12),
(311, 'Camutanga', 34, 32, 'ZAG', 63, 48, 60, 71, 37, 72, 63, 63, 2, 50, 'Brasil', 0, 50, 0, 250000, 465000, 4750, 12, 16, 20, 25),
(312, 'Darlan', 24, 22, 'ZAG', 56, 47, 68, 60, 29, 62, 52, 59, 2, 50, 'Brasil', 1, 50, 0, 100000, 200000, 2500, 12, 16, 50, 12),
(313, 'Luan Cândido', 6, 24, 'LE', 72, 76, 65, 72, 52, 65, 62, 74, 0, 50, 'Brasil', 0, 50, 0, 3000000, 6050000, 45500, 12, 16, 20, 25),
(314, 'Ramon', 16, 24, 'LE', 70, 78, 64, 81, 51, 67, 67, 73, 1, 50, 'Brasil', 0, 50, 0, 2000000, 5890000, 24500, 12, 16, 50, 12),
(315, 'Jamerson', 26, 27, 'LE', 69, 81, 73, 59, 54, 69, 61, 70, 2, 50, 'Brasil', 1, 50, 0, 800000, 1575000, 8750, 12, 16, 50, 12),
(316, 'Nathan Mendes', 23, 23, 'LD', 68, 74, 62, 67, 55, 76, 67, 71, 1, 50, 'Brasil', 1, 50, 0, 1500000, 3105000, 21750, 12, 16, 80, 25),
(317, 'Fabiano', 2, 25, 'LD', 70, 68, 54, 66, 54, 73, 68, 71, 0, 50, 'Brasil', 0, 50, 0, 1500000, 9375000, 21250, 18, 16, 80, 25),
(318, 'Mateus Silva', 27, 27, 'LD', 67, 77, 68, 67, 45, 64, 61, 68, 2, 50, 'Brasil', 1, 50, 0, 800000, 1770000, 10500, 36, 16, 50, 12),
(319, 'Baralhas', 15, 27, 'VOL', 69, 65, 63, 73, 59, 71, 73, 70, 1, 50, 'Brasil', 0, 50, 0, 2500000, 8015000, 34500, 36, 16, 50, 90),
(320, 'Walace', 5, 30, 'VOL', 71, 64, 76, 72, 63, 76, 65, 71, 0, 50, 'Brasil', 0, 50, 0, 2000000, 5165000, 22750, 12, 16, 50, 90),
(321, 'Rúben Ismael', 25, 26, 'VOL', 68, 55, 66, 66, 53, 69, 65, 69, 2, 50, 'Portugal', 1, 50, 0, 1200000, 4785000, 14500, 36, 16, 50, 90),
(322, 'Dudu', 18, 26, 'VOL', 62, 59, 61, 66, 47, 62, 63, 63, 2, 50, 'Brasil', 1, 50, 0, 600000, 1475000, 7500, 12, 16, 85, 62),
(323, 'Caíque Gonçalves', 35, 30, 'VOL', 66, 58, 65, 71, 50, 71, 74, 66, 2, 50, 'Brasil', 0, 50, 0, 500000, 1420000, 6500, 24, 16, 50, 74),
(324, 'Zé Vitor', 8, 25, 'MC', 64, 59, 62, 68, 60, 62, 69, 65, 0, 50, 'Brasil', 0, 50, 0, 750000, 2095000, 14000, 12, 16, 85, 62),
(325, 'Matheuzinho', 10, 28, 'MEI', 74, 78, 63, 81, 69, 47, 77, 74, 0, 50, 'Brasil', 0, 50, 0, 3000000, 15385000, 36250, 48, 16, 85, 62),
(326, 'Tomás Pochettino', 20, 29, 'MEI', 72, 81, 64, 78, 69, 47, 81, 72, 1, 50, 'Argentina', 0, 50, 0, 2500000, 3440000, 34000, 12, 16, 50, 74),
(327, 'Emmanuel Martínez', 30, 31, 'MEI', 68, 67, 61, 75, 68, 47, 78, 68, 2, 50, 'Argentina', 0, 50, 0, 1200000, 2960000, 19250, 24, 16, 50, 74),
(328, 'Renê', 11, 22, 'PE', 72, 80, 64, 69, 74, 45, 74, 76, 0, 50, 'Brasil', 0, 50, 0, 5000000, 28450000, 66000, 48, 16, 50, 74),
(329, 'Diego Tarzia', 21, 22, 'PE', 70, 65, 52, 74, 76, 30, 70, 75, 1, 50, 'Argentina', 1, 50, 0, 2500000, 7155000, 35000, 12, 16, 50, 74),
(330, 'Anderson Pato', 31, 23, 'PE', 62, 72, 54, 58, 60, 45, 52, 66, 2, 50, 'Brasil', 0, 50, 0, 250000, 755000, 3250, 24, 16, 15, 62),
(331, 'Erick', 7, 28, 'PD', 72, 84, 70, 70, 67, 43, 68, 72, 0, 50, 'Brasil', 0, 50, 0, 4000000, 17100000, 50250, 36, 16, 15, 62),
(332, 'Ignacio Laquintana', 37, 26, 'PD', 65, 67, 57, 64, 56, 43, 64, 66, 2, 50, 'Uruguai', 1, 50, 0, 1000000, 1515000, 11000, 12, 16, 15, 62),
(333, 'Lucas Silva', 17, 26, 'PD', 66, 69, 51, 70, 63, 41, 64, 67, 1, 50, 'Brasil', 0, 50, 0, 700000, 1035000, 13000, 12, 16, 50, 48),
(334, 'Marinho', 77, 35, 'PD', 63, 74, 49, 61, 62, 38, 60, 63, 2, 50, 'Brasil', 0, 50, 0, 200000, 205000, 3000, 12, 16, 50, 48),
(335, 'Osvaldo', 47, 38, 'PD', 59, 54, 47, 64, 55, 35, 60, 59, 2, 50, 'Brasil', 1, 50, 0, 75000, 90000, 2500, 12, 16, 50, 48),
(336, 'Renato Kayzer', 9, 29, 'ATA', 69, 68, 69, 76, 77, 40, 55, 69, 0, 50, 'Brasil', 0, 50, 0, 1000000, 3605000, 17250, 15, 16, 50, 58),
(337, 'Fabri', 19, 25, 'ATA', 67, 68, 65, 75, 67, 44, 46, 69, 1, 50, 'Brasil', 1, 50, 0, 900000, 2125000, 17000, 12, 16, 50, 58),
(338, 'Alex Bruno', 99, 26, 'ATA', 61, 63, 62, 61, 69, 33, 48, 62, 1, 50, 'Brasil', 0, 50, 0, 300000, 750000, 3500, 12, 16, 50, 58),
(339, 'Gabriel Brazão', 1, 25, 'GOL', 78, 58, 78, 77, 20, 72, 63, 80, 0, 50, 'Brasil', 0, 50, 0, 12000000, 54385000, 215500, 36, 13, 50, 48),
(340, 'João Paulo', 12, 30, 'GOL', 73, 45, 65, 81, 16, 65, 60, 73, 1, 50, 'Brasil', 0, 50, 0, 2000000, 4835000, 30250, 24, 13, 50, 48),
(341, 'Diógenes', 40, 24, 'GOL', 61, 31, 62, 62, 9, 45, 50, 64, 2, 50, 'Brasil', 0, 50, 0, 200000, 720000, 3000, 36, 13, 50, 58),
(342, 'João Fernandes', 41, 21, 'GOL', 57, 38, 57, 56, 8, 43, 37, 62, 2, 50, 'Brasil', 1, 50, 0, 100000, 285000, 2500, 36, 13, 50, 12),
(343, 'Rodrigo Falcão', 50, 20, 'GOL', 53, 38, 60, 50, 8, 41, 39, 60, 2, 50, 'Brasil', 1, 50, 0, 100000, 375000, 2500, 37, 13, 50, 12),
(344, 'João Ananias', 4, 18, 'ZAG', 71, 65, 72, 63, 38, 83, 68, 78, 0, 50, 'Brasil', 0, 50, 0, 5000000, 37475000, 52500, 54, 13, 50, 12),
(345, 'Lucas Veríssimo', 3, 30, 'ZAG', 76, 64, 71, 80, 47, 82, 66, 76, 0, 50, 'Brasil', 0, 50, 0, 4000000, 22280000, 69250, 36, 13, 80, 25),
(346, 'Alexis Duarte', 13, 25, 'ZAG', 70, 71, 79, 71, 43, 70, 61, 72, 1, 50, 'Paraguai', 1, 50, 0, 1800000, 4375000, 37750, 42, 13, 20, 25),
(347, 'Willian Arão', 33, 33, 'ZAG', 69, 51, 73, 69, 41, 72, 68, 69, 2, 50, 'Brasil', 0, 50, 0, 800000, 1280000, 16000, 24, 13, 20, 25),
(348, 'Luan Peres', 14, 31, 'ZAG', 70, 66, 80, 66, 47, 81, 58, 70, 1, 50, 'Brasil', 0, 50, 0, 700000, 1950000, 11750, 24, 13, 80, 25),
(349, 'João Alencar', 34, 18, 'ZAG', 55, 47, 55, 52, 26, 66, 44, 67, 2, 50, 'Brasil', 1, 50, 0, 100000, 495000, 2500, 54, 13, 50, 12),
(350, 'Vinicius Lira', 6, 18, 'LE', 70, 76, 63, 68, 47, 68, 64, 78, 0, 50, 'Brasil', 0, 50, 0, 4000000, 20600000, 39500, 15, 13, 80, 25),
(351, 'Gonzalo Escobar', 16, 28, 'LE', 67, 79, 57, 68, 41, 66, 64, 67, 1, 50, 'Argentina', 0, 50, 0, 800000, 2075000, 13750, 24, 13, 50, 90),
(352, 'Gabriel Menino', 2, 25, 'LD', 75, 81, 71, 74, 57, 74, 75, 77, 0, 50, 'Brasil', 0, 50, 0, 7000000, 20080000, 122000, 12, 13, 50, 90),
(353, 'Igor Vinícius', 32, 28, 'LD', 68, 74, 54, 75, 54, 67, 70, 68, 2, 50, 'Brasil', 1, 50, 0, 2000000, 5950000, 31250, 30, 13, 50, 90),
(354, 'Rodinei', 23, 33, 'LD', 73, 70, 63, 76, 52, 58, 76, 73, 1, 50, 'Brasil', 0, 50, 0, 800000, 1875000, 17250, 24, 13, 50, 74),
(355, 'Arthur Melo', 5, 29, 'VOL', 71, 63, 68, 76, 66, 75, 79, 71, 0, 50, 'Brasil', 0, 50, 0, 3500000, 7095000, 57750, 12, 13, 50, 74),
(356, 'Gustavinho', 17, 20, 'VOL', 68, 70, 62, 64, 54, 66, 65, 77, 1, 50, 'Brasil', 0, 50, 1, 2000000, 11295000, 27000, 36, 13, 15, 62),
(357, 'Christian Oliva', 15, 29, 'VOL', 69, 80, 79, 64, 48, 73, 65, 69, 1, 50, 'Uruguai', 0, 50, 0, 1400000, 4455000, 25500, 36, 13, 85, 62),
(358, 'João Schmidt', 25, 32, 'VOL', 67, 65, 77, 70, 55, 70, 60, 67, 2, 50, 'Brasil', 1, 50, 0, 700000, 2125000, 14750, 24, 13, 15, 62),
(359, 'Gabriel Bontempo', 8, 20, 'MC', 77, 76, 72, 81, 78, 74, 81, 86, 0, 50, 'Brasil', 0, 50, 0, 12000000, 56895000, 184250, 60, 13, 85, 62),
(360, 'Neymar', 10, 33, 'MEI', 80, 73, 65, 92, 82, 55, 85, 80, 0, 50, 'Brasil', 0, 50, 0, 8000000, 16585000, 144500, 12, 13, 85, 62),
(361, 'Miguelito', 20, 21, 'MEI', 75, 72, 68, 78, 70, 49, 84, 83, 1, 50, 'Bolívia', 1, 50, 0, 5000000, 19205000, 63500, 41, 13, 50, 74),
(362, 'Philippe Coutinho', 30, 33, 'MEI', 74, 68, 56, 86, 68, 46, 84, 74, 2, 50, 'Brasil', 0, 50, 0, 2500000, 2415000, 36000, 12, 13, 50, 74),
(363, 'Lima', 70, 29, 'MEI', 69, 70, 56, 80, 68, 49, 69, 69, 2, 50, 'Brasil', 0, 50, 0, 2000000, 3195000, 32000, 12, 13, 50, 58),
(364, 'Thaciano', 18, 30, 'MEI', 66, 55, 48, 76, 64, 41, 78, 66, 2, 50, 'Brasil', 0, 50, 0, 1000000, 3515000, 17000, 36, 13, 50, 58),
(365, 'Nadson', 22, 16, 'MEI', 63, 61, 42, 59, 62, 41, 70, 75, 2, 50, 'Brasil', 1, 50, 0, 1000000, 6030000, 9750, 24, 13, 50, 48),
(366, 'Pepê Fermino', 24, 18, 'MEI', 53, 45, 38, 53, 58, 32, 56, 64, 2, 50, 'Brasil', 1, 50, 0, 100000, 465000, 2500, 54, 13, 50, 58),
(367, 'Álvaro Barreal', 11, 25, 'PE', 77, 85, 73, 73, 79, 57, 71, 78, 0, 50, 'Argentina', 0, 50, 0, 7000000, 17685000, 97750, 36, 13, 80, 25),
(368, 'Everton', 21, 29, 'PE', 75, 87, 70, 69, 70, 51, 81, 75, 1, 50, 'Brasil', 0, 50, 0, 6000000, 10595000, 84500, 12, 13, 50, 48),
(369, 'Moisés', 31, 29, 'PE', 70, 82, 74, 66, 77, 41, 58, 70, 2, 50, 'Brasil', 0, 50, 0, 2000000, 7240000, 27750, 36, 13, 50, 48),
(370, 'Gustavo Caballero', 51, 24, 'PE', 68, 78, 65, 68, 68, 43, 64, 70, 2, 50, 'Paraguai', 1, 50, 0, 1000000, 3640000, 14000, 36, 13, 50, 48),
(371, 'Mateus Xavier', 71, 18, 'PE', 61, 67, 45, 50, 61, 39, 64, 71, 2, 50, 'Brasil', 1, 50, 0, 400000, 1145000, 5250, 36, 13, 50, 58),
(372, 'Benjamín Rollheiser', 7, 25, 'PD', 77, 89, 65, 73, 71, 51, 76, 79, 0, 50, 'Argentina', 0, 50, 0, 11000000, 38425000, 171000, 36, 13, 50, 58);
INSERT INTO `jogador` (`idJogador`, `nomeJogador`, `numeroCamisa`, `idade`, `posicao_principal`, `overall`, `velocidade`, `forca`, `inteligencia`, `finalizacao`, `marcacao`, `passe`, `potencial`, `titular`, `moral`, `nacionalidade`, `dispEmprestimo`, `satisfacao`, `onfire`, `valor`, `valorRescisao`, `salario`, `tempoContrato`, `clube_idClube`, `posicaoX`, `posicaoY`) VALUES
(373, 'Andrey Quintino', 27, 23, 'PD', 57, 61, 51, 55, 60, 36, 61, 60, 1, 50, 'Brasil', 1, 50, 0, 100000, 255000, 3000, 12, 13, 80, 25),
(374, 'Enzo Boer', 37, 20, 'PD', 54, 61, 43, 47, 59, 24, 54, 63, 2, 50, 'Brasil', 1, 50, 0, 100000, 475000, 2500, 12, 13, 20, 25),
(375, 'Gabriel Barbosa', 19, 29, 'ATA', 73, 81, 67, 75, 83, 37, 63, 73, 1, 50, 'Brasil', 0, 50, 0, 4000000, 8585000, 87000, 12, 13, 50, 12),
(376, 'Rony', 9, 30, 'ATA', 75, 75, 79, 82, 78, 39, 58, 75, 0, 50, 'Brasil', 0, 50, 0, 3000000, 13390000, 52500, 48, 13, 50, 12),
(377, 'Carlos Coronel', 1, 29, 'GOL', 67, 46, 64, 65, 16, 54, 54, 67, 0, 50, 'Paraguai', 0, 50, 0, 1500000, 3930000, 19750, 36, 3, 50, 12),
(378, 'Rafael', 12, 36, 'GOL', 64, 33, 66, 66, 18, 59, 52, 64, 1, 50, 'Brasil', 0, 50, 0, 300000, 665000, 6750, 24, 3, 20, 25),
(379, 'Young', 22, 23, 'GOL', 55, 25, 50, 60, 8, 42, 48, 59, 2, 50, 'Brasil', 1, 50, 0, 100000, 245000, 2500, 12, 3, 80, 25),
(380, 'João Pedro', 40, 19, 'GOL', 55, 31, 47, 50, 8, 39, 38, 64, 2, 50, 'Brasil', 1, 50, 0, 100000, 415000, 2500, 30, 3, 50, 90),
(381, 'Felipe Preis', 41, 20, 'GOL', 55, 41, 53, 46, 8, 43, 42, 60, 2, 50, 'Brasil', 1, 50, 0, 100000, 205000, 2500, 12, 3, 50, 90),
(382, 'Sabino', 4, 29, 'ZAG', 70, 62, 72, 69, 54, 68, 65, 70, 0, 50, 'Brasil', 0, 50, 0, 1000000, 3415000, 18250, 36, 3, 50, 90),
(383, 'Matheus Belém', 34, 22, 'ZAG', 64, 54, 68, 66, 44, 74, 52, 69, 2, 50, 'Brasil', 1, 50, 0, 800000, 1980000, 10250, 12, 3, 50, 74),
(384, 'Rafael Tolói', 3, 35, 'ZAG', 71, 64, 83, 73, 47, 78, 63, 71, 0, 50, 'Itália', 0, 50, 0, 800000, 1395000, 16000, 12, 3, 85, 62),
(385, 'Domingos Duarte', 13, 30, 'ZAG', 69, 59, 78, 74, 47, 78, 54, 69, 1, 50, 'Portugal', 0, 50, 0, 800000, 1845000, 13500, 31, 3, 85, 62),
(386, 'Luis Osorio', 14, 19, 'ZAG', 65, 63, 75, 66, 41, 69, 51, 74, 1, 50, 'Brasil', 0, 50, 0, 500000, 2565000, 6750, 50, 3, 85, 62),
(387, 'Robert Arboleda', 33, 34, 'ZAG', 65, 50, 63, 75, 41, 70, 64, 65, 2, 50, 'Equador', 0, 50, 0, 300000, 550000, 5500, 24, 3, 50, 74),
(388, 'Isac', 44, 19, 'ZAG', 56, 48, 53, 58, 22, 64, 49, 65, 2, 50, 'Brasil', 1, 50, 0, 100000, 530000, 2500, 24, 3, 50, 74),
(389, 'Iago', 16, 28, 'LE', 73, 84, 59, 68, 66, 73, 69, 73, 1, 50, 'Brasil', 0, 50, 0, 3000000, 7470000, 39000, 12, 3, 50, 74),
(390, 'Enzo Díaz', 6, 30, 'LE', 74, 75, 63, 76, 64, 71, 77, 74, 0, 50, 'Argentina', 0, 50, 0, 3000000, 15875000, 43250, 36, 3, 85, 62),
(391, 'Wendell', 26, 32, 'LE', 71, 81, 65, 77, 52, 79, 71, 71, 2, 50, 'Brasil', 0, 50, 0, 1200000, 3475000, 16500, 24, 3, 15, 62),
(392, 'Nicolas', 36, 18, 'LE', 55, 67, 50, 48, 30, 58, 52, 70, 2, 50, 'Brasil', 1, 50, 0, 100000, 465000, 2500, 48, 3, 50, 74),
(393, 'Pedro Lima', 2, 19, 'LD', 70, 81, 64, 66, 55, 68, 63, 79, 0, 50, 'Brasil', 0, 50, 0, 4000000, 28265000, 31750, 18, 3, 50, 58),
(394, 'Aurélio Buta', 27, 28, 'LD', 68, 69, 55, 76, 65, 64, 67, 68, 2, 50, 'Portugal', 0, 50, 0, 1500000, 4865000, 22250, 18, 3, 50, 48),
(395, 'Lucas Ramon', 23, 31, 'LD', 70, 74, 55, 74, 61, 76, 71, 70, 1, 50, 'Brasil', 0, 50, 0, 700000, 2310000, 12500, 24, 3, 50, 58),
(396, 'Cédric Soares', 32, 34, 'LD', 68, 68, 63, 69, 56, 68, 68, 68, 2, 50, 'Portugal', 0, 50, 0, 500000, 925000, 8750, 24, 3, 50, 48),
(397, 'Igor Felisberto', 35, 18, 'LD', 57, 66, 53, 51, 42, 58, 53, 65, 2, 50, 'Brasil', 1, 50, 0, 100000, 560000, 2500, 39, 3, 50, 58),
(398, 'Pablo Maia', 5, 23, 'VOL', 73, 72, 79, 72, 59, 78, 70, 77, 0, 50, 'Brasil', 0, 50, 0, 4000000, 22015000, 58500, 48, 3, 50, 48),
(399, 'Newton', 15, 25, 'VOL', 71, 71, 76, 77, 60, 83, 72, 73, 1, 50, 'Brasil', 0, 50, 0, 3000000, 9260000, 31500, 48, 3, 50, 48),
(400, 'Marcos Antônio', 8, 25, 'MC', 78, 84, 80, 75, 73, 83, 83, 80, 0, 50, 'Brasil', 0, 50, 0, 14000000, 50025000, 217250, 60, 3, 50, 48),
(401, 'Damián Bobadilla', 18, 24, 'MC', 76, 72, 79, 74, 65, 77, 72, 79, 1, 50, 'Paraguai', 0, 50, 0, 8000000, 34640000, 133000, 24, 3, 50, 58),
(402, 'Djhordney', 20, 18, 'MC', 65, 54, 51, 74, 58, 67, 68, 72, 1, 50, 'Brasil', 1, 50, 0, 2000000, 7730000, 13750, 49, 3, 50, 58),
(403, 'Danielzinho', 28, 31, 'MC', 69, 59, 71, 77, 64, 62, 67, 69, 2, 50, 'Brasil', 0, 50, 0, 1000000, 3035000, 12250, 24, 3, 50, 48),
(404, 'Cauly', 10, 30, 'MEI', 74, 67, 63, 82, 73, 52, 74, 74, 0, 50, 'Brasil', 0, 50, 0, 2000000, 4625000, 35500, 12, 3, 20, 25),
(405, 'Pedro Ferreira', 30, 18, 'MEI', 53, 36, 39, 57, 60, 38, 65, 65, 1, 50, 'Brasil', 1, 50, 0, 100000, 510000, 2500, 40, 3, 50, 12),
(406, 'Ferreirinha', 21, 28, 'PE', 73, 70, 53, 84, 80, 57, 82, 74, 1, 50, 'Brasil', 0, 50, 0, 3000000, 10020000, 36750, 24, 3, 50, 12),
(407, 'Lucca', 31, 18, 'PE', 69, 69, 58, 65, 68, 46, 79, 80, 1, 50, 'Brasil', 0, 50, 0, 3000000, 15085000, 26250, 28, 3, 50, 12),
(408, 'Victor Sá', 11, 31, 'PE', 75, 74, 59, 75, 75, 52, 76, 75, 0, 50, 'Brasil', 0, 50, 0, 2000000, 9770000, 33250, 48, 3, 80, 25),
(409, 'Tetê', 51, 18, 'PE', 63, 75, 53, 51, 63, 30, 53, 74, 2, 50, 'Brasil', 1, 50, 0, 1000000, 5475000, 10250, 45, 3, 20, 25),
(410, 'Artur', 7, 27, 'PD', 76, 81, 70, 73, 74, 51, 77, 77, 0, 50, 'Brasil', 0, 50, 0, 8000000, 25505000, 109500, 12, 3, 80, 25),
(411, 'Lucas Moura', 17, 33, 'PD', 73, 79, 56, 75, 77, 53, 76, 73, 1, 50, 'Brasil', 0, 50, 0, 2000000, 2325000, 41500, 12, 3, 50, 12),
(412, 'Ryan Francisco', 29, 19, 'ATA', 68, 63, 69, 62, 67, 28, 61, 79, 1, 50, 'Brasil', 1, 50, 0, 4000000, 25665000, 36250, 48, 3, 20, 25),
(413, 'André Silva', 99, 28, 'ATA', 70, 72, 78, 70, 74, 44, 59, 71, 1, 50, 'Brasil', 0, 50, 0, 2500000, 10830000, 34000, 24, 3, 50, 90),
(414, 'Jonathan Calleri', 9, 32, 'ATA', 73, 71, 74, 76, 77, 46, 60, 73, 0, 50, 'Argentina', 0, 50, 0, 1500000, 6515000, 29500, 36, 3, 50, 90),
(415, 'Luciano', 19, 32, 'ATA', 72, 68, 75, 80, 80, 44, 58, 72, 1, 50, 'Brasil', 0, 50, 0, 1000000, 2700000, 24250, 36, 3, 85, 62),
(416, 'Gustavo Santana', 39, 20, 'ATA', 67, 67, 69, 61, 68, 35, 59, 77, 2, 50, 'Brasil', 1, 50, 0, 1000000, 5635000, 9500, 34, 3, 50, 74),
(417, 'Agustín Rossi', 1, 30, 'GOL', 77, 53, 77, 77, 14, 60, 64, 77, 0, 50, 'Argentina', 0, 50, 0, 10000000, 63135000, 209500, 24, 1, 50, 74),
(418, 'Andrew', 12, 24, 'GOL', 75, 48, 79, 79, 17, 51, 65, 78, 1, 50, 'Brasil', 1, 50, 0, 5000000, 14175000, 88750, 48, 1, 15, 62),
(419, 'Dyogo Alves', 22, 21, 'GOL', 60, 35, 59, 58, 8, 50, 41, 67, 2, 50, 'Brasil', 0, 50, 0, 400000, 850000, 5500, 12, 1, 50, 74),
(420, 'Léo Ortiz', 3, 29, 'ZAG', 80, 77, 88, 77, 59, 88, 71, 80, 0, 50, 'Brasil', 0, 50, 0, 12000000, 47190000, 209500, 36, 1, 50, 74),
(421, 'Léo Pereira', 13, 29, 'ZAG', 75, 74, 87, 77, 53, 77, 61, 75, 1, 50, 'Brasil', 0, 50, 0, 12000000, 42715000, 182000, 24, 1, 85, 62),
(422, 'Vitão', 4, 25, 'ZAG', 78, 78, 89, 80, 54, 86, 75, 80, 0, 50, 'Brasil', 0, 50, 0, 10000000, 62880000, 170750, 48, 1, 15, 62),
(423, 'Danilo', 14, 34, 'ZAG', 72, 57, 81, 75, 51, 79, 69, 72, 1, 50, 'Brasil', 0, 50, 0, 1500000, 1610000, 37250, 12, 1, 85, 62),
(424, 'João Souza', 33, 19, 'ZAG', 63, 51, 67, 59, 29, 73, 56, 70, 2, 50, 'Brasil', 1, 50, 0, 800000, 2275000, 7750, 48, 1, 50, 58),
(425, 'Ayrton Lucas', 6, 28, 'LE', 71, 66, 61, 80, 64, 74, 70, 71, 0, 50, 'Brasil', 0, 50, 0, 4000000, 23225000, 67500, 24, 1, 50, 48),
(426, 'Alex Sandro', 16, 34, 'LE', 71, 76, 73, 71, 63, 75, 72, 71, 1, 50, 'Brasil', 0, 50, 0, 1000000, 1980000, 18500, 24, 1, 50, 48),
(427, 'Emerson Royal', 2, 26, 'LD', 72, 83, 69, 70, 52, 68, 60, 73, 0, 50, 'Brasil', 0, 50, 0, 5000000, 18130000, 95000, 36, 1, 50, 58),
(428, 'Guillermo Varela', 23, 32, 'LD', 67, 72, 64, 69, 45, 66, 59, 67, 1, 50, 'Uruguai', 0, 50, 0, 1000000, 2835000, 23250, 24, 1, 50, 48),
(429, 'Evertton Araújo', 5, 22, 'VOL', 76, 71, 85, 78, 63, 85, 81, 80, 0, 50, 'Brasil', 0, 50, 0, 14000000, 81675000, 230000, 36, 1, 20, 25),
(430, 'Erick Pulgar', 15, 31, 'VOL', 75, 72, 86, 67, 63, 78, 67, 75, 1, 50, 'Chile', 0, 50, 0, 4500000, 11695000, 68250, 48, 1, 20, 25),
(431, 'Jorginho', 25, 34, 'VOL', 75, 61, 73, 86, 61, 82, 77, 75, 2, 50, 'Itália', 0, 50, 0, 3500000, 8305000, 59500, 30, 1, 50, 58),
(432, 'Nicolás de la Cruz', 8, 28, 'MC', 76, 69, 73, 78, 65, 77, 77, 77, 0, 50, 'Uruguai', 0, 50, 0, 7000000, 29245000, 103000, 30, 1, 50, 48),
(433, 'Saúl Ñíguez', 18, 31, 'MC', 70, 71, 67, 79, 61, 71, 68, 70, 1, 50, 'Espanha', 0, 50, 0, 1000000, 3505000, 20500, 36, 1, 50, 58),
(434, 'Lucas Paquetá', 20, 28, 'MEI', 80, 88, 67, 84, 79, 68, 79, 80, 1, 50, 'Brasil', 0, 50, 0, 27000000, 108525000, 335750, 60, 1, 20, 25),
(435, 'Jorge Carrascal', 21, 27, 'MEI', 77, 72, 64, 87, 73, 57, 78, 78, 2, 50, 'Colômbia', 1, 50, 0, 15000000, 40340000, 234000, 42, 1, 50, 12),
(436, 'Giorgian de Arrascaeta', 10, 31, 'MEI', 81, 79, 66, 82, 81, 54, 85, 81, 0, 50, 'Uruguai', 0, 50, 0, 14000000, 29430000, 309000, 36, 1, 50, 12),
(437, 'Samuel Lino', 11, 26, 'PE', 80, 83, 69, 71, 80, 58, 65, 81, 0, 50, 'Brasil', 0, 50, 0, 20000000, 113295000, 316750, 48, 1, 50, 12),
(438, 'Gonzalo Plata', 7, 25, 'PD', 77, 83, 64, 77, 72, 52, 77, 79, 0, 50, 'Equador', 0, 50, 0, 9000000, 26420000, 145500, 42, 1, 20, 25),
(439, 'Luiz Araújo', 17, 29, 'PD', 75, 82, 68, 73, 71, 47, 67, 75, 1, 50, 'Brasil', 0, 50, 0, 7000000, 12955000, 139750, 24, 1, 80, 25),
(440, 'Anthony Valencia', 27, 22, 'PD', 69, 70, 60, 65, 73, 43, 75, 75, 2, 50, 'Equador', 1, 50, 0, 1800000, 7240000, 28500, 72, 1, 80, 25),
(441, 'Pedro', 9, 28, 'ATA', 80, 76, 82, 84, 89, 55, 78, 80, 0, 50, 'Brasil', 0, 50, 0, 22000000, 111135000, 325500, 24, 1, 50, 12),
(442, 'Joaquín Freitas', 99, 19, 'ATA', 70, 64, 65, 73, 82, 35, 61, 79, 1, 50, 'Argentina', 1, 50, 0, 2000000, 7430000, 23000, 72, 1, 50, 90),
(443, 'Bruno Henrique', 19, 35, 'ATA', 71, 63, 71, 73, 74, 34, 60, 71, 1, 50, 'Brasil', 0, 50, 0, 750000, 1145000, 22500, 24, 1, 50, 90),
(444, 'Vitor Eudes', 1, 27, 'GOL', 62, 38, 60, 61, 8, 45, 51, 63, 0, 50, 'Brasil', 0, 50, 0, 400000, 1670000, 6750, 24, 7, 50, 90),
(445, 'Marcelo Pitaluga', 22, 23, 'GOL', 58, 25, 47, 67, 10, 48, 46, 63, 2, 50, 'Brasil', 1, 50, 0, 200000, 545000, 3750, 36, 7, 15, 62),
(446, 'Fábio', 12, 45, 'GOL', 59, 25, 51, 70, 8, 48, 39, 59, 1, 50, 'Brasil', 0, 50, 0, 75000, 140000, 2500, 24, 7, 85, 62),
(447, 'Juan Pablo Freytes', 4, 25, 'ZAG', 72, 65, 75, 71, 49, 70, 59, 74, 0, 50, 'Argentina', 0, 50, 0, 5000000, 24700000, 75000, 36, 7, 85, 62),
(448, 'Julián Millán', 13, 27, 'ZAG', 72, 58, 68, 82, 50, 83, 70, 73, 1, 50, 'Colômbia', 0, 50, 0, 4000000, 19390000, 68500, 48, 7, 15, 62),
(449, 'Ignácio', 3, 29, 'ZAG', 76, 58, 70, 83, 52, 85, 70, 76, 0, 50, 'Brasil', 0, 50, 0, 3500000, 11445000, 53000, 30, 7, 50, 74),
(450, 'Jemmes', 33, 25, 'ZAG', 68, 57, 75, 71, 42, 70, 62, 70, 2, 50, 'Brasil', 1, 50, 0, 3000000, 8220000, 42000, 60, 7, 50, 74),
(451, 'Igor Rabello', 14, 30, 'ZAG', 70, 69, 80, 69, 41, 73, 61, 70, 1, 50, 'Brasil', 0, 50, 0, 1400000, 3785000, 28500, 24, 7, 50, 74),
(452, 'Thiago Silva', 34, 41, 'ZAG', 68, 44, 75, 70, 37, 73, 61, 68, 2, 50, 'Brasil', 0, 50, 0, 500000, 605000, 12750, 12, 7, 50, 74),
(453, 'Guilherme Arana', 6, 28, 'LE', 75, 80, 67, 72, 51, 73, 74, 76, 0, 50, 'Brasil', 0, 50, 0, 6000000, 38175000, 113000, 48, 7, 50, 74),
(454, 'Renê', 16, 33, 'LE', 65, 58, 49, 71, 58, 60, 71, 65, 1, 50, 'Brasil', 0, 50, 0, 400000, 570000, 8500, 24, 7, 15, 62),
(455, 'Léo Jance', 26, 20, 'LE', 56, 53, 45, 65, 47, 47, 52, 65, 2, 50, 'Brasil', 1, 50, 0, 100000, 430000, 2500, 18, 7, 50, 58),
(456, 'Guga', 2, 27, 'LD', 70, 76, 60, 63, 55, 57, 65, 71, 0, 50, 'Brasil', 0, 50, 0, 2000000, 6720000, 30750, 48, 7, 50, 58),
(457, 'Julio Fidelis', 23, 19, 'LD', 64, 63, 51, 60, 42, 59, 68, 71, 1, 50, 'Brasil', 1, 50, 0, 500000, 1900000, 7000, 64, 7, 50, 58),
(458, 'Jhonny', 35, 23, 'LD', 60, 65, 44, 71, 48, 60, 59, 63, 2, 50, 'Brasil', 1, 50, 0, 350000, 840000, 7000, 24, 7, 50, 48),
(459, 'Samuel Xavier', 32, 35, 'LD', 64, 58, 55, 68, 48, 63, 62, 64, 2, 50, 'Brasil', 0, 50, 0, 200000, 515000, 5000, 24, 7, 50, 48),
(460, 'Martinelli', 5, 24, 'VOL', 78, 75, 80, 83, 60, 90, 76, 82, 0, 50, 'Brasil', 0, 50, 0, 18000000, 73135000, 271250, 60, 7, 50, 48),
(461, 'Otávio', 15, 31, 'VOL', 69, 57, 70, 74, 52, 71, 73, 69, 1, 50, 'Brasil', 0, 50, 0, 1000000, 3565000, 17500, 24, 7, 50, 48),
(462, 'Luis Fernando', 25, 20, 'VOL', 57, 32, 51, 69, 49, 51, 68, 66, 2, 50, 'Brasil', 1, 50, 0, 100000, 465000, 2500, 24, 7, 50, 48),
(463, 'Hércules', 8, 25, 'MC', 79, 86, 77, 80, 78, 79, 82, 81, 0, 50, 'Brasil', 0, 50, 0, 15000000, 54030000, 236750, 48, 7, 50, 48),
(464, 'Nonato', 18, 27, 'MC', 70, 68, 69, 70, 62, 66, 70, 71, 1, 50, 'Brasil', 0, 50, 0, 2000000, 5350000, 29750, 36, 7, 50, 12),
(465, 'Alisson', 28, 32, 'MC', 69, 69, 70, 75, 47, 71, 79, 69, 2, 50, 'Brasil', 1, 50, 0, 800000, 2370000, 14250, 12, 7, 80, 25),
(466, 'Jefferson Savarino', 20, 29, 'MEI', 76, 78, 63, 76, 74, 60, 78, 76, 1, 50, 'Venezuela', 0, 50, 0, 8000000, 21850000, 121500, 48, 7, 50, 12),
(467, 'Luciano Acosta', 10, 31, 'MEI', 77, 79, 64, 86, 81, 57, 80, 77, 0, 50, 'Argentina', 0, 50, 0, 5000000, 22215000, 77250, 48, 7, 20, 25),
(468, 'Ganso', 30, 36, 'MEI', 67, 56, 49, 76, 66, 43, 68, 67, 2, 50, 'Brasil', 1, 50, 0, 300000, 485000, 5500, 12, 7, 50, 12),
(469, 'Yago Ferreira', 70, 24, 'MEI', 58, 50, 37, 61, 55, 44, 70, 62, 2, 50, 'Brasil', 0, 50, 0, 100000, 370000, 2500, 15, 7, 50, 12),
(470, 'Yeferson Soteldo', 11, 28, 'PE', 73, 81, 66, 76, 63, 44, 66, 74, 0, 50, 'Venezuela', 0, 50, 0, 3000000, 17105000, 57500, 36, 7, 50, 12),
(471, 'Wesley Natã', 21, 17, 'PE', 62, 71, 47, 55, 68, 41, 56, 78, 1, 50, 'Brasil', 1, 50, 0, 1000000, 4270000, 11000, 29, 7, 50, 12),
(472, 'Matheus Reis', 31, 18, 'PE', 58, 65, 42, 54, 66, 32, 49, 70, 2, 50, 'México', 1, 50, 0, 100000, 450000, 2500, 60, 7, 50, 90),
(473, 'Agustín Canobbio', 7, 27, 'PD', 77, 89, 63, 78, 72, 48, 70, 78, 0, 50, 'Uruguai', 0, 50, 0, 9000000, 33940000, 118250, 36, 7, 50, 90),
(474, 'Riquelme', 17, 18, 'PD', 74, 86, 62, 68, 69, 51, 73, 86, 1, 50, 'Brasil', 1, 50, 0, 6000000, 46375000, 63000, 56, 7, 50, 90),
(475, 'Kevin Serna', 27, 28, 'PD', 74, 82, 67, 69, 75, 51, 69, 74, 2, 50, 'Colômbia', 1, 50, 0, 5000000, 11820000, 75250, 36, 7, 50, 90),
(476, 'John Kennedy', 9, 23, 'ATA', 78, 70, 75, 82, 90, 34, 68, 81, 0, 50, 'Brasil', 0, 50, 0, 12000000, 38445000, 198500, 24, 7, 15, 62),
(477, 'Rodrigo Castillo', 19, 26, 'ATA', 74, 65, 70, 82, 86, 51, 66, 75, 1, 50, 'Argentina', 0, 50, 0, 6000000, 23835000, 81500, 60, 7, 15, 62),
(478, 'Hulk', 99, 39, 'ATA', 72, 54, 71, 76, 66, 37, 63, 72, 1, 50, 'Brasil', 0, 50, 0, 1000000, 1580000, 24250, 24, 7, 85, 62),
(479, 'Germán Cano', 29, 37, 'ATA', 66, 64, 68, 70, 63, 33, 56, 66, 2, 50, 'Argentina', 1, 50, 0, 500000, 770000, 11500, 12, 7, 85, 62),
(480, 'Gabriel Grando', 12, 25, 'GOL', 67, 36, 66, 63, 9, 55, 52, 69, 1, 50, 'Brasil', 0, 50, 0, 1500000, 7425000, 24750, 48, 8, 15, 62),
(481, 'Weverton', 1, 38, 'GOL', 72, 39, 77, 79, 20, 64, 58, 72, 0, 50, 'Brasil', 0, 50, 0, 700000, 1710000, 16500, 36, 8, 50, 74),
(482, 'Thiago Beltrame', 22, 22, 'GOL', 54, 25, 51, 55, 8, 45, 44, 58, 2, 50, 'Brasil', 1, 50, 0, 100000, 420000, 2500, 24, 8, 50, 74),
(483, 'Gabriel Menegon', 30, 17, 'GOL', 54, 28, 43, 48, 8, 48, 52, 63, 2, 50, 'Brasil', 1, 50, 0, 100000, 260000, 2500, 33, 8, 50, 74),
(484, 'Gustavo Martins', 13, 23, 'ZAG', 70, 69, 82, 71, 44, 72, 70, 73, 1, 50, 'Brasil', 1, 50, 0, 5000000, 18695000, 52500, 24, 8, 50, 74),
(485, 'Wallace', 3, 21, 'ZAG', 74, 65, 74, 74, 48, 80, 67, 80, 0, 50, 'Brasil', 0, 50, 0, 3000000, 13500000, 40500, 66, 8, 50, 74),
(486, 'Wagner Leonardo', 4, 26, 'ZAG', 71, 64, 78, 72, 31, 69, 64, 72, 0, 50, 'Brasil', 0, 50, 0, 2000000, 11370000, 32500, 36, 8, 50, 74),
(487, 'Fabián Balbuena', 14, 34, 'ZAG', 69, 47, 69, 74, 34, 80, 65, 69, 1, 50, 'Paraguai', 0, 50, 0, 700000, 1355000, 14750, 18, 8, 50, 58),
(488, 'Luis Eduardo', 34, 17, 'ZAG', 61, 60, 60, 58, 34, 65, 50, 70, 2, 50, 'Brasil', 1, 50, 0, 500000, 2365000, 4750, 29, 8, 50, 58),
(489, 'Walter Kannemann', 33, 34, 'ZAG', 66, 50, 72, 61, 31, 78, 58, 66, 2, 50, 'Argentina', 1, 50, 0, 350000, 720000, 6750, 24, 8, 50, 58),
(490, 'Athos Thawan', 44, 20, 'ZAG', 58, 45, 61, 61, 36, 70, 50, 65, 2, 50, 'Brasil', 0, 50, 0, 100000, 245000, 2500, 12, 8, 50, 58),
(491, 'Marlon', 6, 28, 'LE', 73, 85, 71, 66, 49, 73, 69, 73, 0, 50, 'Brasil', 0, 50, 0, 3500000, 14030000, 41500, 36, 8, 50, 58),
(492, 'Pedro Gabriel', 26, 18, 'LE', 68, 75, 64, 62, 51, 74, 65, 79, 1, 50, 'Brasil', 0, 50, 0, 2000000, 8460000, 22750, 36, 8, 50, 58),
(493, 'Caio Paulista', 16, 27, 'LE', 71, 65, 58, 76, 64, 63, 71, 72, 1, 50, 'Brasil', 0, 50, 0, 1500000, 2410000, 19750, 12, 8, 50, 58),
(494, 'Diego Caito', 23, 21, 'LD', 66, 63, 60, 65, 48, 63, 65, 73, 1, 50, 'Brasil', 1, 50, 0, 1500000, 4695000, 19000, 12, 8, 50, 58),
(495, 'João Pedro', 2, 29, 'LD', 67, 67, 59, 69, 49, 59, 67, 67, 0, 50, 'Brasil', 0, 50, 0, 1000000, 5040000, 14500, 24, 8, 50, 48),
(496, 'Marcos Rocha', 32, 37, 'LD', 62, 60, 42, 62, 47, 53, 58, 62, 2, 50, 'Brasil', 1, 50, 0, 150000, 185000, 3000, 12, 8, 50, 48),
(497, 'Erick Noriega', 5, 24, 'VOL', 77, 71, 78, 73, 57, 79, 76, 80, 0, 50, 'Peru', 0, 50, 0, 6000000, 18980000, 87750, 36, 8, 50, 48),
(498, 'Mathías Villasanti', 15, 28, 'VOL', 75, 66, 69, 80, 58, 83, 81, 76, 1, 50, 'Paraguai', 0, 50, 0, 4000000, 18975000, 46750, 48, 8, 80, 25),
(499, 'Danilo Barbosa', 35, 29, 'VOL', 70, 52, 65, 77, 63, 73, 75, 70, 2, 50, 'Brasil', 1, 50, 0, 2000000, 5240000, 24750, 36, 8, 50, 12),
(500, 'Filip Krovinovic', 25, 30, 'VOL', 71, 79, 83, 71, 51, 73, 54, 71, 2, 50, 'Croácia', 0, 50, 0, 1500000, 3810000, 21000, 36, 8, 20, 25),
(501, 'Dodi', 28, 29, 'VOL', 66, 64, 73, 64, 55, 71, 65, 66, 2, 50, 'Brasil', 0, 50, 0, 500000, 1000000, 7000, 12, 8, 50, 12),
(502, 'Juan Nardoni', 8, 23, 'MC', 75, 82, 78, 67, 72, 68, 73, 77, 0, 50, 'Argentina', 0, 50, 0, 7000000, 23475000, 89750, 48, 8, 20, 25),
(503, 'Tiago Augusto', 18, 17, 'MC', 62, 54, 57, 58, 45, 52, 61, 73, 1, 50, 'Brasil', 1, 50, 0, 500000, 2610000, 5500, 18, 8, 50, 12),
(504, 'Riquelme', 10, 19, 'MEI', 68, 63, 51, 78, 63, 44, 80, 76, 0, 50, 'Brasil', 0, 50, 0, 2000000, 9420000, 23500, 24, 8, 20, 25),
(505, 'Francis Amuzu', 11, 26, 'PE', 74, 84, 72, 74, 73, 49, 74, 75, 0, 50, 'Gana', 0, 50, 0, 8000000, 17955000, 124500, 12, 8, 50, 12),
(506, 'Jovane Cabral', 21, 27, 'PE', 71, 75, 59, 71, 72, 36, 72, 72, 1, 50, 'Cabo Verde', 1, 50, 0, 1500000, 4145000, 20750, 24, 8, 50, 12),
(507, 'Tetê', 7, 25, 'PD', 77, 89, 68, 74, 82, 52, 72, 79, 0, 50, 'Brasil', 0, 50, 0, 7000000, 40045000, 105750, 48, 8, 50, 90),
(508, 'Cristian Pavón', 17, 29, 'PD', 73, 85, 67, 78, 77, 47, 72, 73, 1, 50, 'Argentina', 0, 50, 0, 2500000, 4485000, 43250, 12, 8, 50, 90),
(509, 'José Enamorado', 27, 26, 'PD', 70, 82, 59, 68, 67, 39, 67, 71, 2, 50, 'Colômbia', 1, 50, 0, 2500000, 8930000, 27750, 36, 8, 50, 90),
(510, 'Roger', 37, 17, 'PD', 60, 63, 45, 57, 56, 38, 54, 71, 2, 50, 'Brasil', 1, 50, 0, 400000, 1470000, 3750, 36, 8, 50, 90),
(511, 'Carlos Vinícius', 9, 30, 'ATA', 77, 78, 84, 73, 81, 50, 64, 77, 0, 50, 'Brasil', 0, 50, 0, 6000000, 11840000, 76000, 12, 8, 50, 90),
(512, 'Matheus Nascimento', 99, 21, 'ATA', 70, 68, 73, 65, 72, 35, 54, 76, 1, 50, 'Brasil', 1, 50, 0, 2000000, 9635000, 28250, 54, 8, 85, 62),
(513, 'Martin Braithwaite', 19, 34, 'ATA', 71, 64, 72, 71, 74, 35, 61, 71, 1, 50, 'Dinamarca', 0, 50, 0, 750000, 2005000, 14250, 24, 8, 50, 74),
(514, 'Walter', 1, 38, 'GOL', 62, 27, 58, 72, 9, 58, 53, 62, 0, 50, 'Brasil', 0, 50, 0, 150000, 195000, 2500, 12, 19, 50, 74),
(515, 'Alex Muralha', 22, 36, 'GOL', 58, 25, 53, 65, 11, 47, 42, 58, 2, 50, 'Brasil', 0, 50, 0, 75000, 90000, 2500, 12, 19, 15, 62),
(516, 'Georgemy', 31, 30, 'GOL', 55, 28, 56, 61, 11, 41, 41, 55, 2, 50, 'Brasil', 0, 50, 0, 50000, 140000, 2500, 12, 19, 50, 74),
(517, 'Thomazella', 12, 35, 'GOL', 58, 27, 53, 60, 11, 55, 44, 58, 1, 50, 'Brasil', 0, 50, 0, 100000, 155000, 2500, 12, 19, 50, 74),
(518, 'Willian Machado', 4, 29, 'ZAG', 68, 55, 73, 79, 50, 68, 67, 68, 0, 50, 'Brasil', 0, 50, 0, 2000000, 7685000, 17500, 36, 19, 50, 74),
(519, 'João Victor', 3, 28, 'ZAG', 69, 64, 77, 74, 40, 75, 66, 70, 0, 50, 'Brasil', 0, 50, 0, 1500000, 5900000, 19750, 24, 19, 50, 74),
(520, 'Lucas Oliveira', 13, 29, 'ZAG', 66, 62, 78, 68, 31, 73, 52, 66, 1, 50, 'Brasil', 0, 50, 0, 1000000, 2115000, 13250, 12, 19, 50, 74),
(521, 'Gabriel', 14, 22, 'ZAG', 66, 55, 75, 66, 43, 72, 63, 72, 1, 50, 'Brasil', 1, 50, 0, 700000, 1995000, 9250, 18, 19, 50, 74),
(522, 'Reinaldo', 6, 36, 'LE', 68, 65, 65, 69, 56, 74, 66, 68, 0, 50, 'Brasil', 0, 50, 0, 350000, 340000, 6500, 12, 19, 50, 48),
(523, 'Victor Luís', 16, 32, 'LE', 64, 56, 55, 59, 51, 57, 62, 64, 1, 50, 'Brasil', 0, 50, 0, 300000, 570000, 5000, 9, 19, 50, 48),
(524, 'Igor Formiga', 2, 26, 'LD', 74, 77, 71, 71, 56, 72, 74, 75, 0, 50, 'Brasil', 0, 50, 0, 4000000, 12815000, 55000, 21, 19, 50, 48),
(525, 'Elias', 23, 26, 'LD', 63, 70, 53, 60, 53, 52, 59, 64, 1, 50, 'Brasil', 0, 50, 0, 550000, 1305000, 7500, 12, 19, 50, 58),
(526, 'Daniel Borges', 32, 32, 'LD', 63, 63, 48, 68, 49, 65, 65, 63, 2, 50, 'Brasil', 0, 50, 0, 300000, 615000, 4250, 12, 19, 50, 58),
(527, 'Neto Moura', 5, 29, 'VOL', 71, 75, 80, 70, 48, 78, 58, 71, 0, 50, 'Brasil', 0, 50, 0, 1800000, 5410000, 18500, 12, 19, 50, 48),
(528, 'Wallisson', 15, 28, 'VOL', 70, 61, 70, 72, 50, 82, 75, 71, 1, 50, 'Brasil', 0, 50, 0, 900000, 2995000, 14000, 24, 19, 50, 48),
(529, 'Gustavo Cazonatti', 25, 29, 'VOL', 63, 55, 67, 71, 54, 68, 65, 63, 2, 50, 'Brasil', 0, 50, 0, 450000, 1410000, 5500, 36, 19, 50, 48),
(530, 'Denilson', 18, 24, 'MC', 68, 63, 73, 64, 65, 65, 66, 71, 1, 50, 'Brasil', 0, 50, 0, 2000000, 6010000, 34250, 36, 19, 50, 48),
(531, 'Aldo Filho', 8, 27, 'MC', 70, 59, 60, 76, 72, 66, 75, 71, 0, 50, 'Brasil', 0, 50, 0, 1500000, 4795000, 19000, 24, 19, 50, 48),
(532, 'Japa', 28, 21, 'MC', 66, 54, 63, 71, 61, 64, 75, 74, 1, 50, 'Brasil', 1, 50, 0, 1000000, 2785000, 8000, 12, 19, 50, 58),
(533, 'Shaylon', 20, 28, 'MEI', 67, 73, 55, 74, 65, 47, 76, 67, 1, 50, 'Brasil', 0, 50, 0, 1000000, 2385000, 13250, 12, 19, 50, 48),
(534, 'Eduardo', 10, 36, 'MEI', 71, 69, 59, 76, 73, 51, 73, 71, 0, 50, 'Brasil', 0, 50, 0, 600000, 700000, 12000, 12, 19, 50, 48),
(535, 'Chico Kim', 30, 34, 'MEI', 60, 48, 57, 61, 68, 50, 59, 60, 2, 50, 'Brasil', 0, 50, 0, 150000, 225000, 2500, 12, 19, 50, 48),
(536, 'Alesson', 11, 26, 'PE', 74, 85, 62, 64, 77, 50, 66, 75, 0, 50, 'Brasil', 0, 50, 0, 2500000, 9320000, 35500, 36, 19, 50, 12),
(537, 'Fernandinho', 21, 28, 'PE', 67, 71, 51, 73, 75, 38, 68, 67, 1, 50, 'Brasil', 0, 50, 0, 600000, 1590000, 8500, 12, 19, 50, 12),
(538, 'Negueba', 7, 26, 'PD', 72, 80, 62, 73, 74, 42, 68, 73, 0, 50, 'Brasil', 0, 50, 0, 2500000, 8940000, 34500, 24, 19, 50, 12),
(539, 'Gustavo Silva', 17, 28, 'PD', 68, 75, 67, 73, 58, 40, 61, 68, 1, 50, 'Brasil', 0, 50, 0, 1000000, 2870000, 11250, 24, 19, 80, 25),
(540, 'Carlos Eduardo', 27, 29, 'PD', 66, 71, 56, 73, 77, 35, 66, 66, 2, 50, 'Brasil', 0, 50, 0, 500000, 1025000, 5750, 12, 19, 20, 25),
(541, 'Luiz Filipe', 37, 24, 'PD', 57, 69, 56, 57, 59, 33, 56, 60, 2, 50, 'Brasil', 0, 50, 0, 100000, 445000, 2500, 14, 19, 50, 12),
(542, 'Edson Carioca', 9, 28, 'ATA', 69, 61, 65, 79, 80, 33, 67, 69, 0, 50, 'Brasil', 0, 50, 0, 1500000, 5845000, 23000, 36, 19, 50, 12),
(543, 'André Luis', 19, 31, 'ATA', 67, 64, 66, 67, 72, 39, 63, 67, 1, 50, 'Brasil', 0, 50, 0, 1000000, 2615000, 13000, 12, 19, 50, 12),
(544, 'Zé Roberto', 99, 32, 'ATA', 63, 70, 72, 61, 67, 27, 49, 63, 1, 50, 'Brasil', 0, 50, 0, 300000, 900000, 4750, 12, 19, 50, 12),
(545, 'Bruno Santos', 29, 29, 'ATA', 63, 53, 71, 71, 72, 26, 58, 63, 2, 50, 'Brasil', 1, 50, 0, 200000, 695000, 2750, 36, 19, 50, 12),
(546, 'Cleiton', 1, 28, 'GOL', 71, 48, 69, 77, 22, 63, 58, 71, 0, 50, 'Brasil', 0, 50, 0, 3500000, 10800000, 48750, 24, 14, 50, 12),
(547, 'Tiago Volpi', 12, 35, 'GOL', 69, 47, 71, 65, 13, 55, 49, 69, 1, 50, 'Brasil', 0, 50, 0, 900000, 1035000, 21000, 12, 14, 50, 12),
(548, 'Fabrício', 22, 25, 'GOL', 56, 33, 55, 62, 8, 53, 42, 58, 2, 50, 'Brasil', 1, 50, 0, 100000, 340000, 2500, 24, 14, 50, 90),
(549, 'Gustavo Reis', 40, 20, 'GOL', 56, 39, 50, 52, 8, 50, 39, 62, 2, 50, 'Brasil', 1, 50, 0, 100000, 395000, 2500, 29, 14, 50, 90),
(550, 'Gustavo Marques', 3, 24, 'ZAG', 74, 62, 80, 76, 50, 78, 69, 77, 0, 50, 'Brasil', 0, 50, 0, 7000000, 34870000, 121500, 54, 14, 50, 90),
(551, 'Alix', 4, 26, 'ZAG', 74, 66, 86, 73, 39, 75, 68, 75, 0, 50, 'Brasil', 0, 50, 0, 4000000, 20615000, 54250, 36, 14, 50, 90),
(552, 'Guzmán Rodríguez', 13, 25, 'ZAG', 74, 58, 75, 73, 46, 79, 71, 76, 1, 50, 'Uruguai', 0, 50, 0, 3500000, 14400000, 57750, 48, 14, 50, 90),
(553, 'Eduardo', 14, 28, 'ZAG', 69, 66, 78, 70, 39, 77, 62, 69, 1, 50, 'Brasil', 0, 50, 0, 750000, 2975000, 15250, 35, 14, 50, 74),
(554, 'Juninho Capixaba', 6, 28, 'LE', 74, 79, 72, 77, 60, 68, 70, 74, 0, 50, 'Brasil', 0, 50, 0, 8000000, 39645000, 99750, 36, 14, 50, 74),
(555, 'Vanderlan', 16, 23, 'LE', 71, 67, 55, 77, 59, 66, 65, 75, 1, 50, 'Brasil', 1, 50, 0, 3000000, 11615000, 48000, 60, 14, 85, 62),
(556, 'Cauê Nascimento', 26, 19, 'LE', 60, 68, 50, 48, 50, 53, 62, 69, 2, 50, 'Brasil', 1, 50, 0, 500000, 2155000, 4500, 37, 14, 50, 74),
(557, 'Agustín Sant\'Anna', 2, 28, 'LD', 75, 74, 60, 77, 65, 73, 75, 75, 0, 50, 'Uruguai', 0, 50, 0, 3500000, 18145000, 60250, 24, 14, 85, 62),
(558, 'José Andrés Hurtado', 23, 24, 'LD', 73, 78, 70, 73, 54, 68, 75, 75, 1, 50, 'Equador', 0, 50, 0, 3000000, 8955000, 52250, 24, 14, 15, 62),
(559, 'Ryan Augusto', 27, 18, 'LD', 63, 75, 48, 58, 42, 70, 50, 74, 2, 50, 'Brasil', 1, 50, 0, 1000000, 4905000, 10750, 37, 14, 50, 74),
(560, 'Fabinho', 5, 23, 'VOL', 73, 69, 68, 77, 58, 72, 78, 78, 0, 50, 'Brasil', 0, 50, 0, 5000000, 23715000, 74250, 48, 14, 50, 74),
(561, 'Patrick', 25, 21, 'VOL', 66, 54, 67, 70, 45, 74, 77, 74, 2, 50, 'Brasil', 1, 50, 0, 1500000, 5750000, 16250, 15, 14, 50, 74),
(562, 'Matheus Fernandes', 35, 27, 'VOL', 66, 48, 78, 64, 55, 73, 62, 67, 2, 50, 'Brasil', 0, 50, 0, 1000000, 4020000, 15000, 24, 14, 50, 74),
(563, 'Gabriel', 15, 33, 'VOL', 67, 66, 66, 64, 39, 69, 61, 67, 1, 50, 'Brasil', 0, 50, 0, 900000, 1080000, 18500, 12, 14, 15, 62),
(564, 'Ignacio Sosa', 8, 22, 'MC', 73, 75, 67, 77, 68, 64, 74, 78, 0, 50, 'Uruguai', 0, 50, 0, 5000000, 30575000, 72000, 60, 14, 50, 74),
(565, 'Eric Ramires', 28, 25, 'MC', 71, 54, 65, 74, 72, 65, 79, 73, 2, 50, 'Brasil', 1, 50, 0, 3500000, 7045000, 47250, 12, 14, 50, 74),
(566, 'Gustavo Neves', 18, 21, 'MC', 72, 74, 66, 73, 71, 76, 76, 80, 1, 50, 'Brasil', 1, 50, 0, 3500000, 11555000, 39250, 48, 14, 85, 62),
(567, 'Rodriguinho', 10, 21, 'MEI', 72, 79, 66, 79, 64, 46, 75, 80, 0, 50, 'Brasil', 0, 50, 0, 7000000, 58550000, 116750, 60, 14, 85, 62),
(568, 'Bruninho', 20, 22, 'MEI', 68, 57, 49, 80, 80, 50, 76, 72, 1, 50, 'Brasil', 0, 50, 0, 1000000, 3080000, 13500, 24, 14, 15, 62),
(569, 'Marcelinho Braz', 30, 21, 'MEI', 62, 67, 50, 66, 57, 41, 64, 68, 2, 50, 'Brasil', 1, 50, 0, 400000, 1490000, 4750, 29, 14, 50, 74),
(570, 'Henry Mosquera', 11, 24, 'PE', 76, 86, 68, 71, 74, 54, 70, 78, 0, 50, 'Colômbia', 0, 50, 0, 5000000, 15515000, 90250, 24, 14, 15, 62),
(571, 'Vinicinho', 21, 21, 'PE', 71, 83, 59, 67, 76, 51, 77, 78, 1, 50, 'Brasil', 0, 50, 0, 3500000, 18370000, 39500, 39, 14, 50, 48),
(572, 'Davi Gomes', 31, 20, 'PE', 64, 72, 52, 63, 58, 37, 59, 71, 2, 50, 'Brasil', 1, 50, 0, 400000, 2520000, 5000, 51, 14, 50, 48),
(573, 'Lucas Barbosa', 7, 24, 'PD', 78, 88, 68, 79, 88, 61, 72, 81, 0, 50, 'Brasil', 0, 50, 0, 8000000, 34035000, 170750, 48, 14, 50, 48),
(574, 'José Herrera', 17, 22, 'PD', 71, 79, 61, 67, 70, 45, 66, 77, 1, 50, 'Argentina', 1, 50, 0, 2500000, 11780000, 33500, 48, 14, 50, 48),
(575, 'Isidro Pitta', 9, 26, 'ATA', 75, 73, 73, 80, 87, 57, 70, 76, 0, 50, 'Paraguai', 0, 50, 0, 7500000, 28250000, 109750, 36, 14, 50, 58),
(576, 'Wallace Yan', 19, 20, 'ATA', 70, 68, 69, 68, 81, 39, 64, 77, 1, 50, 'Brasil', 0, 50, 0, 4000000, 21255000, 51750, 68, 14, 50, 58),
(577, 'Fernando', 99, 26, 'ATA', 70, 64, 69, 71, 74, 40, 67, 71, 1, 50, 'Brasil', 0, 50, 0, 1500000, 4850000, 21250, 36, 14, 50, 48),
(578, 'Eduardo Sasha', 29, 33, 'ATA', 68, 58, 67, 71, 79, 34, 73, 68, 2, 50, 'Brasil', 0, 50, 0, 500000, 1135000, 8000, 24, 14, 50, 48),
(579, 'Anthoni', 12, 23, 'GOL', 70, 36, 76, 73, 18, 59, 62, 73, 1, 50, 'Brasil', 0, 50, 0, 3000000, 15765000, 44000, 48, 9, 50, 48),
(580, 'Matheus Cunha', 22, 24, 'GOL', 70, 47, 69, 67, 22, 61, 53, 73, 2, 50, 'Brasil', 1, 50, 0, 2500000, 12640000, 40500, 18, 9, 50, 48),
(581, 'Sergio Rochet', 1, 32, 'GOL', 72, 46, 71, 78, 18, 65, 61, 72, 0, 50, 'Uruguai', 0, 50, 0, 1800000, 3870000, 28500, 12, 9, 50, 48),
(582, 'Kauan', 40, 22, 'GOL', 55, 25, 53, 53, 10, 49, 45, 61, 2, 50, 'Brasil', 1, 50, 0, 100000, 495000, 2500, 24, 9, 50, 58),
(583, 'Diego Esser', 31, 20, 'GOL', 57, 40, 53, 60, 8, 47, 50, 63, 2, 50, 'Brasil', 1, 50, 0, 100000, 290000, 2500, 12, 9, 20, 25),
(584, 'Victor Gabriel', 4, 21, 'ZAG', 71, 64, 83, 72, 39, 81, 67, 75, 0, 50, 'Brasil', 0, 50, 0, 4000000, 20815000, 52000, 48, 9, 50, 48),
(585, 'Guillermo Maripán', 3, 31, 'ZAG', 73, 59, 73, 82, 38, 83, 73, 73, 0, 50, 'Chile', 0, 50, 0, 2000000, 10600000, 31750, 30, 9, 50, 48),
(586, 'Félix Torres', 13, 28, 'ZAG', 68, 58, 69, 75, 43, 72, 68, 69, 1, 50, 'Equador', 0, 50, 0, 800000, 1565000, 14750, 12, 9, 50, 58),
(587, 'Juninho', 14, 30, 'ZAG', 64, 50, 75, 67, 40, 68, 53, 64, 1, 50, 'Brasil', 0, 50, 0, 700000, 1980000, 12000, 24, 9, 50, 58),
(588, 'Gabriel Mercado', 33, 38, 'ZAG', 61, 37, 65, 66, 39, 61, 52, 61, 2, 50, 'Argentina', 0, 50, 0, 100000, 95000, 2500, 12, 9, 50, 48),
(589, 'Alexandro Bernabei', 6, 25, 'LE', 78, 79, 61, 72, 72, 72, 74, 79, 0, 50, 'Argentina', 0, 50, 0, 8000000, 27750000, 130000, 36, 9, 50, 12),
(590, 'Matheus Bahia', 16, 26, 'LE', 70, 77, 56, 81, 60, 68, 68, 71, 1, 50, 'Brasil', 0, 50, 0, 2500000, 9020000, 35750, 24, 9, 50, 12),
(591, 'Bruno Gomes', 2, 24, 'LD', 74, 86, 68, 74, 61, 70, 73, 77, 0, 50, 'Brasil', 0, 50, 0, 7000000, 19625000, 96500, 24, 9, 50, 12),
(592, 'Braian Aguirre', 23, 25, 'LD', 69, 78, 68, 62, 52, 66, 68, 71, 1, 50, 'Argentina', 0, 50, 0, 2500000, 8265000, 41250, 36, 9, 50, 12),
(593, 'Rodrigo Villagra', 5, 24, 'VOL', 72, 67, 75, 69, 52, 75, 73, 75, 0, 50, 'Argentina', 0, 50, 0, 3500000, 10190000, 48250, 12, 9, 20, 25),
(594, 'Ronaldo', 25, 29, 'VOL', 67, 66, 65, 64, 49, 72, 71, 67, 2, 50, 'Brasil', 1, 50, 0, 2000000, 4400000, 27000, 12, 9, 80, 25),
(595, 'Thiago Maia', 15, 28, 'VOL', 72, 66, 72, 78, 60, 75, 76, 72, 1, 50, 'Brasil', 0, 50, 0, 2000000, 2995000, 28750, 12, 9, 20, 25),
(596, 'Benjamin', 35, 19, 'VOL', 54, 57, 56, 45, 35, 61, 55, 62, 2, 50, 'Gana', 1, 50, 0, 100000, 580000, 2500, 25, 9, 50, 12),
(597, 'Paulinho Paula', 18, 28, 'MC', 66, 63, 56, 73, 57, 62, 68, 66, 1, 50, 'Brasil', 0, 50, 0, 1000000, 3530000, 12750, 24, 9, 50, 12),
(598, 'Bruno Henrique', 8, 36, 'MC', 67, 51, 55, 79, 61, 60, 71, 67, 0, 50, 'Brasil', 0, 50, 0, 300000, 430000, 9000, 12, 9, 50, 12),
(599, 'Niclas Eliasson', 7, 30, 'PD', 73, 78, 58, 75, 62, 44, 68, 73, 0, 50, 'Suécia', 0, 50, 0, 3000000, 9595000, 57500, 18, 9, 50, 12),
(600, 'Alan Patrick', 10, 34, 'MEI', 71, 63, 63, 77, 60, 49, 74, 71, 0, 50, 'Brasil', 0, 50, 0, 2000000, 3790000, 43500, 24, 9, 80, 25),
(601, 'Calebe', 20, 25, 'MEI', 67, 51, 55, 79, 64, 33, 79, 69, 1, 50, 'Brasil', 0, 50, 0, 1500000, 4485000, 21750, 18, 9, 50, 12),
(602, 'Allex', 30, 19, 'MEI', 67, 67, 54, 67, 67, 34, 75, 78, 2, 50, 'Brasil', 1, 50, 0, 1000000, 5110000, 9250, 24, 9, 50, 12),
(603, 'Yago Noal', 27, 18, 'MEI', 62, 61, 51, 70, 68, 35, 74, 73, 2, 50, 'Brasil', 1, 50, 0, 500000, 2295000, 5250, 36, 9, 50, 90),
(604, 'Johan Carbonero', 11, 26, 'PE', 76, 85, 72, 72, 72, 43, 69, 77, 0, 50, 'Colômbia', 0, 50, 0, 7000000, 35935000, 84750, 48, 9, 50, 90),
(605, 'Vitinho', 21, 26, 'PE', 75, 86, 61, 72, 78, 52, 72, 76, 1, 50, 'Brasil', 0, 50, 0, 4000000, 11360000, 63000, 54, 9, 50, 90),
(606, 'Kayky', 17, 22, 'PD', 72, 80, 60, 77, 66, 49, 70, 76, 1, 50, 'Brasil', 1, 50, 0, 4000000, 6175000, 52000, 12, 9, 50, 90),
(607, 'Alerrandro', 9, 25, 'ATA', 72, 72, 73, 75, 72, 40, 59, 73, 0, 50, 'Brasil', 0, 50, 0, 2500000, 10265000, 38000, 12, 9, 85, 62),
(608, 'Antonio Sanabria', 19, 29, 'ATA', 71, 72, 81, 72, 72, 42, 59, 71, 1, 50, 'Paraguai', 0, 50, 0, 1800000, 8915000, 26250, 48, 9, 15, 62),
(609, 'Raykkonen', 99, 17, 'ATA', 62, 62, 62, 61, 59, 36, 53, 77, 1, 50, 'Brasil', 1, 50, 0, 1000000, 3600000, 8250, 36, 9, 15, 62),
(610, 'Carlos Miguel', 1, 27, 'GOL', 78, 51, 69, 85, 28, 67, 67, 79, 0, 50, 'Brasil', 0, 50, 0, 9000000, 31395000, 157000, 55, 2, 85, 62),
(611, 'Marcelo Lomba', 12, 39, 'GOL', 59, 26, 60, 65, 8, 36, 37, 59, 1, 50, 'Brasil', 0, 50, 0, 75000, 115000, 3250, 12, 2, 50, 74),
(612, 'Bruno Bertinato', 22, 27, 'GOL', 57, 30, 60, 55, 8, 38, 32, 58, 2, 50, 'Brasil', 0, 50, 0, 100000, 165000, 2500, 12, 2, 50, 74),
(613, 'Murilo', 14, 28, 'ZAG', 74, 64, 78, 76, 43, 83, 62, 75, 1, 50, 'Brasil', 0, 50, 0, 5000000, 24250000, 83500, 48, 2, 85, 62),
(614, 'Alexander Barboza', 4, 30, 'ZAG', 76, 67, 88, 79, 45, 84, 64, 76, 0, 50, 'Uruguai', 0, 50, 0, 4500000, 18965000, 92000, 36, 2, 50, 74),
(615, 'Bruno Fuchs', 13, 26, 'ZAG', 75, 72, 87, 68, 45, 78, 66, 76, 1, 50, 'Brasil', 0, 50, 0, 4000000, 10065000, 54500, 48, 2, 50, 74),
(616, 'Luis Benedetti', 33, 19, 'ZAG', 69, 59, 67, 67, 43, 71, 65, 78, 2, 50, 'Brasil', 1, 50, 0, 4000000, 18150000, 45500, 48, 2, 50, 74),
(617, 'Gustavo Gómez', 3, 32, 'ZAG', 77, 70, 82, 76, 48, 82, 77, 77, 0, 50, 'Paraguai', 0, 50, 0, 3500000, 16675000, 71500, 60, 2, 50, 74),
(618, 'Joaquín Piquerez', 6, 27, 'LE', 78, 82, 68, 77, 61, 78, 74, 79, 0, 50, 'Uruguai', 0, 50, 0, 12000000, 51895000, 241250, 60, 2, 15, 62),
(619, 'Jefté', 26, 22, 'LE', 71, 69, 56, 69, 54, 71, 74, 75, 2, 50, 'Brasil', 1, 50, 0, 4000000, 17285000, 67000, 55, 2, 50, 58),
(620, 'Arthur Gabriel', 16, 20, 'LE', 72, 72, 61, 75, 60, 67, 74, 78, 1, 50, 'Brasil', 0, 50, 0, 4000000, 17560000, 68250, 60, 2, 50, 58),
(621, 'Agustín Giay', 2, 21, 'LD', 77, 84, 66, 76, 59, 73, 79, 81, 0, 50, 'Argentina', 0, 50, 0, 11000000, 54805000, 138250, 60, 2, 50, 58),
(622, 'Khellven', 23, 24, 'LD', 75, 87, 71, 70, 57, 66, 78, 79, 1, 50, 'Brasil', 0, 50, 0, 6000000, 27610000, 96250, 54, 2, 50, 48),
(623, 'Marlon Freitas', 5, 30, 'VOL', 77, 68, 83, 80, 64, 89, 72, 77, 0, 50, 'Brasil', 0, 50, 0, 6000000, 22845000, 103000, 36, 2, 50, 48),
(624, 'Emiliano Martínez', 15, 26, 'VOL', 74, 76, 86, 76, 62, 86, 72, 75, 1, 50, 'Uruguai', 0, 50, 0, 5000000, 17040000, 92250, 48, 2, 50, 48),
(625, 'Luis Pacheco', 17, 17, 'VOL', 66, 64, 60, 66, 50, 71, 66, 78, 2, 50, 'Brasil', 1, 50, 0, 1500000, 6410000, 21750, 48, 2, 50, 48),
(626, 'Andreas Pereira', 8, 30, 'MC', 79, 72, 73, 82, 73, 70, 88, 79, 0, 50, 'Brasil', 0, 50, 0, 14000000, 43265000, 245000, 36, 2, 50, 48),
(627, 'Lucas Evangelista', 18, 30, 'MC', 73, 70, 69, 74, 58, 70, 77, 73, 1, 50, 'Brasil', 0, 50, 0, 4000000, 9630000, 63750, 24, 2, 50, 48),
(628, 'Larson', 28, 20, 'MC', 67, 71, 66, 63, 64, 64, 66, 75, 2, 50, 'Brasil', 1, 50, 0, 1000000, 4405000, 14750, 60, 2, 50, 48),
(629, 'Mauricio', 10, 24, 'MEI', 81, 79, 68, 90, 87, 53, 90, 84, 0, 50, 'Paraguai', 0, 50, 0, 18000000, 121535000, 346250, 36, 2, 20, 25),
(630, 'Erick Belé', 20, 18, 'MEI', 63, 65, 44, 63, 70, 44, 70, 75, 1, 50, 'Brasil', 1, 50, 0, 1000000, 4220000, 10500, 36, 2, 80, 25),
(631, 'Ramón Sosa', 11, 26, 'PE', 78, 89, 69, 75, 73, 60, 67, 79, 0, 50, 'Paraguai', 0, 50, 0, 10000000, 34350000, 174250, 54, 2, 50, 12),
(632, 'Felipe Anderson', 21, 32, 'PE', 68, 65, 52, 69, 72, 38, 67, 68, 1, 50, 'Brasil', 0, 50, 0, 1000000, 3330000, 25250, 24, 2, 50, 12),
(633, 'Jhon Arias', 7, 28, 'PD', 79, 82, 76, 80, 79, 52, 77, 80, 0, 50, 'Colômbia', 0, 50, 0, 15000000, 73275000, 237250, 48, 2, 50, 12),
(634, 'Paulinho', 99, 25, 'ATA', 77, 70, 79, 80, 82, 42, 67, 78, 1, 50, 'Brasil', 1, 50, 0, 7000000, 26465000, 104500, 48, 2, 50, 12),
(635, 'Vitor Roque', 9, 20, 'ATA', 80, 85, 82, 77, 80, 42, 73, 86, 0, 50, 'Brasil', 0, 50, 0, 38000000, 167905000, 708750, 48, 2, 50, 12),
(636, 'José Manuel López', 19, 25, 'ATA', 80, 82, 88, 80, 89, 56, 71, 82, 1, 50, 'Argentina', 0, 50, 0, 30000000, 116990000, 493250, 60, 2, 50, 12),
(637, 'Léo Jardim', 1, 30, 'GOL', 75, 53, 81, 76, 21, 65, 61, 75, 0, 50, 'Brasil', 0, 50, 0, 7000000, 23075000, 129250, 60, 12, 50, 12),
(638, 'Daniel Fuzato', 12, 28, 'GOL', 68, 38, 70, 65, 17, 66, 54, 68, 1, 50, 'Brasil', 0, 50, 0, 900000, 1975000, 16000, 12, 12, 50, 90),
(639, 'Pablo', 31, 22, 'GOL', 54, 39, 60, 58, 8, 42, 36, 59, 2, 50, 'Brasil', 1, 50, 0, 50000, 175000, 2500, 12, 12, 50, 90),
(640, 'Robert Renan', 3, 22, 'ZAG', 76, 66, 80, 78, 54, 81, 66, 82, 0, 50, 'Brasil', 0, 50, 0, 12000000, 41370000, 201500, 12, 12, 50, 48),
(641, 'Carlos Cuesta', 14, 26, 'ZAG', 73, 60, 72, 74, 45, 80, 71, 74, 1, 50, 'Colômbia', 0, 50, 0, 8000000, 11900000, 98000, 12, 12, 50, 90),
(642, 'Gabriel Pereira', 4, 25, 'ZAG', 75, 66, 70, 75, 48, 72, 71, 77, 0, 50, 'Brasil', 0, 50, 0, 6000000, 24615000, 109000, 18, 12, 50, 90),
(643, 'Lucas Freitas', 13, 24, 'ZAG', 74, 63, 81, 75, 48, 80, 66, 78, 1, 50, 'Brasil', 0, 50, 0, 4000000, 19945000, 78750, 24, 12, 85, 62),
(644, 'Alan Saldivia', 33, 23, 'ZAG', 67, 55, 70, 71, 39, 78, 56, 70, 2, 50, 'Uruguai', 1, 50, 0, 1200000, 3430000, 23000, 36, 12, 85, 62),
(645, 'Walace Falcão', 34, 20, 'ZAG', 56, 43, 54, 54, 38, 68, 44, 63, 2, 50, 'Brasil', 1, 50, 0, 100000, 345000, 2500, 24, 12, 85, 62),
(646, 'Cuiabano', 6, 22, 'LE', 76, 80, 69, 74, 63, 75, 77, 81, 0, 50, 'Brasil', 0, 50, 0, 12000000, 30295000, 165750, 12, 12, 50, 74),
(647, 'Lucas Piton', 16, 25, 'LE', 75, 78, 67, 76, 55, 69, 70, 77, 1, 50, 'Itália', 0, 50, 0, 6000000, 21785000, 111750, 36, 12, 50, 74),
(648, 'Riquelme', 26, 23, 'LE', 65, 73, 58, 57, 49, 61, 62, 70, 2, 50, 'Brasil', 1, 50, 0, 700000, 1600000, 12500, 12, 12, 50, 74),
(649, 'Paulinho', 36, 21, 'LE', 62, 70, 55, 56, 44, 61, 62, 69, 2, 50, 'Brasil', 1, 50, 0, 600000, 4190000, 9250, 48, 12, 50, 74),
(650, 'Paulo Henrique', 2, 29, 'LD', 75, 87, 67, 71, 56, 73, 75, 75, 0, 50, 'Brasil', 0, 50, 0, 6000000, 25325000, 103750, 24, 12, 50, 74),
(651, 'José Luis Rodríguez', 23, 28, 'LD', 71, 73, 71, 73, 57, 68, 69, 71, 1, 50, 'Uruguai', 0, 50, 0, 2000000, 7675000, 29000, 24, 12, 50, 74),
(652, 'João Mutano', 32, 20, 'LD', 60, 64, 50, 63, 42, 55, 59, 65, 2, 50, 'Brasil', 1, 50, 0, 500000, 1675000, 6500, 36, 12, 50, 74),
(653, 'Santiago Sosa', 5, 26, 'VOL', 76, 63, 80, 85, 57, 85, 78, 77, 0, 50, 'Argentina', 0, 50, 0, 8000000, 48450000, 131250, 48, 12, 50, 74),
(654, 'Cauan Barros', 15, 21, 'VOL', 72, 57, 63, 76, 53, 78, 80, 80, 1, 50, 'Brasil', 1, 50, 0, 7000000, 35100000, 111750, 24, 12, 50, 74),
(655, 'Mateus Carvalho', 25, 23, 'VOL', 70, 61, 69, 71, 50, 66, 69, 75, 2, 50, 'Brasil', 1, 50, 0, 1200000, 6080000, 21000, 24, 12, 15, 62),
(656, 'Thiago Mendes', 35, 33, 'VOL', 69, 50, 65, 72, 71, 74, 68, 69, 2, 50, 'Brasil', 0, 50, 0, 1000000, 1790000, 20500, 24, 12, 15, 62),
(657, 'Jair', 28, 31, 'VOL', 65, 56, 70, 70, 54, 68, 63, 65, 2, 50, 'Brasil', 1, 50, 0, 600000, 910000, 10500, 12, 12, 50, 58),
(658, 'Euder', 22, 20, 'VOL', 57, 34, 50, 60, 50, 56, 67, 65, 2, 50, 'Brasil', 1, 50, 0, 100000, 605000, 2500, 15, 12, 50, 58),
(659, 'Ramon Rique', 8, 18, 'MC', 71, 65, 68, 72, 53, 71, 74, 80, 0, 50, 'Brasil', 0, 50, 0, 5000000, 38840000, 52250, 48, 12, 50, 48),
(660, 'Tchê Tchê', 18, 33, 'MC', 70, 57, 51, 74, 69, 69, 71, 70, 1, 50, 'Brasil', 0, 50, 0, 800000, 910000, 17000, 12, 12, 50, 48),
(661, 'Alan Lescano', 10, 24, 'MEI', 75, 75, 67, 87, 71, 55, 87, 78, 0, 50, 'Argentina', 0, 50, 0, 7500000, 33780000, 114750, 48, 12, 50, 48),
(662, 'Johan Rojas', 20, 23, 'MEI', 72, 64, 57, 80, 76, 52, 84, 75, 1, 50, 'Colômbia', 0, 50, 0, 3800000, 9760000, 53250, 12, 12, 50, 48),
(663, 'Guilherme Estrella', 30, 20, 'MEI', 66, 56, 47, 73, 63, 47, 78, 75, 2, 50, 'Brasil', 1, 50, 0, 1000000, 5005000, 16250, 36, 12, 50, 48),
(664, 'Andrés Gómez', 11, 23, 'PE', 78, 85, 70, 81, 76, 45, 78, 81, 0, 50, 'Colômbia', 0, 50, 0, 15000000, 89435000, 211000, 61, 12, 50, 48),
(665, 'David', 21, 30, 'PE', 70, 75, 57, 71, 75, 51, 81, 70, 1, 50, 'Brasil', 0, 50, 0, 1500000, 4670000, 27250, 24, 12, 50, 48),
(666, 'Nuno Moreira', 17, 26, 'PD', 74, 83, 71, 69, 69, 45, 68, 75, 1, 50, 'Portugal', 0, 50, 0, 7000000, 20625000, 114750, 24, 12, 50, 90),
(667, 'Marino Hinestroza', 7, 23, 'PD', 75, 87, 69, 75, 75, 51, 75, 78, 0, 50, 'Colômbia', 0, 50, 0, 4000000, 28275000, 57250, 48, 12, 50, 48),
(668, 'Adson', 27, 25, 'PD', 72, 76, 59, 64, 63, 40, 69, 73, 2, 50, 'Brasil', 0, 50, 0, 2500000, 4770000, 24000, 24, 12, 20, 25),
(669, 'Loide Augusto', 37, 25, 'PD', 67, 79, 63, 59, 60, 41, 68, 69, 2, 50, 'Angola', 1, 50, 0, 1200000, 4930000, 14750, 24, 12, 20, 25),
(670, 'Facundo Colidio', 9, 25, 'ATA', 76, 77, 75, 78, 88, 36, 69, 78, 0, 50, 'Argentina', 0, 50, 0, 6000000, 29625000, 136000, 48, 12, 50, 12),
(671, 'Bruno Duarte', 19, 29, 'ATA', 74, 76, 73, 82, 77, 44, 58, 74, 1, 50, 'Brasil', 0, 50, 0, 4000000, 10055000, 64500, 36, 12, 80, 25),
(672, 'Brenner', 99, 25, 'ATA', 74, 71, 73, 78, 74, 50, 64, 76, 1, 50, 'Brasil', 0, 50, 0, 4000000, 16910000, 54750, 48, 12, 50, 12),
(673, 'Claudio Spinelli', 29, 28, 'ATA', 72, 70, 77, 72, 82, 43, 70, 72, 2, 50, 'Argentina', 0, 50, 0, 3000000, 8435000, 45750, 36, 12, 50, 12);

-- --------------------------------------------------------

--
-- Table structure for table `jogador_lesao`
--

CREATE TABLE `jogador_lesao` (
  `lesao_idLesao` int(11) NOT NULL,
  `jogador_idJogador` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lesao`
--

CREATE TABLE `lesao` (
  `idLesao` int(11) NOT NULL,
  `nomeLesao` varchar(255) NOT NULL,
  `tempoLesionado` int(11) NOT NULL,
  `gravidade` enum('LEVE','MODERADO','GRAVE') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `lesao`
--

INSERT INTO `lesao` (`idLesao`, `nomeLesao`, `tempoLesionado`, `gravidade`) VALUES
(1, 'lesao leve', 3, 'LEVE');

-- --------------------------------------------------------

--
-- Table structure for table `manager`
--

CREATE TABLE `manager` (
  `idManager` int(11) NOT NULL,
  `nomeManager` varchar(45) NOT NULL,
  `nacionalidade` varchar(45) NOT NULL,
  `foto` varchar(255) NOT NULL,
  `reputacao` enum('INICIANTE','PROMISSOR','RENOMADO','LENDA') NOT NULL,
  `exp` int(11) NOT NULL,
  `contratoFim` int(11) NOT NULL,
  `clube_idClube` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `manager`
--

INSERT INTO `manager` (`idManager`, `nomeManager`, `nacionalidade`, `foto`, `reputacao`, `exp`, `contratoFim`, `clube_idClube`) VALUES
(19, 'trfh', 'portugues', 'img/rostosManagers/padrao.png', 'INICIANTE', 0, 2027, 16),
(20, 'gdfgdf', 'brasileiro', 'img/rostosManagers/manager-3.jpg', 'INICIANTE', 0, 2027, 16),
(21, 'teste', 'brasileiro', 'img/rostosManagers/manager-1.jpg', 'INICIANTE', 0, 2027, 12);

-- --------------------------------------------------------

--
-- Table structure for table `meta_temporada`
--

CREATE TABLE `meta_temporada` (
  `idMetaTemporada` int(11) NOT NULL,
  `descricao` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `meta_temporada`
--

INSERT INTO `meta_temporada` (`idMetaTemporada`, `descricao`) VALUES
(1, 'Ser Campeão do Campeonato Brasileiro'),
(2, 'Classificar para a Copa Libertadores'),
(3, 'Classificar para a Copa Sul-Americana'),
(4, 'Evitar o Rebaixamento'),
(5, 'Chegar às Semifinais da Copa do Brasil'),
(6, 'Vender um jogador maior que 70 de over nessa temporada'),
(7, 'Manter o orçamento maior que 3M');

-- --------------------------------------------------------

--
-- Table structure for table `noticia`
--

CREATE TABLE `noticia` (
  `idNoticia` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `categoria` enum('MERCADO','IMPRENSA') NOT NULL,
  `dataPublicacao` datetime NOT NULL,
  `clube_idClube` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `noticia`
--

INSERT INTO `noticia` (`idNoticia`, `titulo`, `categoria`, `dataPublicacao`, `clube_idClube`) VALUES
(23, 'Liverpool prepara uma oferta por Puma Rodriguez (Vasco)', 'MERCADO', '2026-01-05 09:30:00', 12),
(24, 'Palmeiras monitora situação de Kevin Serna e pode fazer proposta ao Fluminense', 'MERCADO', '2026-01-06 11:15:00', 7),
(25, 'Flamengo avança nas conversas por zagueiro do Bahia e prepara oferta de R$ 40 milhões', 'MERCADO', '2026-01-07 14:00:00', 11),
(26, 'Botafogo negocia empréstimo de atacante do Santos até o fim da temporada', 'MERCADO', '2026-01-08 10:45:00', 13),
(27, 'Corinthians quer repatriar meia que joga na Europa e inicia sondagem', 'MERCADO', '2026-01-09 16:20:00', 4),
(28, 'Cruzeiro abre negociação para renovar contrato de jovem promessa da base', 'MERCADO', '2026-01-10 12:00:00', 10),
(29, 'Atlético-MG coloca zagueiro na lista de transferências e aceita propostas', 'MERCADO', '2026-01-11 09:10:00', 5),
(30, 'Grêmio e Internacional disputam a contratação de lateral argentino', 'MERCADO', '2026-01-12 18:30:00', 8),
(31, 'Cano marca três gols em treino e anima a torcida do Fluminense', 'IMPRENSA', '2026-01-05 08:00:00', 7),
(32, 'Ganso elogia ambiente do vestiário e pede foco na sequência do campeonato', 'IMPRENSA', '2026-01-06 13:40:00', 7),
(33, 'Diretoria avalia renovar contrato de Arana antes do fim do vínculo', 'IMPRENSA', '2026-01-07 17:25:00', 7),
(34, 'Torcida esgota ingressos para o próximo jogo no Maracanã', 'IMPRENSA', '2026-01-08 15:00:00', 7),
(35, 'Luciano Acosta é apontado pela imprensa como o melhor meia do campeonato', 'IMPRENSA', '2026-01-09 09:50:00', 7),
(36, 'Treinador promete mudanças na escalação após sequência de empates', 'IMPRENSA', '2026-01-10 19:10:00', 7),
(37, 'Riquelme, promessa da base, recebe elogios da comissão técnica', 'IMPRENSA', '2026-01-11 11:30:00', 7),
(38, 'John Kennedy desperta interesse de clubes europeus, mas Fluminense diz que não vende', 'IMPRENSA', '2026-01-12 14:45:00', 7);

-- --------------------------------------------------------

--
-- Table structure for table `noticia_diretoria`
--

CREATE TABLE `noticia_diretoria` (
  `idNoticia` int(11) NOT NULL,
  `texto` varchar(255) NOT NULL,
  `data_registro` date NOT NULL,
  `clube_idClube` int(11) NOT NULL,
  `modificador` int(11) NOT NULL,
  `tipoModificador` enum('SOMA','SUBTRACAO') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `partida`
--

CREATE TABLE `partida` (
  `idPartida` int(11) NOT NULL,
  `golsMandante` int(11) NOT NULL,
  `golsVisitante` int(11) NOT NULL,
  `rodada` int(11) NOT NULL,
  `dataPartida` date NOT NULL,
  `statusPartida` enum('AGENDADA','EM_ANDAMENTO','FINALIZADA') NOT NULL,
  `visitanteIdClube` int(11) NOT NULL,
  `mandanteIdClube` int(11) NOT NULL,
  `horario` time DEFAULT NULL,
  `local` varchar(255) DEFAULT NULL,
  `competicao_idCompeticao` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `partida`
--

INSERT INTO `partida` (`idPartida`, `golsMandante`, `golsVisitante`, `rodada`, `dataPartida`, `statusPartida`, `visitanteIdClube`, `mandanteIdClube`, `horario`, `local`, `competicao_idCompeticao`) VALUES
(1, 0, 0, 1, '2026-10-10', 'AGENDADA', 20, 1, '16:00:00', 'Maracanã', 1),
(2, 0, 0, 1, '2026-10-10', 'AGENDADA', 2, 19, '16:00:00', 'Estádio Maião', 1),
(3, 0, 0, 1, '2026-10-10', 'AGENDADA', 18, 3, '16:00:00', 'MorumBIS', 1),
(4, 0, 0, 1, '2026-10-10', 'AGENDADA', 4, 17, '18:30:00', 'Couto Pereira', 1),
(5, 0, 0, 1, '2026-10-10', 'AGENDADA', 16, 5, '18:30:00', 'Arena MRV', 1),
(6, 0, 0, 1, '2026-10-10', 'AGENDADA', 6, 15, '18:30:00', 'Ligga Arena', 1),
(7, 0, 0, 1, '2026-10-10', 'AGENDADA', 14, 7, '18:30:00', 'Maracanã', 1),
(8, 0, 0, 1, '2026-10-10', 'AGENDADA', 8, 13, '21:00:00', 'Vila Belmiro', 1),
(9, 0, 0, 1, '2026-10-10', 'AGENDADA', 12, 9, '21:00:00', 'Beira-Rio', 1),
(10, 0, 0, 1, '2026-10-10', 'AGENDADA', 10, 11, '21:00:00', 'Arena Fonte Nova', 1),
(11, 0, 0, 2, '2026-10-14', 'AGENDADA', 1, 19, '16:00:00', 'Estádio Maião', 1),
(12, 0, 0, 2, '2026-10-14', 'AGENDADA', 18, 20, '16:00:00', 'Mangueirão', 1),
(13, 0, 0, 2, '2026-10-14', 'AGENDADA', 2, 17, '16:00:00', 'Couto Pereira', 1),
(14, 0, 0, 2, '2026-10-14', 'AGENDADA', 16, 3, '18:30:00', 'MorumBIS', 1),
(15, 0, 0, 2, '2026-10-14', 'AGENDADA', 4, 15, '18:30:00', 'Ligga Arena', 1),
(16, 0, 0, 2, '2026-10-14', 'AGENDADA', 14, 5, '18:30:00', 'Arena MRV', 1),
(17, 0, 0, 2, '2026-10-14', 'AGENDADA', 6, 13, '18:30:00', 'Vila Belmiro', 1),
(18, 0, 0, 2, '2026-10-14', 'AGENDADA', 12, 7, '21:00:00', 'Maracanã', 1),
(19, 0, 0, 2, '2026-10-14', 'AGENDADA', 8, 11, '21:00:00', 'Arena Fonte Nova', 1),
(20, 0, 0, 2, '2026-10-14', 'AGENDADA', 10, 9, '21:00:00', 'Beira-Rio', 1),
(21, 0, 0, 3, '2026-10-17', 'AGENDADA', 18, 1, '16:00:00', 'Maracanã', 1),
(22, 0, 0, 3, '2026-10-17', 'AGENDADA', 19, 17, '16:00:00', 'Couto Pereira', 1),
(23, 0, 0, 3, '2026-10-17', 'AGENDADA', 16, 20, '16:00:00', 'Mangueirão', 1),
(24, 0, 0, 3, '2026-10-17', 'AGENDADA', 2, 15, '18:30:00', 'Ligga Arena', 1),
(25, 0, 0, 3, '2026-10-17', 'AGENDADA', 14, 3, '18:30:00', 'MorumBIS', 1),
(26, 0, 0, 3, '2026-10-17', 'AGENDADA', 4, 13, '18:30:00', 'Vila Belmiro', 1),
(27, 0, 0, 3, '2026-10-17', 'AGENDADA', 12, 5, '18:30:00', 'Arena MRV', 1),
(28, 0, 0, 3, '2026-10-17', 'AGENDADA', 6, 11, '21:00:00', 'Arena Fonte Nova', 1),
(29, 0, 0, 3, '2026-10-17', 'AGENDADA', 10, 7, '21:00:00', 'Maracanã', 1),
(30, 0, 0, 3, '2026-10-17', 'AGENDADA', 8, 9, '21:00:00', 'Beira-Rio', 1),
(31, 0, 0, 4, '2026-10-21', 'AGENDADA', 1, 17, '16:00:00', 'Couto Pereira', 1),
(32, 0, 0, 4, '2026-10-21', 'AGENDADA', 16, 18, '16:00:00', 'Arena Condá', 1),
(33, 0, 0, 4, '2026-10-21', 'AGENDADA', 19, 15, '16:00:00', 'Ligga Arena', 1),
(34, 0, 0, 4, '2026-10-21', 'AGENDADA', 14, 20, '18:30:00', 'Mangueirão', 1),
(35, 0, 0, 4, '2026-10-21', 'AGENDADA', 2, 13, '18:30:00', 'Vila Belmiro', 1),
(36, 0, 0, 4, '2026-10-21', 'AGENDADA', 12, 3, '18:30:00', 'MorumBIS', 1),
(37, 0, 0, 4, '2026-10-21', 'AGENDADA', 4, 11, '18:30:00', 'Arena Fonte Nova', 1),
(38, 0, 0, 4, '2026-10-21', 'AGENDADA', 10, 5, '21:00:00', 'Arena MRV', 1),
(39, 0, 0, 4, '2026-10-21', 'AGENDADA', 6, 9, '21:00:00', 'Beira-Rio', 1),
(40, 0, 0, 4, '2026-10-21', 'AGENDADA', 8, 7, '21:00:00', 'Maracanã', 1),
(41, 0, 0, 5, '2026-10-24', 'AGENDADA', 16, 1, '16:00:00', 'Maracanã', 1),
(42, 0, 0, 5, '2026-10-24', 'AGENDADA', 17, 15, '16:00:00', 'Ligga Arena', 1),
(43, 0, 0, 5, '2026-10-24', 'AGENDADA', 14, 18, '16:00:00', 'Arena Condá', 1),
(44, 0, 0, 5, '2026-10-24', 'AGENDADA', 19, 13, '18:30:00', 'Vila Belmiro', 1),
(45, 0, 0, 5, '2026-10-24', 'AGENDADA', 12, 20, '18:30:00', 'Mangueirão', 1),
(46, 0, 0, 5, '2026-10-24', 'AGENDADA', 2, 11, '18:30:00', 'Arena Fonte Nova', 1),
(47, 0, 0, 5, '2026-10-24', 'AGENDADA', 10, 3, '18:30:00', 'MorumBIS', 1),
(48, 0, 0, 5, '2026-10-24', 'AGENDADA', 4, 9, '21:00:00', 'Beira-Rio', 1),
(49, 0, 0, 5, '2026-10-24', 'AGENDADA', 8, 5, '21:00:00', 'Arena MRV', 1),
(50, 0, 0, 5, '2026-10-24', 'AGENDADA', 6, 7, '21:00:00', 'Maracanã', 1),
(51, 0, 0, 6, '2026-10-28', 'AGENDADA', 1, 15, '16:00:00', 'Ligga Arena', 1),
(52, 0, 0, 6, '2026-10-28', 'AGENDADA', 14, 16, '16:00:00', 'Barradão', 1),
(53, 0, 0, 6, '2026-10-28', 'AGENDADA', 17, 13, '16:00:00', 'Vila Belmiro', 1),
(54, 0, 0, 6, '2026-10-28', 'AGENDADA', 12, 18, '18:30:00', 'Arena Condá', 1),
(55, 0, 0, 6, '2026-10-28', 'AGENDADA', 19, 11, '18:30:00', 'Arena Fonte Nova', 1),
(56, 0, 0, 6, '2026-10-28', 'AGENDADA', 10, 20, '18:30:00', 'Mangueirão', 1),
(57, 0, 0, 6, '2026-10-28', 'AGENDADA', 2, 9, '18:30:00', 'Beira-Rio', 1),
(58, 0, 0, 6, '2026-10-28', 'AGENDADA', 8, 3, '21:00:00', 'MorumBIS', 1),
(59, 0, 0, 6, '2026-10-28', 'AGENDADA', 4, 7, '21:00:00', 'Maracanã', 1),
(60, 0, 0, 6, '2026-10-28', 'AGENDADA', 6, 5, '21:00:00', 'Arena MRV', 1),
(61, 0, 0, 7, '2026-10-31', 'AGENDADA', 14, 1, '16:00:00', 'Maracanã', 1),
(62, 0, 0, 7, '2026-10-31', 'AGENDADA', 15, 13, '16:00:00', 'Vila Belmiro', 1),
(63, 0, 0, 7, '2026-10-31', 'AGENDADA', 12, 16, '16:00:00', 'Barradão', 1),
(64, 0, 0, 7, '2026-10-31', 'AGENDADA', 17, 11, '18:30:00', 'Arena Fonte Nova', 1),
(65, 0, 0, 7, '2026-10-31', 'AGENDADA', 10, 18, '18:30:00', 'Arena Condá', 1),
(66, 0, 0, 7, '2026-10-31', 'AGENDADA', 19, 9, '18:30:00', 'Beira-Rio', 1),
(67, 0, 0, 7, '2026-10-31', 'AGENDADA', 8, 20, '18:30:00', 'Mangueirão', 1),
(68, 0, 0, 7, '2026-10-31', 'AGENDADA', 2, 7, '21:00:00', 'Maracanã', 1),
(69, 0, 0, 7, '2026-10-31', 'AGENDADA', 6, 3, '21:00:00', 'MorumBIS', 1),
(70, 0, 0, 7, '2026-10-31', 'AGENDADA', 4, 5, '21:00:00', 'Arena MRV', 1),
(71, 0, 0, 8, '2026-11-04', 'AGENDADA', 1, 13, '16:00:00', 'Vila Belmiro', 1),
(72, 0, 0, 8, '2026-11-04', 'AGENDADA', 12, 14, '16:00:00', 'Nabi Abi Chedid', 1),
(73, 0, 0, 8, '2026-11-04', 'AGENDADA', 15, 11, '16:00:00', 'Arena Fonte Nova', 1),
(74, 0, 0, 8, '2026-11-04', 'AGENDADA', 10, 16, '18:30:00', 'Barradão', 1),
(75, 0, 0, 8, '2026-11-04', 'AGENDADA', 17, 9, '18:30:00', 'Beira-Rio', 1),
(76, 0, 0, 8, '2026-11-04', 'AGENDADA', 8, 18, '18:30:00', 'Arena Condá', 1),
(77, 0, 0, 8, '2026-11-04', 'AGENDADA', 19, 7, '18:30:00', 'Maracanã', 1),
(78, 0, 0, 8, '2026-11-04', 'AGENDADA', 6, 20, '21:00:00', 'Mangueirão', 1),
(79, 0, 0, 8, '2026-11-04', 'AGENDADA', 2, 5, '21:00:00', 'Arena MRV', 1),
(80, 0, 0, 8, '2026-11-04', 'AGENDADA', 4, 3, '21:00:00', 'MorumBIS', 1),
(81, 0, 0, 9, '2026-11-07', 'AGENDADA', 12, 1, '16:00:00', 'Maracanã', 1),
(82, 0, 0, 9, '2026-11-07', 'AGENDADA', 13, 11, '16:00:00', 'Arena Fonte Nova', 1),
(83, 0, 0, 9, '2026-11-07', 'AGENDADA', 10, 14, '16:00:00', 'Nabi Abi Chedid', 1),
(84, 0, 0, 9, '2026-11-07', 'AGENDADA', 15, 9, '18:30:00', 'Beira-Rio', 1),
(85, 0, 0, 9, '2026-11-07', 'AGENDADA', 8, 16, '18:30:00', 'Barradão', 1),
(86, 0, 0, 9, '2026-11-07', 'AGENDADA', 17, 7, '18:30:00', 'Maracanã', 1),
(87, 0, 0, 9, '2026-11-07', 'AGENDADA', 6, 18, '18:30:00', 'Arena Condá', 1),
(88, 0, 0, 9, '2026-11-07', 'AGENDADA', 19, 5, '21:00:00', 'Arena MRV', 1),
(89, 0, 0, 9, '2026-11-07', 'AGENDADA', 4, 20, '21:00:00', 'Mangueirão', 1),
(90, 0, 0, 9, '2026-11-07', 'AGENDADA', 2, 3, '21:00:00', 'MorumBIS', 1),
(91, 0, 0, 10, '2026-11-11', 'AGENDADA', 1, 11, '16:00:00', 'Arena Fonte Nova', 1),
(92, 0, 0, 10, '2026-11-11', 'AGENDADA', 10, 12, '16:00:00', 'São Januário', 1),
(93, 0, 0, 10, '2026-11-11', 'AGENDADA', 13, 9, '16:00:00', 'Beira-Rio', 1),
(94, 0, 0, 10, '2026-11-11', 'AGENDADA', 8, 14, '18:30:00', 'Nabi Abi Chedid', 1),
(95, 0, 0, 10, '2026-11-11', 'AGENDADA', 15, 7, '18:30:00', 'Maracanã', 1),
(96, 0, 0, 10, '2026-11-11', 'AGENDADA', 6, 16, '18:30:00', 'Barradão', 1),
(97, 0, 0, 10, '2026-11-11', 'AGENDADA', 17, 5, '18:30:00', 'Arena MRV', 1),
(98, 0, 0, 10, '2026-11-11', 'AGENDADA', 4, 18, '21:00:00', 'Arena Condá', 1),
(99, 0, 0, 10, '2026-11-11', 'AGENDADA', 19, 3, '21:00:00', 'MorumBIS', 1),
(100, 0, 0, 10, '2026-11-11', 'AGENDADA', 2, 20, '21:00:00', 'Mangueirão', 1),
(101, 0, 0, 11, '2026-11-14', 'AGENDADA', 10, 1, '16:00:00', 'Maracanã', 1),
(102, 0, 0, 11, '2026-11-14', 'AGENDADA', 11, 9, '16:00:00', 'Beira-Rio', 1),
(103, 0, 0, 11, '2026-11-14', 'AGENDADA', 8, 12, '16:00:00', 'São Januário', 1),
(104, 0, 0, 11, '2026-11-14', 'AGENDADA', 13, 7, '18:30:00', 'Maracanã', 1),
(105, 0, 0, 11, '2026-11-14', 'AGENDADA', 6, 14, '18:30:00', 'Nabi Abi Chedid', 1),
(106, 0, 0, 11, '2026-11-14', 'AGENDADA', 15, 5, '18:30:00', 'Arena MRV', 1),
(107, 0, 0, 11, '2026-11-14', 'AGENDADA', 4, 16, '18:30:00', 'Barradão', 1),
(108, 0, 0, 11, '2026-11-14', 'AGENDADA', 17, 3, '21:00:00', 'MorumBIS', 1),
(109, 0, 0, 11, '2026-11-14', 'AGENDADA', 2, 18, '21:00:00', 'Arena Condá', 1),
(110, 0, 0, 11, '2026-11-14', 'AGENDADA', 19, 20, '21:00:00', 'Mangueirão', 1),
(111, 0, 0, 12, '2026-11-18', 'AGENDADA', 1, 9, '16:00:00', 'Beira-Rio', 1),
(112, 0, 0, 12, '2026-11-18', 'AGENDADA', 8, 10, '16:00:00', 'Mineirão', 1),
(113, 0, 0, 12, '2026-11-18', 'AGENDADA', 11, 7, '16:00:00', 'Maracanã', 1),
(114, 0, 0, 12, '2026-11-18', 'AGENDADA', 6, 12, '18:30:00', 'São Januário', 1),
(115, 0, 0, 12, '2026-11-18', 'AGENDADA', 13, 5, '18:30:00', 'Arena MRV', 1),
(116, 0, 0, 12, '2026-11-18', 'AGENDADA', 4, 14, '18:30:00', 'Nabi Abi Chedid', 1),
(117, 0, 0, 12, '2026-11-18', 'AGENDADA', 15, 3, '18:30:00', 'MorumBIS', 1),
(118, 0, 0, 12, '2026-11-18', 'AGENDADA', 2, 16, '21:00:00', 'Barradão', 1),
(119, 0, 0, 12, '2026-11-18', 'AGENDADA', 17, 20, '21:00:00', 'Mangueirão', 1),
(120, 0, 0, 12, '2026-11-18', 'AGENDADA', 19, 18, '21:00:00', 'Arena Condá', 1),
(121, 0, 0, 13, '2026-11-21', 'AGENDADA', 8, 1, '16:00:00', 'Maracanã', 1),
(122, 0, 0, 13, '2026-11-21', 'AGENDADA', 9, 7, '16:00:00', 'Maracanã', 1),
(123, 0, 0, 13, '2026-11-21', 'AGENDADA', 6, 10, '16:00:00', 'Mineirão', 1),
(124, 0, 0, 13, '2026-11-21', 'AGENDADA', 11, 5, '18:30:00', 'Arena MRV', 1),
(125, 0, 0, 13, '2026-11-21', 'AGENDADA', 4, 12, '18:30:00', 'São Januário', 1),
(126, 0, 0, 13, '2026-11-21', 'AGENDADA', 13, 3, '18:30:00', 'MorumBIS', 1),
(127, 0, 0, 13, '2026-11-21', 'AGENDADA', 2, 14, '18:30:00', 'Nabi Abi Chedid', 1),
(128, 0, 0, 13, '2026-11-21', 'AGENDADA', 15, 20, '21:00:00', 'Mangueirão', 1),
(129, 0, 0, 13, '2026-11-21', 'AGENDADA', 19, 16, '21:00:00', 'Barradão', 1),
(130, 0, 0, 13, '2026-11-21', 'AGENDADA', 17, 18, '21:00:00', 'Arena Condá', 1),
(131, 0, 0, 14, '2026-11-25', 'AGENDADA', 1, 7, '16:00:00', 'Maracanã', 1),
(132, 0, 0, 14, '2026-11-25', 'AGENDADA', 6, 8, '16:00:00', 'Arena do Grêmio', 1),
(133, 0, 0, 14, '2026-11-25', 'AGENDADA', 9, 5, '16:00:00', 'Arena MRV', 1),
(134, 0, 0, 14, '2026-11-25', 'AGENDADA', 4, 10, '18:30:00', 'Mineirão', 1),
(135, 0, 0, 14, '2026-11-25', 'AGENDADA', 11, 3, '18:30:00', 'MorumBIS', 1),
(136, 0, 0, 14, '2026-11-25', 'AGENDADA', 2, 12, '18:30:00', 'São Januário', 1),
(137, 0, 0, 14, '2026-11-25', 'AGENDADA', 13, 20, '18:30:00', 'Mangueirão', 1),
(138, 0, 0, 14, '2026-11-25', 'AGENDADA', 19, 14, '21:00:00', 'Nabi Abi Chedid', 1),
(139, 0, 0, 14, '2026-11-25', 'AGENDADA', 15, 18, '21:00:00', 'Arena Condá', 1),
(140, 0, 0, 14, '2026-11-25', 'AGENDADA', 17, 16, '21:00:00', 'Barradão', 1),
(141, 0, 0, 15, '2026-11-28', 'AGENDADA', 6, 1, '16:00:00', 'Maracanã', 1),
(142, 0, 0, 15, '2026-11-28', 'AGENDADA', 7, 5, '16:00:00', 'Arena MRV', 1),
(143, 0, 0, 15, '2026-11-28', 'AGENDADA', 4, 8, '16:00:00', 'Arena do Grêmio', 1),
(144, 0, 0, 15, '2026-11-28', 'AGENDADA', 9, 3, '18:30:00', 'MorumBIS', 1),
(145, 0, 0, 15, '2026-11-28', 'AGENDADA', 2, 10, '18:30:00', 'Mineirão', 1),
(146, 0, 0, 15, '2026-11-28', 'AGENDADA', 11, 20, '18:30:00', 'Mangueirão', 1),
(147, 0, 0, 15, '2026-11-28', 'AGENDADA', 19, 12, '18:30:00', 'São Januário', 1),
(148, 0, 0, 15, '2026-11-28', 'AGENDADA', 13, 18, '21:00:00', 'Arena Condá', 1),
(149, 0, 0, 15, '2026-11-28', 'AGENDADA', 17, 14, '21:00:00', 'Nabi Abi Chedid', 1),
(150, 0, 0, 15, '2026-11-28', 'AGENDADA', 15, 16, '21:00:00', 'Barradão', 1),
(151, 0, 0, 16, '2026-12-02', 'AGENDADA', 1, 5, '16:00:00', 'Arena MRV', 1),
(152, 0, 0, 16, '2026-12-02', 'AGENDADA', 4, 6, '16:00:00', 'Estádio Nilton Santos', 1),
(153, 0, 0, 16, '2026-12-02', 'AGENDADA', 7, 3, '16:00:00', 'MorumBIS', 1),
(154, 0, 0, 16, '2026-12-02', 'AGENDADA', 2, 8, '18:30:00', 'Arena do Grêmio', 1),
(155, 0, 0, 16, '2026-12-02', 'AGENDADA', 9, 20, '18:30:00', 'Mangueirão', 1),
(156, 0, 0, 16, '2026-12-02', 'AGENDADA', 19, 10, '18:30:00', 'Mineirão', 1),
(157, 0, 0, 16, '2026-12-02', 'AGENDADA', 11, 18, '18:30:00', 'Arena Condá', 1),
(158, 0, 0, 16, '2026-12-02', 'AGENDADA', 17, 12, '21:00:00', 'São Januário', 1),
(159, 0, 0, 16, '2026-12-02', 'AGENDADA', 13, 16, '21:00:00', 'Barradão', 1),
(160, 0, 0, 16, '2026-12-02', 'AGENDADA', 15, 14, '21:00:00', 'Nabi Abi Chedid', 1),
(161, 0, 0, 17, '2026-12-05', 'AGENDADA', 4, 1, '16:00:00', 'Maracanã', 1),
(162, 0, 0, 17, '2026-12-05', 'AGENDADA', 5, 3, '16:00:00', 'MorumBIS', 1),
(163, 0, 0, 17, '2026-12-05', 'AGENDADA', 2, 6, '16:00:00', 'Estádio Nilton Santos', 1),
(164, 0, 0, 17, '2026-12-05', 'AGENDADA', 7, 20, '18:30:00', 'Mangueirão', 1),
(165, 0, 0, 17, '2026-12-05', 'AGENDADA', 19, 8, '18:30:00', 'Arena do Grêmio', 1),
(166, 0, 0, 17, '2026-12-05', 'AGENDADA', 9, 18, '18:30:00', 'Arena Condá', 1),
(167, 0, 0, 17, '2026-12-05', 'AGENDADA', 17, 10, '18:30:00', 'Mineirão', 1),
(168, 0, 0, 17, '2026-12-05', 'AGENDADA', 11, 16, '21:00:00', 'Barradão', 1),
(169, 0, 0, 17, '2026-12-05', 'AGENDADA', 15, 12, '21:00:00', 'São Januário', 1),
(170, 0, 0, 17, '2026-12-05', 'AGENDADA', 13, 14, '21:00:00', 'Nabi Abi Chedid', 1),
(171, 0, 0, 18, '2026-12-09', 'AGENDADA', 1, 3, '16:00:00', 'MorumBIS', 1),
(172, 0, 0, 18, '2026-12-09', 'AGENDADA', 2, 4, '16:00:00', 'Neo Química Arena', 1),
(173, 0, 0, 18, '2026-12-09', 'AGENDADA', 5, 20, '16:00:00', 'Mangueirão', 1),
(174, 0, 0, 18, '2026-12-09', 'AGENDADA', 19, 6, '18:30:00', 'Estádio Nilton Santos', 1),
(175, 0, 0, 18, '2026-12-09', 'AGENDADA', 7, 18, '18:30:00', 'Arena Condá', 1),
(176, 0, 0, 18, '2026-12-09', 'AGENDADA', 17, 8, '18:30:00', 'Arena do Grêmio', 1),
(177, 0, 0, 18, '2026-12-09', 'AGENDADA', 9, 16, '18:30:00', 'Barradão', 1),
(178, 0, 0, 18, '2026-12-09', 'AGENDADA', 15, 10, '21:00:00', 'Mineirão', 1),
(179, 0, 0, 18, '2026-12-09', 'AGENDADA', 11, 14, '21:00:00', 'Nabi Abi Chedid', 1),
(180, 0, 0, 18, '2026-12-09', 'AGENDADA', 13, 12, '21:00:00', 'São Januário', 1),
(181, 0, 0, 19, '2026-12-12', 'AGENDADA', 2, 1, '16:00:00', 'Maracanã', 1),
(182, 0, 0, 19, '2026-12-12', 'AGENDADA', 3, 20, '16:00:00', 'Mangueirão', 1),
(183, 0, 0, 19, '2026-12-12', 'AGENDADA', 19, 4, '16:00:00', 'Neo Química Arena', 1),
(184, 0, 0, 19, '2026-12-12', 'AGENDADA', 5, 18, '18:30:00', 'Arena Condá', 1),
(185, 0, 0, 19, '2026-12-12', 'AGENDADA', 17, 6, '18:30:00', 'Estádio Nilton Santos', 1),
(186, 0, 0, 19, '2026-12-12', 'AGENDADA', 7, 16, '18:30:00', 'Barradão', 1),
(187, 0, 0, 19, '2026-12-12', 'AGENDADA', 15, 8, '18:30:00', 'Arena do Grêmio', 1),
(188, 0, 0, 19, '2026-12-12', 'AGENDADA', 9, 14, '21:00:00', 'Nabi Abi Chedid', 1),
(189, 0, 0, 19, '2026-12-12', 'AGENDADA', 13, 10, '21:00:00', 'Mineirão', 1),
(190, 0, 0, 19, '2026-12-12', 'AGENDADA', 11, 12, '21:00:00', 'São Januário', 1),
(191, 0, 0, 20, '2026-12-16', 'AGENDADA', 1, 20, '16:00:00', 'Mangueirão', 1),
(192, 0, 0, 20, '2026-12-16', 'AGENDADA', 19, 2, '16:00:00', 'Allianz Parque', 1),
(193, 0, 0, 20, '2026-12-16', 'AGENDADA', 3, 18, '16:00:00', 'Arena Condá', 1),
(194, 0, 0, 20, '2026-12-16', 'AGENDADA', 17, 4, '18:30:00', 'Neo Química Arena', 1),
(195, 0, 0, 20, '2026-12-16', 'AGENDADA', 5, 16, '18:30:00', 'Barradão', 1),
(196, 0, 0, 20, '2026-12-16', 'AGENDADA', 15, 6, '18:30:00', 'Estádio Nilton Santos', 1),
(197, 0, 0, 20, '2026-12-16', 'AGENDADA', 7, 14, '18:30:00', 'Nabi Abi Chedid', 1),
(198, 0, 0, 20, '2026-12-16', 'AGENDADA', 13, 8, '21:00:00', 'Arena do Grêmio', 1),
(199, 0, 0, 20, '2026-12-16', 'AGENDADA', 9, 12, '21:00:00', 'São Januário', 1),
(200, 0, 0, 20, '2026-12-16', 'AGENDADA', 11, 10, '21:00:00', 'Mineirão', 1),
(201, 0, 0, 21, '2026-12-19', 'AGENDADA', 19, 1, '16:00:00', 'Maracanã', 1),
(202, 0, 0, 21, '2026-12-19', 'AGENDADA', 20, 18, '16:00:00', 'Arena Condá', 1),
(203, 0, 0, 21, '2026-12-19', 'AGENDADA', 17, 2, '16:00:00', 'Allianz Parque', 1),
(204, 0, 0, 21, '2026-12-19', 'AGENDADA', 3, 16, '18:30:00', 'Barradão', 1),
(205, 0, 0, 21, '2026-12-19', 'AGENDADA', 15, 4, '18:30:00', 'Neo Química Arena', 1),
(206, 0, 0, 21, '2026-12-19', 'AGENDADA', 5, 14, '18:30:00', 'Nabi Abi Chedid', 1),
(207, 0, 0, 21, '2026-12-19', 'AGENDADA', 13, 6, '18:30:00', 'Estádio Nilton Santos', 1),
(208, 0, 0, 21, '2026-12-19', 'AGENDADA', 7, 12, '21:00:00', 'São Januário', 1),
(209, 0, 0, 21, '2026-12-19', 'AGENDADA', 11, 8, '21:00:00', 'Arena do Grêmio', 1),
(210, 0, 0, 21, '2026-12-19', 'AGENDADA', 9, 10, '21:00:00', 'Mineirão', 1),
(211, 0, 0, 22, '2026-12-23', 'AGENDADA', 1, 18, '16:00:00', 'Arena Condá', 1),
(212, 0, 0, 22, '2026-12-23', 'AGENDADA', 17, 19, '16:00:00', 'Estádio Maião', 1),
(213, 0, 0, 22, '2026-12-23', 'AGENDADA', 20, 16, '16:00:00', 'Barradão', 1),
(214, 0, 0, 22, '2026-12-23', 'AGENDADA', 15, 2, '18:30:00', 'Allianz Parque', 1),
(215, 0, 0, 22, '2026-12-23', 'AGENDADA', 3, 14, '18:30:00', 'Nabi Abi Chedid', 1),
(216, 0, 0, 22, '2026-12-23', 'AGENDADA', 13, 4, '18:30:00', 'Neo Química Arena', 1),
(217, 0, 0, 22, '2026-12-23', 'AGENDADA', 5, 12, '18:30:00', 'São Januário', 1),
(218, 0, 0, 22, '2026-12-23', 'AGENDADA', 11, 6, '21:00:00', 'Estádio Nilton Santos', 1),
(219, 0, 0, 22, '2026-12-23', 'AGENDADA', 7, 10, '21:00:00', 'Mineirão', 1),
(220, 0, 0, 22, '2026-12-23', 'AGENDADA', 9, 8, '21:00:00', 'Arena do Grêmio', 1),
(221, 0, 0, 23, '2026-12-26', 'AGENDADA', 17, 1, '16:00:00', 'Maracanã', 1),
(222, 0, 0, 23, '2026-12-26', 'AGENDADA', 18, 16, '16:00:00', 'Barradão', 1),
(223, 0, 0, 23, '2026-12-26', 'AGENDADA', 15, 19, '16:00:00', 'Estádio Maião', 1),
(224, 0, 0, 23, '2026-12-26', 'AGENDADA', 20, 14, '18:30:00', 'Nabi Abi Chedid', 1),
(225, 0, 0, 23, '2026-12-26', 'AGENDADA', 13, 2, '18:30:00', 'Allianz Parque', 1),
(226, 0, 0, 23, '2026-12-26', 'AGENDADA', 3, 12, '18:30:00', 'São Januário', 1),
(227, 0, 0, 23, '2026-12-26', 'AGENDADA', 11, 4, '18:30:00', 'Neo Química Arena', 1),
(228, 0, 0, 23, '2026-12-26', 'AGENDADA', 5, 10, '21:00:00', 'Mineirão', 1),
(229, 0, 0, 23, '2026-12-26', 'AGENDADA', 9, 6, '21:00:00', 'Estádio Nilton Santos', 1),
(230, 0, 0, 23, '2026-12-26', 'AGENDADA', 7, 8, '21:00:00', 'Arena do Grêmio', 1),
(231, 0, 0, 24, '2026-12-30', 'AGENDADA', 1, 16, '16:00:00', 'Barradão', 1),
(232, 0, 0, 24, '2026-12-30', 'AGENDADA', 15, 17, '16:00:00', 'Couto Pereira', 1),
(233, 0, 0, 24, '2026-12-30', 'AGENDADA', 18, 14, '16:00:00', 'Nabi Abi Chedid', 1),
(234, 0, 0, 24, '2026-12-30', 'AGENDADA', 13, 19, '18:30:00', 'Estádio Maião', 1),
(235, 0, 0, 24, '2026-12-30', 'AGENDADA', 20, 12, '18:30:00', 'São Januário', 1),
(236, 0, 0, 24, '2026-12-30', 'AGENDADA', 11, 2, '18:30:00', 'Allianz Parque', 1),
(237, 0, 0, 24, '2026-12-30', 'AGENDADA', 3, 10, '18:30:00', 'Mineirão', 1),
(238, 0, 0, 24, '2026-12-30', 'AGENDADA', 9, 4, '21:00:00', 'Neo Química Arena', 1),
(239, 0, 0, 24, '2026-12-30', 'AGENDADA', 5, 8, '21:00:00', 'Arena do Grêmio', 1),
(240, 0, 0, 24, '2026-12-30', 'AGENDADA', 7, 6, '21:00:00', 'Estádio Nilton Santos', 1),
(241, 0, 0, 25, '2027-01-02', 'AGENDADA', 15, 1, '16:00:00', 'Maracanã', 1),
(242, 0, 0, 25, '2027-01-02', 'AGENDADA', 16, 14, '16:00:00', 'Nabi Abi Chedid', 1),
(243, 0, 0, 25, '2027-01-02', 'AGENDADA', 13, 17, '16:00:00', 'Couto Pereira', 1),
(244, 0, 0, 25, '2027-01-02', 'AGENDADA', 18, 12, '18:30:00', 'São Januário', 1),
(245, 0, 0, 25, '2027-01-02', 'AGENDADA', 11, 19, '18:30:00', 'Estádio Maião', 1),
(246, 0, 0, 25, '2027-01-02', 'AGENDADA', 20, 10, '18:30:00', 'Mineirão', 1),
(247, 0, 0, 25, '2027-01-02', 'AGENDADA', 9, 2, '18:30:00', 'Allianz Parque', 1),
(248, 0, 0, 25, '2027-01-02', 'AGENDADA', 3, 8, '21:00:00', 'Arena do Grêmio', 1),
(249, 0, 0, 25, '2027-01-02', 'AGENDADA', 7, 4, '21:00:00', 'Neo Química Arena', 1),
(250, 0, 0, 25, '2027-01-02', 'AGENDADA', 5, 6, '21:00:00', 'Estádio Nilton Santos', 1),
(251, 0, 0, 26, '2027-01-06', 'AGENDADA', 1, 14, '16:00:00', 'Nabi Abi Chedid', 1),
(252, 0, 0, 26, '2027-01-06', 'AGENDADA', 13, 15, '16:00:00', 'Ligga Arena', 1),
(253, 0, 0, 26, '2027-01-06', 'AGENDADA', 16, 12, '16:00:00', 'São Januário', 1),
(254, 0, 0, 26, '2027-01-06', 'AGENDADA', 11, 17, '18:30:00', 'Couto Pereira', 1),
(255, 0, 0, 26, '2027-01-06', 'AGENDADA', 18, 10, '18:30:00', 'Mineirão', 1),
(256, 0, 0, 26, '2027-01-06', 'AGENDADA', 9, 19, '18:30:00', 'Estádio Maião', 1),
(257, 0, 0, 26, '2027-01-06', 'AGENDADA', 20, 8, '18:30:00', 'Arena do Grêmio', 1),
(258, 0, 0, 26, '2027-01-06', 'AGENDADA', 7, 2, '21:00:00', 'Allianz Parque', 1),
(259, 0, 0, 26, '2027-01-06', 'AGENDADA', 3, 6, '21:00:00', 'Estádio Nilton Santos', 1),
(260, 0, 0, 26, '2027-01-06', 'AGENDADA', 5, 4, '21:00:00', 'Neo Química Arena', 1),
(261, 0, 0, 27, '2027-01-09', 'AGENDADA', 13, 1, '16:00:00', 'Maracanã', 1),
(262, 0, 0, 27, '2027-01-09', 'AGENDADA', 14, 12, '16:00:00', 'São Januário', 1),
(263, 0, 0, 27, '2027-01-09', 'AGENDADA', 11, 15, '16:00:00', 'Ligga Arena', 1),
(264, 0, 0, 27, '2027-01-09', 'AGENDADA', 16, 10, '18:30:00', 'Mineirão', 1),
(265, 0, 0, 27, '2027-01-09', 'AGENDADA', 9, 17, '18:30:00', 'Couto Pereira', 1),
(266, 0, 0, 27, '2027-01-09', 'AGENDADA', 18, 8, '18:30:00', 'Arena do Grêmio', 1),
(267, 0, 0, 27, '2027-01-09', 'AGENDADA', 7, 19, '18:30:00', 'Estádio Maião', 1),
(268, 0, 0, 27, '2027-01-09', 'AGENDADA', 20, 6, '21:00:00', 'Estádio Nilton Santos', 1),
(269, 0, 0, 27, '2027-01-09', 'AGENDADA', 5, 2, '21:00:00', 'Allianz Parque', 1),
(270, 0, 0, 27, '2027-01-09', 'AGENDADA', 3, 4, '21:00:00', 'Neo Química Arena', 1),
(271, 0, 0, 28, '2027-01-13', 'AGENDADA', 1, 12, '16:00:00', 'São Januário', 1),
(272, 0, 0, 28, '2027-01-13', 'AGENDADA', 11, 13, '16:00:00', 'Vila Belmiro', 1),
(273, 0, 0, 28, '2027-01-13', 'AGENDADA', 14, 10, '16:00:00', 'Mineirão', 1),
(274, 0, 0, 28, '2027-01-13', 'AGENDADA', 9, 15, '18:30:00', 'Ligga Arena', 1),
(275, 0, 0, 28, '2027-01-13', 'AGENDADA', 16, 8, '18:30:00', 'Arena do Grêmio', 1),
(276, 0, 0, 28, '2027-01-13', 'AGENDADA', 7, 17, '18:30:00', 'Couto Pereira', 1),
(277, 0, 0, 28, '2027-01-13', 'AGENDADA', 18, 6, '18:30:00', 'Estádio Nilton Santos', 1),
(278, 0, 0, 28, '2027-01-13', 'AGENDADA', 5, 19, '21:00:00', 'Estádio Maião', 1),
(279, 0, 0, 28, '2027-01-13', 'AGENDADA', 20, 4, '21:00:00', 'Neo Química Arena', 1),
(280, 0, 0, 28, '2027-01-13', 'AGENDADA', 3, 2, '21:00:00', 'Allianz Parque', 1),
(281, 0, 0, 29, '2027-01-16', 'AGENDADA', 11, 1, '16:00:00', 'Maracanã', 1),
(282, 0, 0, 29, '2027-01-16', 'AGENDADA', 12, 10, '16:00:00', 'Mineirão', 1),
(283, 0, 0, 29, '2027-01-16', 'AGENDADA', 9, 13, '16:00:00', 'Vila Belmiro', 1),
(284, 0, 0, 29, '2027-01-16', 'AGENDADA', 14, 8, '18:30:00', 'Arena do Grêmio', 1),
(285, 0, 0, 29, '2027-01-16', 'AGENDADA', 7, 15, '18:30:00', 'Ligga Arena', 1),
(286, 0, 0, 29, '2027-01-16', 'AGENDADA', 16, 6, '18:30:00', 'Estádio Nilton Santos', 1),
(287, 0, 0, 29, '2027-01-16', 'AGENDADA', 5, 17, '18:30:00', 'Couto Pereira', 1),
(288, 0, 0, 29, '2027-01-16', 'AGENDADA', 18, 4, '21:00:00', 'Neo Química Arena', 1),
(289, 0, 0, 29, '2027-01-16', 'AGENDADA', 3, 19, '21:00:00', 'Estádio Maião', 1),
(290, 0, 0, 29, '2027-01-16', 'AGENDADA', 20, 2, '21:00:00', 'Allianz Parque', 1),
(291, 0, 0, 30, '2027-01-20', 'AGENDADA', 1, 10, '16:00:00', 'Mineirão', 1),
(292, 0, 0, 30, '2027-01-20', 'AGENDADA', 9, 11, '16:00:00', 'Arena Fonte Nova', 1),
(293, 0, 0, 30, '2027-01-20', 'AGENDADA', 12, 8, '16:00:00', 'Arena do Grêmio', 1),
(294, 0, 0, 30, '2027-01-20', 'AGENDADA', 7, 13, '18:30:00', 'Vila Belmiro', 1),
(295, 0, 0, 30, '2027-01-20', 'AGENDADA', 14, 6, '18:30:00', 'Estádio Nilton Santos', 1),
(296, 0, 0, 30, '2027-01-20', 'AGENDADA', 5, 15, '18:30:00', 'Ligga Arena', 1),
(297, 0, 0, 30, '2027-01-20', 'AGENDADA', 16, 4, '18:30:00', 'Neo Química Arena', 1),
(298, 0, 0, 30, '2027-01-20', 'AGENDADA', 3, 17, '21:00:00', 'Couto Pereira', 1),
(299, 0, 0, 30, '2027-01-20', 'AGENDADA', 18, 2, '21:00:00', 'Allianz Parque', 1),
(300, 0, 0, 30, '2027-01-20', 'AGENDADA', 20, 19, '21:00:00', 'Estádio Maião', 1),
(301, 0, 0, 31, '2027-01-23', 'AGENDADA', 9, 1, '16:00:00', 'Maracanã', 1),
(302, 0, 0, 31, '2027-01-23', 'AGENDADA', 10, 8, '16:00:00', 'Arena do Grêmio', 1),
(303, 0, 0, 31, '2027-01-23', 'AGENDADA', 7, 11, '16:00:00', 'Arena Fonte Nova', 1),
(304, 0, 0, 31, '2027-01-23', 'AGENDADA', 12, 6, '18:30:00', 'Estádio Nilton Santos', 1),
(305, 0, 0, 31, '2027-01-23', 'AGENDADA', 5, 13, '18:30:00', 'Vila Belmiro', 1),
(306, 0, 0, 31, '2027-01-23', 'AGENDADA', 14, 4, '18:30:00', 'Neo Química Arena', 1),
(307, 0, 0, 31, '2027-01-23', 'AGENDADA', 3, 15, '18:30:00', 'Ligga Arena', 1),
(308, 0, 0, 31, '2027-01-23', 'AGENDADA', 16, 2, '21:00:00', 'Allianz Parque', 1),
(309, 0, 0, 31, '2027-01-23', 'AGENDADA', 20, 17, '21:00:00', 'Couto Pereira', 1),
(310, 0, 0, 31, '2027-01-23', 'AGENDADA', 18, 19, '21:00:00', 'Estádio Maião', 1),
(311, 0, 0, 32, '2027-01-27', 'AGENDADA', 1, 8, '16:00:00', 'Arena do Grêmio', 1),
(312, 0, 0, 32, '2027-01-27', 'AGENDADA', 7, 9, '16:00:00', 'Beira-Rio', 1),
(313, 0, 0, 32, '2027-01-27', 'AGENDADA', 10, 6, '16:00:00', 'Estádio Nilton Santos', 1),
(314, 0, 0, 32, '2027-01-27', 'AGENDADA', 5, 11, '18:30:00', 'Arena Fonte Nova', 1),
(315, 0, 0, 32, '2027-01-27', 'AGENDADA', 12, 4, '18:30:00', 'Neo Química Arena', 1),
(316, 0, 0, 32, '2027-01-27', 'AGENDADA', 3, 13, '18:30:00', 'Vila Belmiro', 1),
(317, 0, 0, 32, '2027-01-27', 'AGENDADA', 14, 2, '18:30:00', 'Allianz Parque', 1),
(318, 0, 0, 32, '2027-01-27', 'AGENDADA', 20, 15, '21:00:00', 'Ligga Arena', 1),
(319, 0, 0, 32, '2027-01-27', 'AGENDADA', 16, 19, '21:00:00', 'Estádio Maião', 1),
(320, 0, 0, 32, '2027-01-27', 'AGENDADA', 18, 17, '21:00:00', 'Couto Pereira', 1),
(321, 0, 0, 33, '2027-01-30', 'AGENDADA', 7, 1, '16:00:00', 'Maracanã', 1),
(322, 0, 0, 33, '2027-01-30', 'AGENDADA', 8, 6, '16:00:00', 'Estádio Nilton Santos', 1),
(323, 0, 0, 33, '2027-01-30', 'AGENDADA', 5, 9, '16:00:00', 'Beira-Rio', 1),
(324, 0, 0, 33, '2027-01-30', 'AGENDADA', 10, 4, '18:30:00', 'Neo Química Arena', 1),
(325, 0, 0, 33, '2027-01-30', 'AGENDADA', 3, 11, '18:30:00', 'Arena Fonte Nova', 1),
(326, 0, 0, 33, '2027-01-30', 'AGENDADA', 12, 2, '18:30:00', 'Allianz Parque', 1),
(327, 0, 0, 33, '2027-01-30', 'AGENDADA', 20, 13, '18:30:00', 'Vila Belmiro', 1),
(328, 0, 0, 33, '2027-01-30', 'AGENDADA', 14, 19, '21:00:00', 'Estádio Maião', 1),
(329, 0, 0, 33, '2027-01-30', 'AGENDADA', 18, 15, '21:00:00', 'Ligga Arena', 1),
(330, 0, 0, 33, '2027-01-30', 'AGENDADA', 16, 17, '21:00:00', 'Couto Pereira', 1),
(331, 0, 0, 34, '2027-02-03', 'AGENDADA', 1, 6, '16:00:00', 'Estádio Nilton Santos', 1),
(332, 0, 0, 34, '2027-02-03', 'AGENDADA', 5, 7, '16:00:00', 'Maracanã', 1),
(333, 0, 0, 34, '2027-02-03', 'AGENDADA', 8, 4, '16:00:00', 'Neo Química Arena', 1),
(334, 0, 0, 34, '2027-02-03', 'AGENDADA', 3, 9, '18:30:00', 'Beira-Rio', 1),
(335, 0, 0, 34, '2027-02-03', 'AGENDADA', 10, 2, '18:30:00', 'Allianz Parque', 1),
(336, 0, 0, 34, '2027-02-03', 'AGENDADA', 20, 11, '18:30:00', 'Arena Fonte Nova', 1),
(337, 0, 0, 34, '2027-02-03', 'AGENDADA', 12, 19, '18:30:00', 'Estádio Maião', 1),
(338, 0, 0, 34, '2027-02-03', 'AGENDADA', 18, 13, '21:00:00', 'Vila Belmiro', 1),
(339, 0, 0, 34, '2027-02-03', 'AGENDADA', 14, 17, '21:00:00', 'Couto Pereira', 1),
(340, 0, 0, 34, '2027-02-03', 'AGENDADA', 16, 15, '21:00:00', 'Ligga Arena', 1),
(341, 0, 0, 35, '2027-02-06', 'AGENDADA', 5, 1, '16:00:00', 'Maracanã', 1),
(342, 0, 0, 35, '2027-02-06', 'AGENDADA', 6, 4, '16:00:00', 'Neo Química Arena', 1),
(343, 0, 0, 35, '2027-02-06', 'AGENDADA', 3, 7, '16:00:00', 'Maracanã', 1),
(344, 0, 0, 35, '2027-02-06', 'AGENDADA', 8, 2, '18:30:00', 'Allianz Parque', 1),
(345, 0, 0, 35, '2027-02-06', 'AGENDADA', 20, 9, '18:30:00', 'Beira-Rio', 1),
(346, 0, 0, 35, '2027-02-06', 'AGENDADA', 10, 19, '18:30:00', 'Estádio Maião', 1),
(347, 0, 0, 35, '2027-02-06', 'AGENDADA', 18, 11, '18:30:00', 'Arena Fonte Nova', 1),
(348, 0, 0, 35, '2027-02-06', 'AGENDADA', 12, 17, '21:00:00', 'Couto Pereira', 1),
(349, 0, 0, 35, '2027-02-06', 'AGENDADA', 16, 13, '21:00:00', 'Vila Belmiro', 1),
(350, 0, 0, 35, '2027-02-06', 'AGENDADA', 14, 15, '21:00:00', 'Ligga Arena', 1),
(351, 0, 0, 36, '2027-02-10', 'AGENDADA', 1, 4, '16:00:00', 'Neo Química Arena', 1),
(352, 0, 0, 36, '2027-02-10', 'AGENDADA', 3, 5, '16:00:00', 'Arena MRV', 1),
(353, 0, 0, 36, '2027-02-10', 'AGENDADA', 6, 2, '16:00:00', 'Allianz Parque', 1),
(354, 0, 0, 36, '2027-02-10', 'AGENDADA', 20, 7, '18:30:00', 'Maracanã', 1),
(355, 0, 0, 36, '2027-02-10', 'AGENDADA', 8, 19, '18:30:00', 'Estádio Maião', 1),
(356, 0, 0, 36, '2027-02-10', 'AGENDADA', 18, 9, '18:30:00', 'Beira-Rio', 1),
(357, 0, 0, 36, '2027-02-10', 'AGENDADA', 10, 17, '18:30:00', 'Couto Pereira', 1),
(358, 0, 0, 36, '2027-02-10', 'AGENDADA', 16, 11, '21:00:00', 'Arena Fonte Nova', 1),
(359, 0, 0, 36, '2027-02-10', 'AGENDADA', 12, 15, '21:00:00', 'Ligga Arena', 1),
(360, 0, 0, 36, '2027-02-10', 'AGENDADA', 14, 13, '21:00:00', 'Vila Belmiro', 1),
(361, 0, 0, 37, '2027-02-13', 'AGENDADA', 3, 1, '16:00:00', 'Maracanã', 1),
(362, 0, 0, 37, '2027-02-13', 'AGENDADA', 4, 2, '16:00:00', 'Allianz Parque', 1),
(363, 0, 0, 37, '2027-02-13', 'AGENDADA', 20, 5, '16:00:00', 'Arena MRV', 1),
(364, 0, 0, 37, '2027-02-13', 'AGENDADA', 6, 19, '18:30:00', 'Estádio Maião', 1),
(365, 0, 0, 37, '2027-02-13', 'AGENDADA', 18, 7, '18:30:00', 'Maracanã', 1),
(366, 0, 0, 37, '2027-02-13', 'AGENDADA', 8, 17, '18:30:00', 'Couto Pereira', 1),
(367, 0, 0, 37, '2027-02-13', 'AGENDADA', 16, 9, '18:30:00', 'Beira-Rio', 1),
(368, 0, 0, 37, '2027-02-13', 'AGENDADA', 10, 15, '21:00:00', 'Ligga Arena', 1),
(369, 0, 0, 37, '2027-02-13', 'AGENDADA', 14, 11, '21:00:00', 'Arena Fonte Nova', 1),
(370, 0, 0, 37, '2027-02-13', 'AGENDADA', 12, 13, '21:00:00', 'Vila Belmiro', 1),
(371, 0, 0, 38, '2027-02-17', 'AGENDADA', 1, 2, '16:00:00', 'Allianz Parque', 1),
(372, 0, 0, 38, '2027-02-17', 'AGENDADA', 20, 3, '16:00:00', 'MorumBIS', 1),
(373, 0, 0, 38, '2027-02-17', 'AGENDADA', 4, 19, '16:00:00', 'Estádio Maião', 1),
(374, 0, 0, 38, '2027-02-17', 'AGENDADA', 18, 5, '18:30:00', 'Arena MRV', 1),
(375, 0, 0, 38, '2027-02-17', 'AGENDADA', 6, 17, '18:30:00', 'Couto Pereira', 1),
(376, 0, 0, 38, '2027-02-17', 'AGENDADA', 16, 7, '18:30:00', 'Maracanã', 1),
(377, 0, 0, 38, '2027-02-17', 'AGENDADA', 8, 15, '18:30:00', 'Ligga Arena', 1),
(378, 0, 0, 38, '2027-02-17', 'AGENDADA', 14, 9, '21:00:00', 'Beira-Rio', 1),
(379, 0, 0, 38, '2027-02-17', 'AGENDADA', 10, 13, '21:00:00', 'Vila Belmiro', 1),
(380, 0, 0, 38, '2027-02-17', 'AGENDADA', 12, 11, '21:00:00', 'Arena Fonte Nova', 1);

-- --------------------------------------------------------

--
-- Table structure for table `patrocinador`
--

CREATE TABLE `patrocinador` (
  `idPatrocinador` int(11) NOT NULL,
  `nomePatrocinador` varchar(45) NOT NULL,
  `descricao` varchar(500) NOT NULL,
  `duracao` int(11) NOT NULL,
  `valorMensal` float NOT NULL,
  `multaRescisao` float NOT NULL,
  `foto` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `patrocinador`
--

INSERT INTO `patrocinador` (`idPatrocinador`, `nomePatrocinador`, `descricao`, `duracao`, `valorMensal`, `multaRescisao`, `foto`) VALUES
(1, 'Betano', 'Uma das maiores casas de apostas esportivas do país, referência em odds competitivas e experiência premium para quem vive o esporte. Presença forte nas principais competições, camisas e transmissões, com uma marca que combina ousadia, tecnologia e paixão pelo jogo.', 12, 800000, 15000000, 'img/patrocinadores/Betano.png'),
(2, 'Caixa Econômica', 'Instituição financeira pública com tradição de décadas e confiança construída em todo o território nacional. Parceira histórica do futebol brasileiro, entrega estabilidade, credibilidade e uma imagem sólida que valoriza qualquer clube que estampe sua marca.', 36, 1200000, 25000000, 'img/patrocinadores/caixa-economico.png'),
(3, 'Nike', 'Ícone mundial do esporte, sinônimo de inovação, performance e estilo dentro e fora de campo. Seus uniformes viram objeto de desejo da torcida e sua marca eleva o prestígio internacional de qualquer clube, com tecnologia de ponta em cada detalhe do material esportivo.', 24, 950000, 20000000, 'img/patrocinadores/nike.png'),
(4, 'Brahma', 'Cervejaria das mais tradicionais do Brasil, que respira o clima de arquibancada, torcida apaixonada e resenha pós-jogo. Marca onipresente na cultura popular, com campanhas marcantes e um alcance gigantesco que conecta o clube a milhões de torcedores.', 12, 600000, 10000000, 'img/patrocinadores/brahma.png'),
(5, 'Havan', 'Rede varejista com lojas espalhadas pelo país e uma marca queridinha do consumidor brasileiro. Investe pesado em marketing, promoções e presença no esporte, levando o nome do clube para dentro de milhões de lares em todas as regiões.', 18, 500000, 8000000, 'img/patrocinadores/havan.png'),
(6, 'Superbet', 'Casa de apostas moderna e agressiva, que cresce em ritmo acelerado e aposta alto em visibilidade. Contratos generosos, campanhas ousadas e uma marca jovem e dinâmica que injeta dinheiro e energia nova nos clubes parceiros.', 12, 700000, 12000000, 'img/patrocinadores/superbet.png'),
(7, 'Banco BMG', 'Banco de tradição e solidez, com forte atuação em crédito e serviços financeiros para o torcedor. Parceiro de longa data no futebol, une credibilidade de mercado a ações de relacionamento que aproximam a marca da arquibancada.', 24, 900000, 18000000, 'img/patrocinadores/bmg.png'),
(8, 'Vivo', 'Gigante das telecomunicações, líder em conectividade e presente na vida de milhões de brasileiros. Patrocínio de peso, com contratos longos e valiosos, que associa o clube a tecnologia, inovação e uma das marcas mais reconhecidas do país.', 36, 1100000, 22000000, 'img/patrocinadores/vivo.png'),
(9, 'Multilaser', 'Fabricante nacional de eletrônicos e acessórios com preço acessível e enorme popularidade entre os consumidores. Marca em expansão que busca exposição máxima em jogos e transmissões, trazendo investimento e uma imagem simpática para o clube.', 12, 350000, 6000000, 'img/patrocinadores/multilaser.png'),
(10, 'KTO', 'Casa de apostas determinada a conquistar seu espaço no mercado brasileiro, com visão de futuro e muita fome de crescimento. Oferece contratos curtos e flexíveis, ideais para clubes que querem receita rápida sem abrir mão da liberdade de negociar de novo.', 6, 650000, 9000000, 'img/patrocinadores/kto.png');

-- --------------------------------------------------------

--
-- Table structure for table `patrocinador_exigencia`
--

CREATE TABLE `patrocinador_exigencia` (
  `exigencia_idExigencia` int(11) NOT NULL,
  `patrocinador_idPatrocinador` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `patrocinador_exigencia`
--

INSERT INTO `patrocinador_exigencia` (`exigencia_idExigencia`, `patrocinador_idPatrocinador`) VALUES
(1, 1),
(1, 4),
(1, 6),
(1, 10),
(2, 2),
(2, 8),
(3, 3),
(3, 7),
(4, 2),
(4, 8),
(5, 6),
(5, 10),
(6, 7),
(7, 1),
(7, 4),
(7, 5),
(7, 9),
(8, 8),
(9, 2),
(9, 5),
(9, 7),
(10, 3);

-- --------------------------------------------------------

--
-- Table structure for table `proposta_emprego`
--

CREATE TABLE `proposta_emprego` (
  `idPropostaEmprego` int(11) NOT NULL,
  `salarioOferecido` float DEFAULT NULL,
  `status` enum('PENDENTE','ACEITO','RECUSADO') DEFAULT NULL,
  `manager_idManager` int(11) NOT NULL,
  `clube_idClube` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `proposta_transferencia`
--

CREATE TABLE `proposta_transferencia` (
  `idPropostaTransferencia` int(11) NOT NULL,
  `valorOferecido` float NOT NULL,
  `statusProposta` enum('PENDENTE','ACEITA','RECUSADA','CANCELADA') NOT NULL,
  `revelado` tinyint(1) NOT NULL,
  `jogador_idJogador` int(11) NOT NULL,
  `clube_idClube_exterior` int(11) NOT NULL,
  `clube_idClube_interior` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `titulo_tecnico`
--

CREATE TABLE `titulo_tecnico` (
  `competicao_idCompeticao` int(11) NOT NULL,
  `manager_idManager` int(11) NOT NULL,
  `ano` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `treino`
--

CREATE TABLE `treino` (
  `idTreino` int(11) NOT NULL,
  `nomeTreino` varchar(50) NOT NULL,
  `descTreino` varchar(100) NOT NULL,
  `intensidade` int(11) NOT NULL,
  `data` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `treino`
--

INSERT INTO `treino` (`idTreino`, `nomeTreino`, `descTreino`, `intensidade`, `data`) VALUES
(1, 'Finalização', 'Aumenta precisão dos chutes ao gol', 3, '2026-08-10'),
(2, 'Passe', 'Melhora a troca de bola e retenção', 2, '2026-08-10'),
(3, 'Cruzamento', 'Aprimora jogadas aéreas nas pontas', 2, '2026-08-10'),
(4, 'Contra-Ataque', 'Melhora a velocidade na transição', 3, '2026-08-10'),
(5, 'Desarme', 'Aumenta roubadas de bola e combates', 3, '2026-08-10'),
(6, 'Posicionamento', 'Coordenção e cobertura defensiva', 2, '2026-08-10'),
(7, 'Pressão', 'Recupera a bola no campo de ataque', 3, '2026-08-10'),
(8, 'Escanteio', 'Aproveitamento de bolas alçadas', 1, '2026-08-10'),
(9, 'Falta', 'Precisão em cobranças diretas/indiretas', 1, '2026-08-10'),
(10, 'Goleiro', 'Melhora reflexos e saídas de gol', 2, '2026-08-10'),
(11, 'Resistência', 'Reduz o desgaste durante as partidas', 3, '2026-08-10'),
(12, 'Velocidade', 'Aumenta aceleração dos atletas', 3, '2026-08-10'),
(13, 'Fisioterapia', 'Acelera recuperação e reduz lesões', 1, '2026-08-10'),
(14, 'Tática', 'Melhora visão e organização em campo', 1, '2026-08-10'),
(15, 'Recreativo', 'Aumenta a moral do elenco', 1, '2026-08-10');

-- --------------------------------------------------------

--
-- Table structure for table `upgrade`
--

CREATE TABLE `upgrade` (
  `idUpgrade` int(11) NOT NULL,
  `nomeUpgrade` varchar(255) NOT NULL,
  `preco` float NOT NULL,
  `tipoUpgrade` enum('ESTADIO','GRAMADO_DM','CENTRO_TREINAMENTO','MEGALOJA','MARKETING') NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `modificador` float NOT NULL,
  `nivelMaximo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `upgrade`
--

INSERT INTO `upgrade` (`idUpgrade`, `nomeUpgrade`, `preco`, `tipoUpgrade`, `descricao`, `modificador`, `nivelMaximo`) VALUES
(1, 'Modernização do Estádio', 5000000, 'ESTADIO', 'Aumenta a capacidade e o conforto do estádio', 0.04, 15),
(2, 'Gramado Padrão FIFA', 2000000, 'GRAMADO_DM', 'Melhora a qualidade do campo e reduz lesões', 0.05, 10),
(3, 'Centro de Treinamento', 3000000, 'CENTRO_TREINAMENTO', 'Melhora a evolução de atributos dos jogadores', 0.03, 15),
(4, 'Megaloja Oficial', 2500000, 'MEGALOJA', 'Aumenta a venda de camisas e produtos licenciados', 0.04, 12),
(5, 'Marketing e Marca', 1500000, 'MARKETING', 'Expande a marca e atrai patrocínios maiores', 0.04, 12);

-- --------------------------------------------------------

--
-- Table structure for table `upgrade_has_patrocinador`
--

CREATE TABLE `upgrade_has_patrocinador` (
  `upgrade_idUpgrade` int(11) NOT NULL,
  `patrocinador_idPatrocinador` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `acao_diretoria`
--
ALTER TABLE `acao_diretoria`
  ADD PRIMARY KEY (`idAcaoDiretoria`);

--
-- Indexes for table `clube`
--
ALTER TABLE `clube`
  ADD PRIMARY KEY (`idClube`),
  ADD KEY `fk_clube_patrocinador1_idx` (`patrocinador_idPatrocinador`);

--
-- Indexes for table `clube_competicao`
--
ALTER TABLE `clube_competicao`
  ADD PRIMARY KEY (`competicao_idCompeticao`,`clube_idClube`),
  ADD KEY `fk_competicao_has_clube_clube1_idx` (`clube_idClube`),
  ADD KEY `fk_competicao_has_clube_competicao1_idx` (`competicao_idCompeticao`);

--
-- Indexes for table `clube_has_acao_diretoria`
--
ALTER TABLE `clube_has_acao_diretoria`
  ADD PRIMARY KEY (`clube_idClube`,`acao_diretoria_idAcaoDiretoria`),
  ADD KEY `fk_clube_has_acao_diretoria_acao_diretoria1_idx` (`acao_diretoria_idAcaoDiretoria`),
  ADD KEY `fk_clube_has_acao_diretoria_clube1_idx` (`clube_idClube`);

--
-- Indexes for table `clube_has_meta_temporada`
--
ALTER TABLE `clube_has_meta_temporada`
  ADD KEY `clube_idClube` (`clube_idClube`),
  ADD KEY `meta_temporada_idMetaTemporada` (`meta_temporada_idMetaTemporada`);

--
-- Indexes for table `clube_has_treino`
--
ALTER TABLE `clube_has_treino`
  ADD PRIMARY KEY (`clube_idClube`,`treino_idTreino`),
  ADD KEY `fk_clube_has_treino_treino1_idx` (`treino_idTreino`),
  ADD KEY `fk_clube_has_treino_clube1_idx` (`clube_idClube`);

--
-- Indexes for table `clube_has_upgrade`
--
ALTER TABLE `clube_has_upgrade`
  ADD PRIMARY KEY (`clube_idClube`,`upgrade_idUpgrade`),
  ADD KEY `fk_clube_has_upgrade_upgrade1_idx` (`upgrade_idUpgrade`),
  ADD KEY `fk_clube_has_upgrade_clube1_idx` (`clube_idClube`);

--
-- Indexes for table `competicao`
--
ALTER TABLE `competicao`
  ADD PRIMARY KEY (`idCompeticao`);

--
-- Indexes for table `estatisticas_ano_clube`
--
ALTER TABLE `estatisticas_ano_clube`
  ADD PRIMARY KEY (`idEstatisticasAnoClube`),
  ADD KEY `fk_estatisticas_ano_clube_clube1_idx` (`clube_idClube`);

--
-- Indexes for table `estatisticas_jogador_competicao`
--
ALTER TABLE `estatisticas_jogador_competicao`
  ADD PRIMARY KEY (`jogador_idJogador`,`competicao_idCompeticao`),
  ADD KEY `fk_jogador_has_competicao_competicao1_idx` (`competicao_idCompeticao`),
  ADD KEY `fk_jogador_has_competicao_jogador1_idx` (`jogador_idJogador`);

--
-- Indexes for table `exigencia`
--
ALTER TABLE `exigencia`
  ADD PRIMARY KEY (`idExigencia`);

--
-- Indexes for table `historico_tecnico`
--
ALTER TABLE `historico_tecnico`
  ADD PRIMARY KEY (`idHistoricoTecnico`),
  ADD KEY `fk_historico_tecnico_manager1_idx` (`manager_idManager`),
  ADD KEY `fk_historico_tecnico_clube1_idx` (`clube_idClube`);

--
-- Indexes for table `jogador`
--
ALTER TABLE `jogador`
  ADD PRIMARY KEY (`idJogador`),
  ADD KEY `fk_jogador_clube1_idx` (`clube_idClube`);

--
-- Indexes for table `jogador_lesao`
--
ALTER TABLE `jogador_lesao`
  ADD PRIMARY KEY (`lesao_idLesao`,`jogador_idJogador`),
  ADD KEY `fk_lesao_has_jogador_jogador1_idx` (`jogador_idJogador`),
  ADD KEY `fk_lesao_has_jogador_lesao1_idx` (`lesao_idLesao`);

--
-- Indexes for table `lesao`
--
ALTER TABLE `lesao`
  ADD PRIMARY KEY (`idLesao`);

--
-- Indexes for table `manager`
--
ALTER TABLE `manager`
  ADD PRIMARY KEY (`idManager`),
  ADD KEY `fk_manager_clube1_idx` (`clube_idClube`);

--
-- Indexes for table `meta_temporada`
--
ALTER TABLE `meta_temporada`
  ADD PRIMARY KEY (`idMetaTemporada`);

--
-- Indexes for table `noticia`
--
ALTER TABLE `noticia`
  ADD PRIMARY KEY (`idNoticia`),
  ADD KEY `fk_noticia_clube1_idx` (`clube_idClube`);

--
-- Indexes for table `noticia_diretoria`
--
ALTER TABLE `noticia_diretoria`
  ADD PRIMARY KEY (`idNoticia`),
  ADD KEY `fk_noticia_diretoria_clube1_idx` (`clube_idClube`);

--
-- Indexes for table `partida`
--
ALTER TABLE `partida`
  ADD PRIMARY KEY (`idPartida`),
  ADD KEY `fk_partida_clube1_idx` (`visitanteIdClube`),
  ADD KEY `fk_partida_clube2_idx` (`mandanteIdClube`),
  ADD KEY `fk_partida_competicao` (`competicao_idCompeticao`);

--
-- Indexes for table `patrocinador`
--
ALTER TABLE `patrocinador`
  ADD PRIMARY KEY (`idPatrocinador`);

--
-- Indexes for table `patrocinador_exigencia`
--
ALTER TABLE `patrocinador_exigencia`
  ADD PRIMARY KEY (`exigencia_idExigencia`,`patrocinador_idPatrocinador`),
  ADD KEY `fk_exigencia_has_patrocinador_patrocinador1_idx` (`patrocinador_idPatrocinador`),
  ADD KEY `fk_exigencia_has_patrocinador_exigencia_idx` (`exigencia_idExigencia`);

--
-- Indexes for table `proposta_emprego`
--
ALTER TABLE `proposta_emprego`
  ADD PRIMARY KEY (`idPropostaEmprego`),
  ADD KEY `fk_proposta_emprego_manager1_idx` (`manager_idManager`),
  ADD KEY `fk_proposta_emprego_clube1_idx` (`clube_idClube`);

--
-- Indexes for table `proposta_transferencia`
--
ALTER TABLE `proposta_transferencia`
  ADD PRIMARY KEY (`idPropostaTransferencia`),
  ADD KEY `fk_proposta_transferencia_jogador1_idx` (`jogador_idJogador`),
  ADD KEY `fk_proposta_transferencia_clube1_idx` (`clube_idClube_exterior`),
  ADD KEY `fk_proposta_clube_interior` (`clube_idClube_interior`);

--
-- Indexes for table `titulo_tecnico`
--
ALTER TABLE `titulo_tecnico`
  ADD PRIMARY KEY (`competicao_idCompeticao`,`manager_idManager`),
  ADD KEY `fk_competicao_has_manager_manager1_idx` (`manager_idManager`),
  ADD KEY `fk_competicao_has_manager_competicao1_idx` (`competicao_idCompeticao`);

--
-- Indexes for table `treino`
--
ALTER TABLE `treino`
  ADD PRIMARY KEY (`idTreino`);

--
-- Indexes for table `upgrade`
--
ALTER TABLE `upgrade`
  ADD PRIMARY KEY (`idUpgrade`);

--
-- Indexes for table `upgrade_has_patrocinador`
--
ALTER TABLE `upgrade_has_patrocinador`
  ADD PRIMARY KEY (`upgrade_idUpgrade`,`patrocinador_idPatrocinador`),
  ADD KEY `fk_upgrade_has_patrocinador_patrocinador1_idx` (`patrocinador_idPatrocinador`),
  ADD KEY `fk_upgrade_has_patrocinador_upgrade1_idx` (`upgrade_idUpgrade`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `acao_diretoria`
--
ALTER TABLE `acao_diretoria`
  MODIFY `idAcaoDiretoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `clube`
--
ALTER TABLE `clube`
  MODIFY `idClube` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `competicao`
--
ALTER TABLE `competicao`
  MODIFY `idCompeticao` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `estatisticas_ano_clube`
--
ALTER TABLE `estatisticas_ano_clube`
  MODIFY `idEstatisticasAnoClube` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `exigencia`
--
ALTER TABLE `exigencia`
  MODIFY `idExigencia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `historico_tecnico`
--
ALTER TABLE `historico_tecnico`
  MODIFY `idHistoricoTecnico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `jogador`
--
ALTER TABLE `jogador`
  MODIFY `idJogador` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=679;

--
-- AUTO_INCREMENT for table `lesao`
--
ALTER TABLE `lesao`
  MODIFY `idLesao` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `manager`
--
ALTER TABLE `manager`
  MODIFY `idManager` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `meta_temporada`
--
ALTER TABLE `meta_temporada`
  MODIFY `idMetaTemporada` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `noticia`
--
ALTER TABLE `noticia`
  MODIFY `idNoticia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `noticia_diretoria`
--
ALTER TABLE `noticia_diretoria`
  MODIFY `idNoticia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `partida`
--
ALTER TABLE `partida`
  MODIFY `idPartida` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=381;

--
-- AUTO_INCREMENT for table `patrocinador`
--
ALTER TABLE `patrocinador`
  MODIFY `idPatrocinador` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `proposta_emprego`
--
ALTER TABLE `proposta_emprego`
  MODIFY `idPropostaEmprego` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `proposta_transferencia`
--
ALTER TABLE `proposta_transferencia`
  MODIFY `idPropostaTransferencia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `treino`
--
ALTER TABLE `treino`
  MODIFY `idTreino` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `upgrade`
--
ALTER TABLE `upgrade`
  MODIFY `idUpgrade` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `clube`
--
ALTER TABLE `clube`
  ADD CONSTRAINT `fk_clube_patrocinador1` FOREIGN KEY (`patrocinador_idPatrocinador`) REFERENCES `patrocinador` (`idPatrocinador`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `clube_competicao`
--
ALTER TABLE `clube_competicao`
  ADD CONSTRAINT `fk_competicao_has_clube_clube1` FOREIGN KEY (`clube_idClube`) REFERENCES `clube` (`idClube`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_competicao_has_clube_competicao1` FOREIGN KEY (`competicao_idCompeticao`) REFERENCES `competicao` (`idCompeticao`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `clube_has_acao_diretoria`
--
ALTER TABLE `clube_has_acao_diretoria`
  ADD CONSTRAINT `fk_clube_has_acao_diretoria_acao_diretoria1` FOREIGN KEY (`acao_diretoria_idAcaoDiretoria`) REFERENCES `acao_diretoria` (`idAcaoDiretoria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_clube_has_acao_diretoria_clube1` FOREIGN KEY (`clube_idClube`) REFERENCES `clube` (`idClube`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `clube_has_meta_temporada`
--
ALTER TABLE `clube_has_meta_temporada`
  ADD CONSTRAINT `clube_has_meta_temporada_ibfk_1` FOREIGN KEY (`clube_idClube`) REFERENCES `clube` (`idClube`),
  ADD CONSTRAINT `clube_has_meta_temporada_ibfk_2` FOREIGN KEY (`meta_temporada_idMetaTemporada`) REFERENCES `meta_temporada` (`idMetaTemporada`);

--
-- Constraints for table `clube_has_treino`
--
ALTER TABLE `clube_has_treino`
  ADD CONSTRAINT `fk_clube_has_treino_clube1` FOREIGN KEY (`clube_idClube`) REFERENCES `clube` (`idClube`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_clube_has_treino_treino1` FOREIGN KEY (`treino_idTreino`) REFERENCES `treino` (`idTreino`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `clube_has_upgrade`
--
ALTER TABLE `clube_has_upgrade`
  ADD CONSTRAINT `fk_clube_has_upgrade_clube1` FOREIGN KEY (`clube_idClube`) REFERENCES `clube` (`idClube`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_clube_has_upgrade_upgrade1` FOREIGN KEY (`upgrade_idUpgrade`) REFERENCES `upgrade` (`idUpgrade`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `estatisticas_ano_clube`
--
ALTER TABLE `estatisticas_ano_clube`
  ADD CONSTRAINT `fk_estatisticas_ano_clube_clube1` FOREIGN KEY (`clube_idClube`) REFERENCES `clube` (`idClube`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `estatisticas_jogador_competicao`
--
ALTER TABLE `estatisticas_jogador_competicao`
  ADD CONSTRAINT `fk_jogador_has_competicao_competicao1` FOREIGN KEY (`competicao_idCompeticao`) REFERENCES `competicao` (`idCompeticao`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_jogador_has_competicao_jogador1` FOREIGN KEY (`jogador_idJogador`) REFERENCES `jogador` (`idJogador`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `historico_tecnico`
--
ALTER TABLE `historico_tecnico`
  ADD CONSTRAINT `fk_historico_tecnico_clube1` FOREIGN KEY (`clube_idClube`) REFERENCES `clube` (`idClube`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_historico_tecnico_manager1` FOREIGN KEY (`manager_idManager`) REFERENCES `manager` (`idManager`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `jogador`
--
ALTER TABLE `jogador`
  ADD CONSTRAINT `fk_jogador_clube1` FOREIGN KEY (`clube_idClube`) REFERENCES `clube` (`idClube`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `jogador_lesao`
--
ALTER TABLE `jogador_lesao`
  ADD CONSTRAINT `fk_lesao_has_jogador_jogador1` FOREIGN KEY (`jogador_idJogador`) REFERENCES `jogador` (`idJogador`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_lesao_has_jogador_lesao1` FOREIGN KEY (`lesao_idLesao`) REFERENCES `lesao` (`idLesao`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `manager`
--
ALTER TABLE `manager`
  ADD CONSTRAINT `fk_manager_clube1` FOREIGN KEY (`clube_idClube`) REFERENCES `clube` (`idClube`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `noticia`
--
ALTER TABLE `noticia`
  ADD CONSTRAINT `fk_noticia_clube1` FOREIGN KEY (`clube_idClube`) REFERENCES `clube` (`idClube`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `noticia_diretoria`
--
ALTER TABLE `noticia_diretoria`
  ADD CONSTRAINT `fk_noticia_diretoria_clube1` FOREIGN KEY (`clube_idClube`) REFERENCES `clube` (`idClube`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `partida`
--
ALTER TABLE `partida`
  ADD CONSTRAINT `fk_partida_clube1` FOREIGN KEY (`visitanteIdClube`) REFERENCES `clube` (`idClube`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_partida_clube2` FOREIGN KEY (`mandanteIdClube`) REFERENCES `clube` (`idClube`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_partida_competicao` FOREIGN KEY (`competicao_idCompeticao`) REFERENCES `competicao` (`idCompeticao`);

--
-- Constraints for table `patrocinador_exigencia`
--
ALTER TABLE `patrocinador_exigencia`
  ADD CONSTRAINT `fk_exigencia_has_patrocinador_exigencia` FOREIGN KEY (`exigencia_idExigencia`) REFERENCES `exigencia` (`idExigencia`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_exigencia_has_patrocinador_patrocinador1` FOREIGN KEY (`patrocinador_idPatrocinador`) REFERENCES `patrocinador` (`idPatrocinador`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `proposta_emprego`
--
ALTER TABLE `proposta_emprego`
  ADD CONSTRAINT `fk_proposta_emprego_clube1` FOREIGN KEY (`clube_idClube`) REFERENCES `clube` (`idClube`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_proposta_emprego_manager1` FOREIGN KEY (`manager_idManager`) REFERENCES `manager` (`idManager`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `proposta_transferencia`
--
ALTER TABLE `proposta_transferencia`
  ADD CONSTRAINT `fk_proposta_clube_interior` FOREIGN KEY (`clube_idClube_interior`) REFERENCES `clube` (`idClube`),
  ADD CONSTRAINT `fk_proposta_transferencia_clube1` FOREIGN KEY (`clube_idClube_exterior`) REFERENCES `clube` (`idClube`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_proposta_transferencia_jogador1` FOREIGN KEY (`jogador_idJogador`) REFERENCES `jogador` (`idJogador`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `titulo_tecnico`
--
ALTER TABLE `titulo_tecnico`
  ADD CONSTRAINT `fk_competicao_has_manager_competicao1` FOREIGN KEY (`competicao_idCompeticao`) REFERENCES `competicao` (`idCompeticao`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_competicao_has_manager_manager1` FOREIGN KEY (`manager_idManager`) REFERENCES `manager` (`idManager`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `upgrade_has_patrocinador`
--
ALTER TABLE `upgrade_has_patrocinador`
  ADD CONSTRAINT `fk_upgrade_has_patrocinador_patrocinador1` FOREIGN KEY (`patrocinador_idPatrocinador`) REFERENCES `patrocinador` (`idPatrocinador`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_upgrade_has_patrocinador_upgrade1` FOREIGN KEY (`upgrade_idUpgrade`) REFERENCES `upgrade` (`idUpgrade`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

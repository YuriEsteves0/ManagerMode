-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 02, 2026 at 06:30 PM
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
  `foto` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `clube`
--

INSERT INTO `clube` (`idClube`, `nomeClube`, `orcamento`, `valorClube`, `camisasVendidas`, `qntTorcedores`, `reputacao`, `patrocinador_idPatrocinador`, `confiancaDiretoria`, `statusConfianca`, `eventoAtual`, `capacidadeEstadio`, `foto`) VALUES
(1, 'Flamengo', 900000000, 1200000000, 1200000, 40000000, 60, 1, 85, 'EXCELENTE', 'Boa Gestão', 78838, 'img/escudosClubes/brasileiraoSerieA/flamengo.png'),
(2, 'Palmeiras', 800000000, 1100000000, 950000, 15000000, 58, 3, 88, 'EXCELENTE', 'Boa Gestão', 43713, 'img/escudosClubes/brasileiraoSerieA/palmeiras.png'),
(3, 'São Paulo', 500000000, 550000000, 600000, 18000000, 50, 8, 65, 'ESTAVEL', NULL, 66795, 'img/escudosClubes/brasileiraoSerieA/sao_paulo.png'),
(4, 'Corinthians', 450000000, 500000000, 700000, 30000000, 52, 6, 55, 'INSTAVEL', 'Crise Financeira', 47605, 'img/escudosClubes/brasileiraoSerieA/Corinthians.png'),
(5, 'Atlético-MG', 400000000, 480000000, 500000, 7000000, 45, 2, 70, 'ESTAVEL', NULL, 47465, 'img/escudosClubes/brasileiraoSerieA/Atletico_mineiro.png'),
(6, 'Botafogo', 350000000, 650000000, 400000, 8000000, 42, 4, 75, 'ESTAVEL', NULL, 44661, 'img/escudosClubes/brasileiraoSerieA/Botafogo.png'),
(7, 'Fluminense', 300000000, 400000000, 350000, 7000000, 38, 9, 60, 'ESTAVEL', NULL, 78838, 'img/escudosClubes/brasileiraoSerieA/Fluminense.png'),
(8, 'Grêmio', 300000000, 380000000, 380000, 9000000, 40, 7, 68, 'ESTAVEL', NULL, 55662, 'img/escudosClubes/brasileiraoSerieA/gremio.png'),
(9, 'Internacional', 280000000, 350000000, 360000, 8000000, 39, 10, 66, 'ESTAVEL', NULL, 50842, 'img/escudosClubes/brasileiraoSerieA/Internacional.png'),
(10, 'Cruzeiro', 250000000, 380000000, 300000, 10000000, 36, 5, 72, 'ESTAVEL', NULL, 61927, 'img/escudosClubes/brasileiraoSerieA/cruzeiro.png'),
(11, 'Bahia', 200000000, 320000000, 220000, 6000000, 30, NULL, 60, 'ESTAVEL', NULL, 47907, 'img/escudosClubes/brasileiraoSerieA/bahia.png'),
(12, 'Vasco da Gama', 200000000, 300000000, 250000, 13000000, 32, NULL, 57, 'INSTAVEL', 'Pressão da Torcida', 21880, 'img/escudosClubes/brasileiraoSerieA/vascoDaGama.png'),
(13, 'Santos', 180000000, 280000000, 400000, 10000000, 28, NULL, 50, 'INSTAVEL', 'Reconstrução Pós-Rebaixamento', 16068, 'img/escudosClubes/brasileiraoSerieA/Santos.png'),
(14, 'Bragantino', 220000000, 450000000, 150000, 500000, 27, 3, 78, 'EXCELENTE', 'Boa Gestão', 17000, 'img/escudosClubes/brasileiraoSerieA/RedBullBragantino.png'),
(15, 'Athletico Paranaense', 150000000, 330000000, 180000, 2000000, 25, NULL, 62, 'ESTAVEL', NULL, 42372, 'img/escudosClubes/brasileiraoSerieA/cap.png'),
(16, 'Vitória', 120000000, 180000000, 130000, 3000000, 20, NULL, 55, 'ESTAVEL', NULL, 30240, 'img/escudosClubes/brasileiraoSerieA/vitoria.png'),
(17, 'Coritiba', 100000000, 150000000, 90000, 1500000, 18, NULL, 80, 'EXCELENTE', 'Acesso à Série A', 40502, 'img/escudosClubes/brasileiraoSerieA/Coritiba.png'),
(18, 'Chapecoense', 60000000, 90000000, 60000, 1000000, 15, NULL, 74, 'ESTAVEL', 'Acesso à Série A', 22000, 'img/escudosClubes/brasileiraoSerieA/chapecoense.png'),
(19, 'Mirassol', 70000000, 110000000, 50000, 200000, 14, NULL, 70, 'ESTAVEL', NULL, 15632, 'img/escudosClubes/brasileiraoSerieA/mirassol.png'),
(20, 'Remo', 50000000, 80000000, 70000, 2000000, 16, NULL, 76, 'ESTAVEL', 'Acesso à Série A', 45000, 'img/escudosClubes/brasileiraoSerieA/remo.png');

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
  `statusAcao` enum('DISPONIVEL','EM ANALISE','CONCLUIDO') NOT NULL
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
  `status` enum('DENTRO DO ESPERADO','ABAIXO DO ESPERADO','CONCLUIDO','FALHOU') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `clube_has_meta_temporada`
--

INSERT INTO `clube_has_meta_temporada` (`clube_idClube`, `meta_temporada_idMetaTemporada`, `status`) VALUES
(1, 1, 'DENTRO DO ESPERADO'),
(1, 5, 'DENTRO DO ESPERADO'),
(1, 6, 'DENTRO DO ESPERADO'),
(2, 1, 'DENTRO DO ESPERADO'),
(2, 5, 'DENTRO DO ESPERADO'),
(2, 7, 'DENTRO DO ESPERADO'),
(3, 2, 'DENTRO DO ESPERADO'),
(3, 5, 'ABAIXO DO ESPERADO'),
(4, 2, 'ABAIXO DO ESPERADO'),
(4, 6, 'DENTRO DO ESPERADO'),
(5, 2, 'DENTRO DO ESPERADO'),
(5, 5, 'DENTRO DO ESPERADO'),
(6, 2, 'DENTRO DO ESPERADO'),
(6, 7, 'DENTRO DO ESPERADO'),
(7, 3, 'DENTRO DO ESPERADO'),
(7, 6, 'DENTRO DO ESPERADO'),
(8, 3, 'DENTRO DO ESPERADO'),
(8, 7, 'DENTRO DO ESPERADO'),
(9, 2, 'ABAIXO DO ESPERADO'),
(9, 6, 'DENTRO DO ESPERADO'),
(10, 3, 'DENTRO DO ESPERADO'),
(10, 7, 'DENTRO DO ESPERADO'),
(11, 3, 'DENTRO DO ESPERADO'),
(11, 6, 'DENTRO DO ESPERADO'),
(12, 4, 'ABAIXO DO ESPERADO'),
(12, 6, 'DENTRO DO ESPERADO'),
(13, 3, 'ABAIXO DO ESPERADO'),
(13, 6, 'DENTRO DO ESPERADO'),
(14, 3, 'DENTRO DO ESPERADO'),
(14, 6, 'DENTRO DO ESPERADO'),
(15, 3, 'DENTRO DO ESPERADO'),
(15, 6, 'DENTRO DO ESPERADO'),
(16, 4, 'DENTRO DO ESPERADO'),
(16, 7, 'DENTRO DO ESPERADO'),
(17, 4, 'ABAIXO DO ESPERADO'),
(17, 7, 'DENTRO DO ESPERADO'),
(18, 4, 'ABAIXO DO ESPERADO'),
(18, 7, 'ABAIXO DO ESPERADO'),
(19, 4, 'DENTRO DO ESPERADO'),
(19, 7, 'DENTRO DO ESPERADO'),
(20, 4, 'DENTRO DO ESPERADO'),
(20, 7, 'DENTRO DO ESPERADO');

-- --------------------------------------------------------

--
-- Table structure for table `clube_has_treino`
--

CREATE TABLE `clube_has_treino` (
  `clube_idClube` int(11) NOT NULL,
  `treino_idTreino` int(11) NOT NULL,
  `slot` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `clube_has_upgrade`
--

CREATE TABLE `clube_has_upgrade` (
  `clube_idClube` int(11) NOT NULL,
  `upgrade_idUpgrade` int(11) NOT NULL,
  `nivelAtual` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `clube_has_upgrade`
--

INSERT INTO `clube_has_upgrade` (`clube_idClube`, `upgrade_idUpgrade`, `nivelAtual`) VALUES
(1, 2, 2),
(1, 7, 2),
(1, 13, 4),
(1, 14, 2),
(1, 17, 3),
(1, 20, 3),
(2, 3, 3),
(2, 4, 2),
(2, 9, 3),
(2, 13, 4),
(2, 17, 3),
(2, 19, 2),
(3, 2, 2),
(3, 8, 2),
(3, 12, 3),
(3, 16, 2),
(3, 19, 2),
(4, 3, 3),
(4, 8, 2),
(4, 10, 1),
(4, 16, 2),
(4, 19, 2),
(5, 3, 3),
(5, 9, 3),
(5, 11, 2),
(5, 16, 2),
(6, 2, 2),
(6, 7, 2),
(6, 12, 3),
(6, 18, 1),
(7, 1, 1),
(7, 6, 1),
(7, 11, 2),
(7, 15, 1),
(8, 3, 3),
(8, 8, 2),
(8, 10, 1),
(8, 18, 1),
(9, 2, 2),
(9, 6, 1),
(9, 10, 1),
(9, 15, 1),
(10, 1, 1),
(10, 8, 2),
(10, 11, 2),
(10, 15, 1),
(11, 2, 2),
(11, 6, 1),
(11, 10, 1),
(12, 1, 1),
(12, 6, 1),
(12, 18, 1),
(13, 1, 1),
(13, 10, 1),
(13, 18, 1),
(14, 4, 2),
(14, 9, 3),
(14, 12, 3),
(15, 3, 3),
(15, 4, 2),
(15, 11, 2),
(16, 6, 1),
(16, 10, 1),
(17, 6, 1),
(17, 15, 1),
(18, 10, 1),
(19, 6, 1),
(20, 18, 1);

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
(20, 2026, 0, 0, 0, 0, 0, 0, 20);

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
  `titular` tinyint(4) DEFAULT NULL,
  `moral` int(11) DEFAULT NULL,
  `nacionalidade` varchar(255) DEFAULT NULL,
  `dispEmprestimo` tinyint(4) DEFAULT NULL,
  `satisfacao` int(11) DEFAULT NULL,
  `onfire` tinyint(4) DEFAULT NULL,
  `valor` float DEFAULT NULL,
  `valorRescisao` float DEFAULT NULL,
  `tempoContrato` int(11) DEFAULT NULL,
  `clube_idClube` int(11) DEFAULT NULL,
  `posicaoX` float DEFAULT NULL,
  `posicaoY` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `jogador`
--

INSERT INTO `jogador` (`idJogador`, `nomeJogador`, `idade`, `posicao_principal`, `overall`, `velocidade`, `forca`, `inteligencia`, `finalizacao`, `marcacao`, `passe`, `potencial`, `titular`, `moral`, `nacionalidade`, `dispEmprestimo`, `satisfacao`, `onfire`, `valor`, `valorRescisao`, `tempoContrato`, `clube_idClube`, `posicaoX`, `posicaoY`) VALUES
(1, 'Agustin Rossi', 31, 'GOL', 78, 55, 74, 79, 20, 30, 62, 79, 2, 50, 'Argentina', 0, 50, 0, 10000000, 4730000, 12, 1, 50, 90),
(2, 'Andrew', 25, 'GOL', 68, 58, 70, 66, 15, 25, 58, 74, 0, 50, 'Brasil', 1, 50, 0, 6700000, 2520000, 48, 1, 50, 90),
(3, 'Dyogo Alves', 22, 'GOL', 60, 56, 65, 58, 12, 20, 52, 72, 0, 50, 'Brasil', 1, 50, 0, 400000, 2530000, 48, 1, 50, 90),
(4, 'Guillermo Varela', 33, 'LD', 74, 68, 72, 75, 45, 76, 72, 74, 0, 50, 'Uruguai', 1, 50, 0, 1000000, 1530000, 6, 1, 85, 62),
(5, 'Leo Ortiz', 30, 'ZAG', 79, 68, 82, 80, 40, 83, 74, 80, 2, 50, 'Brasil', 0, 50, 0, 12000000, 3150000, 6, 1, 50, 74),
(6, 'Leo Pereira', 30, 'ZAG', 80, 70, 84, 81, 42, 85, 73, 81, 2, 50, 'Brasil', 0, 50, 0, 12000000, 5020000, 12, 1, 50, 74),
(7, 'Ayrton Lucas', 29, 'LE', 79, 78, 74, 78, 50, 78, 76, 80, 2, 50, 'Brasil', 0, 50, 0, 14948000, 5660000, 42, 1, 15, 62),
(8, 'Danilo', 35, 'ZAG', 72, 58, 76, 78, 35, 76, 72, 72, 0, 50, 'Brasil', 1, 50, 0, 3441000, 1870000, 60, 1, 50, 74),
(9, 'Emerson Royal', 27, 'LD', 78, 74, 79, 77, 44, 79, 74, 79, 2, 50, 'Brasil', 0, 50, 0, 17285000, 7490000, 48, 1, 85, 62),
(10, 'Alex Sandro', 35, 'LE', 76, 66, 78, 79, 40, 78, 75, 76, 1, 50, 'Brasil', 0, 50, 0, 4899000, 1790000, 18, 1, 15, 62),
(11, 'Vitao', 26, 'ZAG', 76, 70, 79, 75, 35, 78, 71, 80, 1, 50, 'Brasil', 0, 50, 0, 16796000, 6460000, 60, 1, 50, 74),
(12, 'Joao Victor', 19, 'ZAG', 62, 68, 68, 60, 30, 62, 60, 78, 0, 50, 'Brasil', 1, 50, 0, 3833000, 1790000, 30, 1, 50, 74),
(13, 'Erick Pulgar', 32, 'VOL', 78, 58, 78, 82, 55, 79, 79, 78, 1, 50, 'Chile', 0, 50, 0, 9557000, 2990000, 6, 1, 50, 58),
(14, 'Saul Niguez', 32, 'MC', 76, 60, 74, 80, 58, 70, 79, 76, 1, 50, 'Espanha', 0, 50, 0, 8554000, 5270000, 18, 1, 50, 48),
(15, 'Giorgian de Arrascaeta', 32, 'MEI', 85, 74, 68, 88, 78, 45, 87, 85, 2, 50, 'Uruguai', 0, 50, 0, 18377000, 10590000, 24, 1, 50, 35),
(16, 'Jorge Carrascal', 28, 'MEI', 79, 76, 66, 79, 68, 42, 80, 81, 1, 50, 'Colômbia', 0, 50, 0, 19140000, 8190000, 6, 1, 50, 35),
(17, 'Nicolas de la Cruz', 29, 'MC', 80, 72, 68, 82, 65, 55, 82, 80, 2, 50, 'Uruguai', 0, 50, 0, 17067000, 6910000, 24, 1, 50, 48),
(18, 'Lucas Paqueta', 29, 'MEI', 84, 76, 74, 85, 74, 58, 84, 85, 2, 50, 'Brasil', 0, 50, 0, 26237000, 13310000, 6, 1, 50, 35),
(19, 'Jorginho', 35, 'VOL', 78, 52, 70, 87, 55, 75, 86, 78, 1, 50, 'Itália', 0, 50, 0, 4000000, 3990000, 18, 1, 50, 58),
(20, 'Evertton Araujo', 23, 'VOL', 72, 68, 74, 71, 55, 70, 71, 82, 0, 50, 'Brasil', 1, 50, 0, 14008000, 4420000, 18, 1, 50, 58),
(21, 'Luiz Araujo', 30, 'PD', 77, 84, 65, 76, 74, 38, 75, 77, 2, 50, 'Brasil', 0, 50, 0, 14858000, 3340000, 54, 1, 80, 25),
(22, 'Pedro', 29, 'ATA', 81, 78, 76, 79, 84, 30, 68, 81, 2, 50, 'Brasil', 0, 50, 0, 21136000, 5870000, 60, 1, 50, 12),
(23, 'Everton', 30, 'PE', 76, 80, 62, 75, 72, 32, 72, 76, 0, 50, 'Brasil', 1, 50, 0, 13686000, 3510000, 18, 1, 20, 25),
(24, 'Samuel Lino', 27, 'PE', 80, 85, 70, 78, 76, 40, 76, 82, 2, 50, 'Brasil', 0, 50, 0, 25813000, 6740000, 24, 1, 20, 25),
(25, 'Gonzalo Plata', 26, 'PD', 77, 83, 66, 75, 74, 35, 74, 79, 1, 50, 'Equador', 0, 50, 0, 20430000, 4530000, 12, 1, 80, 25),
(26, 'Bruno Henrique', 36, 'PE', 74, 72, 68, 78, 74, 35, 71, 74, 0, 50, 'Brasil', 1, 50, 0, 5044000, 1700000, 30, 1, 20, 25),
(27, 'Wallace Yan', 21, 'ATA', 68, 82, 66, 65, 66, 25, 60, 83, 0, 50, 'Brasil', 1, 50, 0, 12118000, 3830000, 18, 1, 50, 12),
(28, 'Carlos Miguel', 28, 'GOL', 76, 50, 68, 74, 10, 30, 55, 78, 2, 50, 'Brasil', 0, 50, 0, 10949000, 4130000, 6, 2, 50, 90),
(29, 'Alexander Barboza', 27, 'ZAG', 78, 62, 80, 76, 20, 82, 60, 81, 2, 50, 'Argentina', 0, 50, 0, 18931000, 9510000, 6, 2, 50, 74),
(30, 'Bruno Fuchs', 25, 'ZAG', 75, 58, 78, 73, 15, 79, 58, 80, 1, 50, 'Brasil', 0, 50, 0, 16078000, 5980000, 36, 2, 50, 74),
(31, 'Agustín Giay', 25, 'LD', 76, 74, 71, 75, 35, 74, 72, 80, 2, 50, 'Argentina', 0, 50, 0, 16796000, 7840000, 18, 2, 85, 62),
(32, 'Jefté', 23, 'LE', 72, 76, 68, 70, 30, 70, 68, 81, 0, 50, 'Brasil', 1, 50, 0, 12829000, 3220000, 18, 2, 15, 62),
(33, 'Felipe Anderson', 33, 'MC', 80, 80, 64, 82, 72, 40, 80, 80, 2, 50, 'Brasil', 0, 50, 0, 11733000, 2760000, 18, 2, 50, 48),
(34, 'Andreas Pereira', 30, 'MC', 80, 71, 68, 83, 68, 45, 84, 81, 2, 50, 'Brasil', 0, 50, 0, 17920000, 8190000, 18, 2, 50, 48),
(35, 'Vitor Roque', 21, 'ATA', 78, 80, 72, 75, 82, 25, 65, 88, 2, 50, 'Brasil', 0, 50, 0, 38000000, 6960000, 48, 2, 50, 12),
(36, 'Paulinho', 26, 'ATA', 79, 79, 70, 76, 81, 22, 66, 84, 2, 50, 'Brasil', 0, 50, 0, 28424000, 9710000, 30, 2, 50, 12),
(37, 'Jhon Arias', 33, 'MEI', 80, 78, 66, 80, 74, 32, 78, 80, 2, 50, 'Colômbia', 0, 50, 0, 12907000, 2780000, 24, 2, 50, 35),
(38, 'Khellven', 25, 'LD', 76, 82, 72, 72, 38, 73, 70, 80, 1, 50, 'Brasil', 0, 50, 0, 16796000, 5770000, 60, 2, 85, 62),
(39, 'Marcelo Lomba', 40, 'GOL', 68, 40, 64, 72, 8, 25, 50, 68, 0, 50, 'Brasil', 1, 50, 0, 1171000, 910000, 42, 2, 50, 90),
(40, 'Gustavo Gómez', 33, 'ZAG', 82, 60, 83, 85, 22, 86, 68, 82, 2, 50, 'Paraguai', 0, 50, 0, 3500000, 3610000, 48, 2, 50, 74),
(41, 'Marlon Freitas', 30, 'VOL', 78, 68, 78, 80, 35, 78, 76, 79, 1, 50, 'Brasil', 0, 50, 0, 14596000, 6650000, 54, 2, 50, 58),
(42, 'Maurício', 25, 'MC', 74, 72, 66, 73, 55, 45, 72, 79, 1, 50, 'Brasil', 0, 50, 0, 16377000, 3140000, 42, 2, 50, 48),
(43, 'Ramón Sosa', 27, 'ATA', 76, 81, 66, 72, 72, 28, 68, 80, 1, 50, 'Paraguai', 0, 50, 0, 21462000, 4270000, 24, 2, 50, 12),
(44, 'Kaique', 22, 'LD', 70, 77, 66, 68, 28, 66, 64, 80, 0, 50, 'Brasil', 1, 50, 0, 10935000, 4210000, 6, 2, 85, 62),
(45, 'Joaquín Piquerez', 29, 'LE', 79, 75, 74, 78, 42, 78, 76, 80, 2, 50, 'Uruguai', 0, 50, 0, 14948000, 7200000, 54, 2, 15, 62),
(46, 'Murilo', 28, 'ZAG', 80, 64, 81, 79, 18, 83, 64, 81, 2, 50, 'Brasil', 0, 50, 0, 16128000, 8670000, 36, 2, 50, 74),
(47, 'Lucas Evangelista', 32, 'MC', 74, 66, 66, 74, 48, 50, 74, 74, 0, 50, 'Brasil', 1, 50, 0, 7206000, 3920000, 42, 2, 50, 48),
(48, 'Luighi', 21, 'ATA', 72, 84, 64, 68, 68, 22, 60, 83, 0, 50, 'Brasil', 1, 50, 0, 17523000, 5770000, 36, 2, 50, 12),
(49, 'Emiliano Martínez', 30, 'MC', 73, 66, 67, 74, 45, 52, 72, 74, 0, 50, 'Argentina', 1, 50, 0, 10062000, 2800000, 6, 2, 50, 48),
(50, 'Allan', 35, 'VOL', 76, 60, 76, 80, 30, 80, 74, 76, 1, 50, 'Brasil', 0, 50, 0, 5171000, 1840000, 12, 2, 50, 58),
(51, 'Flaco López', 25, 'ATA', 78, 75, 74, 74, 80, 28, 64, 82, 1, 50, 'Argentina', 0, 50, 0, 25241000, 7310000, 60, 2, 50, 12),
(52, 'Benedetti', 21, 'ZAG', 68, 60, 75, 66, 15, 72, 58, 79, 0, 50, 'Brasil', 1, 50, 0, 9187000, 4090000, 18, 2, 50, 74),
(53, 'Larson', 20, 'MC', 66, 68, 60, 64, 50, 40, 64, 78, 0, 50, 'Brasil', 1, 50, 0, 7030000, 2630000, 18, 2, 50, 48),
(54, 'Arthur', 20, 'LE', 67, 74, 62, 64, 25, 62, 60, 77, 0, 50, 'Brasil', 1, 50, 0, 6643000, 2580000, 60, 2, 15, 62),
(55, 'Carlos Coronel', 29, 'GOL', 78, 55, 72, 76, 12, 32, 58, 79, 2, 50, 'Venezuela', 0, 50, 0, 12291000, 5140000, 12, 3, 50, 90),
(56, 'Felipe Preis', 23, 'GOL', 67, 48, 64, 66, 8, 25, 50, 76, 0, 50, 'Brasil', 1, 50, 0, 6850000, 3570000, 60, 3, 50, 90),
(57, 'João Pedro', 21, 'GOL', 63, 45, 60, 62, 6, 20, 46, 74, 0, 50, 'Brasil', 1, 50, 0, 4526000, 1430000, 42, 3, 50, 90),
(58, 'Rafael', 36, 'GOL', 72, 42, 66, 74, 9, 28, 54, 72, 0, 50, 'Brasil', 1, 50, 0, 3058000, 1530000, 42, 3, 50, 90),
(59, 'Young', 21, 'GOL', 62, 46, 60, 60, 6, 20, 46, 73, 0, 50, 'Brasil', 1, 50, 0, 3961000, 2280000, 6, 3, 50, 90),
(60, 'Cédric Soares', 35, 'LD', 75, 68, 70, 76, 30, 74, 74, 75, 2, 50, 'Portugal', 0, 50, 0, 4502000, 3470000, 60, 3, 85, 62),
(61, 'João Moreira', 23, 'LD', 68, 74, 64, 66, 24, 62, 62, 78, 0, 50, 'Brasil', 1, 50, 0, 8891000, 2400000, 12, 3, 85, 62),
(62, 'Lucas Ramon', 25, 'LD', 71, 76, 68, 70, 28, 68, 66, 77, 0, 50, 'Brasil', 1, 50, 0, 11618000, 5210000, 48, 3, 85, 62),
(63, 'Maik', 28, 'LD', 70, 75, 68, 68, 26, 66, 64, 71, 0, 50, 'Brasil', 1, 50, 0, 6804000, 2530000, 18, 3, 85, 62),
(64, 'Enzo Díaz', 27, 'LE', 77, 76, 70, 76, 32, 74, 74, 78, 1, 50, 'Argentina', 0, 50, 0, 15956000, 5920000, 30, 3, 15, 62),
(65, 'Nicolas', 19, 'LE', 62, 72, 58, 58, 20, 56, 52, 76, 0, 50, 'Brasil', 1, 50, 0, 3833000, 2160000, 30, 3, 15, 62),
(66, 'Wendell', 33, 'LE', 79, 72, 74, 80, 30, 78, 76, 79, 2, 50, 'Brasil', 0, 50, 0, 9788000, 3610000, 12, 3, 15, 62),
(67, 'Alan Franco', 29, 'ZAG', 78, 60, 80, 78, 18, 82, 62, 79, 2, 50, 'Argentina', 0, 50, 0, 13828000, 4840000, 42, 3, 50, 74),
(68, 'Arboleda', 32, 'ZAG', 77, 58, 79, 78, 16, 82, 60, 77, 2, 50, 'Equador', 0, 50, 0, 8358000, 6260000, 60, 3, 50, 74),
(69, 'Rafael Tolói', 36, 'ZAG', 76, 54, 76, 82, 14, 80, 66, 76, 1, 50, 'Itália', 0, 50, 0, 4899000, 1380000, 18, 3, 50, 74),
(70, 'Sabino', 29, 'ZAG', 74, 58, 76, 74, 14, 76, 60, 76, 0, 50, 'Brasil', 1, 50, 0, 10376000, 3260000, 60, 3, 50, 74),
(71, 'Bobadilla', 28, 'VOL', 75, 66, 76, 78, 30, 76, 72, 76, 1, 50, 'Paraguai', 0, 50, 0, 11405000, 4650000, 42, 3, 50, 58),
(72, 'Cauly', 29, 'MC', 76, 72, 66, 78, 62, 40, 78, 77, 2, 50, 'Brasil', 0, 50, 0, 13064000, 4170000, 48, 3, 50, 48),
(73, 'Danielzinho', 28, 'MC', 72, 68, 64, 72, 55, 42, 72, 73, 0, 50, 'Brasil', 1, 50, 0, 9175000, 2880000, 24, 3, 50, 48),
(74, 'Hugo Leonardo', 21, 'MC', 65, 66, 60, 64, 45, 35, 62, 77, 0, 50, 'Brasil', 1, 50, 0, 7500000, 2990000, 6, 3, 50, 48),
(75, 'Luan', 33, 'MC', 74, 66, 62, 76, 58, 38, 74, 74, 0, 50, 'Brasil', 1, 50, 0, 7206000, 1440000, 30, 3, 50, 48),
(76, 'Marcos Antônio', 26, 'VOL', 77, 68, 74, 79, 45, 72, 78, 79, 2, 50, 'Brasil', 0, 50, 0, 17644000, 6450000, 36, 3, 50, 58),
(77, 'Negrucci', 21, 'MC', 64, 64, 58, 62, 42, 34, 60, 75, 0, 50, 'Brasil', 1, 50, 0, 6428000, 2440000, 24, 3, 50, 48),
(78, 'Pablo Maia', 25, 'VOL', 78, 70, 72, 80, 40, 76, 78, 84, 2, 50, 'Brasil', 0, 50, 0, 22589000, 7350000, 36, 3, 50, 58),
(79, 'Pedro Ferreira', 22, 'MC', 66, 68, 60, 65, 46, 36, 64, 76, 0, 50, 'Brasil', 1, 50, 0, 7909000, 2960000, 12, 3, 50, 48),
(80, 'André Silva', 29, 'ATA', 75, 76, 74, 72, 76, 24, 60, 75, 1, 50, 'Brasil', 0, 50, 0, 13148000, 4760000, 6, 3, 50, 12),
(81, 'Artur', 28, 'PD', 76, 80, 68, 72, 68, 26, 66, 76, 1, 50, 'Brasil', 0, 50, 0, 13686000, 5680000, 60, 3, 80, 25),
(82, 'Calleri', 33, 'ATA', 80, 68, 78, 78, 82, 26, 62, 80, 2, 50, 'Argentina', 0, 50, 0, 13493000, 4530000, 54, 3, 50, 12),
(83, 'Ferreirinha', 26, 'PE', 73, 78, 62, 70, 66, 22, 66, 76, 2, 50, 'Brasil', 0, 50, 0, 15153000, 3130000, 18, 3, 20, 25),
(84, 'Gonzalo Tapia', 28, 'ATA', 76, 78, 72, 72, 78, 24, 62, 77, 1, 50, 'Chile', 0, 50, 0, 15023000, 5360000, 54, 3, 50, 12),
(85, 'Lucas Moura', 34, 'PD', 79, 80, 62, 78, 70, 28, 74, 79, 2, 50, 'Brasil', 0, 50, 0, 7613000, 2500000, 6, 3, 80, 25),
(86, 'Lucca', 23, 'ATA', 70, 78, 68, 66, 66, 22, 58, 80, 0, 50, 'Brasil', 1, 50, 0, 13972000, 3690000, 24, 3, 50, 12),
(87, 'Luciano', 33, 'ATA', 80, 74, 74, 76, 82, 24, 64, 80, 1, 50, 'Brasil', 0, 50, 0, 13493000, 3220000, 18, 3, 50, 12),
(88, 'Paulinho', 29, 'ATA', 74, 74, 70, 70, 70, 24, 62, 74, 0, 50, 'Brasil', 1, 50, 0, 12053000, 4920000, 12, 3, 50, 12),
(89, 'Ryan Francisco', 21, 'PE', 66, 79, 60, 62, 60, 20, 56, 78, 0, 50, 'Brasil', 1, 50, 0, 9280000, 3120000, 42, 3, 20, 25),
(90, 'Felipe Longo', 21, 'GOL', 63, 46, 62, 62, 7, 22, 48, 75, 0, 50, 'Brasil', 1, 50, 0, 4672000, 3590000, 24, 4, 50, 90),
(91, 'Hugo Souza', 27, 'GOL', 78, 54, 74, 78, 11, 32, 58, 80, 2, 50, 'Brasil', 0, 50, 0, 16096000, 7700000, 36, 4, 50, 90),
(92, 'Kauê', 22, 'GOL', 62, 44, 60, 60, 6, 20, 46, 74, 0, 50, 'Brasil', 1, 50, 0, 4089000, 2020000, 60, 4, 50, 90),
(93, 'Matheus Donelli', 24, 'GOL', 68, 48, 66, 70, 8, 26, 52, 76, 0, 50, 'Brasil', 1, 50, 0, 8195000, 2170000, 6, 4, 50, 90),
(94, 'André Ramalho', 34, 'ZAG', 74, 52, 76, 78, 14, 78, 60, 74, 1, 50, 'Brasil', 0, 50, 0, 4127000, 2910000, 54, 4, 50, 74),
(95, 'Gabriel Paulista', 35, 'ZAG', 75, 50, 78, 78, 14, 80, 62, 75, 2, 50, 'Brasil', 0, 50, 0, 4502000, 2930000, 30, 4, 50, 74),
(96, 'Gustavo Henrique', 33, 'ZAG', 76, 54, 79, 78, 15, 80, 62, 76, 2, 50, 'Brasil', 0, 50, 0, 7698000, 2760000, 6, 4, 50, 74),
(97, 'Pedro Milans', 24, 'ZAG', 71, 58, 74, 72, 14, 74, 60, 79, 0, 50, 'Brasil', 1, 50, 0, 12512000, 5850000, 6, 4, 50, 74),
(98, 'Renato Santos', 21, 'ZAG', 64, 58, 68, 64, 12, 66, 54, 76, 0, 50, 'Brasil', 1, 50, 0, 5972000, 2590000, 6, 4, 50, 74),
(99, 'Tchoca', 22, 'ZAG', 65, 56, 70, 64, 12, 67, 54, 77, 0, 50, 'Brasil', 1, 50, 0, 6750000, 3740000, 30, 4, 50, 74),
(100, 'Hugo', 28, 'LD', 72, 74, 68, 70, 26, 68, 66, 73, 0, 50, 'Brasil', 1, 50, 0, 8258000, 4360000, 6, 4, 85, 62),
(101, 'Matheuzinho', 25, 'LD', 74, 78, 66, 72, 28, 70, 68, 78, 2, 50, 'Brasil', 0, 50, 0, 14149000, 5340000, 42, 4, 85, 62),
(102, 'Fabrizio Angileri', 32, 'LE', 76, 70, 72, 76, 30, 74, 74, 76, 2, 50, 'Argentina', 0, 50, 0, 7698000, 4740000, 54, 4, 15, 62),
(103, 'Matheus Bidu', 27, 'LE', 72, 72, 68, 70, 26, 70, 68, 73, 0, 50, 'Brasil', 1, 50, 0, 10322000, 4980000, 36, 4, 15, 62),
(104, 'Alex Santana', 31, 'MC', 74, 66, 66, 74, 50, 46, 74, 74, 1, 50, 'Brasil', 0, 50, 0, 7206000, 2730000, 42, 4, 50, 48),
(105, 'Allan', 29, 'VOL', 78, 62, 78, 80, 32, 80, 74, 78, 2, 50, 'Brasil', 0, 50, 0, 13901000, 6820000, 48, 4, 50, 58),
(106, 'André Carrillo', 35, 'MC', 75, 68, 62, 76, 58, 34, 74, 75, 1, 50, 'Peru', 0, 50, 0, 5002000, 1910000, 48, 4, 50, 48),
(107, 'André Luiz', 20, 'MC', 64, 66, 58, 62, 42, 36, 60, 78, 0, 50, 'Brasil', 1, 50, 0, 5530000, 2060000, 42, 4, 50, 48),
(108, 'Bahia', 20, 'MC', 63, 64, 58, 60, 40, 34, 58, 76, 0, 50, 'Brasil', 1, 50, 0, 4867000, 2040000, 12, 4, 50, 48),
(109, 'Breno Bidon', 21, 'VOL', 74, 68, 72, 78, 36, 74, 72, 84, 1, 50, 'Brasil', 0, 50, 0, 16802000, 6840000, 48, 4, 50, 58),
(110, 'Charles', 30, 'VOL', 76, 64, 76, 78, 32, 78, 72, 76, 2, 50, 'Brasil', 0, 50, 0, 11820000, 3200000, 48, 4, 50, 58),
(111, 'Jesse Lingard', 33, 'MC', 74, 64, 62, 76, 58, 36, 76, 74, 0, 50, 'Inglaterra', 1, 50, 0, 7206000, 2430000, 30, 4, 50, 48),
(112, 'Matheus Pereira', 28, 'MC', 76, 70, 64, 76, 62, 38, 76, 76, 1, 50, 'Brasil', 0, 50, 0, 12442000, 5050000, 18, 4, 50, 48),
(113, 'Raniele', 29, 'VOL', 76, 66, 77, 78, 34, 78, 72, 76, 1, 50, 'Brasil', 0, 50, 0, 11820000, 3710000, 6, 4, 50, 58),
(114, 'Rodrigo Garro', 28, 'MC', 79, 72, 62, 80, 66, 38, 80, 80, 2, 50, 'Argentina', 0, 50, 0, 16609000, 10850000, 48, 4, 50, 48),
(115, 'Zakaria Labyad', 33, 'MC', 73, 64, 62, 74, 56, 36, 74, 73, 0, 50, 'Marrocos', 1, 50, 0, 6588000, 1330000, 48, 4, 50, 48),
(116, 'Dieguinho', 18, 'PE', 62, 78, 56, 58, 54, 20, 54, 79, 2, 50, 'Brasil', 0, 50, 0, 4685000, 2180000, 18, 4, 20, 25),
(117, 'Gui Negão', 19, 'ATA', 65, 74, 66, 64, 64, 22, 56, 80, 0, 50, 'Brasil', 1, 50, 0, 7188000, 2690000, 54, 4, 50, 12),
(118, 'Kaio César', 22, 'PD', 66, 76, 62, 64, 58, 22, 58, 77, 0, 50, 'Brasil', 1, 50, 0, 8990000, 3920000, 24, 4, 80, 25),
(119, 'Kayke', 22, 'ATA', 68, 76, 68, 66, 66, 22, 58, 78, 0, 50, 'Brasil', 1, 50, 0, 11360000, 4110000, 12, 4, 50, 12),
(120, 'Memphis Depay', 32, 'ATA', 82, 74, 76, 80, 84, 26, 74, 82, 2, 50, 'Holanda', 0, 50, 0, 7000000, 7630000, 36, 4, 50, 12),
(121, 'Pedro Raul', 29, 'ATA', 74, 66, 78, 70, 74, 24, 58, 74, 0, 50, 'Brasil', 1, 50, 0, 12053000, 5870000, 24, 4, 50, 12),
(122, 'Vitinho', 32, 'PD', 74, 78, 64, 70, 66, 24, 64, 74, 2, 50, 'Brasil', 0, 50, 0, 7926000, 2300000, 18, 4, 80, 25),
(123, 'Yuri Alberto', 25, 'ATA', 80, 78, 74, 76, 80, 24, 64, 84, 1, 50, 'Brasil', 0, 50, 0, 29440000, 5690000, 42, 4, 50, 12),
(124, 'Éverson', 35, 'GOL', 79, 48, 72, 80, 10, 32, 58, 79, 2, 50, 'Brasil', 0, 50, 0, 5536000, 2830000, 54, 5, 50, 90),
(125, 'Pedro Cobra', 20, 'GOL', 60, 44, 60, 58, 6, 20, 44, 74, 0, 50, 'Brasil', 1, 50, 0, 2560000, 1790000, 60, 5, 50, 90),
(126, 'Gabriel Delfim', 24, 'GOL', 68, 46, 66, 70, 8, 26, 52, 75, 0, 50, 'Brasil', 1, 50, 0, 7903000, 2700000, 30, 5, 50, 90),
(127, 'Robert', 21, 'GOL', 61, 44, 60, 60, 6, 20, 44, 73, 0, 50, 'Brasil', 1, 50, 0, 3556000, 2530000, 36, 5, 50, 90),
(128, 'Lyanco', 29, 'ZAG', 77, 58, 80, 78, 16, 82, 62, 77, 2, 50, 'Brasil', 0, 50, 0, 12157000, 5320000, 30, 5, 50, 74),
(129, 'Ruan', 27, 'LD', 74, 76, 68, 72, 28, 68, 66, 74, 1, 50, 'Brasil', 0, 50, 0, 11791000, 3160000, 42, 5, 85, 62),
(130, 'Léo Duarte', 29, 'ZAG', 73, 56, 76, 74, 14, 76, 58, 73, 1, 50, 'Brasil', 0, 50, 0, 8625000, 4560000, 18, 5, 50, 74),
(131, 'Iván Román', 20, 'ZAG', 68, 60, 74, 66, 14, 70, 56, 80, 0, 50, 'Argentina', 1, 50, 0, 7903000, 3410000, 18, 5, 50, 74),
(132, 'Vitor Hugo', 35, 'ZAG', 74, 50, 76, 78, 14, 78, 58, 74, 2, 50, 'Brasil', 0, 50, 0, 4127000, 1290000, 60, 5, 50, 74),
(133, 'Rômulo', 22, 'LD', 66, 74, 64, 64, 22, 62, 60, 76, 0, 50, 'Brasil', 1, 50, 0, 7118000, 4070000, 42, 5, 85, 62),
(134, 'Vitão', 18, 'ZAG', 62, 58, 68, 60, 12, 64, 52, 78, 0, 50, 'Brasil', 1, 50, 0, 3833000, 2220000, 42, 5, 50, 74),
(135, 'Renan Lodi', 28, 'LE', 78, 76, 70, 76, 32, 74, 74, 78, 2, 50, 'Brasil', 0, 50, 0, 13169000, 4430000, 48, 5, 15, 62),
(136, 'Kauã Pascini', 18, 'LE', 61, 72, 60, 58, 20, 58, 52, 77, 0, 50, 'Brasil', 1, 50, 0, 3334000, 2630000, 30, 5, 15, 62),
(137, 'Natanael', 24, 'LE', 71, 74, 66, 70, 24, 70, 66, 74, 1, 50, 'Brasil', 0, 50, 0, 10278000, 4740000, 6, 5, 15, 62),
(138, 'Angelo Preciado', 28, 'LD', 75, 76, 68, 74, 30, 72, 70, 75, 2, 50, 'Equador', 0, 50, 0, 10290000, 3760000, 24, 5, 85, 62),
(139, 'Alexsander', 22, 'VOL', 70, 66, 70, 72, 28, 72, 66, 79, 0, 50, 'Brasil', 1, 50, 0, 11158000, 5030000, 6, 5, 50, 58),
(140, 'Tomás Pérez', 20, 'VOL', 65, 64, 66, 64, 24, 66, 60, 78, 0, 50, 'Argentina', 1, 50, 0, 5938000, 2590000, 12, 5, 50, 58),
(141, 'Patrick', 22, 'MC', 67, 68, 62, 66, 42, 42, 64, 76, 0, 50, 'Brasil', 1, 50, 0, 8562000, 4650000, 60, 5, 50, 48),
(142, 'Victor Hugo', 22, 'MC', 72, 72, 64, 74, 54, 40, 74, 82, 1, 50, 'Brasil', 0, 50, 0, 14746000, 5480000, 24, 5, 50, 48),
(143, 'Alan Franco', 27, 'VOL', 72, 64, 74, 74, 28, 74, 66, 72, 1, 50, 'Argentina', 0, 50, 0, 10377000, 3910000, 54, 5, 50, 58),
(144, 'Maycon', 29, 'VOL', 74, 64, 74, 76, 30, 76, 70, 74, 2, 50, 'Brasil', 0, 50, 0, 9957000, 6310000, 30, 5, 50, 58),
(145, 'Mamady Cissé', 19, 'MC', 64, 68, 62, 62, 40, 38, 60, 78, 0, 50, 'Brasil', 1, 50, 0, 5530000, 2690000, 12, 5, 50, 48),
(146, 'Índio', 18, 'MC', 61, 66, 58, 58, 38, 36, 58, 76, 0, 50, 'Brasil', 1, 50, 0, 3704000, 1750000, 12, 5, 50, 48),
(147, 'Gustavo Scarpa', 32, 'MC', 80, 70, 64, 82, 66, 38, 82, 80, 2, 50, 'Brasil', 0, 50, 0, 11733000, 4730000, 18, 5, 50, 48),
(148, 'Igor Gomes', 27, 'MC', 75, 70, 66, 76, 58, 42, 76, 75, 2, 50, 'Brasil', 0, 50, 0, 14292000, 4730000, 24, 5, 50, 48),
(149, 'Reinier', 24, 'MC', 74, 74, 64, 74, 56, 38, 74, 82, 1, 50, 'Brasil', 0, 50, 0, 18342000, 6050000, 60, 5, 50, 48),
(150, 'Tomás Cuello', 26, 'PE', 75, 80, 64, 72, 68, 24, 66, 75, 1, 50, 'Brasil', 0, 50, 0, 15721000, 3040000, 12, 5, 20, 25),
(151, 'Dudu', 34, 'PD', 76, 78, 64, 76, 68, 26, 68, 76, 2, 50, 'Brasil', 0, 50, 0, 5988000, 2500000, 18, 5, 80, 25),
(152, 'Bernard', 33, 'PE', 76, 78, 60, 74, 66, 24, 68, 76, 2, 50, 'Brasil', 0, 50, 0, 9409000, 3380000, 60, 5, 20, 25),
(153, 'Alan Minda', 23, 'PD', 70, 80, 60, 66, 62, 22, 60, 79, 0, 50, 'Equador', 1, 50, 0, 12920000, 4760000, 48, 5, 80, 25),
(154, 'Cauã Soares', 18, 'ATA', 61, 74, 62, 58, 60, 20, 52, 77, 0, 50, 'Brasil', 1, 50, 0, 4260000, 1920000, 60, 5, 50, 12),
(155, 'Mateo Cassierra', 29, 'ATA', 77, 76, 76, 74, 78, 24, 60, 77, 2, 50, 'Colômbia', 0, 50, 0, 15534000, 7440000, 60, 5, 50, 12),
(156, 'Cristhian Loor', 20, 'GOL', 65, 48, 62, 62, 7, 22, 48, 78, 0, 50, 'Brasil', 1, 50, 0, 5000000, 2630000, 48, 6, 50, 90),
(157, 'Léo Linck', 25, 'GOL', 76, 52, 70, 76, 10, 30, 56, 78, 2, 50, 'Brasil', 0, 50, 0, 13686000, 5700000, 30, 6, 50, 90),
(158, 'Raul', 28, 'GOL', 74, 50, 70, 74, 9, 28, 54, 74, 1, 50, 'Brasil', 0, 50, 0, 8385000, 4170000, 42, 6, 50, 90),
(159, 'Alex Telles', 33, 'LE', 77, 72, 70, 76, 32, 74, 76, 77, 2, 50, 'Brasil', 0, 50, 0, 8358000, 2800000, 48, 6, 15, 62),
(160, 'Anthony', 21, 'LD', 66, 76, 64, 64, 24, 60, 58, 78, 0, 50, 'Brasil', 1, 50, 0, 7593000, 3170000, 36, 6, 85, 62),
(161, 'Bastos', 35, 'ZAG', 73, 50, 78, 76, 14, 78, 56, 73, 2, 50, 'Angola', 0, 50, 0, 3773000, 1450000, 12, 6, 50, 74),
(162, 'Caio Roque', 24, 'ZAG', 68, 58, 72, 66, 12, 70, 54, 75, 0, 50, 'Brasil', 1, 50, 0, 8891000, 3570000, 24, 6, 50, 74),
(163, 'Jhoan Hernández', 20, 'ZAG', 66, 60, 72, 64, 12, 68, 52, 79, 0, 50, 'Colômbia', 1, 50, 0, 6327000, 3000000, 18, 6, 50, 74),
(164, 'Kaio', 30, 'ZAG', 70, 54, 74, 70, 12, 72, 54, 70, 0, 50, 'Brasil', 1, 50, 0, 6480000, 1810000, 24, 6, 50, 74),
(165, 'Marçal', 37, 'LE', 71, 62, 68, 74, 26, 72, 68, 71, 0, 50, 'Brasil', 1, 50, 0, 1787000, 820000, 54, 6, 15, 62),
(166, 'Mateo Ponte', 23, 'ZAG', 72, 58, 74, 72, 14, 74, 58, 80, 0, 50, 'Brasil', 1, 50, 0, 12386000, 5610000, 30, 6, 50, 74),
(167, 'Nahuel Ferraresi', 27, 'ZAG', 76, 58, 79, 76, 16, 80, 60, 76, 2, 50, 'Venezuela', 0, 50, 0, 13997000, 4630000, 48, 6, 50, 74),
(168, 'Vitinho', 26, 'LD', 76, 78, 68, 74, 30, 72, 70, 76, 2, 50, 'Brasil', 0, 50, 0, 13997000, 4870000, 30, 6, 85, 62),
(169, 'Ythallo', 21, 'LD', 65, 74, 62, 62, 22, 60, 58, 77, 0, 50, 'Brasil', 1, 50, 0, 6750000, 2420000, 6, 6, 85, 62),
(170, 'Allan', 35, 'VOL', 77, 58, 76, 80, 30, 80, 72, 77, 2, 50, 'Brasil', 0, 50, 0, 5614000, 3540000, 12, 6, 50, 58),
(171, 'Cristian Medina', 24, 'MC', 76, 68, 64, 76, 58, 40, 78, 78, 2, 50, 'Argentina', 0, 50, 0, 17107000, 5880000, 18, 6, 50, 48),
(172, 'Danilo', 25, 'VOL', 74, 64, 74, 74, 28, 76, 68, 75, 1, 50, 'Brasil', 0, 50, 0, 13069000, 4380000, 24, 6, 50, 58),
(173, 'Edenilson', 36, 'MC', 73, 60, 64, 74, 52, 42, 72, 73, 1, 50, 'Brasil', 0, 50, 0, 4193000, 940000, 30, 6, 50, 48),
(174, 'Huguinho', 19, 'MC', 63, 66, 58, 60, 42, 34, 58, 77, 0, 50, 'Brasil', 1, 50, 0, 4867000, 2270000, 24, 6, 50, 48),
(175, 'Jordan Barrera', 20, 'MC', 65, 68, 58, 62, 44, 34, 60, 78, 0, 50, 'Brasil', 1, 50, 0, 6250000, 2130000, 24, 6, 50, 48),
(176, 'Newton', 26, 'VOL', 73, 64, 74, 74, 28, 74, 66, 74, 0, 50, 'Brasil', 1, 50, 0, 11949000, 6200000, 12, 6, 50, 58),
(177, 'Patrick de Paula', 26, 'VOL', 76, 66, 76, 76, 32, 78, 72, 76, 1, 50, 'Brasil', 0, 50, 0, 14774000, 3740000, 24, 6, 50, 58),
(178, 'Santiago Rodríguez', 26, 'MC', 77, 70, 62, 78, 60, 38, 80, 77, 2, 50, 'Uruguai', 0, 50, 0, 16884000, 6220000, 18, 6, 50, 48),
(179, 'Wallace Davi', 19, 'MC', 62, 66, 58, 60, 40, 32, 58, 76, 0, 50, 'Brasil', 1, 50, 0, 4259000, 2060000, 18, 6, 50, 48),
(180, 'Arthur Cabral', 28, 'ATA', 78, 72, 78, 74, 80, 26, 62, 78, 2, 50, 'Brasil', 0, 50, 0, 16827000, 6790000, 24, 6, 50, 12),
(181, 'Diego Hernández', 26, 'ATA', 74, 74, 72, 70, 74, 24, 58, 74, 1, 50, 'Brasil', 0, 50, 0, 15067000, 3250000, 24, 6, 50, 12),
(182, 'Elias Manoel', 24, 'PD', 73, 80, 62, 68, 64, 22, 64, 76, 0, 50, 'Brasil', 1, 50, 0, 15153000, 3680000, 24, 6, 80, 25),
(183, 'Joaquín Correa', 31, 'PE', 77, 76, 66, 76, 74, 24, 70, 77, 2, 50, 'Argentina', 0, 50, 0, 10215000, 4990000, 36, 6, 20, 25),
(184, 'Júnior Santos', 31, 'ATA', 76, 74, 74, 72, 76, 24, 60, 76, 1, 50, 'Brasil', 0, 50, 0, 9837000, 3940000, 24, 6, 50, 12),
(185, 'Kadir Barria', 18, 'PD', 63, 78, 58, 58, 54, 20, 54, 78, 0, 50, 'Brasil', 1, 50, 0, 5353000, 1870000, 48, 6, 80, 25),
(186, 'Lucas Villalba', 25, 'PE', 74, 78, 62, 70, 66, 22, 66, 74, 1, 50, 'Brasil', 0, 50, 0, 14411000, 3970000, 18, 6, 20, 25),
(187, 'Matheus Martins', 23, 'PD', 74, 80, 60, 70, 66, 22, 66, 82, 2, 50, 'Brasil', 0, 50, 0, 18158000, 4580000, 12, 6, 80, 25),
(188, 'Matheus Nascimento', 22, 'ATA', 71, 76, 70, 66, 70, 22, 58, 81, 0, 50, 'Brasil', 1, 50, 0, 15417000, 3080000, 6, 6, 50, 12),
(189, 'Nathan Fernandes', 21, 'PE', 66, 78, 58, 62, 58, 20, 56, 78, 0, 50, 'Brasil', 1, 50, 0, 9280000, 3500000, 36, 6, 20, 25),
(190, 'Álvaro Montoro', 19, 'MC', 66, 72, 58, 66, 54, 28, 64, 79, 0, 50, 'Brasil', 1, 50, 0, 7030000, 2470000, 6, 6, 50, 48),
(191, 'Fábio', 45, 'GOL', 73, 38, 62, 80, 8, 26, 52, 73, 2, 50, 'Brasil', 0, 50, 0, 1917000, 1460000, 30, 7, 50, 90),
(192, 'Marcelo Pitaluga', 23, 'GOL', 71, 50, 68, 72, 9, 28, 54, 80, 0, 50, 'Brasil', 1, 50, 0, 10367000, 6340000, 12, 7, 50, 90),
(193, 'Vitor Eudes', 27, 'GOL', 68, 48, 66, 68, 8, 24, 50, 70, 0, 50, 'Brasil', 1, 50, 0, 6439000, 4080000, 42, 7, 50, 90),
(194, 'Davi Schuindt', 22, 'ZAG', 66, 58, 68, 64, 12, 68, 54, 78, 0, 50, 'Brasil', 1, 50, 0, 7593000, 3770000, 60, 7, 50, 74),
(195, 'Freytes', 26, 'ZAG', 75, 56, 78, 76, 15, 79, 58, 75, 2, 50, 'Argentina', 0, 50, 0, 12862000, 5800000, 42, 7, 50, 74),
(196, 'Guga', 27, 'LD', 77, 78, 68, 74, 28, 70, 70, 77, 2, 50, 'Brasil', 0, 50, 0, 15196000, 7010000, 18, 7, 85, 62),
(197, 'Guilherme Arana', 29, 'LE', 80, 78, 70, 78, 34, 76, 78, 80, 2, 50, 'Brasil', 0, 50, 0, 15360000, 5780000, 6, 7, 15, 62),
(198, 'Ignácio', 29, 'ZAG', 74, 54, 76, 74, 14, 76, 58, 74, 2, 50, 'Brasil', 0, 50, 0, 9433000, 5550000, 6, 7, 50, 74),
(199, 'Igor Rabello', 31, 'ZAG', 74, 52, 77, 74, 14, 77, 58, 74, 1, 50, 'Brasil', 0, 50, 0, 6485000, 3660000, 18, 7, 50, 74),
(200, 'Jemmes', 26, 'LD', 68, 72, 64, 64, 22, 62, 58, 70, 0, 50, 'Brasil', 1, 50, 0, 7244000, 2290000, 48, 7, 85, 62),
(201, 'Julio Fidelis', 19, 'ZAG', 62, 58, 66, 60, 12, 64, 52, 76, 0, 50, 'Brasil', 1, 50, 0, 3833000, 1510000, 18, 7, 50, 74),
(202, 'Julián Millán', 28, 'LE', 74, 72, 68, 72, 26, 72, 68, 74, 1, 50, 'Colômbia', 0, 50, 0, 9433000, 4450000, 24, 7, 15, 62),
(203, 'Renê', 33, 'LE', 73, 68, 68, 74, 26, 74, 70, 73, 0, 50, 'Brasil', 1, 50, 0, 5930000, 1750000, 60, 7, 15, 62),
(204, 'Samuel Xavier', 36, 'LD', 72, 68, 66, 74, 24, 72, 68, 72, 0, 50, 'Brasil', 1, 50, 0, 3441000, 1090000, 12, 7, 85, 62),
(205, 'Alisson', 33, 'VOL', 75, 62, 76, 76, 28, 78, 72, 75, 2, 50, 'Brasil', 0, 50, 0, 7467000, 2300000, 18, 7, 50, 58),
(206, 'David Terans', 31, 'MC', 75, 68, 64, 76, 58, 38, 76, 75, 1, 50, 'Uruguai', 0, 50, 0, 7860000, 3290000, 48, 7, 50, 48),
(207, 'Facundo Bernal', 22, 'VOL', 70, 66, 70, 70, 26, 70, 64, 80, 0, 50, 'Uruguai', 1, 50, 0, 11542000, 4480000, 30, 7, 50, 58),
(208, 'Ganso', 36, 'MC', 76, 58, 58, 82, 54, 32, 84, 76, 2, 50, 'Brasil', 0, 50, 0, 5443000, 1790000, 36, 7, 50, 48),
(209, 'Hércules', 25, 'VOL', 73, 66, 72, 72, 28, 74, 66, 73, 0, 50, 'Brasil', 1, 50, 0, 11380000, 5100000, 36, 7, 50, 58),
(210, 'Jefferson Savarino', 29, 'PD', 78, 80, 66, 74, 68, 26, 70, 78, 2, 50, 'Venezuela', 0, 50, 0, 16096000, 3910000, 54, 7, 80, 25),
(211, 'Luciano Acosta', 32, 'MC', 81, 74, 60, 82, 68, 32, 82, 81, 2, 50, 'Argentina', 0, 50, 0, 12636000, 7740000, 12, 7, 50, 48),
(212, 'Martinelli', 24, 'VOL', 73, 68, 70, 72, 32, 72, 68, 76, 0, 50, 'Brasil', 1, 50, 0, 13087000, 6020000, 60, 7, 50, 58),
(213, 'Nonato', 28, 'MC', 74, 72, 62, 74, 52, 38, 74, 74, 1, 50, 'Brasil', 0, 50, 0, 10481000, 5670000, 54, 7, 50, 48),
(214, 'Otávio', 32, 'VOL', 75, 64, 74, 76, 30, 76, 70, 75, 1, 50, 'Brasil', 0, 50, 0, 7467000, 3800000, 36, 7, 50, 58),
(215, 'Agustín Canobbio', 27, 'PD', 76, 80, 66, 72, 66, 26, 66, 76, 1, 50, 'Uruguai', 0, 50, 0, 17107000, 4290000, 30, 7, 80, 25),
(216, 'Germán Cano', 38, 'ATA', 78, 66, 72, 78, 84, 22, 58, 78, 2, 50, 'Argentina', 0, 50, 0, 4207000, 1040000, 42, 7, 50, 12),
(217, 'John Kennedy', 24, 'ATA', 73, 76, 72, 68, 72, 22, 58, 81, 0, 50, 'Brasil', 1, 50, 0, 19286000, 5440000, 54, 7, 50, 12),
(218, 'Kevin Serna', 28, 'PE', 76, 80, 64, 72, 68, 24, 66, 76, 1, 50, 'Colômbia', 0, 50, 0, 13686000, 4100000, 12, 7, 20, 25),
(219, 'Matheus Reis', 19, 'PE', 62, 76, 58, 58, 54, 20, 52, 77, 0, 50, 'Brasil', 1, 50, 0, 4685000, 1440000, 6, 7, 20, 25),
(220, 'Riquelme', 19, 'PD', 63, 78, 58, 60, 56, 20, 54, 78, 0, 50, 'Brasil', 1, 50, 0, 5353000, 1810000, 48, 7, 80, 25),
(221, 'Rodrigo Castillo', 27, 'ATA', 71, 74, 70, 66, 68, 22, 58, 72, 0, 50, 'Brasil', 1, 50, 0, 11991000, 3850000, 42, 7, 50, 12),
(222, 'Yeferson Soteldo', 28, 'PE', 78, 80, 58, 76, 72, 22, 72, 78, 2, 50, 'Venezuela', 0, 50, 0, 16096000, 5580000, 48, 7, 20, 25),
(223, 'Gabriel Grando', 26, 'GOL', 74, 50, 70, 74, 9, 28, 54, 76, 1, 50, 'Brasil', 0, 50, 0, 11529000, 4130000, 42, 8, 50, 90),
(224, 'Gabriel Menegon', 17, 'GOL', 58, 42, 58, 56, 5, 18, 42, 74, 0, 50, 'Brasil', 1, 50, 0, 1866000, 1390000, 36, 8, 50, 90),
(225, 'Thiago Beltrame', 22, 'GOL', 65, 46, 64, 66, 7, 24, 48, 76, 0, 50, 'Brasil', 1, 50, 0, 5812000, 3300000, 36, 8, 50, 90),
(226, 'Weverton', 38, 'GOL', 78, 44, 72, 80, 10, 30, 58, 78, 2, 50, 'Brasil', 0, 50, 0, 2927000, 1020000, 24, 8, 50, 90),
(227, 'Caio Paulista', 28, 'LE', 74, 74, 68, 72, 26, 72, 68, 74, 1, 50, 'Brasil', 0, 50, 0, 9433000, 5460000, 42, 8, 15, 62),
(228, 'Cristian Pavón', 30, 'PD', 74, 78, 64, 70, 64, 22, 64, 74, 1, 50, 'Argentina', 0, 50, 0, 11529000, 3220000, 60, 8, 80, 25),
(229, 'Fabián Balbuena', 34, 'ZAG', 73, 50, 78, 76, 14, 78, 58, 73, 1, 50, 'Paraguai', 0, 50, 0, 3773000, 2630000, 12, 8, 50, 74),
(230, 'Gustavo Martins', 23, 'ZAG', 68, 58, 70, 64, 12, 68, 54, 78, 0, 50, 'Brasil', 1, 50, 0, 8891000, 4160000, 18, 8, 50, 74),
(231, 'João Pedro', 29, 'ZAG', 72, 54, 74, 72, 14, 74, 56, 72, 0, 50, 'Brasil', 1, 50, 0, 7864000, 2380000, 18, 8, 50, 74),
(232, 'Luis Eduardo', 18, 'LE', 61, 72, 60, 58, 20, 58, 52, 76, 0, 50, 'Brasil', 1, 50, 0, 3334000, 1550000, 6, 8, 15, 62),
(233, 'Marcos Rocha', 37, 'LD', 70, 66, 64, 74, 24, 70, 66, 70, 2, 50, 'Brasil', 0, 50, 0, 1620000, 750000, 48, 8, 85, 62),
(234, 'Marlon', 28, 'LE', 75, 74, 68, 74, 28, 74, 70, 75, 2, 50, 'Brasil', 0, 50, 0, 10290000, 5650000, 48, 8, 15, 62),
(235, 'Viery', 21, 'LD', 67, 76, 64, 64, 24, 64, 60, 79, 0, 50, 'Brasil', 1, 50, 0, 8503000, 3440000, 60, 8, 85, 62),
(236, 'Wagner Leonardo', 26, 'ZAG', 74, 56, 76, 74, 15, 77, 58, 74, 2, 50, 'Brasil', 0, 50, 0, 11791000, 6520000, 6, 8, 50, 74),
(237, 'Walter Kannemann', 35, 'ZAG', 74, 52, 78, 76, 14, 78, 58, 74, 2, 50, 'Argentina', 0, 50, 0, 4127000, 1420000, 18, 8, 50, 74),
(238, 'Arthur', 29, 'VOL', 76, 64, 64, 80, 44, 62, 80, 76, 2, 50, 'Brasil', 0, 50, 0, 11820000, 4940000, 12, 8, 50, 58),
(239, 'Dodi', 30, 'VOL', 74, 64, 74, 74, 28, 76, 68, 74, 2, 50, 'Brasil', 0, 50, 0, 9957000, 4580000, 18, 8, 50, 58),
(240, 'Erick Noriega', 24, 'VOL', 71, 64, 72, 70, 26, 72, 64, 73, 0, 50, 'Brasil', 1, 50, 0, 10377000, 4040000, 6, 8, 50, 58),
(241, 'Gabriel Mec', 18, 'MC', 61, 66, 58, 60, 42, 34, 58, 77, 0, 50, 'Brasil', 1, 50, 0, 3704000, 1910000, 54, 8, 50, 48),
(242, 'Juan Nardoni', 23, 'VOL', 68, 64, 68, 68, 26, 68, 62, 78, 0, 50, 'Brasil', 1, 50, 0, 9384000, 4530000, 36, 8, 50, 58),
(243, 'Leonel Pérez', 21, 'MC', 64, 68, 60, 64, 44, 36, 62, 78, 0, 50, 'Brasil', 1, 50, 0, 6636000, 2680000, 12, 8, 50, 48),
(244, 'Mathías Villasanti', 29, 'VOL', 77, 64, 78, 78, 30, 80, 70, 77, 2, 50, 'Paraguai', 0, 50, 0, 12832000, 5190000, 30, 8, 50, 58),
(245, 'Miguel Monsalve', 22, 'PD', 67, 76, 60, 64, 58, 22, 58, 78, 0, 50, 'Colômbia', 1, 50, 0, 10068000, 2950000, 36, 8, 80, 25),
(246, 'Riquelme', 19, 'MC', 61, 68, 58, 60, 42, 32, 58, 76, 0, 50, 'Brasil', 1, 50, 0, 3704000, 2130000, 42, 8, 50, 48),
(247, 'Tiaguinho', 18, 'MC', 60, 66, 56, 58, 40, 30, 56, 76, 0, 50, 'Brasil', 1, 50, 0, 3200000, 2400000, 42, 8, 50, 48),
(248, 'Andre Martins', 24, 'ATA', 68, 72, 68, 64, 64, 22, 56, 74, 0, 50, 'Brasil', 1, 50, 0, 10939000, 3700000, 24, 8, 50, 12),
(249, 'Carlos Vinícius', 31, 'ATA', 78, 72, 76, 74, 80, 24, 60, 78, 2, 50, 'Brasil', 0, 50, 0, 11569000, 6220000, 12, 8, 50, 12),
(250, 'Francis Amuzu', 26, 'PE', 74, 80, 64, 68, 62, 22, 62, 74, 2, 50, 'Bélgica', 0, 50, 0, 14411000, 4210000, 24, 8, 20, 25),
(251, 'José Enamorado', 27, 'PE', 73, 78, 62, 68, 64, 22, 64, 73, 1, 50, 'Brasil', 0, 50, 0, 13177000, 4490000, 6, 8, 20, 25),
(252, 'Martin Braithwaite', 34, 'ATA', 76, 70, 74, 74, 78, 24, 60, 76, 1, 50, 'Dinamarca', 0, 50, 0, 6260000, 2650000, 12, 8, 50, 12),
(253, 'Roger', 18, 'PD', 61, 76, 58, 58, 52, 20, 52, 78, 0, 50, 'Brasil', 1, 50, 0, 4075000, 1950000, 12, 8, 80, 25),
(254, 'Tetê', 26, 'PD', 76, 80, 64, 72, 68, 24, 68, 76, 2, 50, 'Brasil', 0, 50, 0, 17107000, 4160000, 36, 8, 80, 25),
(255, 'Willian', 37, 'PD', 73, 64, 58, 76, 60, 24, 72, 73, 1, 50, 'Brasil', 0, 50, 0, 2635000, 920000, 48, 8, 80, 25),
(256, 'Anthoni', 24, 'GOL', 74, 50, 70, 74, 9, 28, 54, 76, 1, 50, 'Brasil', 0, 50, 0, 11529000, 5120000, 36, 9, 50, 90),
(257, 'Diego Esser', 21, 'GOL', 63, 44, 62, 62, 6, 20, 46, 76, 0, 50, 'Brasil', 1, 50, 0, 4672000, 1910000, 54, 9, 50, 90),
(258, 'Kauan', 23, 'GOL', 65, 46, 64, 66, 7, 22, 48, 75, 0, 50, 'Brasil', 1, 50, 0, 5625000, 2470000, 42, 9, 50, 90),
(259, 'Sergio Rochet', 33, 'GOL', 79, 52, 74, 80, 11, 32, 58, 79, 2, 50, 'Uruguai', 0, 50, 0, 8700000, 4480000, 6, 9, 50, 90),
(260, 'Alexandro Bernabei', 25, 'LE', 75, 74, 68, 72, 28, 72, 70, 75, 2, 50, 'Argentina', 0, 50, 0, 12862000, 3750000, 30, 9, 15, 62),
(261, 'Braian Aguirre', 25, 'LD', 73, 76, 66, 70, 26, 68, 64, 74, 1, 50, 'Argentina', 0, 50, 0, 11320000, 5350000, 54, 9, 85, 62),
(262, 'Bruno Gomes', 25, 'ZAG', 72, 58, 72, 72, 14, 74, 60, 73, 2, 50, 'Brasil', 0, 50, 0, 10322000, 4780000, 48, 9, 50, 74),
(263, 'Clayton', 26, 'LD', 72, 76, 64, 68, 24, 64, 62, 73, 0, 50, 'Brasil', 1, 50, 0, 10322000, 5140000, 12, 9, 85, 62),
(264, 'Félix Torres', 29, 'ZAG', 77, 56, 79, 78, 15, 80, 58, 77, 2, 50, 'Brasil', 0, 50, 0, 12157000, 6600000, 30, 9, 50, 74),
(265, 'Gabriel Mercado', 39, 'ZAG', 71, 46, 74, 78, 12, 76, 58, 71, 0, 50, 'Argentina', 1, 50, 0, 1787000, 1080000, 24, 9, 50, 74),
(266, 'Juninho', 31, 'LD', 74, 70, 66, 74, 26, 72, 68, 74, 2, 50, 'Brasil', 0, 50, 0, 6485000, 2890000, 36, 9, 85, 62),
(267, 'Matheus Bahia', 26, 'LE', 73, 74, 66, 70, 24, 70, 66, 73, 0, 50, 'Brasil', 1, 50, 0, 10781000, 3820000, 60, 9, 15, 62),
(268, 'Victor Gabriel', 22, 'ZAG', 67, 58, 68, 64, 12, 68, 54, 78, 0, 50, 'Brasil', 1, 50, 0, 8237000, 3220000, 18, 9, 50, 74),
(269, 'Alan Patrick', 35, 'MC', 79, 64, 60, 84, 68, 36, 80, 79, 2, 50, 'Brasil', 0, 50, 0, 6921000, 3780000, 6, 9, 50, 48),
(270, 'Alan Rodríguez', 26, 'VOL', 74, 64, 74, 74, 28, 74, 68, 74, 2, 50, 'Uruguai', 0, 50, 0, 12446000, 5150000, 30, 9, 50, 58),
(271, 'Allex', 20, 'MC', 65, 68, 58, 64, 44, 34, 62, 78, 0, 50, 'Brasil', 1, 50, 0, 6250000, 1680000, 60, 9, 50, 48),
(272, 'Benjamin', 20, 'MC', 63, 68, 58, 60, 42, 32, 58, 77, 0, 50, 'Brasil', 1, 50, 0, 4867000, 1770000, 18, 9, 50, 48),
(273, 'Bruno Henrique', 36, 'MC', 71, 58, 58, 74, 50, 34, 72, 71, 0, 50, 'Brasil', 1, 50, 0, 3476000, 700000, 30, 9, 50, 48),
(274, 'Paulinho Paula', 29, 'VOL', 73, 64, 74, 72, 28, 74, 66, 73, 0, 50, 'Brasil', 1, 50, 0, 9104000, 4560000, 42, 9, 50, 58),
(275, 'Richard', 32, 'VOL', 74, 62, 74, 74, 28, 76, 68, 74, 1, 50, 'Brasil', 0, 50, 0, 6845000, 4780000, 54, 9, 50, 58),
(276, 'Rodrigo Villagra', 25, 'VOL', 74, 66, 72, 74, 30, 74, 68, 74, 1, 50, 'Argentina', 0, 50, 0, 12446000, 3580000, 48, 9, 50, 58),
(277, 'Ronaldo', 29, 'MC', 73, 68, 62, 74, 54, 38, 72, 73, 0, 50, 'Brasil', 1, 50, 0, 9583000, 3160000, 6, 9, 50, 48),
(278, 'Thiago Maia', 29, 'VOL', 77, 64, 78, 78, 30, 80, 72, 77, 2, 50, 'Brasil', 0, 50, 0, 12832000, 4000000, 36, 9, 50, 58),
(279, 'Yago Noal', 19, 'MC', 62, 66, 58, 60, 42, 32, 58, 76, 0, 50, 'Brasil', 1, 50, 0, 4259000, 2070000, 18, 9, 50, 48),
(280, 'Alerrandro', 26, 'ATA', 74, 72, 74, 70, 74, 24, 58, 74, 1, 50, 'Brasil', 0, 50, 0, 15067000, 5160000, 54, 9, 50, 12),
(281, 'Bruno Tabata', 29, 'PD', 76, 80, 64, 74, 68, 24, 68, 76, 2, 50, 'Brasil', 0, 50, 0, 13686000, 4320000, 18, 9, 80, 25),
(282, 'Johan Carbonero', 26, 'PD', 76, 82, 64, 72, 66, 24, 66, 76, 1, 50, 'Colômbia', 0, 50, 0, 17107000, 5970000, 6, 9, 80, 25),
(283, 'Kayky', 23, 'PE', 72, 80, 62, 66, 64, 22, 62, 81, 2, 50, 'Brasil', 0, 50, 0, 15679000, 4820000, 60, 9, 20, 25),
(284, 'Rafael Borré', 30, 'ATA', 79, 74, 76, 76, 82, 24, 62, 79, 2, 50, 'Colômbia', 0, 50, 0, 18191000, 3500000, 42, 9, 50, 12),
(285, 'Raykkonen', 18, 'ATA', 62, 74, 62, 58, 60, 20, 52, 78, 0, 50, 'Brasil', 1, 50, 0, 4898000, 2680000, 24, 9, 50, 12),
(286, 'Vitinho', 27, 'PD', 75, 80, 64, 72, 66, 24, 66, 75, 1, 50, 'Brasil', 0, 50, 0, 15721000, 4250000, 30, 9, 80, 25),
(287, 'João Paulo', 30, 'GOL', 75, 52, 70, 76, 10, 30, 56, 76, 2, 50, 'Brasil', 0, 50, 0, 9604000, 3760000, 36, 11, 50, 90),
(288, 'Léo Vieira', 35, 'GOL', 72, 46, 68, 72, 9, 28, 54, 72, 0, 50, 'Brasil', 1, 50, 0, 3058000, 1450000, 42, 11, 50, 90),
(289, 'Ronaldo', 29, 'GOL', 70, 48, 66, 70, 8, 26, 52, 71, 0, 50, 'Brasil', 1, 50, 0, 6048000, 3370000, 18, 11, 50, 90),
(290, 'Victor', 20, 'GOL', 62, 44, 60, 60, 6, 20, 46, 76, 0, 50, 'Brasil', 1, 50, 0, 3407000, 1710000, 54, 11, 50, 90),
(291, 'David Duarte', 31, 'ZAG', 76, 54, 78, 76, 15, 80, 60, 76, 2, 50, 'Brasil', 0, 50, 0, 7698000, 4640000, 12, 11, 50, 74),
(292, 'Fredi Gomes', 20, 'LD', 62, 74, 58, 58, 20, 58, 52, 76, 0, 50, 'Brasil', 1, 50, 0, 3833000, 1920000, 18, 11, 85, 62),
(293, 'Gabriel Xavier', 25, 'LD', 71, 74, 64, 68, 24, 68, 64, 73, 2, 50, 'Brasil', 0, 50, 0, 9831000, 5490000, 12, 11, 85, 62),
(294, 'Gilberto', 33, 'LE', 76, 72, 66, 76, 28, 72, 74, 76, 2, 50, 'Brasil', 0, 50, 0, 7698000, 2320000, 30, 11, 15, 62),
(295, 'Iago', 29, 'LD', 71, 72, 64, 68, 24, 68, 64, 71, 0, 50, 'Brasil', 1, 50, 0, 7150000, 4300000, 60, 11, 85, 62),
(296, 'Kanu', 29, 'ZAG', 78, 56, 80, 78, 16, 82, 60, 78, 2, 50, 'Brasil', 0, 50, 0, 13169000, 8000000, 30, 11, 50, 74),
(297, 'Luciano', 26, 'LE', 75, 76, 66, 74, 28, 74, 72, 75, 1, 50, 'Brasil', 0, 50, 0, 12862000, 4160000, 30, 11, 15, 62),
(298, 'Luiz Gustavo', 20, 'ZAG', 62, 58, 66, 60, 12, 64, 50, 76, 0, 50, 'Brasil', 1, 50, 0, 3833000, 1240000, 36, 11, 50, 74),
(299, 'Marcos Victor', 24, 'ZAG', 71, 58, 72, 68, 13, 72, 56, 79, 0, 50, 'Brasil', 1, 50, 0, 12512000, 2610000, 36, 11, 50, 74),
(300, 'Román Gómez', 21, 'ZAG', 66, 58, 70, 64, 12, 68, 54, 78, 0, 50, 'Brasil', 1, 50, 0, 7593000, 2880000, 48, 11, 50, 74),
(301, 'Santiago Ramos Mingo', 24, 'ZAG', 73, 58, 76, 72, 14, 76, 58, 80, 1, 50, 'Argentina', 0, 50, 0, 14554000, 5870000, 12, 11, 50, 74),
(302, 'Zé Guilherme', 21, 'ZAG', 64, 58, 68, 62, 12, 66, 52, 77, 0, 50, 'Brasil', 1, 50, 0, 5972000, 3040000, 54, 11, 50, 74),
(303, 'Caio Alexandre', 27, 'VOL', 78, 66, 76, 78, 32, 78, 74, 78, 2, 50, 'Brasil', 0, 50, 0, 17376000, 8070000, 36, 11, 50, 58),
(304, 'Erick', 28, 'MC', 77, 74, 64, 76, 62, 38, 76, 77, 2, 50, 'Brasil', 0, 50, 0, 13507000, 7380000, 54, 11, 50, 48),
(305, 'Everton Ribeiro', 37, 'MC', 78, 62, 58, 82, 58, 36, 82, 78, 2, 50, 'Brasil', 0, 50, 0, 3658000, 1600000, 6, 11, 50, 48),
(306, 'Jean Lucas', 27, 'VOL', 75, 64, 74, 74, 28, 76, 68, 75, 1, 50, 'Brasil', 0, 50, 0, 13577000, 6230000, 24, 11, 50, 58),
(307, 'Nicolás Acevedo', 27, 'VOL', 76, 64, 74, 76, 30, 76, 70, 76, 1, 50, 'Uruguai', 0, 50, 0, 14774000, 6170000, 6, 11, 50, 58),
(308, 'Rodrigo Nestor', 25, 'MC', 73, 70, 62, 72, 50, 36, 72, 73, 1, 50, 'Brasil', 0, 50, 0, 11979000, 3130000, 18, 11, 50, 48),
(309, 'Roger', 19, 'MC', 63, 66, 58, 60, 42, 32, 58, 77, 0, 50, 'Brasil', 1, 50, 0, 4867000, 2320000, 6, 11, 50, 48),
(310, 'Ademir', 31, 'ATA', 74, 74, 72, 68, 74, 22, 58, 74, 1, 50, 'Brasil', 0, 50, 0, 8287000, 2630000, 18, 11, 50, 12),
(311, 'Cristian Olivera', 24, 'PE', 75, 80, 64, 70, 68, 22, 64, 75, 1, 50, 'Uruguai', 0, 50, 0, 15721000, 6500000, 12, 11, 20, 25),
(312, 'Dell', 17, 'ATA', 60, 74, 58, 56, 56, 18, 50, 78, 0, 50, 'Brasil', 1, 50, 0, 3680000, 1570000, 6, 11, 50, 12),
(313, 'Erick Pulga', 25, 'PE', 76, 80, 60, 70, 66, 20, 66, 76, 2, 50, 'Brasil', 0, 50, 0, 17107000, 3560000, 36, 11, 20, 25),
(314, 'Everaldo', 34, 'ATA', 73, 68, 74, 68, 74, 22, 56, 73, 0, 50, 'Brasil', 1, 50, 0, 4822000, 1710000, 60, 11, 50, 12),
(315, 'Mateo Sanabria', 22, 'ATA', 71, 74, 70, 66, 70, 22, 58, 80, 0, 50, 'Brasil', 1, 50, 0, 14903000, 4250000, 18, 11, 50, 12),
(316, 'Michel Araújo', 29, 'PD', 74, 76, 64, 70, 64, 22, 66, 74, 2, 50, 'Brasil', 0, 50, 0, 11529000, 5540000, 48, 11, 80, 25),
(317, 'Ruan Pablo', 17, 'PD', 59, 76, 56, 54, 52, 18, 50, 77, 0, 50, 'Brasil', 1, 50, 0, 3018000, 2040000, 54, 11, 80, 25),
(318, 'Willian José', 34, 'ATA', 75, 66, 76, 72, 76, 22, 58, 75, 2, 50, 'Brasil', 0, 50, 0, 5752000, 1700000, 12, 11, 50, 12),
(319, 'Cássio', 38, 'GOL', 76, 44, 70, 80, 10, 30, 58, 76, 2, 50, 'Brasil', 0, 50, 0, 2488000, 1460000, 36, 10, 50, 90),
(320, 'Matheus Cunha', 25, 'GOL', 71, 50, 66, 70, 8, 26, 52, 75, 0, 50, 'Brasil', 1, 50, 0, 9533000, 4820000, 18, 10, 50, 90),
(321, 'Otávio Costa', 20, 'GOL', 62, 44, 60, 60, 6, 20, 44, 76, 0, 50, 'Brasil', 1, 50, 0, 3407000, 2110000, 18, 10, 50, 90),
(322, 'Bruno Alves', 20, 'LD', 62, 72, 58, 58, 20, 58, 52, 76, 0, 50, 'Brasil', 1, 50, 0, 3833000, 1350000, 30, 10, 85, 62),
(323, 'Fabrício Bruno', 30, 'ZAG', 78, 58, 80, 78, 16, 82, 62, 78, 2, 50, 'Brasil', 0, 50, 0, 13169000, 5830000, 6, 10, 50, 74),
(324, 'Fagner', 36, 'LD', 71, 66, 64, 74, 24, 70, 66, 71, 2, 50, 'Brasil', 0, 50, 0, 3128000, 890000, 48, 10, 85, 62),
(325, 'Janderson', 20, 'LD', 62, 74, 58, 58, 20, 58, 52, 75, 0, 50, 'Brasil', 1, 50, 0, 3833000, 2080000, 42, 10, 85, 62),
(326, 'Jonathan Jesus', 22, 'ZAG', 65, 58, 68, 64, 12, 66, 52, 77, 0, 50, 'Brasil', 1, 50, 0, 6750000, 2780000, 24, 10, 50, 74),
(327, 'João Marcelo', 25, 'ZAG', 73, 56, 76, 72, 14, 76, 58, 73, 2, 50, 'Brasil', 0, 50, 0, 10781000, 4230000, 42, 10, 50, 74),
(328, 'Kaiki', 23, 'ZAG', 68, 58, 70, 66, 12, 70, 54, 78, 0, 50, 'Brasil', 1, 50, 0, 8891000, 3740000, 12, 10, 50, 74),
(329, 'Kauã Moraes', 19, 'ZAG', 61, 58, 66, 60, 12, 64, 50, 76, 0, 50, 'Brasil', 1, 50, 0, 3334000, 1970000, 6, 10, 50, 74),
(330, 'Kauã Prates', 17, 'LE', 58, 70, 56, 54, 18, 54, 48, 76, 0, 50, 'Brasil', 1, 50, 0, 2100000, 1250000, 60, 10, 15, 62),
(331, 'Lucas Villalba', 31, 'LE', 74, 72, 68, 74, 26, 74, 68, 74, 2, 50, 'Brasil', 0, 50, 0, 6485000, 4070000, 18, 10, 15, 62),
(332, 'William', 31, 'LE', 73, 68, 68, 72, 25, 72, 66, 73, 1, 50, 'Brasil', 0, 50, 0, 5930000, 2550000, 36, 10, 15, 62),
(333, 'Christian', 25, 'MC', 74, 72, 64, 74, 58, 38, 74, 74, 1, 50, 'Brasil', 0, 50, 0, 13101000, 6160000, 6, 10, 50, 48),
(334, 'Gerson', 29, 'MC', 80, 68, 64, 84, 64, 40, 84, 80, 2, 50, 'Brasil', 0, 50, 0, 17067000, 7850000, 42, 10, 50, 48),
(335, 'Japa', 22, 'MC', 67, 70, 60, 64, 46, 36, 62, 78, 0, 50, 'Brasil', 1, 50, 0, 9153000, 4030000, 18, 10, 50, 48),
(336, 'Lucas Romero', 32, 'VOL', 74, 62, 74, 74, 28, 76, 68, 74, 1, 50, 'Argentina', 0, 50, 0, 6845000, 2630000, 6, 10, 50, 58),
(337, 'Lucas Silva', 33, 'VOL', 75, 60, 74, 78, 28, 76, 72, 75, 1, 50, 'Brasil', 0, 50, 0, 7467000, 2290000, 42, 10, 50, 58),
(338, 'Matheus Henrique', 28, 'VOL', 76, 64, 74, 76, 30, 76, 72, 76, 2, 50, 'Brasil', 0, 50, 0, 11820000, 8310000, 48, 10, 50, 58),
(339, 'Matheus Pereira', 30, 'MC', 76, 70, 64, 76, 62, 38, 76, 76, 2, 50, 'Brasil', 0, 50, 0, 12442000, 3600000, 60, 10, 50, 48),
(340, 'Murilo Rhikman', 20, 'MC', 63, 66, 58, 60, 42, 32, 58, 77, 0, 50, 'Brasil', 1, 50, 0, 4867000, 2630000, 42, 10, 50, 48),
(341, 'Walace', 31, 'VOL', 76, 62, 78, 76, 30, 78, 70, 76, 1, 50, 'Brasil', 0, 50, 0, 8126000, 3880000, 36, 10, 50, 58),
(342, 'Bruno Rodrigues', 29, 'ATA', 73, 72, 72, 68, 72, 22, 58, 73, 1, 50, 'Brasil', 0, 50, 0, 11021000, 6110000, 30, 10, 50, 12),
(343, 'Chico da Costa', 31, 'ATA', 72, 70, 72, 68, 70, 22, 56, 72, 1, 50, 'Brasil', 0, 50, 0, 6909000, 2450000, 60, 10, 50, 12),
(344, 'Kaio Jorge', 24, 'ATA', 79, 76, 74, 76, 82, 24, 62, 79, 2, 50, 'Brasil', 0, 50, 0, 22739000, 6990000, 18, 10, 50, 12),
(345, 'Kaique Kenji', 20, 'PD', 63, 76, 58, 60, 54, 20, 54, 77, 0, 50, 'Brasil', 1, 50, 0, 5353000, 2540000, 12, 10, 80, 25),
(346, 'Keny Arroyo', 20, 'PE', 66, 80, 58, 62, 58, 20, 58, 79, 0, 50, 'Brasil', 1, 50, 0, 7733000, 2450000, 36, 10, 20, 25),
(347, 'Luis Sinisterra', 26, 'PE', 78, 82, 64, 74, 72, 24, 68, 78, 2, 50, 'Colômbia', 0, 50, 0, 20120000, 8550000, 54, 10, 20, 25),
(348, 'Marquinhos', 23, 'PD', 70, 78, 62, 66, 62, 22, 62, 79, 0, 50, 'Brasil', 1, 50, 0, 12920000, 4330000, 54, 10, 80, 25),
(349, 'Neyser Villareal', 21, 'ATA', 67, 74, 68, 64, 66, 20, 54, 79, 0, 50, 'Colômbia', 1, 50, 0, 10865000, 3980000, 54, 10, 50, 12),
(350, 'Wanderson', 31, 'PD', 75, 78, 64, 72, 68, 24, 66, 75, 2, 50, 'Brasil', 0, 50, 0, 8646000, 2810000, 36, 10, 80, 25),
(351, 'Daniel Fuzato', 29, 'GOL', 74, 50, 68, 74, 9, 28, 54, 74, 1, 50, 'Brasil', 0, 50, 0, 8385000, 4230000, 18, 12, 50, 90),
(352, 'Léo Jardim', 31, 'GOL', 76, 52, 70, 76, 10, 30, 56, 76, 2, 50, 'Brasil', 0, 50, 0, 6843000, 4170000, 30, 12, 50, 90),
(353, 'Pablo', 23, 'GOL', 66, 46, 64, 64, 7, 22, 48, 77, 0, 50, 'Brasil', 1, 50, 0, 6538000, 2590000, 60, 12, 50, 90),
(354, 'Alan Saldivia', 24, 'ZAG', 71, 56, 74, 70, 13, 74, 56, 79, 2, 50, 'Brasil', 0, 50, 0, 12512000, 4150000, 12, 12, 50, 74),
(355, 'Carlos Cuesta', 27, 'ZAG', 75, 58, 78, 76, 15, 79, 60, 75, 2, 50, 'Brasil', 0, 50, 0, 12862000, 5490000, 42, 12, 50, 74),
(356, 'Cuiabano', 23, 'LE', 69, 74, 64, 66, 22, 66, 62, 79, 0, 50, 'Brasil', 1, 50, 1, 9878000, 4900000, 30, 12, 15, 62),
(357, 'Lucas Freitas', 25, 'LD', 70, 74, 64, 66, 22, 66, 62, 70, 0, 50, 'Brasil', 1, 50, 0, 8100000, 3310000, 18, 12, 85, 62),
(358, 'Lucas Piton', 25, 'LE', 75, 78, 66, 74, 28, 74, 70, 75, 2, 50, 'Brasil', 0, 50, 0, 12862000, 7070000, 30, 12, 15, 62),
(359, 'Paulo Henrique', 29, 'LD', 72, 72, 66, 70, 24, 70, 64, 72, 1, 50, 'Brasil', 0, 50, 0, 7864000, 3590000, 18, 12, 85, 62),
(360, 'Puma Rodríguez', 29, 'LD', 76, 76, 68, 74, 30, 74, 68, 76, 2, 50, 'Uruguai', 0, 50, 0, 11197000, 5650000, 30, 12, 85, 62),
(361, 'Robert Renan', 22, 'ZAG', 68, 58, 70, 66, 12, 70, 54, 79, 0, 50, 'Brasil', 1, 50, 0, 9187000, 4640000, 18, 12, 50, 74),
(362, 'Walace', 21, 'ZAG', 64, 58, 68, 60, 12, 66, 50, 77, 0, 50, 'Brasil', 1, 50, 0, 5972000, 2840000, 18, 12, 50, 74),
(363, 'Cauan Barros', 22, 'VOL', 65, 66, 64, 64, 26, 66, 58, 78, 0, 50, 'Brasil', 1, 50, 0, 7125000, 2640000, 54, 12, 50, 58),
(364, 'Hugo Moura', 28, 'VOL', 74, 64, 74, 74, 28, 76, 68, 74, 2, 50, 'Brasil', 0, 50, 0, 9957000, 5140000, 42, 12, 50, 58),
(365, 'JP', 21, 'MC', 62, 66, 58, 60, 42, 32, 58, 76, 0, 50, 'Brasil', 1, 50, 0, 5111000, 2330000, 12, 12, 50, 48),
(366, 'Jair', 31, 'VOL', 74, 60, 74, 74, 28, 76, 68, 74, 1, 50, 'Brasil', 0, 50, 0, 6845000, 4790000, 48, 12, 50, 58),
(367, 'Johan Rojas', 23, 'PD', 72, 80, 60, 68, 64, 22, 62, 80, 1, 50, 'Equador', 0, 50, 0, 15139000, 5230000, 60, 12, 80, 25),
(368, 'Lucas Eduardo', 22, 'MC', 63, 66, 58, 62, 42, 34, 60, 77, 0, 50, 'Brasil', 1, 50, 0, 5840000, 3290000, 54, 12, 50, 48),
(369, 'Mateus Carvalho', 24, 'MC', 70, 68, 62, 70, 50, 38, 70, 73, 0, 50, 'Brasil', 1, 50, 0, 10350000, 2120000, 36, 12, 50, 48),
(370, 'Matheus França', 22, 'MC', 75, 74, 62, 78, 64, 36, 78, 84, 2, 50, 'Brasil', 0, 50, 0, 18651000, 7970000, 60, 12, 50, 48),
(371, 'Tchê Tchê', 33, 'VOL', 73, 62, 74, 74, 28, 76, 66, 73, 1, 50, 'Brasil', 0, 50, 0, 6259000, 2440000, 42, 12, 50, 58),
(372, 'Thiago Mendes', 34, 'VOL', 76, 60, 76, 78, 30, 78, 70, 76, 2, 50, 'Brasil', 0, 50, 0, 5171000, 1900000, 12, 12, 50, 58),
(373, 'Adson', 25, 'PD', 73, 80, 62, 68, 66, 22, 64, 73, 1, 50, 'Brasil', 0, 50, 0, 13177000, 5530000, 54, 12, 80, 25),
(374, 'Andrés Gómez', 23, 'PE', 71, 78, 60, 66, 64, 20, 60, 80, 0, 50, 'Equador', 1, 50, 0, 14255000, 4780000, 12, 12, 20, 25),
(375, 'Brenner', 26, 'ATA', 74, 74, 74, 68, 74, 22, 58, 74, 1, 50, 'Brasil', 0, 50, 0, 15067000, 5500000, 12, 12, 50, 12),
(376, 'Claudio Spinelli', 29, 'ATA', 76, 72, 76, 72, 78, 24, 60, 76, 2, 50, 'Brasil', 0, 50, 0, 14308000, 4580000, 60, 12, 50, 12),
(377, 'David', 30, 'ATA', 71, 70, 72, 66, 70, 22, 56, 71, 0, 50, 'Brasil', 1, 50, 0, 9136000, 2890000, 54, 12, 50, 12),
(378, 'Marino Hinestroza', 24, 'PE', 74, 80, 62, 68, 66, 22, 64, 74, 2, 50, 'Brasil', 0, 50, 0, 14411000, 5310000, 54, 12, 20, 25),
(379, 'Nuno Moreira', 27, 'PD', 75, 80, 64, 72, 68, 24, 68, 75, 2, 50, 'Brasil', 0, 50, 0, 15721000, 3810000, 30, 12, 80, 25),
(380, 'Diógenes', 25, 'GOL', 68, 48, 64, 66, 7, 22, 48, 72, 0, 50, 'Brasil', 1, 50, 0, 7025000, 3230000, 6, 13, 50, 90),
(381, 'Gabriel Brazão', 25, 'GOL', 72, 50, 68, 72, 9, 26, 52, 75, 2, 50, 'Brasil', 0, 50, 0, 10049000, 5080000, 60, 13, 50, 90),
(382, 'Rodrigo Falcão', 21, 'GOL', 63, 44, 60, 60, 6, 20, 44, 76, 0, 50, 'Brasil', 1, 50, 0, 4672000, 2130000, 36, 13, 50, 90),
(383, 'Adonis Frías', 28, 'ZAG', 74, 54, 76, 74, 14, 76, 58, 74, 1, 50, 'Brasil', 0, 50, 0, 9433000, 3210000, 42, 13, 50, 74),
(384, 'Alex', 27, 'LD', 68, 72, 62, 64, 22, 62, 60, 68, 0, 50, 'Brasil', 1, 50, 0, 6586000, 4040000, 18, 13, 85, 62),
(385, 'Gonzalo Escobar', 29, 'LD', 72, 72, 66, 70, 26, 68, 66, 72, 0, 50, 'Argentina', 1, 50, 0, 7864000, 2970000, 12, 13, 85, 62),
(386, 'Igor Vinícius', 29, 'LD', 74, 76, 66, 72, 26, 70, 66, 74, 2, 50, 'Brasil', 0, 50, 0, 9433000, 4270000, 24, 13, 85, 62),
(387, 'João Ananias', 19, 'ZAG', 62, 58, 66, 60, 12, 64, 50, 76, 0, 50, 'Brasil', 1, 50, 0, 3833000, 1930000, 60, 13, 50, 74),
(388, 'Luan Peres', 31, 'ZAG', 77, 56, 78, 78, 15, 80, 62, 77, 2, 50, 'Brasil', 0, 50, 0, 8358000, 5150000, 12, 13, 50, 74),
(389, 'Lucas Veríssimo', 31, 'ZAG', 76, 56, 78, 76, 15, 79, 60, 76, 2, 50, 'Brasil', 0, 50, 0, 7698000, 3710000, 24, 13, 50, 74),
(390, 'Mayke', 33, 'LD', 73, 68, 66, 74, 24, 70, 66, 73, 0, 50, 'Brasil', 1, 50, 0, 5930000, 1710000, 12, 13, 85, 62),
(391, 'Vinicius Lira', 18, 'LE', 60, 72, 58, 56, 18, 56, 50, 76, 2, 50, 'Brasil', 0, 50, 0, 2880000, 1920000, 36, 13, 15, 62),
(392, 'Zé Ivaldo', 29, 'ZAG', 72, 54, 74, 70, 13, 74, 56, 72, 0, 50, 'Brasil', 1, 50, 0, 7864000, 5720000, 24, 13, 50, 74),
(393, 'Christian Oliva', 30, 'VOL', 73, 62, 72, 74, 28, 74, 68, 73, 0, 50, 'Uruguai', 1, 50, 0, 9104000, 2730000, 48, 13, 50, 58),
(394, 'Gabriel Bontempo', 21, 'MC', 66, 68, 60, 66, 46, 36, 64, 78, 0, 50, 'Brasil', 1, 50, 0, 8436000, 3250000, 54, 13, 50, 48),
(395, 'Gabriel Menino', 25, 'VOL', 76, 72, 70, 76, 36, 74, 72, 76, 2, 50, 'Brasil', 0, 50, 0, 14774000, 5960000, 36, 13, 50, 58),
(396, 'Gustavo Henrique', 21, 'MC', 64, 66, 58, 62, 44, 34, 60, 77, 0, 50, 'Brasil', 1, 50, 0, 6636000, 3370000, 60, 13, 50, 48),
(397, 'João Schmidt', 33, 'VOL', 74, 60, 74, 74, 28, 76, 68, 74, 1, 50, 'Brasil', 0, 50, 0, 6845000, 2360000, 30, 13, 50, 58),
(398, 'Miguelito', 22, 'MC', 66, 70, 60, 64, 46, 34, 62, 78, 0, 50, 'Brasil', 1, 50, 0, 8436000, 3590000, 54, 13, 50, 48),
(399, 'Neymar', 34, 'MC', 82, 72, 58, 86, 74, 32, 86, 82, 2, 50, 'Brasil', 0, 50, 0, 8000000, 5070000, 36, 13, 50, 48),
(400, 'Thaciano', 31, 'MC', 74, 72, 62, 74, 58, 36, 74, 74, 1, 50, 'Brasil', 0, 50, 0, 7206000, 4520000, 30, 13, 50, 48),
(401, 'Tomás Rincón', 38, 'VOL', 71, 52, 72, 76, 24, 76, 66, 71, 0, 50, 'Venezuela', 1, 50, 0, 1887000, 1320000, 24, 13, 50, 58),
(402, 'Willian Arão', 34, 'VOL', 76, 62, 78, 76, 32, 78, 70, 76, 2, 50, 'Brasil', 0, 50, 0, 5171000, 2230000, 30, 13, 50, 58),
(403, 'Zé Rafael', 33, 'MC', 75, 66, 68, 76, 56, 44, 76, 75, 1, 50, 'Brasil', 0, 50, 0, 7860000, 2730000, 36, 13, 50, 48),
(404, 'Benjamín Rollheiser', 26, 'PE', 75, 78, 64, 72, 68, 24, 68, 75, 1, 50, 'Argentina', 0, 50, 0, 15721000, 3370000, 30, 13, 20, 25);
INSERT INTO `jogador` (`idJogador`, `nomeJogador`, `idade`, `posicao_principal`, `overall`, `velocidade`, `forca`, `inteligencia`, `finalizacao`, `marcacao`, `passe`, `potencial`, `titular`, `moral`, `nacionalidade`, `dispEmprestimo`, `satisfacao`, `onfire`, `valor`, `valorRescisao`, `tempoContrato`, `clube_idClube`, `posicaoX`, `posicaoY`) VALUES
(405, 'Enzo Boer', 21, 'ATA', 64, 72, 64, 60, 60, 20, 52, 77, 0, 50, 'Brasil', 1, 50, 0, 7631000, 2570000, 36, 13, 50, 12),
(406, 'Gabriel Barbosa', 29, 'ATA', 79, 74, 72, 76, 82, 24, 60, 79, 2, 50, 'Brasil', 0, 50, 0, 18191000, 7970000, 12, 13, 50, 12),
(407, 'Lautaro Díaz', 28, 'ATA', 74, 72, 74, 70, 74, 22, 58, 74, 1, 50, 'Argentina', 0, 50, 0, 12053000, 5320000, 54, 13, 50, 12),
(408, 'Mateus Xavier', 19, 'PD', 61, 76, 58, 58, 54, 20, 52, 77, 2, 50, 'Brasil', 0, 50, 0, 4075000, 2230000, 54, 13, 80, 25),
(409, 'Moisés', 29, 'PE', 74, 78, 64, 70, 66, 22, 64, 74, 0, 50, 'Brasil', 1, 50, 0, 11529000, 5010000, 48, 13, 20, 25),
(410, 'Robinho Júnior', 18, 'PD', 60, 76, 56, 58, 52, 18, 54, 78, 0, 50, 'Brasil', 1, 50, 0, 3520000, 1740000, 18, 13, 80, 25),
(411, 'Rony', 31, 'ATA', 77, 78, 68, 72, 74, 24, 64, 77, 1, 50, 'Brasil', 0, 50, 0, 10679000, 5430000, 36, 13, 50, 12),
(412, 'Álvaro Barreal', 25, 'PE', 76, 78, 62, 74, 68, 22, 70, 76, 2, 50, 'Argentina', 0, 50, 0, 17107000, 8100000, 54, 13, 20, 25),
(413, 'Cleiton', 28, 'GOL', 74, 50, 75, 76, 10, 70, 68, 75, 2, 50, 'Brasil', 0, 50, 0, 8804000, 6260000, 42, 14, 50, 90),
(414, 'Tiago Volpi', 35, 'GOL', 73, 42, 74, 80, 10, 68, 70, 73, 1, 50, 'Brasil', 0, 50, 0, 3354000, 3040000, 60, 14, 50, 90),
(415, 'Guzmán Rodríguez', 26, 'LD', 71, 74, 70, 70, 45, 72, 70, 73, 2, 50, 'Uruguai', 0, 50, 0, 9831000, 3720000, 30, 14, 85, 62),
(416, 'Eduardo Santos', 28, 'ZAG', 68, 60, 75, 68, 30, 74, 62, 68, 0, 50, 'Brasil', 1, 50, 0, 5268000, 1910000, 24, 14, 50, 74),
(417, 'Alix Vinicius', 26, 'ZAG', 70, 62, 77, 70, 32, 75, 64, 71, 2, 50, 'Brasil', 0, 50, 0, 8505000, 3550000, 48, 14, 50, 74),
(418, 'Vanderlan', 23, 'LE', 67, 73, 66, 64, 38, 65, 66, 74, 0, 50, 'Brasil', 1, 50, 0, 7174000, 3790000, 18, 14, 15, 62),
(419, 'Pedro Henrique', 30, 'ZAG', 70, 58, 78, 72, 28, 76, 62, 70, 1, 50, 'Brasil', 0, 50, 0, 6480000, 3100000, 18, 14, 50, 74),
(420, 'Gustavo Marques', 24, 'ZAG', 71, 64, 76, 71, 35, 74, 68, 76, 2, 50, 'Brasil', 0, 50, 0, 11172000, 2860000, 18, 14, 50, 74),
(421, 'Agustín Sant\'Anna', 28, 'LD', 69, 71, 68, 67, 36, 70, 68, 69, 1, 50, 'Uruguai', 0, 50, 0, 5853000, 4210000, 6, 14, 85, 62),
(422, 'Juninho Capixaba', 28, 'LE', 76, 78, 70, 75, 55, 72, 75, 76, 2, 50, 'Brasil', 0, 50, 0, 11197000, 6760000, 12, 14, 15, 62),
(423, 'José Hurtado', 24, 'LD', 71, 75, 70, 69, 40, 71, 69, 75, 1, 50, 'Venezuela', 0, 50, 0, 10725000, 2890000, 60, 14, 85, 62),
(424, 'Fabinho', 24, 'VOL', 68, 66, 72, 70, 45, 72, 68, 72, 0, 50, 'Brasil', 1, 50, 0, 8342000, 3930000, 30, 14, 50, 58),
(425, 'Gabriel', 33, 'MC', 73, 58, 62, 80, 62, 55, 78, 73, 2, 50, 'Brasil', 0, 50, 0, 6588000, 1780000, 48, 14, 50, 48),
(426, 'Ramires', 25, 'MC', 66, 68, 62, 64, 50, 55, 66, 70, 0, 50, 'Brasil', 1, 50, 0, 7030000, 3450000, 12, 14, 50, 48),
(427, 'Ignacio Sosa', 22, 'VOL', 70, 66, 70, 72, 40, 70, 70, 80, 2, 50, 'Argentina', 0, 50, 0, 11542000, 3950000, 6, 14, 50, 58),
(428, 'Rodriguinho', 22, 'MC', 69, 67, 63, 70, 58, 50, 72, 79, 1, 50, 'Brasil', 0, 50, 0, 10975000, 3080000, 42, 14, 50, 48),
(429, 'Lucas Barbosa', 25, 'PE', 74, 78, 68, 72, 70, 45, 73, 76, 2, 50, 'Brasil', 0, 50, 0, 15853000, 6380000, 60, 14, 20, 25),
(430, 'Gustavinho', 22, 'PE', 70, 80, 62, 68, 62, 42, 68, 80, 1, 50, 'Brasil', 0, 50, 0, 13365000, 3850000, 6, 14, 20, 25),
(431, 'Bruno Conceição', 24, 'VOL', 64, 64, 68, 63, 40, 66, 62, 70, 0, 50, 'Brasil', 1, 50, 0, 5691000, 2020000, 18, 14, 50, 58),
(432, 'Davi Gomes', 21, 'MC', 62, 64, 58, 60, 48, 48, 64, 76, 0, 50, 'Brasil', 1, 50, 0, 5111000, 2500000, 6, 14, 50, 48),
(433, 'Matheus Fernandes', 27, 'VOL', 72, 62, 73, 76, 42, 74, 72, 72, 2, 50, 'Brasil', 0, 50, 0, 10377000, 2550000, 24, 14, 50, 58),
(434, 'Marcelinho Braz', 21, 'PE', 64, 72, 58, 58, 56, 38, 62, 76, 0, 50, 'Brasil', 1, 50, 0, 7299000, 3160000, 24, 14, 20, 25),
(435, 'Eduardo Sasha', 34, 'ATA', 71, 62, 70, 72, 74, 30, 62, 71, 1, 50, 'Brasil', 0, 50, 0, 3997000, 1310000, 60, 14, 50, 12),
(436, 'Isidro Pitta', 26, 'ATA', 76, 76, 72, 74, 78, 32, 64, 79, 2, 50, 'Paraguai', 0, 50, 0, 20568000, 6650000, 24, 14, 50, 12),
(437, 'Fernando', 27, 'ATA', 66, 70, 62, 62, 66, 28, 58, 68, 0, 50, 'Brasil', 1, 50, 0, 7411000, 2300000, 30, 14, 50, 12),
(438, 'Vinicinho', 22, 'PE', 63, 75, 58, 58, 58, 32, 58, 74, 0, 50, 'Brasil', 1, 50, 0, 6223000, 1880000, 12, 14, 20, 25),
(439, 'Henry Mosquera', 24, 'PD', 72, 78, 62, 70, 64, 35, 70, 75, 2, 50, 'Equador', 0, 50, 0, 13817000, 4260000, 48, 14, 80, 25),
(440, 'José Herrera', 23, 'PD', 69, 76, 58, 66, 62, 32, 66, 78, 0, 50, 'Colômbia', 1, 50, 0, 11670000, 3680000, 48, 14, 80, 25),
(441, 'Bruno Gonçalves', 23, 'ATA', 61, 72, 56, 56, 62, 25, 54, 73, 0, 50, 'Brasil', 1, 50, 0, 5112000, 2090000, 36, 14, 50, 12),
(442, 'Mycael', 22, 'GOL', 70, 48, 74, 72, 10, 66, 64, 78, 2, 50, 'Brasil', 0, 50, 0, 9072000, 3890000, 48, 15, 50, 90),
(443, 'Aderbar', 36, 'GOL', 66, 40, 70, 74, 10, 62, 62, 66, 1, 50, 'Brasil', 0, 50, 0, 1640000, 480000, 42, 15, 50, 90),
(444, 'Matheus Soares Rocha', 21, 'GOL', 58, 46, 68, 55, 8, 52, 52, 72, 0, 50, 'Brasil', 1, 50, 0, 2239000, 1830000, 30, 15, 50, 90),
(445, 'Lucas Esquivel', 24, 'LE', 68, 74, 68, 66, 42, 68, 66, 72, 2, 50, 'Brasil', 0, 50, 0, 7903000, 3620000, 6, 15, 15, 62),
(446, 'Gastón Benavídez', 30, 'LD', 70, 68, 72, 74, 40, 74, 66, 70, 2, 50, 'Brasil', 0, 50, 0, 6480000, 2980000, 12, 15, 85, 62),
(447, 'Gilberto Junior', 21, 'LD', 64, 72, 60, 58, 32, 60, 60, 76, 1, 50, 'Brasil', 0, 50, 0, 5972000, 1760000, 18, 15, 85, 62),
(448, 'Leonardo Pinheiro da Conceição', 30, 'LE', 65, 66, 68, 66, 35, 68, 63, 65, 1, 50, 'Brasil', 0, 50, 0, 3750000, 1740000, 30, 15, 15, 62),
(449, 'Arthur Dias', 19, 'ZAG', 60, 60, 70, 55, 22, 62, 52, 78, 0, 50, 'Brasil', 1, 50, 0, 2880000, 1320000, 42, 15, 50, 74),
(450, 'Carlos Teran', 25, 'ZAG', 66, 58, 74, 64, 28, 71, 58, 69, 2, 50, 'Equador', 0, 50, 0, 6064000, 2140000, 24, 15, 50, 74),
(451, 'Juan Aguirre', 29, 'ZAG', 68, 56, 76, 68, 26, 73, 60, 68, 2, 50, 'Uruguai', 0, 50, 0, 5268000, 2100000, 30, 15, 50, 74),
(452, 'Luis Eduardo Marques dos Santos', 29, 'ZAG', 62, 54, 70, 62, 24, 67, 56, 62, 0, 50, 'Brasil', 1, 50, 0, 2556000, 2030000, 36, 15, 50, 74),
(453, 'Leonardo Derik', 20, 'ZAG', 58, 58, 66, 54, 20, 60, 50, 74, 0, 50, 'Brasil', 1, 50, 0, 2100000, 1570000, 36, 15, 50, 74),
(454, 'Claudinho', 20, 'LE', 56, 64, 58, 52, 28, 56, 54, 72, 0, 50, 'Brasil', 1, 50, 0, 1475000, 1080000, 48, 15, 15, 62),
(455, 'Juan Portilla', 27, 'VOL', 70, 64, 72, 74, 42, 71, 70, 70, 2, 50, 'Colômbia', 0, 50, 0, 8550000, 2440000, 30, 15, 50, 58),
(456, 'Luiz Gustavo', 38, 'VOL', 70, 48, 70, 84, 38, 72, 74, 70, 2, 50, 'Brasil', 0, 50, 0, 1710000, 1160000, 54, 15, 50, 58),
(457, 'Antonio Feliphe Costa Silva', 24, 'VOL', 63, 62, 68, 63, 38, 65, 62, 68, 1, 50, 'Brasil', 0, 50, 0, 4816000, 2350000, 12, 15, 50, 58),
(458, 'Bruno Zapelli', 24, 'MC', 71, 68, 63, 72, 58, 48, 73, 76, 2, 50, 'Brasil', 0, 50, 0, 12413000, 2690000, 36, 15, 50, 48),
(459, 'Jadson', 32, 'MC', 68, 58, 60, 74, 54, 45, 72, 68, 1, 50, 'Brasil', 0, 50, 0, 4025000, 2130000, 48, 15, 50, 48),
(460, 'Alejandro García', 25, 'MC', 65, 66, 62, 66, 48, 50, 66, 71, 1, 50, 'Argentina', 0, 50, 0, 6771000, 2810000, 30, 15, 50, 48),
(461, 'Eduardo Kogitzki', 20, 'MC', 60, 64, 58, 58, 44, 44, 62, 76, 0, 50, 'Brasil', 1, 50, 0, 3200000, 1120000, 54, 15, 50, 48),
(462, 'Chiqueti', 20, 'MC', 58, 66, 56, 55, 42, 42, 60, 75, 0, 50, 'Brasil', 1, 50, 0, 2333000, 1050000, 12, 15, 50, 48),
(463, 'João Cruz', 20, 'MC', 57, 63, 55, 54, 40, 42, 58, 74, 0, 50, 'Brasil', 1, 50, 0, 1965000, 1500000, 60, 15, 50, 48),
(464, 'Kevin Viveros', 26, 'ATA', 75, 76, 70, 72, 78, 28, 64, 78, 2, 50, 'Colômbia', 0, 50, 0, 18901000, 5400000, 6, 15, 50, 12),
(465, 'Stiven Mendoza', 34, 'PD', 72, 74, 64, 72, 66, 30, 68, 72, 2, 50, 'Colômbia', 0, 50, 0, 4205000, 1890000, 42, 15, 80, 25),
(466, 'Julimar', 25, 'ATA', 68, 70, 66, 64, 68, 26, 58, 72, 1, 50, 'Brasil', 0, 50, 0, 10098000, 3950000, 42, 15, 50, 12),
(467, 'Isaac', 22, 'PE', 61, 76, 56, 58, 58, 28, 56, 72, 2, 50, 'Brasil', 0, 50, 0, 4737000, 2550000, 6, 15, 20, 25),
(468, 'Leonardo Caetano Silva', 27, 'ATA', 60, 68, 58, 58, 60, 24, 52, 60, 0, 50, 'Brasil', 1, 50, 0, 3067000, 1250000, 6, 15, 50, 12),
(469, 'Renan Peixoto', 26, 'ATA', 62, 68, 66, 58, 62, 26, 54, 63, 0, 50, 'Brasil', 1, 50, 0, 4286000, 1460000, 18, 15, 50, 12),
(470, 'Renan Viana', 23, 'ATA', 58, 70, 60, 54, 58, 22, 50, 68, 0, 50, 'Brasil', 1, 50, 0, 3018000, 1400000, 12, 15, 50, 12),
(471, 'Bruno Braga Ramos', 17, 'ATA', 52, 68, 54, 48, 52, 20, 46, 80, 0, 50, 'Brasil', 1, 50, 0, 795000, 1030000, 54, 15, 50, 12),
(472, 'Lucas Arcanjo', 30, 'GOL', 73, 48, 74, 75, 10, 68, 68, 73, 2, 50, 'Brasil', 0, 50, 0, 7667000, 2640000, 6, 16, 50, 90),
(473, 'Gabriel Vasconcelos', 23, 'GOL', 60, 50, 64, 56, 8, 54, 54, 70, 0, 50, 'Brasil', 1, 50, 0, 2880000, 1450000, 18, 16, 50, 90),
(474, 'Fintelman', 22, 'GOL', 58, 48, 64, 54, 8, 52, 52, 68, 0, 50, 'Brasil', 1, 50, 0, 2100000, 1470000, 30, 16, 50, 90),
(475, 'Yuri Sena', 20, 'GOL', 55, 50, 60, 50, 8, 48, 50, 70, 0, 50, 'Brasil', 1, 50, 0, 1080000, 1230000, 60, 16, 50, 90),
(476, 'Ramon', 25, 'LE', 71, 73, 68, 68, 42, 70, 68, 73, 2, 50, 'Brasil', 0, 50, 0, 9831000, 3070000, 18, 16, 15, 62),
(477, 'Jamerson', 26, 'LE', 66, 70, 66, 64, 36, 68, 64, 66, 1, 50, 'Brasil', 0, 50, 0, 5273000, 2370000, 48, 16, 15, 62),
(478, 'Fabiano', 29, 'LD', 68, 70, 68, 66, 38, 69, 64, 68, 2, 50, 'Brasil', 0, 50, 0, 5268000, 3850000, 24, 16, 85, 62),
(479, 'Mateus Silva', 24, 'LD', 60, 68, 62, 58, 32, 62, 58, 68, 0, 50, 'Brasil', 1, 50, 0, 3360000, 2340000, 24, 16, 85, 62),
(480, 'Nathan Mendes', 26, 'LE', 63, 68, 64, 60, 32, 64, 60, 63, 1, 50, 'Brasil', 0, 50, 0, 3650000, 2100000, 6, 16, 15, 62),
(481, 'Emanuel Brítez', 27, 'ZAG', 69, 58, 76, 68, 26, 73, 60, 70, 2, 50, 'Brasil', 0, 50, 0, 7683000, 3220000, 24, 16, 50, 74),
(482, 'Camutanga', 26, 'ZAG', 66, 56, 74, 64, 22, 71, 56, 66, 2, 50, 'Brasil', 0, 50, 0, 5273000, 2670000, 30, 16, 50, 74),
(483, 'Kauan Coutinho', 20, 'ZAG', 57, 58, 66, 52, 20, 60, 50, 74, 0, 50, 'Brasil', 1, 50, 0, 1769000, 1160000, 36, 16, 50, 74),
(484, 'Cacá', 25, 'ZAG', 63, 56, 72, 60, 22, 68, 54, 65, 1, 50, 'Brasil', 0, 50, 0, 4015000, 2550000, 42, 16, 50, 74),
(485, 'Edenilson', 24, 'ZAG', 61, 54, 70, 58, 20, 66, 53, 64, 0, 50, 'Brasil', 1, 50, 0, 3195000, 2420000, 54, 16, 50, 74),
(486, 'Luan Cândido', 24, 'ZAG', 64, 58, 72, 62, 24, 69, 56, 68, 1, 50, 'Brasil', 0, 50, 0, 4977000, 3390000, 48, 16, 50, 74),
(487, 'Emmanuel Martínez', 31, 'VOL', 67, 54, 68, 74, 36, 66, 68, 67, 1, 50, 'Argentina', 0, 50, 0, 3428000, 2290000, 36, 16, 50, 58),
(488, 'Walace', 30, 'VOL', 71, 56, 76, 76, 32, 74, 70, 71, 2, 50, 'Brasil', 0, 50, 0, 7547000, 1970000, 30, 16, 50, 58),
(489, 'Ruben Ismael', 27, 'VOL', 62, 58, 64, 62, 32, 62, 60, 64, 1, 50, 'Brasil', 0, 50, 0, 3709000, 2280000, 12, 16, 50, 58),
(490, 'Dudu', 26, 'VOL', 60, 56, 62, 60, 30, 60, 58, 62, 0, 50, 'Brasil', 1, 50, 0, 2787000, 1320000, 42, 16, 50, 58),
(491, 'Gabriel Baralhas', 28, 'VOL', 69, 58, 70, 72, 38, 70, 66, 70, 2, 50, 'Brasil', 0, 50, 0, 6487000, 2690000, 54, 16, 50, 58),
(492, 'Zé Breno', 20, 'VOL', 56, 60, 60, 53, 28, 56, 54, 72, 0, 50, 'Brasil', 1, 50, 0, 1556000, 1050000, 42, 16, 50, 58),
(493, 'Zé Vitor', 20, 'VOL', 55, 58, 58, 52, 26, 55, 52, 71, 0, 50, 'Brasil', 1, 50, 0, 1282000, 1010000, 36, 16, 50, 58),
(494, 'Caíque Gonçalves', 20, 'VOL', 55, 58, 60, 52, 26, 56, 52, 71, 0, 50, 'Brasil', 1, 50, 0, 1282000, 870000, 18, 16, 50, 58),
(495, 'Tomás Pochettino', 30, 'MC', 71, 64, 62, 74, 58, 48, 72, 71, 2, 50, 'Brasil', 0, 50, 0, 7944000, 2510000, 42, 16, 50, 48),
(496, 'Matheuzinho', 23, 'MC', 60, 66, 58, 60, 48, 42, 62, 72, 0, 50, 'Brasil', 1, 50, 0, 3840000, 2060000, 18, 16, 50, 48),
(497, 'Aitor Cantalapiedra', 26, 'MC', 62, 62, 60, 62, 50, 44, 64, 64, 0, 50, 'Espanha', 1, 50, 0, 3904000, 1830000, 60, 16, 50, 48),
(498, 'Marinho', 35, 'PD', 72, 68, 60, 72, 66, 32, 68, 72, 2, 50, 'Brasil', 0, 50, 0, 4205000, 1180000, 36, 16, 80, 25),
(499, 'Osvaldo', 29, 'ATA', 62, 64, 64, 58, 62, 26, 54, 62, 0, 50, 'Brasil', 1, 50, 0, 3265000, 2130000, 18, 16, 50, 12),
(500, 'Diego Tarzia', 26, 'PE', 64, 70, 58, 60, 58, 28, 58, 65, 2, 50, 'Argentina', 0, 50, 0, 5322000, 1920000, 42, 16, 20, 25),
(501, 'Lucas Silva', 24, 'ATA', 58, 66, 58, 54, 56, 24, 50, 64, 0, 50, 'Brasil', 1, 50, 0, 2906000, 1470000, 12, 16, 50, 12),
(502, 'Fabri', 21, 'PE', 57, 72, 54, 52, 54, 24, 52, 74, 0, 50, 'Brasil', 1, 50, 0, 2594000, 1410000, 60, 16, 20, 25),
(503, 'Anderson Pato', 24, 'ATA', 58, 66, 58, 54, 56, 24, 50, 63, 0, 50, 'Brasil', 1, 50, 0, 2794000, 1330000, 60, 16, 50, 12),
(504, 'Erick', 22, 'PE', 63, 74, 58, 58, 60, 26, 56, 76, 1, 50, 'Brasil', 0, 50, 0, 6424000, 2840000, 6, 16, 20, 25),
(505, 'Renato Kayzer', 29, 'ATA', 68, 64, 72, 64, 70, 26, 56, 68, 2, 50, 'Brasil', 0, 50, 0, 6732000, 1920000, 24, 16, 50, 12),
(506, 'Renê', 25, 'ATA', 58, 66, 60, 54, 56, 24, 50, 62, 0, 50, 'Brasil', 1, 50, 0, 2683000, 1390000, 24, 16, 50, 12),
(507, 'Pedro Rangel', 24, 'GOL', 71, 50, 74, 72, 10, 68, 66, 74, 2, 50, 'Brasil', 0, 50, 0, 9136000, 3110000, 54, 17, 50, 90),
(508, 'Gabriel Leite', 29, 'GOL', 68, 46, 72, 70, 10, 64, 64, 68, 1, 50, 'Brasil', 0, 50, 0, 4683000, 2040000, 12, 17, 50, 90),
(509, 'Keiller', 35, 'GOL', 66, 42, 70, 74, 10, 62, 62, 66, 1, 50, 'Brasil', 0, 50, 0, 1640000, 940000, 48, 17, 50, 90),
(510, 'Pedro Morisco', 20, 'GOL', 58, 48, 64, 54, 8, 52, 52, 72, 0, 50, 'Brasil', 1, 50, 0, 1866000, 1460000, 42, 17, 50, 90),
(511, 'Benassi', 19, 'GOL', 55, 46, 60, 50, 8, 48, 50, 70, 0, 50, 'Brasil', 1, 50, 0, 1080000, 1390000, 42, 17, 50, 90),
(512, 'Tinga', 34, 'LD', 68, 60, 66, 74, 32, 70, 66, 68, 2, 50, 'Brasil', 0, 50, 0, 2305000, 1570000, 36, 17, 85, 62),
(513, 'Maicon', 38, 'ZAG', 66, 44, 72, 80, 20, 72, 60, 66, 2, 50, 'Brasil', 0, 50, 0, 1055000, 750000, 36, 17, 50, 74),
(514, 'Rodrigo Moledo', 30, 'ZAG', 69, 54, 76, 70, 24, 73, 58, 69, 2, 50, 'Brasil', 0, 50, 0, 5853000, 1670000, 36, 17, 50, 74),
(515, 'Felipe Jonatan', 26, 'LE', 68, 72, 66, 66, 36, 68, 64, 70, 2, 50, 'Brasil', 0, 50, 0, 7244000, 3980000, 54, 17, 15, 62),
(516, 'Bruno Melo', 25, 'ZAG', 66, 62, 68, 64, 30, 68, 62, 68, 1, 50, 'Brasil', 0, 50, 0, 5800000, 2920000, 24, 17, 50, 74),
(517, 'João Almeida', 20, 'ZAG', 57, 58, 64, 52, 20, 60, 50, 73, 0, 50, 'Brasil', 1, 50, 0, 1769000, 1010000, 54, 17, 50, 74),
(518, 'Tiago Cóser', 22, 'ZAG', 59, 56, 66, 55, 22, 62, 52, 71, 0, 50, 'Brasil', 1, 50, 0, 2963000, 1830000, 48, 17, 50, 74),
(519, 'João Pedro Chermont', 20, 'ZAG', 58, 56, 64, 54, 20, 61, 51, 73, 0, 50, 'Brasil', 1, 50, 0, 2100000, 1710000, 48, 17, 50, 74),
(520, 'Jacy', 21, 'ZAG', 58, 58, 64, 54, 22, 60, 52, 70, 0, 50, 'Brasil', 1, 50, 0, 2519000, 1920000, 42, 17, 50, 74),
(521, 'Lucas Taverna', 19, 'ZAG', 55, 56, 62, 50, 18, 58, 48, 71, 0, 50, 'Brasil', 1, 50, 0, 1215000, 1090000, 24, 17, 50, 74),
(522, 'Josué', 32, 'MC', 73, 60, 60, 78, 54, 42, 74, 73, 2, 50, 'Brasil', 0, 50, 0, 6588000, 2730000, 30, 17, 50, 48),
(523, 'Sebastián Gómez', 29, 'MC', 71, 62, 60, 74, 50, 40, 72, 71, 2, 50, 'Uruguai', 0, 50, 0, 7944000, 2830000, 36, 17, 50, 48),
(524, 'Brian Ocampo', 29, 'MC', 68, 64, 58, 68, 52, 38, 68, 68, 2, 50, 'Uruguai', 0, 50, 0, 5854000, 2120000, 6, 17, 50, 48),
(525, 'Willian Oliveira', 32, 'VOL', 67, 54, 68, 72, 34, 70, 64, 67, 1, 50, 'Brasil', 0, 50, 0, 3428000, 2570000, 30, 17, 50, 58),
(526, 'Wallisson', 25, 'VOL', 64, 58, 66, 64, 34, 66, 60, 68, 1, 50, 'Brasil', 0, 50, 0, 5253000, 2930000, 18, 17, 50, 58),
(527, 'Gustavo', 35, 'MC', 64, 50, 60, 72, 42, 48, 64, 64, 0, 50, 'Brasil', 1, 50, 0, 1613000, 1210000, 24, 17, 50, 48),
(528, 'Vini Paulista', 23, 'MC', 60, 64, 58, 58, 44, 42, 60, 72, 0, 50, 'Brasil', 1, 50, 0, 3840000, 1420000, 12, 17, 50, 48),
(529, 'Thiago Santos', 25, 'MC', 60, 60, 60, 60, 42, 50, 60, 64, 0, 50, 'Brasil', 1, 50, 0, 3200000, 2120000, 24, 17, 50, 48),
(530, 'Alejandro Ararat', 22, 'MC', 58, 62, 56, 58, 42, 42, 58, 72, 0, 50, 'Colômbia', 1, 50, 0, 2799000, 1530000, 54, 17, 50, 48),
(531, 'Fernando Sobral', 24, 'MC', 58, 60, 58, 58, 40, 44, 58, 64, 0, 50, 'Brasil', 1, 50, 0, 2527000, 1900000, 24, 17, 50, 48),
(532, 'Geovane Meurer', 22, 'VOL', 57, 56, 62, 56, 30, 60, 54, 70, 0, 50, 'Brasil', 1, 50, 0, 2240000, 1740000, 36, 17, 50, 58),
(533, 'Miguel Silva', 19, 'MC', 54, 58, 54, 50, 36, 40, 54, 71, 0, 50, 'Brasil', 1, 50, 0, 1098000, 1320000, 12, 17, 50, 48),
(534, 'Tissi', 19, 'MC', 53, 58, 52, 50, 36, 40, 53, 71, 0, 50, 'Brasil', 1, 50, 0, 879000, 890000, 6, 17, 50, 48),
(535, 'Thiago Azaf', 19, 'MC', 53, 58, 52, 50, 34, 38, 52, 70, 0, 50, 'Brasil', 1, 50, 0, 879000, 870000, 6, 17, 50, 48),
(536, 'Breno Lopes', 29, 'ATA', 73, 72, 64, 70, 74, 26, 60, 73, 2, 50, 'Brasil', 0, 50, 0, 11021000, 2930000, 6, 17, 50, 12),
(537, 'Pedro Rocha', 33, 'ATA', 68, 60, 64, 68, 68, 24, 58, 68, 1, 50, 'Brasil', 0, 50, 0, 4628000, 1210000, 18, 17, 50, 12),
(538, 'Joaquín Lavega', 25, 'ATA', 68, 72, 62, 64, 68, 24, 56, 71, 1, 50, 'Brasil', 0, 50, 0, 9677000, 2250000, 60, 17, 50, 12),
(539, 'Lucas Ronier', 24, 'PD', 66, 74, 58, 62, 60, 26, 58, 70, 2, 50, 'Brasil', 0, 50, 0, 7733000, 2010000, 18, 17, 80, 25),
(540, 'Keno', 35, 'PE', 65, 68, 56, 66, 58, 24, 58, 65, 2, 50, 'Brasil', 0, 50, 0, 2005000, 1470000, 48, 17, 20, 25),
(541, 'Renato Marques', 27, 'ATA', 62, 66, 62, 58, 60, 24, 52, 62, 0, 50, 'Brasil', 1, 50, 0, 4082000, 1870000, 42, 17, 50, 12),
(542, 'Fabinho', 22, 'ATA', 57, 68, 56, 52, 54, 22, 48, 70, 0, 50, 'Brasil', 1, 50, 0, 2712000, 1910000, 36, 17, 50, 12),
(543, 'Enzo Vágner', 19, 'ATA', 55, 68, 54, 50, 52, 20, 46, 74, 0, 50, 'Brasil', 1, 50, 0, 1552000, 1320000, 24, 17, 50, 12),
(544, 'Éberth', 20, 'ATA', 56, 68, 54, 50, 52, 20, 46, 73, 0, 50, 'Brasil', 1, 50, 0, 1884000, 1040000, 42, 17, 50, 12),
(545, 'David Alves', 19, 'ATA', 54, 66, 52, 48, 50, 20, 44, 71, 0, 50, 'Brasil', 1, 50, 0, 1262000, 760000, 48, 17, 50, 12),
(546, 'Matheus Dias', 20, 'ATA', 55, 66, 54, 50, 52, 20, 46, 71, 0, 50, 'Brasil', 1, 50, 0, 1552000, 1130000, 6, 17, 50, 12),
(547, 'Rodrigo Rodrigues', 21, 'ATA', 56, 66, 54, 50, 52, 20, 46, 70, 0, 50, 'Brasil', 1, 50, 0, 2261000, 1070000, 48, 17, 50, 12),
(548, 'Matheus', 24, 'GOL', 63, 48, 68, 60, 10, 58, 56, 66, 2, 50, 'Brasil', 0, 50, 0, 3731000, 2030000, 48, 18, 50, 90),
(549, 'Wellington', 22, 'GOL', 58, 46, 64, 54, 8, 52, 52, 68, 1, 50, 'Brasil', 0, 50, 0, 2100000, 1190000, 30, 18, 50, 90),
(550, 'Rafael Santos', 32, 'GOL', 60, 44, 66, 62, 10, 56, 54, 60, 1, 50, 'Brasil', 0, 50, 0, 1173000, 1070000, 42, 18, 50, 90),
(551, 'Kainã', 20, 'GOL', 54, 48, 60, 50, 8, 48, 48, 68, 0, 50, 'Brasil', 1, 50, 0, 878000, 1240000, 30, 18, 50, 90),
(552, 'Anderson', 28, 'GOL', 59, 46, 66, 58, 10, 54, 52, 59, 1, 50, 'Brasil', 0, 50, 0, 1463000, 910000, 54, 18, 50, 90),
(553, 'Da Silva', 23, 'ZAG', 56, 54, 66, 52, 20, 60, 48, 64, 0, 50, 'Brasil', 1, 50, 0, 1548000, 1490000, 54, 18, 50, 74),
(554, 'Eduardo', 22, 'ZAG', 55, 52, 64, 52, 18, 58, 48, 64, 0, 50, 'Brasil', 1, 50, 0, 1321000, 1680000, 42, 18, 50, 74),
(555, 'Iago', 21, 'LD', 54, 60, 58, 50, 26, 56, 50, 66, 0, 50, 'Brasil', 1, 50, 0, 1185000, 1040000, 36, 18, 85, 62),
(556, 'Ígor Rampazzo', 20, 'ZAG', 53, 54, 62, 50, 18, 56, 46, 68, 0, 50, 'Brasil', 1, 50, 0, 791000, 1080000, 54, 18, 50, 74),
(557, 'Márcio Kalebe', 21, 'LD', 54, 62, 58, 50, 26, 55, 50, 66, 0, 50, 'Brasil', 1, 50, 0, 1185000, 1310000, 54, 18, 85, 62),
(558, 'Yago', 22, 'LE', 54, 60, 58, 50, 26, 54, 50, 64, 0, 50, 'Brasil', 1, 50, 0, 1111000, 1100000, 42, 18, 15, 62),
(559, 'Marcos Vinícius', 32, 'ZAG', 60, 50, 68, 64, 20, 64, 52, 60, 2, 50, 'Brasil', 0, 50, 0, 1320000, 1530000, 6, 18, 50, 74),
(560, 'Doma', 26, 'ZAG', 57, 54, 66, 56, 20, 60, 50, 58, 0, 50, 'Brasil', 1, 50, 0, 1548000, 1710000, 12, 18, 50, 74),
(561, 'João Paulo', 27, 'ZAG', 58, 52, 66, 58, 20, 61, 50, 58, 1, 50, 'Brasil', 0, 50, 0, 1750000, 1580000, 18, 18, 50, 74),
(562, 'Mancha', 25, 'ZAG', 56, 52, 64, 55, 18, 58, 48, 58, 0, 50, 'Brasil', 1, 50, 0, 1352000, 1330000, 30, 18, 50, 74),
(563, 'Felipe', 23, 'LE', 54, 60, 58, 50, 26, 55, 50, 64, 0, 50, 'Brasil', 1, 50, 0, 1111000, 980000, 54, 18, 15, 62),
(564, 'Rafael Thyere', 37, 'ZAG', 60, 42, 68, 68, 18, 66, 50, 60, 2, 50, 'Brasil', 0, 50, 0, 480000, 370000, 12, 18, 50, 74),
(565, 'Gustavo Talles', 21, 'ZAG', 54, 54, 62, 50, 18, 56, 46, 66, 0, 50, 'Brasil', 1, 50, 0, 1185000, 1030000, 24, 18, 50, 74),
(566, 'Kauan Faria', 20, 'LD', 53, 60, 58, 48, 24, 54, 48, 66, 0, 50, 'Brasil', 1, 50, 0, 791000, 740000, 36, 18, 85, 62),
(567, 'Victor Caetano', 26, 'LD', 58, 64, 60, 58, 28, 60, 54, 58, 2, 50, 'Brasil', 0, 50, 0, 1750000, 1790000, 6, 18, 85, 62),
(568, 'Bruno Leonardo', 24, 'LE', 55, 60, 58, 52, 26, 56, 50, 60, 0, 50, 'Brasil', 1, 50, 0, 1266000, 1350000, 48, 18, 15, 62),
(569, 'Vinicius', 20, 'ZAG', 52, 54, 60, 48, 18, 54, 44, 66, 0, 50, 'Brasil', 1, 50, 0, 622000, 810000, 30, 18, 50, 74),
(570, 'Bruno Pacheco', 29, 'LE', 61, 64, 60, 62, 32, 62, 58, 61, 2, 50, 'Brasil', 0, 50, 0, 2223000, 1450000, 6, 18, 15, 62),
(571, 'Bernardo', 20, 'MC', 53, 58, 52, 50, 36, 40, 54, 66, 0, 50, 'Brasil', 1, 50, 0, 879000, 1310000, 24, 18, 50, 48),
(572, 'Kauan Godoy', 19, 'MC', 52, 58, 52, 48, 34, 38, 52, 68, 0, 50, 'Brasil', 1, 50, 0, 691000, 710000, 18, 18, 50, 48),
(573, 'Kauê Arno', 20, 'MC', 52, 58, 52, 48, 34, 38, 52, 67, 0, 50, 'Brasil', 1, 50, 0, 691000, 920000, 12, 18, 50, 48),
(574, 'Miguel', 19, 'MC', 51, 56, 50, 46, 32, 38, 50, 67, 0, 50, 'Brasil', 1, 50, 0, 532000, 800000, 48, 18, 50, 48),
(575, 'João Vitor', 25, 'VOL', 57, 58, 62, 58, 32, 60, 54, 58, 0, 50, 'Brasil', 1, 50, 0, 1634000, 1270000, 36, 18, 50, 58),
(576, 'Robert', 26, 'VOL', 56, 56, 62, 56, 30, 60, 52, 57, 0, 50, 'Brasil', 1, 50, 0, 1362000, 1470000, 48, 18, 50, 58),
(577, 'Giovanni Augusto', 36, 'MC', 62, 46, 54, 72, 48, 36, 66, 62, 2, 50, 'Brasil', 0, 50, 0, 1242000, 590000, 30, 18, 50, 48),
(578, 'Bruno Matias', 24, 'MC', 55, 58, 54, 54, 38, 40, 55, 60, 0, 50, 'Brasil', 1, 50, 0, 1406000, 1760000, 54, 18, 50, 48),
(579, 'Vinícius Balieiro', 25, 'MC', 55, 58, 54, 54, 38, 40, 55, 58, 0, 50, 'Brasil', 1, 50, 0, 1294000, 1050000, 48, 18, 50, 48),
(580, 'David', 22, 'MC', 53, 58, 52, 50, 36, 38, 53, 64, 0, 50, 'Brasil', 1, 50, 0, 1022000, 1170000, 54, 18, 50, 48),
(581, 'Jean Carlos', 27, 'MC', 61, 62, 56, 62, 44, 42, 62, 63, 1, 50, 'Brasil', 0, 50, 0, 3396000, 2380000, 54, 18, 50, 48),
(582, 'Higor Meritão', 29, 'VOL', 56, 54, 62, 56, 30, 60, 52, 56, 0, 50, 'Brasil', 1, 50, 0, 1038000, 810000, 30, 18, 50, 58),
(583, 'Everton', 25, 'PE', 58, 68, 54, 56, 44, 32, 54, 60, 1, 50, 'Brasil', 0, 50, 0, 2352000, 1710000, 36, 18, 20, 25),
(584, 'Camilo', 27, 'MC', 63, 62, 56, 66, 46, 42, 63, 64, 2, 50, 'Brasil', 0, 50, 0, 4258000, 1940000, 54, 18, 50, 48),
(585, 'Walter Clar', 29, 'MC', 63, 60, 58, 64, 50, 38, 64, 63, 2, 50, 'Brasil', 0, 50, 0, 3245000, 2770000, 48, 18, 50, 48),
(586, 'Wermeson', 22, 'VOL', 54, 56, 60, 52, 28, 58, 50, 63, 0, 50, 'Brasil', 1, 50, 0, 1134000, 1060000, 12, 18, 50, 58),
(587, 'Rubens', 23, 'VOL', 54, 54, 60, 52, 28, 58, 50, 61, 0, 50, 'Brasil', 1, 50, 0, 1056000, 1280000, 48, 18, 50, 58),
(588, 'Rafael Carvalheira', 20, 'MC', 52, 58, 52, 48, 34, 38, 52, 66, 0, 50, 'Brasil', 1, 50, 0, 691000, 1050000, 24, 18, 50, 48),
(589, 'Alberto', 20, 'ATA', 54, 66, 54, 48, 54, 20, 46, 68, 0, 50, 'Brasil', 1, 50, 0, 1262000, 730000, 48, 18, 50, 12),
(590, 'Gleidson', 20, 'ATA', 53, 68, 52, 48, 52, 20, 44, 68, 0, 50, 'Brasil', 1, 50, 0, 1011000, 1020000, 54, 18, 50, 12),
(591, 'Luizão', 23, 'ATA', 55, 64, 60, 50, 58, 22, 46, 60, 0, 50, 'Brasil', 1, 50, 0, 1455000, 1060000, 48, 18, 50, 12),
(592, 'Matheus Milani', 20, 'ATA', 53, 66, 52, 48, 52, 20, 44, 67, 0, 50, 'Brasil', 1, 50, 0, 1011000, 1290000, 30, 18, 50, 12),
(593, 'Talison', 20, 'PE', 54, 70, 52, 50, 54, 20, 48, 68, 0, 50, 'Brasil', 1, 50, 0, 1207000, 830000, 18, 18, 20, 25),
(594, 'Marcinho', 27, 'PD', 58, 72, 54, 58, 58, 24, 56, 58, 2, 50, 'Brasil', 0, 50, 0, 2138000, 1450000, 48, 18, 80, 25),
(595, 'Yannick Bolasie', 36, 'PE', 64, 68, 66, 64, 60, 26, 58, 64, 2, 50, 'Brasil', 0, 50, 0, 1774000, 650000, 30, 18, 20, 25),
(596, 'Neto Pessoa', 25, 'ATA', 58, 66, 58, 54, 60, 22, 48, 62, 1, 50, 'Brasil', 0, 50, 0, 2683000, 830000, 12, 18, 50, 12),
(597, 'Maurício Garcez', 26, 'ATA', 56, 64, 58, 52, 58, 22, 46, 58, 0, 50, 'Brasil', 1, 50, 0, 1727000, 1080000, 30, 18, 50, 12),
(598, 'João Bom', 21, 'ATA', 55, 68, 56, 50, 56, 20, 46, 66, 0, 50, 'Brasil', 1, 50, 0, 1805000, 1440000, 24, 18, 50, 12),
(599, 'Rodrigo Endrio', 24, 'ATA', 54, 64, 56, 50, 56, 20, 44, 58, 0, 50, 'Brasil', 1, 50, 0, 1262000, 720000, 42, 18, 50, 12),
(600, 'Italo', 22, 'PD', 55, 68, 54, 52, 54, 22, 50, 64, 0, 50, 'Brasil', 1, 50, 0, 1615000, 950000, 48, 18, 80, 25),
(601, 'Kevin Ramírez', 29, 'ATA', 58, 66, 60, 56, 58, 22, 48, 58, 0, 50, 'Brasil', 1, 50, 0, 1788000, 1670000, 12, 18, 50, 12),
(602, 'Ênio', 24, 'ATA', 60, 68, 58, 56, 58, 24, 52, 64, 2, 50, 'Brasil', 0, 50, 0, 3680000, 1330000, 36, 18, 50, 12),
(603, 'Walter', 29, 'GOL', 70, 48, 72, 72, 10, 66, 64, 70, 2, 50, 'Brasil', 0, 50, 0, 5760000, 3300000, 6, 19, 50, 90),
(604, 'Georgemy', 34, 'GOL', 64, 44, 68, 66, 10, 60, 58, 64, 1, 50, 'Brasil', 0, 50, 0, 1290000, 990000, 12, 19, 50, 90),
(605, 'Alex Muralha', 37, 'GOL', 62, 40, 66, 68, 10, 58, 56, 62, 1, 50, 'Brasil', 0, 50, 0, 568000, 350000, 24, 19, 50, 90),
(606, 'Thomazella', 25, 'GOL', 60, 48, 64, 58, 8, 56, 54, 64, 0, 50, 'Brasil', 1, 50, 0, 2560000, 1740000, 60, 19, 50, 90),
(607, 'Willian Machado', 26, 'LD', 71, 72, 66, 68, 38, 70, 68, 73, 2, 50, 'Brasil', 0, 50, 0, 9831000, 3770000, 36, 19, 85, 62),
(608, 'Reinaldo', 34, 'LE', 68, 64, 64, 72, 34, 68, 66, 68, 2, 50, 'Brasil', 0, 50, 0, 2305000, 1090000, 24, 19, 15, 62),
(609, 'Victor Luís', 32, 'LE', 64, 64, 62, 64, 32, 64, 60, 64, 1, 50, 'Brasil', 0, 50, 0, 2281000, 1100000, 24, 19, 15, 62),
(610, 'Lucas Oliveira', 25, 'LD', 60, 64, 60, 58, 30, 62, 56, 64, 0, 50, 'Brasil', 1, 50, 0, 2880000, 1920000, 24, 19, 85, 62),
(611, 'Igor Formiga', 26, 'ZAG', 70, 58, 74, 68, 42, 72, 60, 71, 2, 50, 'Brasil', 0, 50, 0, 8505000, 3580000, 60, 19, 50, 74),
(612, 'João Victor', 29, 'ZAG', 68, 54, 74, 68, 26, 73, 58, 68, 2, 50, 'Brasil', 0, 50, 0, 5268000, 3010000, 42, 19, 50, 74),
(613, 'Daniel Borges', 23, 'LD', 58, 62, 58, 56, 28, 60, 52, 64, 0, 50, 'Brasil', 1, 50, 0, 2047000, 1650000, 48, 19, 85, 62),
(614, 'Elias', 26, 'ZAG', 60, 54, 68, 58, 20, 62, 52, 60, 0, 50, 'Brasil', 1, 50, 0, 2400000, 1890000, 24, 19, 50, 74),
(615, 'Luiz Fernando', 20, 'ZAG', 53, 54, 62, 50, 18, 56, 46, 68, 0, 50, 'Brasil', 1, 50, 0, 791000, 1230000, 42, 19, 50, 74),
(616, 'Gabriel Knesowitsch', 21, 'ZAG', 55, 54, 64, 52, 20, 58, 48, 68, 0, 50, 'Brasil', 1, 50, 0, 1458000, 1300000, 24, 19, 50, 74),
(617, 'Cauã Victor', 19, 'ZAG', 52, 54, 60, 48, 18, 54, 44, 68, 0, 50, 'Brasil', 1, 50, 0, 622000, 950000, 12, 19, 50, 74),
(618, 'Marcelinho', 19, 'LE', 53, 60, 58, 50, 24, 54, 50, 68, 0, 50, 'Brasil', 1, 50, 0, 791000, 1180000, 42, 19, 15, 62),
(619, 'José Aldo', 28, 'VOL', 69, 58, 70, 74, 32, 72, 66, 69, 2, 50, 'Brasil', 0, 50, 0, 6179000, 3800000, 18, 19, 50, 58),
(620, 'Denilson', 30, 'VOL', 68, 56, 68, 72, 32, 70, 66, 68, 2, 50, 'Brasil', 0, 50, 0, 5561000, 1580000, 18, 19, 50, 58),
(621, 'Chico', 28, 'VOL', 62, 54, 64, 62, 30, 64, 58, 62, 1, 50, 'Brasil', 0, 50, 0, 2697000, 1730000, 24, 19, 50, 58),
(622, 'Gabriel Pires', 32, 'MC', 66, 58, 58, 68, 44, 42, 66, 66, 2, 50, 'Brasil', 0, 50, 0, 3222000, 1150000, 36, 19, 50, 48),
(623, 'Shaylon', 29, 'MC', 66, 66, 58, 64, 50, 38, 64, 66, 1, 50, 'Brasil', 0, 50, 0, 4687000, 1850000, 36, 19, 50, 48),
(624, 'Japa', 25, 'MC', 58, 62, 54, 56, 44, 36, 56, 62, 0, 50, 'Brasil', 1, 50, 0, 2333000, 1650000, 30, 19, 50, 48),
(625, 'Eduardo', 30, 'MC', 62, 60, 58, 62, 52, 36, 58, 62, 1, 50, 'Brasil', 0, 50, 0, 2839000, 1350000, 12, 19, 50, 48),
(626, 'Neto Moura', 29, 'MC', 58, 58, 56, 58, 42, 42, 56, 58, 0, 50, 'Brasil', 1, 50, 0, 1555000, 1520000, 42, 19, 50, 48),
(627, 'Giovanni Pacheco', 20, 'MC', 53, 58, 52, 48, 36, 38, 52, 68, 0, 50, 'Brasil', 1, 50, 0, 879000, 1070000, 42, 19, 50, 48),
(628, 'Gustavo Silva', 27, 'MC', 60, 58, 58, 60, 42, 42, 58, 60, 0, 50, 'Brasil', 1, 50, 0, 2667000, 1280000, 6, 19, 50, 48),
(629, 'Negueba', 33, 'PE', 73, 72, 60, 70, 62, 32, 64, 73, 2, 50, 'Brasil', 0, 50, 0, 7247000, 2060000, 36, 19, 20, 25),
(630, 'Alesson', 29, 'PD', 70, 72, 58, 68, 58, 30, 66, 70, 2, 50, 'Brasil', 0, 50, 0, 7920000, 4500000, 30, 19, 80, 25),
(631, 'Edson Carioca', 26, 'ATA', 65, 68, 62, 60, 64, 26, 54, 66, 2, 50, 'Brasil', 0, 50, 0, 6289000, 2450000, 60, 19, 50, 12),
(632, 'Fernandinho', 28, 'ATA', 62, 64, 64, 58, 62, 26, 50, 62, 1, 50, 'Brasil', 0, 50, 0, 3265000, 1870000, 24, 19, 50, 12),
(633, 'Antonio Galeano', 30, 'ATA', 60, 62, 66, 58, 60, 26, 48, 60, 0, 50, 'Paraguai', 1, 50, 0, 2453000, 1580000, 24, 19, 50, 12),
(634, 'Bruno Santos', 24, 'ATA', 58, 66, 58, 54, 58, 24, 48, 64, 0, 50, 'Brasil', 1, 50, 0, 2906000, 1940000, 18, 19, 50, 12),
(635, 'Felipinho', 20, 'ATA', 53, 68, 52, 48, 52, 20, 44, 68, 0, 50, 'Brasil', 1, 50, 0, 1011000, 840000, 48, 19, 50, 12),
(636, 'Carlos Eduardo', 26, 'ATA', 56, 64, 58, 52, 56, 22, 46, 58, 0, 50, 'Brasil', 1, 50, 0, 1727000, 1210000, 42, 19, 50, 12),
(637, 'André Luís', 24, 'ATA', 55, 64, 58, 52, 54, 22, 46, 58, 0, 50, 'Brasil', 1, 50, 0, 1488000, 810000, 18, 19, 50, 12),
(638, 'Marcelo Rangel', 38, 'GOL', 72, 42, 72, 78, 10, 66, 64, 72, 2, 50, 'Brasil', 0, 50, 0, 1748000, 930000, 54, 20, 50, 90),
(639, 'Alexandre', 24, 'GOL', 60, 50, 64, 58, 8, 54, 54, 68, 0, 50, 'Brasil', 1, 50, 0, 2987000, 1780000, 12, 20, 50, 90),
(640, 'João Victor', 22, 'GOL', 56, 48, 62, 54, 8, 50, 50, 68, 0, 50, 'Brasil', 1, 50, 0, 1573000, 1220000, 18, 20, 50, 48),
(641, 'Ygor Vinhas', 29, 'GOL', 58, 44, 64, 58, 8, 52, 52, 58, 0, 50, 'Brasil', 1, 50, 0, 1244000, 1370000, 24, 20, 50, 90),
(642, 'Ivan', 20, 'GOL', 54, 48, 60, 50, 8, 48, 48, 66, 0, 50, 'Brasil', 1, 50, 0, 878000, 1140000, 6, 20, 50, 90),
(643, 'João Lucas', 28, 'LD', 62, 64, 62, 60, 32, 64, 58, 62, 1, 50, 'Brasil', 0, 50, 0, 2556000, 1320000, 12, 20, 85, 62),
(644, 'Marcelinho', 24, 'LD', 63, 68, 60, 62, 32, 64, 60, 66, 2, 50, 'Brasil', 0, 50, 0, 4198000, 2040000, 6, 20, 85, 62),
(645, 'Thalisson', 24, 'LD', 58, 64, 58, 56, 28, 58, 54, 63, 0, 50, 'Brasil', 1, 50, 0, 2187000, 1870000, 36, 20, 85, 62),
(646, 'Zé Ivaldo', 29, 'ZAG', 64, 54, 70, 64, 22, 68, 56, 64, 1, 50, 'Brasil', 0, 50, 0, 3318000, 1650000, 54, 20, 50, 74),
(647, 'Léo Andrade', 33, 'ZAG', 63, 48, 72, 68, 20, 70, 54, 63, 1, 50, 'Brasil', 0, 50, 0, 2008000, 1040000, 36, 20, 50, 74),
(648, 'Marllon', 32, 'ZAG', 65, 52, 74, 70, 24, 72, 58, 65, 2, 50, 'Brasil', 0, 50, 0, 2578000, 1260000, 48, 20, 50, 74),
(649, 'Matheus Alexandre', 25, 'ZAG', 58, 52, 66, 56, 20, 60, 50, 60, 0, 50, 'Brasil', 1, 50, 0, 1925000, 1240000, 12, 20, 50, 74),
(650, 'Kauan', 19, 'ZAG', 52, 54, 60, 48, 18, 54, 44, 68, 0, 50, 'Brasil', 1, 50, 0, 622000, 1030000, 6, 20, 50, 74),
(651, 'Kerlon', 19, 'ZAG', 52, 54, 60, 48, 18, 54, 44, 67, 0, 50, 'Brasil', 1, 50, 0, 622000, 1180000, 54, 20, 50, 74),
(652, 'Rafael', 20, 'ZAG', 53, 54, 62, 50, 18, 56, 46, 68, 0, 50, 'Brasil', 1, 50, 0, 791000, 1010000, 30, 20, 50, 74),
(653, 'Cristian Tassano', 31, 'ZAG', 61, 50, 70, 62, 20, 66, 52, 61, 1, 50, 'Uruguai', 0, 50, 0, 1528000, 1340000, 42, 20, 50, 74),
(654, 'Duplexe Tchamba', 28, 'ZAG', 66, 56, 74, 66, 22, 70, 54, 66, 2, 50, 'Camarões', 0, 50, 0, 4218000, 1920000, 60, 20, 50, 74),
(655, 'Braian Cufré', 34, 'LE', 62, 62, 60, 66, 28, 64, 58, 62, 1, 50, 'Brasil', 0, 50, 0, 1118000, 870000, 60, 20, 15, 62),
(656, 'Mayk', 26, 'LE', 64, 66, 62, 62, 30, 64, 60, 66, 2, 50, 'Brasil', 0, 50, 0, 4562000, 2230000, 12, 20, 15, 62),
(657, 'Patrick', 26, 'VOL', 66, 58, 64, 68, 36, 66, 64, 68, 2, 50, 'Brasil', 0, 50, 0, 6122000, 2130000, 36, 20, 50, 58),
(658, 'Zé Welison', 29, 'VOL', 64, 56, 66, 66, 32, 66, 62, 64, 2, 50, 'Brasil', 0, 50, 0, 3502000, 2850000, 24, 20, 50, 58),
(659, 'Zé Ricardo', 27, 'MC', 62, 58, 58, 62, 42, 44, 62, 62, 1, 50, 'Brasil', 0, 50, 0, 3549000, 2460000, 18, 20, 50, 48),
(660, 'Vitor Bueno', 30, 'MC', 68, 60, 58, 68, 46, 40, 68, 68, 2, 50, 'Brasil', 0, 50, 0, 5854000, 1710000, 54, 20, 50, 48),
(661, 'Edson Fernando', 28, 'MC', 58, 58, 56, 58, 40, 42, 56, 58, 0, 50, 'Brasil', 1, 50, 0, 1555000, 1460000, 36, 20, 50, 48),
(662, 'Jáderson', 24, 'MC', 55, 58, 54, 54, 38, 40, 54, 62, 0, 50, 'Brasil', 1, 50, 0, 1519000, 1050000, 30, 20, 50, 48),
(663, 'Leonel Picco', 28, 'MC', 58, 56, 58, 58, 40, 44, 56, 58, 0, 50, 'Argentina', 1, 50, 0, 1555000, 1700000, 60, 20, 50, 48),
(664, 'Franco Catarozzi', 29, 'MC', 58, 54, 58, 58, 40, 44, 56, 58, 0, 50, 'Argentina', 1, 50, 0, 1555000, 1150000, 12, 20, 50, 48),
(665, 'David Braga', 26, 'MC', 56, 56, 56, 56, 38, 42, 54, 58, 0, 50, 'Brasil', 1, 50, 0, 1502000, 830000, 60, 20, 50, 48),
(666, 'Tico', 19, 'MC', 52, 58, 52, 48, 34, 38, 52, 68, 0, 50, 'Brasil', 1, 50, 0, 691000, 1280000, 18, 20, 50, 90),
(667, 'Miguel', 19, 'MC', 52, 58, 52, 48, 34, 38, 52, 67, 0, 50, 'Brasil', 1, 50, 0, 691000, 1250000, 48, 20, 50, 48),
(668, 'Alef Manga', 28, 'PE', 69, 74, 60, 64, 68, 26, 58, 69, 2, 50, 'Brasil', 0, 50, 0, 7479000, 2950000, 54, 20, 20, 25),
(669, 'Jaja Silva', 24, 'PE', 64, 72, 58, 58, 64, 24, 52, 68, 0, 50, 'Brasil', 0, 50, 0, 6359000, 1650000, 42, 20, 20, 25),
(670, 'Gabriel Taliari', 27, 'ATA', 63, 68, 60, 58, 62, 24, 50, 63, 2, 50, 'Brasil', 0, 50, 0, 4664000, 2190000, 42, 20, 50, 12),
(671, 'Yago Pikachu', 33, 'PD', 65, 68, 58, 66, 58, 28, 60, 65, 2, 50, 'Brasil', 0, 50, 0, 3151000, 1140000, 12, 20, 80, 25),
(672, 'Eduardo Melo', 25, 'ATA', 58, 66, 58, 54, 58, 22, 46, 60, 0, 50, 'Brasil', 1, 50, 0, 2459000, 1770000, 48, 20, 50, 12),
(673, 'Andres Gonzalez', 27, 'ATA', 58, 64, 60, 54, 58, 24, 48, 58, 0, 50, 'Colômbia', 1, 50, 0, 2236000, 1350000, 24, 20, 50, 12),
(674, 'Rafael Monti', 26, 'ATA', 58, 66, 58, 54, 56, 22, 48, 58, 0, 50, 'Brasil', 1, 50, 0, 2236000, 1320000, 36, 20, 50, 12),
(675, 'Gabriel Poveda', 28, 'ATA', 57, 64, 58, 54, 56, 22, 46, 57, 0, 50, 'Brasil', 1, 50, 0, 1507000, 1500000, 36, 20, 50, 12),
(676, 'Paulo Henrique', 19, 'ATA', 53, 68, 52, 48, 50, 20, 44, 68, 0, 50, 'Brasil', 1, 50, 0, 1011000, 1100000, 48, 20, 50, 12);

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
(16, 'Yhureei', 'BRA', 'img/rostoManager/rosto-1.png', 'INICIANTE', 0, 32, 2),
(17, 'dfgdfg', 'POR', 'img/rostoManager/rosto-1.png', 'INICIANTE', 0, 32, 13);

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
  `dataPublicacao` int(11) NOT NULL,
  `clube_idClube` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `noticia_diretoria`
--

CREATE TABLE `noticia_diretoria` (
  `idNoticia` int(11) NOT NULL,
  `texto` varchar(255) NOT NULL,
  `data_registro` datetime NOT NULL,
  `clube_idClube` int(11) NOT NULL
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
  `local` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `patrocinador`
--

CREATE TABLE `patrocinador` (
  `idPatrocinador` int(11) NOT NULL,
  `nomePatrocinador` varchar(45) NOT NULL,
  `descricao` varchar(45) NOT NULL,
  `duracao` int(11) NOT NULL,
  `valorMensal` float NOT NULL,
  `multaRescisao` float NOT NULL,
  `foto` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `patrocinador`
--

INSERT INTO `patrocinador` (`idPatrocinador`, `nomePatrocinador`, `descricao`, `duracao`, `valorMensal`, `multaRescisao`, `foto`) VALUES
(1, 'Betano', 'Casa de apostas esportivas', 12, 800000, 15000000, 'img/patrocinadores/Betano.png'),
(2, 'Caixa Econômica', 'Banco público federal', 36, 1200000, 25000000, 'img/patrocinadores/caixa-economico.png'),
(3, 'Nike', 'Material esportivo e uniformes', 24, 950000, 20000000, 'img/patrocinadores/nike.png'),
(4, 'Ambev/Brahma', 'Bebidas - cervejaria', 12, 600000, 10000000, 'img/patrocinadores/ambev.png'),
(5, 'Havan', 'Rede varejista nacional', 18, 500000, 8000000, 'img/patrocinadores/havan.png'),
(6, 'Superbet', 'Casa de apostas esportivas', 12, 700000, 12000000, 'img/patrocinadores/superbet.png'),
(7, 'Banco BMG', 'Instituição financeira', 24, 900000, 18000000, 'img/patrocinadores/bmg.png'),
(8, 'Vivo', 'Telecomunicações', 36, 1100000, 22000000, 'img/patrocinadores/vivo.png'),
(9, 'Multilaser', 'Eletrônicos e acessórios', 12, 350000, 6000000, 'img/patrocinadores/multilaser.png'),
(10, 'KTO', 'Casa de apostas esportivas', 6, 650000, 9000000, 'img/patrocinadores/kto.png');

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
  `revelado` tinyint(4) NOT NULL,
  `jogador_idJogador` int(11) NOT NULL,
  `clube_idClube` int(11) NOT NULL
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
  `nivel` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `upgrade`
--

INSERT INTO `upgrade` (`idUpgrade`, `nomeUpgrade`, `preco`, `tipoUpgrade`, `descricao`, `modificador`, `nivel`) VALUES
(1, 'Reforma de Arquibancada', 5000000, 'ESTADIO', 'Aumenta a capacidade do estádio em pequena escala', 0.05, 1),
(2, 'Ampliação de Setores', 12000000, 'ESTADIO', 'Expande significativamente a capacidade do estádio', 0.12, 2),
(3, 'Cobertura Total', 25000000, 'ESTADIO', 'Cobre todos os setores, aumentando conforto e público em dias de chuva', 0.18, 3),
(4, 'Telão de LED Panorâmico', 8000000, 'ESTADIO', 'Melhora a experiência do torcedor e a receita de publicidade no estádio', 0.1, 2),
(5, 'Estádio Última Geração', 60000000, 'ESTADIO', 'Reconstrução completa com padrão internacional', 0.35, 4),
(6, 'Drenagem Básica', 2000000, 'GRAMADO_DM', 'Melhora o escoamento de água e reduz cancelamento de jogos', 0.05, 1),
(7, 'Gramado Híbrido', 6000000, 'GRAMADO_DM', 'Mistura de grama natural e sintética, mais resistente', 0.1, 2),
(8, 'Sistema de Irrigação Automatizado', 4000000, 'GRAMADO_DM', 'Mantém o gramado em condições ideais o ano todo', 0.08, 2),
(9, 'Gramado Padrão FIFA', 15000000, 'GRAMADO_DM', 'Qualidade de campo aprovada para jogos internacionais', 0.2, 3),
(10, 'Centro de Treinamento Básico', 3000000, 'CENTRO_TREINAMENTO', 'Estrutura mínima para treinos diários', 0.05, 1),
(11, 'Centro de Treinamento Intermediário', 9000000, 'CENTRO_TREINAMENTO', 'Melhora a evolução de atributos dos jogadores', 0.12, 2),
(12, 'Centro de Treinamento Avançado', 20000000, 'CENTRO_TREINAMENTO', 'Equipamentos de ponta para maximizar o desenvolvimento do elenco', 0.2, 3),
(13, 'CT de Alto Rendimento', 45000000, 'CENTRO_TREINAMENTO', 'Referência mundial em performance e recuperação física', 0.3, 4),
(14, 'Departamento Médico Reforçado', 10000000, 'CENTRO_TREINAMENTO', 'Reduz o tempo médio de recuperação de lesões', 0.15, 2),
(15, 'Loja Oficial Pequena', 2500000, 'MEGALOJA', 'Ponto de venda simples dentro do estádio', 0.05, 1),
(16, 'Megaloja Regional', 7000000, 'MEGALOJA', 'Aumenta a venda de camisas e produtos licenciados', 0.12, 2),
(17, 'Megaloja Flagship', 18000000, 'MEGALOJA', 'Loja conceito com forte apelo de marca', 0.22, 3),
(18, 'Campanha de Marketing Local', 1500000, 'MARKETING', 'Aumenta a base de torcedores na região', 0.05, 1),
(19, 'Marketing Nacional', 8000000, 'MARKETING', 'Expande a marca do clube para todo o país', 0.15, 2),
(20, 'Marketing Internacional', 22000000, 'MARKETING', 'Projeta o clube no cenário mundial, atraindo patrocínios maiores', 0.28, 3);

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
  ADD KEY `fk_partida_clube2_idx` (`mandanteIdClube`);

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
  ADD KEY `fk_proposta_transferencia_clube1_idx` (`clube_idClube`);

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
  MODIFY `idEstatisticasAnoClube` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `exigencia`
--
ALTER TABLE `exigencia`
  MODIFY `idExigencia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `historico_tecnico`
--
ALTER TABLE `historico_tecnico`
  MODIFY `idHistoricoTecnico` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jogador`
--
ALTER TABLE `jogador`
  MODIFY `idJogador` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=677;

--
-- AUTO_INCREMENT for table `lesao`
--
ALTER TABLE `lesao`
  MODIFY `idLesao` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `manager`
--
ALTER TABLE `manager`
  MODIFY `idManager` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `meta_temporada`
--
ALTER TABLE `meta_temporada`
  MODIFY `idMetaTemporada` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `noticia`
--
ALTER TABLE `noticia`
  MODIFY `idNoticia` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `noticia_diretoria`
--
ALTER TABLE `noticia_diretoria`
  MODIFY `idNoticia` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `partida`
--
ALTER TABLE `partida`
  MODIFY `idPartida` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `patrocinador`
--
ALTER TABLE `patrocinador`
  MODIFY `idPatrocinador` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `proposta_emprego`
--
ALTER TABLE `proposta_emprego`
  MODIFY `idPropostaEmprego` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `proposta_transferencia`
--
ALTER TABLE `proposta_transferencia`
  MODIFY `idPropostaTransferencia` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `treino`
--
ALTER TABLE `treino`
  MODIFY `idTreino` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `upgrade`
--
ALTER TABLE `upgrade`
  MODIFY `idUpgrade` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

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
  ADD CONSTRAINT `fk_partida_clube2` FOREIGN KEY (`mandanteIdClube`) REFERENCES `clube` (`idClube`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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
  ADD CONSTRAINT `fk_proposta_transferencia_clube1` FOREIGN KEY (`clube_idClube`) REFERENCES `clube` (`idClube`) ON DELETE NO ACTION ON UPDATE NO ACTION,
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

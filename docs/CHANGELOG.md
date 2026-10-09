# Changelog

Todas as mudanças relevantes do projeto ManagerMode.

## [09/10/2026]

### Adicionado
- **API:** endpoint `GET /jogadores/overall` para listar todos os jogadores do jogo ordenados por overall (decrescente)
- **API:** `JogadoresService.listarPorOverall()` e `JogadoresRepository.findAllByOrderByOverallDesc()`, que junta com `Clube` para trazer o nome do clube e não retorna jogadores lesionados
- **API:** record `JogadoresResponse.comClube`, com os dados do jogador mais `nomeClube`
- **Web:** busca, filtros, ordenação e paginação em `negociacao_mercado.php`
  - Filtros por posição (chips), status no mercado, contrato restante, clube, nacionalidade, faixa de idade, overall e valor de mercado
  - Contador de filtros ativos e botão "Limpar filtros"
  - Ordenação por overall, potencial, valor, idade, contrato ou nome, com botão para inverter a direção
  - Paginação de 15 jogadores por página
- **Web:** botão "Fazer proposta" na ficha do jogador, que abre um modal com valor oferecido (formatado em pt-BR), valor de mercado, multa de rescisão e clube do jogador. O modal mostra o percentual do valor de mercado e avisa quando a oferta é igual ou maior que a multa (`enviarProposta()` ainda está vazia)
- **Web:** estilos de filtros, paginação, ordenação e modal de proposta em `negociacao_mercado.css`
- **Docs:** imagens no `README.md` (tela inicial, central do elenco, patrocínios, resposta da API no Postman e galeria com outras telas)

### Alterado
- **API:** `GET /jogador/{id}/estatistica` agora tem `@CrossOrigin(origins="http://localhost")`, para ser chamado direto pelo navegador
- **Web:** `negociacao_mercado.php` busca os jogadores na API (antes eram linhas fixas no HTML). A ficha mostra posição, nacionalidade, clube, valor, salário, contrato restante, overall/potencial, multa, empréstimo e atributos. As estatísticas da temporada são carregadas via `fetch` e ficam em cache por jogador
- **Docs:** o exemplo de uso da API no `README.md` agora é `curl http://localhost:8080/jogadores/clube/12?todos=false`

## [08/10/2026]

### Adicionado
- **API:** módulo de lesões (`Lesao`, `JogadorLesao`, `LesaoId` (chave composta), enum `Gravidade` (`LEVE`, `MODERADO`, `GRAVE`), `JogadorHasLesaoRepository`, `LesaoResponse`, `LesaoJogadorResponse`, `JogadorLesaoService`)
- **API:** endpoint `GET /jogadores/clube/{idClube}/lesoes` para listar as lesões ativas dos jogadores do clube
- **API:** endpoint `GET /jogador/{id}/lesoes` para listar as lesões de um jogador
- **Docs:** pasta `fotosReadMe/` com os prints do README (`inicio.png`, `central-elenco.png`, `patrocinios.png`, `postman.png`)

### Alterado
- **API:** `JogadoresController` agora injeta `JogadorLesaoService`
- **Web:** `clube_central_elenco.php` busca as lesões do clube na API e mostra na ficha do jogador no formato `nome • N dias • gravidade` (antes aceitava só texto ou `descricao`)
- **BD:** `BD/manager.sql` atualizado (dump de 07/10) com as colunas que já existiam no código:
  - `clube.nomeEstadio` (obrigatória)
  - `jogador.numeroCamisa` e `jogador.salario` (padrão `0`)
  - `noticia.dataPublicacao` agora é `datetime` (era `int`)
  - `partida.competicao_idCompeticao`, com chave estrangeira para `competicao`
  - `upgrade.nivel` renomeada para `nivelMaximo`, e `upgrade.descricao` ampliada de 45 para 500 caracteres
  - `clube_has_upgrade.nivelAtual` com padrão `1`
- **BD:** o dump agora inclui as partidas, e os inserts de `clube`, `jogador` e `upgrade` foram atualizados

## [06/10/2026]

### Adicionado
- **API:** `PatrocinioController` com o endpoint `GET /patrocinios` para listar todos os patrocínios disponíveis
- **API:** `PatrocinadorService.listarPatrocinios()`
- **API:** endpoint `GET /jogadores/clube/{idClube}/estatisticas` para listar as estatísticas dos jogadores do clube por competição e ano
- **API:** `EstatisticaJogadoresService.estatisticasPorClube()` e `EstatisticasJogadorCompeticaoRepository.buscarPorClube()`
- **API:** `JogadoresService.listarPorClubeFull()` e `JogadoresRepository.findByClubeIdClube()` para retornar o elenco completo
- **API:** campo `salario` em `Jogadores` e `JogadoresResponse`
- **Web:** `services/TextService.php` com a função `limitarTexto()`
- **Web:** `services/YearService.php` com a função `formatarMesesParaAnos()` (ex.: `2a 6m`)
- **Web:** `dataAtual` em `EstadoJogo`, iniciada em `2026-01-01` no `Cadastro3Controller`
- **Web:** logos dos patrocinadores em `assets/img/patrocinadores/` (Betano, BMG, Brahma, Caixa, Havan, KTO, Multilaser, Nike, Superbet, Vivo)

### Alterado
- **API:** `GET /jogadores/clube/{idClube}` agora exige o parâmetro `todos`: `true` retorna o elenco completo e `false` retorna só os jogadores reserva (`titular = false`)
- **API:** `JogadoresRepository` e `JogadoresService` passam a retornar `JogadoresResponse` direto, sem o mapeamento manual para `NomeCamisaTitular`
- **Web:** `clube_central_elenco.php` busca elenco e estatísticas na API (antes eram linhas fixas no HTML). Ao clicar num jogador, a ficha mostra posição, overall, contrato, salário, multa de rescisão, status, moral, satisfação, atributos, lesões e estatísticas da temporada atual
- **Web:** `clube_patrocinios.php` busca os patrocínios na API (antes eram blocos fixos). Ao clicar num patrocinador, o painel de detalhes mostra logo, valor mensal, multa de rescisão, duração e descrição (o botão "Assinar Contrato" já tem o `data-id`, mas ainda sem ação)
- **Web:** `inicio.php` passa `?todos=false` na chamada de `/jogadores/clube/{id}`
- **Web:** `index.php` carrega `TextService.php` e `YearService.php`

## [05/10/2026]

### Adicionado
- **API:** módulo de upgrades do clube (`Upgrade`, `TipoUpgrade`, `UpgradeRepository`, `UpgradeResponse`, `UpgradeService`, `UpgradeController`)
- **API:** endpoint `GET /upgrades` para listar todos os upgrades disponíveis
- **API:** `ClubeHasUpgrade` e `ClubeHasUpgradeId` (chave composta), com `ClubeHasUpgradeRepository`, `ClubeHasUpgradeResponse` e `ClubeHasUpgradeService`
- **API:** endpoint `GET /clubes/{id}/upgrades` para listar os upgrades do clube com nome, preço, modificador, nível atual e nível máximo
- **API:** módulo de estatísticas por ano do clube (`EstatisticasAnoClube`, `EstatisticasAnoClubeRepository`, `EstatisticaAnoClubeResponse`, `EstatisticasAnoClubeService`)
- **API:** endpoint `GET /clubes/{id}/estatisticasAno` para listar o histórico de temporadas do clube
- **Web:** barra de progresso do nível dos upgrades (`.barra` e `.barra-preenchida` em `clube_estatisticas.css`)
- **Web:** imagem `assets/img/BD.png` (diagrama do banco de dados)

### Alterado
- **API:** `ClubeController` agora injeta `EstatisticasAnoClubeService` e `ClubeHasUpgradeService`
- **Web:** `clube_estatisticas.php` busca "Últimas Temporadas" na API (antes eram linhas fixas no HTML)
- **Web:** `clube_estatisticas.php` busca "Melhorias do Clube" na API (antes eram 5 blocos fixos), calculando bônus atual, bônus do próximo nível, custo (`preco * (nivelAtual + 1)`) e percentual da barra
- **Web:** botão "Melhorar" fica desabilitado no nível máximo ou quando o orçamento não cobre o custo do próximo nível (ainda sem ação de compra; o `data-upgrade-id` já está no botão)
- **Web:** cabeçalho da tabela de temporadas renomeado de `GP`/`GC` para `GF`/`GS`
- **Web:** limpeza de espaços em branco em `clube_estatisticas.php`

## [03/10/2026]

### Adicionado
- **API:** módulo de partidas (`Partida`, `StatusPartida`, `PartidaRepository`, `PartidaResponse`, `PartidaService`, `PartidaController`)
- **API:** endpoint `GET /partidas/clube/{idClube}/proximosJogos?dataPartida=` para listar os próximos jogos do clube
- **API:** `NoticiasController` com o endpoint `GET /noticias` (parâmetros `categoria` e `idClube`)
- **API:** `NoticiaService.listarNoticiasDeImprensa(idClube)`
- **Web:** classe `EstadoJogo` e `Clube` em `models/` para guardar o estado da carreira
- **Web:** arquivo `services/GameService.php` (ainda vazio)
- **Web:** rota `TREINO` apontando para `view/treino.php` em `Pagina.php`

### Alterado
- **Web:** sessão da carreira migrada de `$_SESSION['carreira']` (array) para `$_SESSION['estado_jogo']` (objeto `EstadoJogo`)
- **Web:** `index.php` carrega `EstadoJogo` e inicia a sessão antes de qualquer saída HTML
- **Web:** `header.php` lê escudo e nome do clube a partir do `EstadoJogo`
- **Web:** `inicio.php` refatorado: usa `EstadoJogo`, remove a janela duplicada da tabela, trata retorno `null` da API, escapa títulos das notícias com `htmlspecialchars` e extrai a função `formatarTitulo()`
- **API:** notícias agora retornam apenas as 5 mais recentes (`findTop5...OrderByDataPublicacaoDesc`)
- **API:** `dataPublicacao` de `Noticia` e `NoticiaResponse` mudou de `Integer` para `LocalDateTime`

### Corrigido
- Caminho do `require_once` do `EstadoJogo` no `Cadastro3Controller` (agora usa `__DIR__`)
- Erro de `TypeError` na tabela quando a liga não estava na sessão

## [02/10/2026]

### Adicionado
- **API:** entidades `Jogadores` e `Noticia`, com enums `PosicaoPrincipal` e `Categoria`
- **API:** `JogadoresRepository`, `JogadoresService`, `JogadoresResponse` e endpoint `GET /jogadores/clube/{idClube}`
- **API:** `NoticiaRepository`, `NoticiaService` e `NoticiaResponse`
- **API:** endpoint `GET /competicoes/{id}/classificacao`
- **Web:** `ApiService::getClassificacaoProxima()` para buscar a janela da tabela ao redor do clube do jogador
- **Web:** `inicio.php` passa a exibir elenco, tabela reduzida, transferências e imprensa com dados da API

### Alterado
- **API:** ajustes em `ClubeController`, `CompeticaoController`, `ClubeCompeticaoService` e `ClubeCompeticaoResponse`
- **API:** atualização do `pom.xml` e do `application.properties`
- **Web:** ajustes no `Cadastro3Controller` e em `cadastro_3.php`

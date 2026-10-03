# Changelog

Todas as mudanças relevantes do projeto ManagerMode.

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

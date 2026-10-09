# ⚽ ManagerMode

Jogo de **manager de futebol pelo navegador**, ambientado no **Brasileirão Série A**, inspirado em sites como o 7a0 e o 38a0. Você assume o comando de um clube e cuida de tudo fora das quatro linhas: elenco, mercado de transferências, diretoria, patrocínios, imprensa e a sua própria reputação como treinador.

> 🎓 **Projeto pessoal de estudo, sem fins lucrativos.** Nasceu para eu aprender e testar **Spring Boot** e **PHP** trabalhando juntos em uma mesma aplicação.

<!-- FOTO 1: imagem principal (hero) -->
<p align="center">
  <img src="/fotosReadMe/inicio.png" alt="Tela inicial do ManagerMode" width="850">
</p>

---

## 📑 Índice

- [Sobre o projeto](#-sobre-o-projeto)
- [Ideia do jogo](#-ideia-do-jogo)
- [Arquitetura](#-arquitetura)
- [Tecnologias](#-tecnologias)
- [Estrutura de pastas](#-estrutura-de-pastas)
- [Banco de dados](#-banco-de-dados)
- [Endpoints da API](#-endpoints-da-api)
- [Telas do front-end](#-telas-do-front-end)
- [Como rodar](#-como-rodar)
- [Status do projeto](#-status-do-projeto)
- [Documentação](#-documentação)
- [Aviso legal](#-aviso-legal)

---

## 📖 Sobre o projeto

O ManagerMode é dividido em duas aplicações que conversam entre si:

- **`manager-api`**: back-end em **Java + Spring Boot**. Expõe os dados do jogo em JSON por uma API REST.
- **`manager-web`**: front-end em **PHP**. Renderiza as telas e consome a API.

Os dados ficam em um banco **MySQL** que já vem com o schema e os dados prontos. A API **não cria tabelas**, ela só lê e grava no que já existe.

O objetivo principal é aprender na prática como um back-end Spring Boot e um front-end PHP se integram, enquanto desenvolvo um jogo com bastante regra de negócio.

---

## 🎮 Ideia do jogo

Você escolhe um clube da Série A e passa a ser o manager dele. O jogo gira em torno de decisões de gestão, não de controlar jogadores em campo.

Os principais elementos do jogo:

| Entidade | Resumo |
|---|---|
| **Manager** | O jogador. Tem uma reputação que evolui conforme os resultados e decisões. |
| **Clube** | O time que você comanda, com elenco, diretoria, torcida e finanças. |
| **Jogador** | Atletas com atributos, posição, idade e características próprias. |
| **Temporada** | O ciclo de competições do ano. |
| **Partida** | Os jogos disputados nas competições. |
| **Mercado de transferências** | Compra, venda e propostas, incluindo leilões com participação de bots. |
| **Seleção Nacional** | Convocações e a relação com a seleção. |
| **Diretoria / Presidência** | Cobra resultados e pode pressionar o manager. |
| **Patrocínio** | Contratos com nome, valor mensal fixo, duração e cláusula de reputação mínima. |
| **Imprensa / Eventos** | Entrevistas e acontecimentos que mexem com torcida, diretoria e vestiário. |

<!-- FOTO 2 e 3: duas telas lado a lado, ilustrando elenco e patrocínio -->
<p align="center">
  <img src="/fotosReadMe/central-elenco.png" alt="Central do Elenco" width="49%">
  <img src="/fotosReadMe/patrocinios.png" alt="Patrocínios" width="49%">
</p>

Algumas mecânicas planejadas: reputação do manager, pressão de diretoria e torcida, leilões movidos por bots e lendas aposentadas. O detalhamento de cada uma vai ficar no [`funcionalidades.md`](docs/funcionalidades.md).

### Base de jogadores

O jogo usa uma base de dados de jogadores da **Série A 2025**, cobrindo os **20 clubes** e **676 jogadores**. Os atributos foram gerados por um modelo heurístico (considerando nível do clube, idade e posição), com ajustes manuais para os grandes nomes.

### Uma instância de banco por jogador

O arquivo `manager.sql` funciona como um **molde**: cada jogador (usuário) do jogo recebe a sua própria instância do banco, criada a partir dele. É por isso que a API trabalha só com leitura e escrita nos dados e nunca altera o schema.

---

## 🏗️ Arquitetura

```
┌──────────────┐   HTTP    ┌──────────────────┐   JPA    ┌─────────┐
│ manager-web  │ ────────► │   manager-api    │ ───────► │  MySQL  │
│  (PHP)       │ ◄──────── │ (Spring Boot)    │ ◄─────── │ manager │
│ porta 8000*  │   JSON    │   porta 8080     │          └─────────┘
└──────────────┘           └──────────────────┘
```

\* A porta do PHP depende de como você servir o front. A API usa a `8080` padrão do Spring Boot, que é para onde o `ApiService.php` aponta.

**Camadas da API** (`com.manager.api`):

| Pacote | Responsabilidade |
|---|---|
| `controller` | Recebe as requisições HTTP e define as rotas. |
| `service` | Regras de negócio. |
| `repository` | Acesso ao banco via Spring Data JPA. |
| `model` | Entidades JPA mapeadas para as tabelas. |
| `responses` | Objetos de resposta enviados ao front. |
| `enums` | Valores fixos do domínio (status, tipos, níveis, fases). |

**Camadas do front** (`manager-web`):

| Pasta | Responsabilidade |
|---|---|
| `index.php` | Ponto de entrada. Resolve a página pelo parâmetro `?pag=`. |
| `routes/Pagina.php` | Enum com todas as páginas e o arquivo de cada uma. |
| `view/` | Telas do jogo. |
| `services/ApiService.php` | Cliente HTTP (cURL) que consome a API. |
| `controller/` | Controladores de formulários e ações. |
| `assets/` | CSS e imagens (escudos dos clubes). |

---

## 🛠️ Tecnologias

**Back-end**
- Java 17
- Spring Boot 4.1.1 (Web MVC, Spring Data JPA)
- Hibernate
- Lombok
- Maven (com Maven Wrapper)

**Front-end**
- PHP (com extensão cURL habilitada)
- HTML e CSS

**Banco de dados**
- MySQL

---

## 📁 Estrutura de pastas

```
Futebol/
├── manager-api/                 # Back-end Spring Boot
│   ├── src/main/java/com/manager/api/
│   │   ├── controller/          # ClubeController, CompeticaoController
│   │   ├── enums/               # clube/ e competicao/
│   │   ├── model/               # Clube, Competicao, ClubeCompeticao...
│   │   ├── repository/
│   │   ├── responses/
│   │   └── service/
│   ├── src/main/resources/application.properties
│   └── pom.xml
│
└── manager-web/                 # Front-end PHP
    ├── assets/
    │   ├── css/                 # Um CSS por tela
    │   └── img/escudosClubes/   # Escudos dos clubes
    ├── controller/
    ├── includes/
    ├── routes/Pagina.php
    ├── services/ApiService.php
    ├── view/                    # Telas do jogo
    └── index.php
```

---

## 🗄️ Banco de dados

- **SGBD:** MySQL
- **Nome do banco:** `manager`
- **Schema:** vem do arquivo `manager.sql`
- A API usa `spring.jpa.hibernate.ddl-auto=validate`, ou seja, **só confere** se as entidades batem com as tabelas existentes. Se o schema estiver diferente, a aplicação não sobe.

Entidades já mapeadas na API:

- **`Clube`**: dados do clube, incluindo status de confiança (`PESSIMO`, `INSTAVEL`, `ESTAVEL`, `EXCELENTE`).
- **`Competicao`**: competições com tipo (`PONTOS_CORRIDOS`, `MATA_MATA`, `MISTO`), nível (`NACIONAL`, `CONTINENTAL`, `ESTADUAL`) e status (`NAO_INICIADA`, `EM_ANDAMENTO`, `FINALIZADA`).
- **`ClubeCompeticao`**: relação entre clube e competição (chave composta), com pontos e fase atual (`OITAVAS`, `QUARTAS`, `SEMI`, `FINAL`).

---

## 🔌 Endpoints da API

| Método | Rota | Descrição |
|---|---|---|
| `GET` | `/competicoes` | Lista as competições. Aceita o filtro opcional `?tipo=PONTOS_CORRIDOS`. |
| `GET` | `/competicoes/{id}/clubes` | Lista os clubes (foto e nome) de uma competição. |
| `GET` | `/competicoes/{id}/classificacao` | Retorna a classificação de uma competição. |
| `GET` | `/clubes/{id}` | Busca os dados de um clube pelo id. |

Exemplo:

```bash
curl http://localhost:8080/jogadores/clube/12?todos=false
```

<p align="center">
  <img src="/fotosReadMe/postman.png" alt="Exemplo de resposta da API" width="700">
</p>

Os detalhes completos (parâmetros, exemplos de resposta) vão ficar no [`docs/api.md`](docs/api.md).

---

## 🖥️ Telas do front-end

A navegação é feita pelo parâmetro `pag` (ex.: `index.php?pag=inicio`). A página padrão é o `cadastro_1`.

| Grupo | Páginas |
|---|---|
| **Cadastro** | `cadastro_1`, `cadastro_2`, `cadastro_3` |
| **Início** | `inicio` |
| **Clube** | `equipe`, `estatisticas`, `patrocinios`, `central_elenco` |
| **Negociação** | `mercado`, `propostas_recebidas`, `propostas_enviadas` |
| **Gestão** | `calendario`, `treino`, `diretoria` |
| **Carreira e jogo** | `carreira`, `partida`, `imprensa` |

<!-- FOTO 6 a 9: galeria 2x2 com as outras telas -->
| Escolha do clube | Estatísticas do clube |
|:---:|:---:|
| <img src="/fotosReadMe/cadastro.png" width="420"> | <img src="fotosReadMe/estatisticas.png" width="420"> |
| **Mercado de transferências** | **Imprensa** |
| <img src="/fotosReadMe/mercado.png" width="420"> | <img src="fotosReadMe/imprensa.png" width="420"> |

---

## 🚧 Status do projeto

O projeto está **em desenvolvimento ativo**.

**Já existe:**
- Estrutura base da API com camadas (controller, service, repository, model).
- Mapeamento de clubes, competições e a relação entre eles.
- Endpoints de listagem de competições, clubes por competição, classificação e busca de clube.
- Esqueleto do front com as principais telas e o cliente HTTP para a API.
- Base de jogadores da Série A 2025.

**Em andamento / planejado:**
- Integrar as telas do front aos dados reais da API.
- Endpoints de jogadores, elenco, mercado, propostas e partidas.
- Mecânicas de reputação, diretoria, patrocínio e imprensa.
- Simulação de partidas e de temporada.

O planejamento detalhado vai ficar no [`docs/roadmap.md`](docs/roadmap.md).

---

## 📚 Documentação

Documentos que complementam este README. Alguns ainda vão ser escritos (🚧).

| Documento | O que vai conter | Status |
|---|---|---|
| [`docs/funcionalidades.md`](docs/funcionalidades.md) | Todas as funcionalidades e mecânicas do jogo, explicando o que cada uma faz | 🚧 |
| [`docs/api.md`](docs/api.md) | Referência completa dos endpoints, parâmetros e exemplos de resposta | 🚧 |
| [`docs/banco-de-dados.md`](docs/banco-de-dados.md) | Modelo de dados, tabelas, relacionamentos e diagrama ER | 🚧 |
| [`docs/arquitetura.md`](docs/arquitetura.md) | Como API, front e banco se comunicam e as decisões de design | 🚧 |
| [`docs/instalacao.md`](docs/instalacao.md) | Guia de instalação passo a passo, com solução de problemas comuns | 🚧 |
| [`docs/roadmap.md`](docs/roadmap.md) | O que já foi feito, o que está em andamento e o que vem depois | 🚧 |
| [`docs/base-de-jogadores.md`](docs/base-de-jogadores.md) | Como os atributos dos 676 jogadores foram gerados e como funcionam as posições | 🚧 |
| [`CHANGELOG.md`](CHANGELOG.md) | Histórico de mudanças por versão | 🚧 |

---

## ⚖️ Aviso legal

Este é um projeto **pessoal, educacional e sem fins lucrativos**, sem qualquer vínculo com clubes, ligas ou federações.

Nomes e escudos de clubes são **marcas registradas de seus respectivos proprietários** e aparecem aqui apenas para fins de estudo. Se algum titular de direitos quiser que algum material seja removido, basta abrir uma issue.

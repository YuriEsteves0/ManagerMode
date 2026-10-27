# ManagerMode.com — Funcionalidades do Jogo

Jogo de gerenciamento de futebol (estilo *football manager*) em que o jogador assume o papel de **técnico** e conduz um clube do zero à elite, tomando decisões de elenco, mercado, finanças, relacionamento com a diretoria e imprensa ao longo de várias temporadas.

> Este documento descreve **todas** as funcionalidades do jogo (as já implementadas e as previstas nas telas e na modelagem de dados).

---

## Sumário

1. [Visão geral](#1-visão-geral)
2. [Criação da carreira](#2-criação-da-carreira)
3. [Início (painel principal)](#3-início-painel-principal)
4. [Clube](#4-clube)
5. [Negociação (mercado de transferências)](#5-negociação-mercado-de-transferências)
6. [Calendário](#6-calendário)
7. [Treino](#7-treino)
8. [Diretoria](#8-diretoria)
9. [Carreira do técnico](#9-carreira-do-técnico)
10. [Dia de jogo: Partida e Imprensa](#10-dia-de-jogo-partida-e-imprensa)
11. [Configurações](#11-configurações)
12. [Competições](#12-competições)
13. [Sistemas e regras do jogo](#13-sistemas-e-regras-do-jogo)
14. [Navegação](#14-navegação)
15. [Resumo técnico](#15-resumo-técnico)

---

## 1. Visão geral

| Item | Descrição |
|---|---|
| Gênero | Simulação / gerenciamento de futebol |
| Plataforma | Web (navegador) |
| Papel do jogador | Técnico (manager) de um clube |
| Liga inicial | Brasileirão Série A (20 clubes com escudos reais) |
| Nacionalidades do técnico | Brasileiro, Português, Espanhol |
| Modos de jogo | **Normal** (para conhecer o jogo) e **Pro** (sem ajuda da IA) |
| Duração | Infinita: "∞ temporadas pela frente" |
| Data de início da carreira | 01/01/2026 |

**Pilares do jogo:** montar elenco e escalação, negociar jogadores, gerir as finanças e a estrutura do clube, manter a confiança da diretoria, lidar com a imprensa e construir a reputação do técnico até virar "referência no futebol mundial".

---

## 2. Criação da carreira

Fluxo em 3 etapas antes de entrar no jogo.

### 2.1 Etapa 1 — Criar técnico
- Informar o **nome do técnico**.
- Escolher a **nacionalidade** (Brasileiro, Português ou Espanhol).
- Escolher o **modo de jogo**:
  - **Normal:** pensado para conhecer o jogo.
  - **Pro:** sem ajuda da IA.
- Botão **Iniciar carreira**.

### 2.2 Etapa 2 — Escolher a liga
- Lista as competições de **pontos corridos** disponíveis, com seu nível (nacional, continental ou estadual).
- A liga escolhida é onde a carreira começa.
- Mensagem de aviso quando não há competições disponíveis.

### 2.3 Etapa 3 — Clube sorteado
- O jogo **sorteia aleatoriamente** um clube da liga escolhida.
- Exibe escudo, nome e orçamento do clube.
- Ao clicar em **Jogar**, o técnico é criado com:
  - Foto de rosto sorteada entre 3 opções.
  - Reputação inicial **Iniciante**, experiência 0.
  - Contrato inicial até 2027.
  - Vínculo com o clube sorteado.
- Em caso de falha na criação, o jogo retorna à etapa 3 com indicação de erro.

---

## 3. Início (painel principal)

Painel com 6 blocos de resumo da situação atual:

| Bloco | O que mostra |
|---|---|
| **Elenco** | Jogadores titulares com número da camisa e nome |
| **Próximos Jogos** | Próximas 4 partidas: rodada, adversário, mando (casa/fora), data e hora |
| **Artilharia** | Maiores goleadores da competição |
| **Tabela** | Classificação da liga (posição, time, pontos, jogos, vitórias, saldo de gols) com o clube do jogador destacado |
| **Transferências** | Últimas notícias do mercado da bola, com indicador de **janela de transferências aberta** |
| **Imprensa** | Últimas notícias da imprensa sobre o clube do jogador |

---

## 4. Clube

Menu com 4 telas.

### 4.1 Equipe (escalação)
- Campo de futebol com os **11 titulares** posicionados por linha (goleiro, defesa, meio, ataque).
- **Formação calculada automaticamente** a partir dos titulares (ex.: 4-3-3).
- Contador de titulares definidos (`x/11`) e **aviso** quando a escalação não tem exatamente 11 jogadores.
- Lista de **Reservas** e de **Não Relacionados**, ordenadas por overall, com posição, número e OVR.
- Posições de jogo: Goleiro (GOL), Zagueiro (ZAG), Lateral direito/esquerdo (LD/LE), Volante (VOL), Meia (MC/MEI), Ponta direito/esquerdo (PD/PE) e Atacante (ATA).
- Montagem da escalação para o próximo jogo (titulares, reservas e não relacionados).

### 4.2 Estatísticas do Clube
- **Painel do clube:** escudo, nome, liga, valor do clube, quantidade de torcedores, reputação (0 a 100), orçamento, receita mensal e patrocinador atual.
- **Receita mensal estimada**, composta por:
  - Bilheteria (capacidade do estádio × ocupação média × preço do ingresso × jogos em casa no mês).
  - Venda de camisas.
  - Sócio-torcedor.
  - Mídia/patrocínio base (parte do orçamento).
- **Últimas temporadas:** histórico ano a ano (jogos, vitórias, empates, derrotas, gols feitos e sofridos).
- **Melhorias do Clube (upgrades):**
  - Tipos: **Estádio**, **Gramado e Departamento Médico**, **Centro de Treinamento**, **Megaloja** e **Marketing**.
  - Cada melhoria tem nível atual/máximo, barra de progresso, descrição, bônus atual (%) e bônus do próximo nível.
  - O custo cresce a cada nível; o botão **Melhorar** fica bloqueado sem orçamento suficiente ou ao atingir o nível máximo.

### 4.3 Patrocínios
- Lista de **propostas de patrocínio** disponíveis (ex.: Betano, Nike, Vivo, Brahma, Caixa, Havan, KTO, Multilaser, Superbet, BMG).
- Detalhe da proposta: **valor mensal**, **multa de rescisão**, **duração do contrato** (em meses) e descrição da empresa.
- Botão **Assinar Contrato** para fechar com o patrocinador escolhido.

### 4.4 Central do Elenco
- Lista de **todos os jogadores** do clube com posição, nome, overall, valor de mercado, tempo de contrato e indicador 🔥 (**on fire**).
- **Ficha do jogador:**
  - Idade, valor, overall e posição.
  - Contrato restante, salário mensal e multa de rescisão.
  - Status (On fire / Normal).
  - **Moral** e **satisfação** (0 a 100).
  - **Atributos:** velocidade, força, inteligência, finalização, marcação e passe.
  - **Lesões:** nome, dias de afastamento e gravidade (leve, moderada ou grave).
  - **Estatísticas da temporada** por competição: jogos, gols e assistências.

---

## 5. Negociação (mercado de transferências)

### 5.1 Comprar (Mercado)
- Lista de jogadores de **todos os clubes**, ranqueados por overall (jogadores lesionados ficam fora do ranking).
- **Orçamento disponível** sempre visível.
- **Busca** por nome de jogador ou clube.
- **Filtros:**
  - Posição (múltipla escolha).
  - Status no mercado: listado para empréstimo, não listado, contrato terminando (≤ 6 meses).
  - Contrato restante (até 6 meses, 1 ano, 2 anos, mais de 2 anos).
  - Clube e nacionalidade.
  - Faixa de idade, de overall e de valor de mercado.
  - Contador de filtros ativos e botão **Limpar filtros**.
- **Ordenação** por overall, potencial, valor, idade, contrato restante ou nome, com inversão de ordem.
- **Paginação** da lista.
- **Ficha do jogador:** valor de mercado, salário, contrato, overall/potencial, multa de rescisão, disponibilidade para empréstimo, atributos, lesões e estatísticas da temporada.
- **Fazer proposta:** informa o valor oferecido, com referência ao valor de mercado, à multa de rescisão e ao clube atual do jogador.

### 5.2 Propostas Recebidas
- Lista de propostas de **outros clubes por jogadores do seu elenco**, com o clube interessado e o valor oferecido.
- Detalhe: valor da proposta, valor do jogador, overall, posição, idade, status, tipo de contratação (definitiva ou empréstimo) e rescisão.
- Ações:
  - **Aceitar termos.**
  - **Recusar proposta** (ícone de lixeira).
  - **Contraproposta**, com:
    - Tipo de negociação: **Definitiva** ou **Empréstimo**.
    - Valor de transferência (definitiva).
    - Empréstimo: duração do contrato (6 meses, 1, 2 ou 3 anos), taxa de empréstimo, **opção de compra** (com valor) e **divisão do salário** entre os clubes (controle deslizante de 0 a 100%).
    - Visualização do salário atual do jogador, do orçamento do clube e do valor original oferecido.

### 5.3 Propostas Enviadas
- Lista de **alvos do mercado** para os quais o clube já enviou proposta, com status:
  - **Enviada**, **Aceita**, **Recusada**, **Cancelada** ou **Contraproposta**.
- Detalhe: valor enviado, valor do jogador, contrato restante, overall, salário, rescisão, atributos, lesões e estatísticas.
- **Formalizar Contratação** (disponível quando a proposta é aceita):
  - Salário oferecido ao jogador.
  - Tempo de contrato (1 a 5 anos).
  - Valor de rescisão.
  - **Medidor de moral** do jogador no clube atual, com aviso de **contratação dificultada** quando ele não quer sair.

---

## 6. Calendário

- **Calendário mensal** navegável (mês anterior/próximo), com destaque para:
  - O dia de hoje.
  - Dias que já passaram.
  - **Dias de jogo**, com dica ao passar o mouse (adversário, casa/fora e horário).
- **Painel do próximo jogo:**
  - Manchete dinâmica: "Hoje tem jogo!", "Amanhã tem jogo" ou "Seu próximo jogo é daqui a N dias".
  - Confronto com escudos, data, horário, rodada, estádio (com capacidade) e mando de campo.
  - **Enquete "Quem vencerá?"**: porcentagens de vitória do mandante, empate e vitória do visitante, calculadas pela reputação dos clubes com fator casa, e uma frase de veredito da torcida (ex.: "Jogo parelho").
  - **Depois disso:** lista dos 3 jogos seguintes.

---

## 7. Treino

- Catálogo de **tipos de treino**, cada um com nome e descrição.
- O técnico escolhe **até 4 treinos por semana**, com contador de selecionados (`x/4`).
- Treinos já escolhidos anteriormente aparecem pré-selecionados.
- Botão **Confirmar Treino** para fechar o plano semanal.
- A melhoria **Centro de Treinamento** (Clube → Estatísticas) potencializa essa área.

---

## 8. Diretoria

- **Confiança da diretoria** (0 a 100%) com barra e status textual (de péssimo a excelente), além do evento atual do clube (ex.: "Boa gestão").
- **Orçamento disponível** do clube.
- **Metas da Temporada**, cada uma com status: *dentro do esperado*, *abaixo do esperado*, *concluída* ou *falhou*.
- **Recados da Diretoria:** mensagens que aumentam (+) ou reduzem (−) a confiança, com o percentual do efeito.
- **Ações de Carreira:** pedidos que o técnico pode **solicitar à diretoria**, cada um com título, requisito, efeito e status:
  - **Disponível**, **Em análise** (aguardando resposta), **Concluída** (já utilizada) ou **Bloqueada** (confiança insuficiente).

---

## 9. Carreira do técnico

### 9.1 Ficha do técnico
- Foto, nome, clube atual, nacionalidade, **contrato restante** e **reputação** (Iniciante → Promissor → Renomado → Lenda).
- **Títulos conquistados** (competição e ano).
- **Histórico dos últimos 5 clubes** comandados, com o ano de cada passagem e indicação do clube atual.
- **Desempenho por temporada:** jogos, vitórias, empates e derrotas.

### 9.2 Mercado de trabalho
- **Propostas de emprego** recebidas de outros clubes, com escudo, reputação do clube, **salário mensal** oferecido e botão **Aceitar**.
- **Pedir demissão** do clube atual.

---

## 10. Dia de jogo: Partida e Imprensa

Acionado pelo botão **JOGAR** no topo do jogo.

### 10.1 Partida
- **Placar** com escudos e nomes dos clubes, resultado e cronômetro.
- **Acontecimentos da partida** em ordem de minuto: **gols**, **cartões amarelos** e **cartões vermelhos**, indicando o jogador e o lado (mandante/visitante).
- Estados de uma partida: **agendada**, **em andamento** e **finalizada**.
- Opção de **pular direto para o resultado** (ver Configurações).

### 10.2 Imprensa (coletiva pós-jogo)
- Um **repórter** faz uma pergunta sobre o jogo.
- O técnico escolhe entre **três respostas** de tons diferentes (ex.: autocrítica, elogio ao adversário, evasiva).
- Depois da coletiva, o jogo retorna ao painel **Início**.
- As notícias geradas alimentam o bloco **Imprensa** da tela inicial.

---

## 11. Configurações

### 11.1 Preferências
| Seção | Opção | Padrão |
|---|---|---|
| Partida | Pular direto para o resultado (simula sem acompanhar os lances e mostra o resumo) | Desligado |
| Gestão | Confirmar ações irreversíveis (vender, dispensar, aceitar proposta) | Ligado |
| Gestão | Escalação automática (completa titulares faltantes por lesão ou suspensão) | Desligado |
| Notificações | Propostas recebidas | Ligado |
| Notificações | Imprensa e diretoria | Ligado |
| Notificações | Lesões e suspensões | Ligado |

- Botões **Salvar** e **Restaurar padrão**, com aviso "Configurações salvas ✓". As preferências ficam guardadas no navegador.

### 11.2 Meu jogo
- Resumo da carreira: técnico, clube, liga, modo de jogo, data de início e data atual no jogo.
- **Exportar jogo:** baixa um arquivo com o progresso, para guardar ou levar a outro dispositivo.

### 11.3 Zona de perigo
- **Reiniciar carreira:** apaga o progresso e volta à criação do técnico.

---

## 12. Competições

- **Tipos:** pontos corridos, mata-mata e misto.
- **Níveis:** nacional, continental e estadual.
- **Status:** não iniciada, em andamento e finalizada.
- **Fases do mata-mata:** oitavas, quartas, semifinal e final.
- Cada competição possui **ano**, **valor do prêmio** e **prêmio por vitória**.
- **Classificação** ordenada por pontos, com a fase atual de cada clube.
- Estatísticas de jogadores por competição: jogos, gols, assistências e **nota média**, que alimentam a artilharia.
- Os **títulos** conquistados pelo técnico ficam registrados no histórico de carreira.

---

## 13. Sistemas e regras do jogo

### Jogadores
- **Atributos:** velocidade, força, inteligência, finalização, marcação e passe.
- **Overall** e **potencial** de evolução.
- **Moral** e **satisfação** do jogador.
- **On fire:** jogador em grande fase.
- **Contrato:** tempo restante, salário mensal e multa de rescisão.
- **Disponibilidade para empréstimo.**
- **Lesões** com nome, duração em dias e gravidade (leve, moderada ou grave); jogadores lesionados não aparecem no ranking de mercado.
- **Escalação:** titular, reserva ou não relacionado, com posição em campo.

### Clube
- **Orçamento**, **valor do clube**, **camisas vendidas**, **torcedores** e **reputação** (0 a 100).
- **Estádio:** nome e capacidade.
- **Patrocinador** atual.
- **Confiança da diretoria** e evento atual.
- **Upgrades** de infraestrutura (estádio, gramado/DM, centro de treinamento, megaloja e marketing).

### Técnico
- **Reputação:** Iniciante, Promissor, Renomado e Lenda.
- **Experiência** (exp) e **contrato** com o clube.
- **Propostas de emprego** de outros clubes (pendente, aceito ou recusado).
- **Títulos** e **histórico** de clubes.

### Notícias
- **Imprensa:** notícias sobre o clube do jogador.
- **Mercado:** notícias gerais da janela de transferências.

### Tempo do jogo
- O jogo mantém uma **data atual** que avança ao longo da temporada; calendário, próximos jogos e estatísticas do ano dependem dela.

---

## 14. Navegação

Barra superior fixa com acesso a todas as áreas:

```
MANAGERMODE.COM
├── INÍCIO
├── CLUBE
│   ├── Equipe
│   ├── Estatísticas do Clube
│   ├── Patrocínios
│   └── Central do Elenco
├── NEGOCIAÇÃO
│   ├── Comprar
│   ├── Propostas Recebidas
│   └── Propostas Enviadas
├── CALENDÁRIO
├── TREINO
├── DIRETORIA
├── CARREIRA
└── (direita) Clube atual · ⚙ Configurações · JOGAR
```

Durante a criação da carreira, o topo exibe apenas a marca do jogo.

---

## 15. Resumo técnico

| Camada | Tecnologia | Papel |
|---|---|---|
| **manager-web** | PHP (páginas, rotas por *enum*, sessão do jogo), HTML/CSS/JS | Interface do jogo, animações e estado da sessão (técnico, clube, liga, datas) |
| **api** | Java / Spring Boot (REST + JPA) | Regras e dados: clubes, jogadores, competições, partidas, transferências, diretoria, treino, patrocínios, upgrades, notícias, técnico |

**Principais grupos de endpoints da API:**

| Área | Endpoints |
|---|---|
| Clubes | `/clubes/{id}`, `/patrocinador`, `/estatisticasAno`, `/upgrades`, `/transferencias`, `/treino`, `/metaTemporada`, `/noticiasDiretoria`, `/acaoDiretoria` |
| Competições | `/competicoes`, `/competicoes/{id}`, `/clubes`, `/classificacao` |
| Jogadores | `/jogadores/clube/{id}`, `/jogadores/overall`, `/estatisticas`, `/lesoes` |
| Partidas | `/partidas/clube/{id}/proximosJogos`, `/proximosJogosCalendario` |
| Técnico | `/manager/{id}`, `/titulos`, `/historico`, `POST /manager/criar`, `/propostas-emprego/{idManager}` |
| Outros | `/noticias`, `/patrocinios`, `/treinos`, `/upgrades`, `/noticiasDiretoria` |

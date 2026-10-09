# ManagerMode — Funcionalidades e Mecânicas

ManagerMode é um jogo web de gerenciamento de futebol em que você assume o papel de **técnico**: monta o time, cuida das finanças, negocia jogadores, responde à imprensa e tenta construir uma carreira.

## Legenda de status

| Ícone | Significado |
|---|---|
| ✅ | Funcionando com dados reais (front-end PHP + API + banco) |
| 🟡 | Tela pronta, mas com dados de exemplo fixos (ainda não integrada à API) |
| 🗄️ | Mecânica já modelada no banco de dados, aguardando implementação |

---

## 1. Criação da carreira ✅

Fluxo em 3 telas, antes de começar a jogar.

### 1.1 Criar técnico (`cadastro_1`)
Você define:
- **Nome do técnico**
- **Nacionalidade:** Brasileiro, Português ou Espanhol
- **Modo de jogo:**
  - **Normal:** pensado para conhecer o jogo
  - **Pro:** sem ajuda da IA

### 1.2 Escolher a liga (`cadastro_2`)
Lista as competições de **pontos corridos** cadastradas na API, mostrando o nome e o nível (nacional, continental ou estadual). É a liga em que a carreira começa.

### 1.3 Clube sorteado (`cadastro_3`)
O jogo **sorteia aleatoriamente** um clube entre os participantes da liga escolhida e exibe o escudo e o nome. Ao clicar em **Jogar**, os dados (técnico, modo, liga e clube) são guardados na sessão (`EstadoJogo`) e você vai para a tela inicial.

---

## 2. Navegação

O menu superior dá acesso às áreas do jogo e mostra, no canto direito, o **escudo e o nome do seu clube** (leva à Diretoria) e o botão **JOGAR** (leva à Partida).

| Menu | Telas |
|---|---|
| Início | Painel geral |
| Clube | Equipe, Estatísticas, Patrocínios, Central do Elenco |
| Negociação | Mercado, Propostas Enviadas, Propostas Recebidas |
| Calendário | Calendário e próximo jogo |
| Treino | Treinos da semana |
| Diretoria | Metas, recados e ações de carreira |
| Carreira | Ficha do técnico e mercado de trabalho |

---

## 3. Início ✅

Painel resumido com seis blocos:

| Bloco | O que mostra | Status |
|---|---|---|
| **Elenco** | Jogadores do seu clube com número da camisa e nome | ✅ API |
| **Tabela** | Recorte da classificação com 5 clubes ao redor do seu, com o seu destacado (posição e pontos) | ✅ API |
| **Transferências** | As 5 notícias de mercado mais recentes, com o selo "Janela aberta" | ✅ API |
| **Imprensa** | As 5 notícias de imprensa mais recentes sobre o seu clube | ✅ API |
| **Próximos Jogos** | Lista de rodadas, adversários, mando e data | 🟡 fixo (endpoint já existe na API) |
| **Artilharia** | Ranking de goleadores | 🟡 fixo |

> Na tabela, as colunas J, V e SG ainda aparecem zeradas, porque a API só devolve os pontos.

---

## 4. Clube

### 4.1 Equipe / Escalação 🟡
Monta o time para o próximo jogo:
- **Titulares** em formação (ex.: 4-3-3), com 11 posições
- **Reservas** (banco)
- **Não relacionados**, com o motivo: lesionado, suspenso, departamento médico ou fora de forma

### 4.2 Central do Elenco 🟡
Lista todos os jogadores do clube (posição, nome, overall, valor de mercado e contrato restante). Um ícone de fogo (🔥) marca quem está **"on fire"**. Ao selecionar um jogador, mostra a ficha completa:
- Idade, overall, valor, status (ex.: On fire)
- Contrato restante, salário mensal e multa de rescisão
- **Moral** e **satisfação** (0 a 100)
- **Atributos:** velocidade, força, inteligência, finalização, marcação e passe
- Lesões
- Estatísticas da temporada por competição (jogos, gols, assistências)

### 4.3 Estatísticas do Clube 🟡
Resume a situação do clube:
- **Valor do clube, torcedores, reputação (0–100), orçamento, receita mensal e patrocinador**
- **Histórico das últimas temporadas:** jogos, vitórias, empates, derrotas, gols pró e contra
- **Melhorias do Clube** (compradas com o orçamento, em níveis de 1 a 5):

| Melhoria | Efeito |
|---|---|
| Departamento Médico | Reduz a chance de lesões e a fadiga pós-jogo |
| Centro de Treinamento | Acelera a evolução dos jovens |
| Rede de Scouting | Libera mais regiões de olheiros e relatórios detalhados |
| Estádio | Aumenta a capacidade e a receita de bilheteria |
| Marketing & Patrocínio | Aumenta a receita de patrocínio |

Cada melhoria mostra o efeito atual, o benefício do próximo nível e o preço. No nível 5, aparece "Máximo".

### 4.4 Patrocínios 🟡
- Mostra o **patrocinador máster atual:** valor mensal, multa de rescisão, duração do contrato, descrição da empresa e **exigências do contrato** (ex.: exibir a marca na manga, dar entrevistas, manter a reputação acima de um mínimo).
- Lista as **propostas disponíveis** de outras empresas, cada uma com valor mensal, duração e exigências. É possível **assinar um novo contrato**.

---

## 5. Negociação

### 5.1 Mercado (comprar jogadores) 🟡
Busca jogadores de outros clubes. Mostra o **orçamento disponível** e permite filtrar por:
- Posição (GL, ZG, LD, LE, VOL, MEI, PE, PD, CA)
- Nacionalidade
- Idade
- Valor de mercado
- Disponibilidade para empréstimo

Ao selecionar um jogador, vê-se a ficha dele (clube atual, valor, salário, contrato, atributos, lesões e estatísticas). Para jogadores de **outros clubes**, algumas informações aparecem como **faixas** (ex.: overall "62–78", moral "60–95"), indicadas com "(?)". Isso funciona como informação incompleta, que o jogo parece revelar aos poucos.

### 5.2 Propostas Enviadas 🟡
Acompanha os **alvos do mercado** e as propostas que você mandou. Ao **formalizar uma contratação**, você define:
- **Salário** oferecido ao jogador
- **Tempo de contrato** (1 a 5 anos)
- **Valor de rescisão**

A tela mostra a **moral do jogador no clube atual**: se ele está feliz e não quer sair, a contratação fica **dificultada**. A proposta pode ter status como "Proposta Aceita".

### 5.3 Propostas Recebidas 🟡
Mostra as ofertas de outros clubes pelos **seus jogadores** (valor, clube, liga, tipo de contratação, rescisão e observações, como "difícil efetivação: o jogador não deseja sair"). Você pode **aceitar os termos** ou **enviar uma contraproposta**:
- **Tipo de negociação:** definitiva, empréstimo (6 meses, 1, 2 ou 3 anos) ou empréstimo com opção de compra
- **Valor de transferência** oferecido
- **Divisão do salário** entre os dois clubes (no empréstimo)
- Referências na tela: valor de mercado do jogador, salário atual, orçamento disponível e valor pedido originalmente

---

## 6. Calendário 🟡

Calendário mensal navegável (mês anterior e seguinte), com o dia atual e os dias já passados destacados. Ao lado, o painel **Próximo Jogo** mostra:
- Confronto, data e horário
- Transmissão
- Estádio e local
- Ingressos vendidos / capacidade
- **"Quem vencerá?"** com a probabilidade de vitória, empate e derrota

---

## 7. Treino 🟡

Você escolhe **até 4 treinos por semana** entre 15 opções e confirma. Cada treino melhora um aspecto do time:

| Treino | Efeito |
|---|---|
| Resistência Física | Aumenta o fôlego e reduz a fadiga em jogos longos |
| Velocidade | Melhora a aceleração e o sprint |
| Força | Aumenta a força nos duelos corporais |
| Finalização | Melhora a precisão e a potência dos chutes |
| Passe | Aumenta a precisão dos passes curtos e longos |
| Marcação | Melhora a defesa individual |
| Cabeceio | Melhora o desempenho em bolas aéreas |
| Cruzamento | Melhora a precisão dos cruzamentos |
| Drible | Aumenta a habilidade de finta e condução |
| Bola Parada | Melhora faltas, escanteios e pênaltis |
| Reflexos (Goleiros) | Melhora o tempo de reação dos goleiros |
| Saída de Bola | Melhora a construção de jogo desde a defesa |
| Tática Ofensiva | Aumenta a sincronia nas jogadas de ataque |
| Tática Defensiva | Melhora a organização defensiva coletiva |
| Recuperação Física | Reduz o tempo de recuperação de lesões e fadiga |

Atualmente a confirmação só exibe um aviso; os efeitos ainda não são aplicados aos jogadores.

---

## 8. Diretoria 🟡

Representa a relação do técnico com a diretoria do clube.

### 8.1 Confiança da diretoria
Um indicador de **0 a 100%** (com status: péssimo, instável, estável ou excelente) que sobe e desce conforme seus resultados e decisões. Também aparece o **orçamento disponível**.

### 8.2 Metas da temporada
Objetivos definidos pela diretoria, por exemplo: classificar para a Libertadores, chegar às quartas da Copa do Brasil, manter o orçamento positivo, vender um jogador da base.

### 8.3 Recados da diretoria
Mensagens que explicam por que a confiança mudou (ex.: **+3%** por liderar o campeonato, **−8%** pela eliminação na Copa).

### 8.4 Ações de carreira
Pedidos que você faz à diretoria. Cada um exige um **nível mínimo de confiança** e pode **custar confiança**:

| Ação | Exigência | Efeito | Custo |
|---|---|---|---|
| Pedir reforço no orçamento | confiança acima de 60% | +R$ 5M no orçamento | −10% |
| Pedir aumento de salário | confiança acima de 50% | +20% no salário mensal | −5% |
| Solicitar investimento no elenco | confiança acima de 55% | Libera verba extra para contratações | −8% |
| Solicitar demissão de diretor | confiança acima de 75% | Substitui um membro da diretoria | −15% |
| Solicitar melhoria no estádio | confiança acima de 65% | Acelera a expansão do estádio | −6% |
| Renovar contrato automaticamente | nenhuma | Renova por mais 2 anos | nenhum |
| Negociar novo contrato | menos de 6 meses restantes | Renegocia salário e prazo | nenhum |
| Pedir demissão voluntária | nenhuma | Encerra o contrato antes do prazo | multa de rescisão |

Cada ação aparece como **Disponível**, **Bloqueado** (confiança insuficiente) ou **Em análise** (aguardando resposta, com prazo em dias).

---

## 9. Carreira 🟡

Visão da trajetória do técnico:
- **Ficha do técnico:** nome, nacionalidade, clube atual, fim do contrato e **reputação** (Iniciante, Promissor, Renomado ou Lenda)
- **Títulos conquistados** por competição
- **Histórico de clubes** com os períodos em cada um
- **Desempenho por temporada:** jogos, vitórias, empates e derrotas
- **Mercado de trabalho:** propostas de emprego de outros clubes e seleções, com salário mensal. Dá para **aceitar** uma proposta ou **pedir demissão** do clube atual.

---

## 10. Partida e Imprensa 🟡

### 10.1 Partida
Tela de jogo com o placar, o cronômetro e a lista de **acontecimentos** (gols com jogador e minuto). O botão **Próximo** avança o jogo.

### 10.2 Entrevista coletiva
Após o jogo, um repórter faz uma pergunta e você escolhe entre **respostas** de tons diferentes (autocrítica, elogio ao grupo, evasiva). O botão **Próximo** avança. A escolha serve de base para as notícias de imprensa e deve influenciar a reputação e a diretoria.

---

## 11. Mecânicas e conceitos do jogo

Resumo dos sistemas que conectam as telas:

- **Orçamento:** dinheiro disponível para contratar, melhorar o clube e pagar salários. Cresce com receitas (bilheteria, patrocínio, vendas) e com pedidos à diretoria.
- **Confiança da diretoria:** sobe com bons resultados e cai com derrotas, eliminações e atrasos de salário. Libera ou bloqueia as ações de carreira.
- **Reputação:** existe para o clube (0–100) e para o técnico (Iniciante → Lenda). Afeta patrocinadores e propostas de emprego.
- **Jogadores:** cada um tem overall, potencial, atributos, moral, satisfação, contrato, valor e multa de rescisão. Pode estar **"on fire"**, lesionado ou fora de forma.
- **Moral e satisfação:** influenciam se o jogador aceita sair ou chegar ao clube.
- **Lesões:** têm gravidade (leve, moderada ou grave) e tempo de recuperação. O Departamento Médico e o treino de Recuperação Física ajudam.
- **Competições:** pontos corridos, mata-mata ou mistas; com nível nacional, continental ou estadual; prêmio fixo e por vitória; fases (oitavas, quartas, semi e final) e eliminação.
- **Partidas:** têm rodada, data, horário, local, status (agendada, em andamento ou finalizada) e placar.
- **Notícias:** de **mercado** (movimentações gerais) e de **imprensa** (sobre o seu clube).

---

## 12. Estado atual do desenvolvimento

| Área | Situação |
|---|---|
| Criação da carreira | ✅ Completa |
| Painel inicial (elenco, tabela, notícias) | ✅ Integrado à API |
| Próximos jogos | 🟡 Endpoint pronto, falta ligar ao `inicio.php` |
| Demais telas (Clube, Negociação, Calendário, Treino, Diretoria, Carreira, Partida, Imprensa) | 🟡 Interface pronta com dados de exemplo |
| Salvar progresso do jogo | 🗄️ Hoje só a sessão do navegador guarda a carreira |

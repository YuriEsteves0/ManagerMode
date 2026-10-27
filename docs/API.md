# API do ManagerMode — Referência de Endpoints

API REST (Spring Boot) que alimenta o jogo **ManagerMode.com**. Esta referência lista todos os endpoints, seus parâmetros, os formatos de resposta e exemplos.

---

## Sumário

- [Convenções gerais](#convenções-gerais)
- [Enums](#enums)
- [Clubes](#clubes)
- [Competições](#competições)
- [Jogadores](#jogadores)
- [Partidas](#partidas)
- [Manager (técnico)](#manager-técnico)
- [Propostas de emprego](#propostas-de-emprego)
- [Notícias](#notícias)
- [Patrocínios](#patrocínios)
- [Treinos](#treinos)
- [Upgrades](#upgrades)
- [Erros](#erros)
- [Observações e pontos de atenção](#observações-e-pontos-de-atenção)
- [Resumo dos endpoints](#resumo-dos-endpoints)

---

## Convenções gerais

| Item | Valor |
|---|---|
| URL base (desenvolvimento) | `http://localhost:8080` |
| Formato | JSON (`Content-Type: application/json`) |
| Autenticação | Nenhuma |
| Métodos | `GET` em todos os endpoints, exceto `POST /manager/criar` |
| Datas (`LocalDate`) | `yyyy-MM-dd`, ex.: `2026-10-21` |
| Horários (`LocalTime`) | `HH:mm:ss`, ex.: `16:00:00` |
| Data e hora (`LocalDateTime`) | `yyyy-MM-ddTHH:mm:ss`, ex.: `2026-10-21T14:30:00` |
| Valores monetários | Números decimais (`Float`), em reais, ex.: `22400000.0` |
| Foto/escudo | Caminho relativo, ex.: `img/escudosClubes/brasileiraoSerieA/bahia.png` |

Exemplo de chamada:

```bash
curl -H "Accept: application/json" http://localhost:8080/clubes/1
```

> **Atenção:** o campo identificador do clube varia conforme o endpoint. Em respostas "planas" o campo é `idClube`; em objetos `Clube` **aninhados** (partidas, treino, metas e ações da diretoria) o campo é `id`. Veja [Observações](#observações-e-pontos-de-atenção).

---

## Enums

| Enum | Valores |
|---|---|
| `TipoCompeticao` | `PONTOS_CORRIDOS`, `MATA_MATA`, `MISTO` |
| `NivelCompeticao` | `NACIONAL`, `CONTINENTAL`, `ESTADUAL` |
| `StatusCompeticao` | `NAO_INICIADA`, `EM_ANDAMENTO`, `FINALIZADA` |
| `FaseAtual` | `OITAVAS`, `QUARTAS`, `SEMI`, `FINAL` |
| `StatusConfianca` | `PESSIMO`, `INSTAVEL`, `ESTAVEL`, `EXCELENTE` |
| `PosicaoPrincipal` | `GOL`, `ZAG`, `LD`, `LE`, `VOL`, `MC`, `MEI`, `PD`, `PE`, `ATA` |
| `Gravidade` (lesão) | `LEVE`, `MODERADO`, `GRAVE` |
| `StatusPartida` | `AGENDADA`, `EM_ANDAMENTO`, `FINALIZADA` |
| `StatusProposta` (transferência) | `PENDENTE`, `ACEITA`, `RECUSADA`, `CANCELADA` |
| `Status` (proposta de emprego) | `PENDENTE`, `ACEITO`, `RECUSADO` |
| `Reputacao` (manager) | `INICIANTE`, `PROMISSOR`, `RENOMANDO`, `LENDA` |
| `StatusAcao` (ação da diretoria) | `DISPONIVEL`, `EM_ANALISE`, `CONCLUIDO` |
| `Status` (meta da temporada) | `DENTRO_DO_ESPERADO`, `ABAIXO_DO_ESPERADO`, `CONCLUIDO`, `FALHOU` |
| `TipoModificador` (notícia da diretoria) | `SOMA`, `SUBTRACAO` |
| `Categoria` (notícia) | `MERCADO`, `IMPRENSA` |
| `TipoUpgrade` | `ESTADIO`, `GRAMADO_DM`, `CENTRO_TREINAMENTO`, `MEGALOJA`, `MARKETING` |

---

## Clubes

### `GET /clubes/{id}`

Busca os dados completos de um clube.

**Parâmetros de rota**

| Nome | Tipo | Descrição |
|---|---|---|
| `id` | Integer | ID do clube |

**Resposta `200`** — objeto `ClubeResponse`

| Campo | Tipo | Descrição |
|---|---|---|
| `idClube` | Integer | Identificador do clube |
| `nomeClube` | String | Nome do clube |
| `orcamento` | Float | Orçamento disponível para gastos |
| `valorClube` | Long | Valor de mercado do clube |
| `camisasVendidas` | Integer | Quantidade de camisas vendidas |
| `qntTorcedores` | Integer | Quantidade de torcedores |
| `reputacao` | Integer | Reputação de 0 a 100 |
| `patrocinador_idPatrocinador` | Integer \| null | ID do patrocinador atual (`null` se não houver) |
| `confiancaDiretoria` | Integer | Confiança da diretoria no técnico (0 a 100) |
| `statusConfianca` | `StatusConfianca` | Status derivado da confiança |
| `eventoAtual` | String \| null | Evento atual que afeta a confiança |
| `capacidadeEstadio` | Integer | Capacidade do estádio |
| `foto` | String | Caminho do escudo |
| `nomeEstadio` | String | Nome do estádio |

**Exemplo**

```json
{
  "idClube": 1,
  "nomeClube": "Palmeiras",
  "orcamento": 22400000.0,
  "valorClube": 850000000,
  "camisasVendidas": 180000,
  "qntTorcedores": 18000000,
  "reputacao": 82,
  "patrocinador_idPatrocinador": 4,
  "confiancaDiretoria": 65,
  "statusConfianca": "ESTAVEL",
  "eventoAtual": "Boa gestão",
  "capacidadeEstadio": 43000,
  "foto": "img/escudosClubes/brasileiraoSerieA/palmeiras.png",
  "nomeEstadio": "Allianz Parque"
}
```

**Erros:** clube inexistente lança `RuntimeException("Clube não encontrado!")` (resposta `500`).

---

### `GET /clubes/{id}/patrocinador`

Retorna apenas o nome do patrocinador atual do clube.

**Parâmetros de rota:** `id` (Integer) — ID do clube.

**Resposta `200`**

```json
{
  "nomePatrocinador": "Nike"
}
```

Se o clube não existir ou não tiver patrocinador, o corpo vem vazio (o endpoint não devolve `404`).

---

### `GET /clubes/{id}/estatisticasAno`

Histórico de estatísticas do clube, uma linha por temporada/registro.

**Parâmetros de rota:** `id` (Integer) — ID do clube.

**Resposta `200`** — lista de `EstatisticaAnoClubeResponse`

| Campo | Tipo | Descrição |
|---|---|---|
| `idEstatisticasAnoClube` | Integer | ID do registro |
| `ano` | Integer | Ano da temporada |
| `jogos` | Integer | Jogos disputados |
| `vitorias` | Integer | Vitórias |
| `empates` | Integer | Empates |
| `derrotas` | Integer | Derrotas |
| `golsFeitos` | Integer | Gols marcados |
| `golsSofridos` | Integer | Gols sofridos |
| `clubeId` | Integer | ID do clube |

**Exemplo**

```json
[
  {
    "idEstatisticasAnoClube": 12,
    "ano": 2025,
    "jogos": 38,
    "vitorias": 22,
    "empates": 8,
    "derrotas": 8,
    "golsFeitos": 64,
    "golsSofridos": 35,
    "clubeId": 1
  }
]
```

---

### `GET /clubes/{id}/estatisticasAno/{ano}`

Estatísticas do clube em um ano específico. Se houver mais de um registro no mesmo ano (várias competições), os valores são **somados** em um único resultado.

**Parâmetros de rota**

| Nome | Tipo | Descrição |
|---|---|---|
| `id` | Integer | ID do clube |
| `ano` | Integer | Ano (ex.: `2026`) |

**Resposta `200`** — um `EstatisticaAnoClubeResponse` (mesmos campos do endpoint anterior). Se não houver registro para o ano, o corpo vem vazio (`null`).

**Exemplo**

```json
{
  "idEstatisticasAnoClube": 15,
  "ano": 2026,
  "jogos": 12,
  "vitorias": 7,
  "empates": 3,
  "derrotas": 2,
  "golsFeitos": 21,
  "golsSofridos": 10,
  "clubeId": 1
}
```

---

### `GET /clubes/{id}/upgrades`

Lista os upgrades do clube, unindo os dados do upgrade ao progresso do clube (nível atual).

**Parâmetros de rota:** `id` (Integer) — ID do clube.

**Resposta `200`** — lista de `ClubeHasUpgradeResponse`

| Campo | Tipo | Descrição |
|---|---|---|
| `idUpgrade` | Integer | ID do upgrade |
| `nomeUpgrade` | String | Nome do upgrade |
| `preco` | Float | Preço base (o custo do próximo nível é `preco × (nivelAtual + 1)` no front) |
| `tipoUpgrade` | `TipoUpgrade` | Tipo do upgrade |
| `descricao` | String | Descrição do efeito |
| `modificador` | Float | Bônus por nível (ex.: `0.05` = 5% por nível) |
| `nivelAtual` | Integer | Nível atual do clube |
| `nivelMaximo` | Integer | Nível máximo |

**Exemplo**

```json
[
  {
    "idUpgrade": 1,
    "nomeUpgrade": "Estádio",
    "preco": 2000000.0,
    "tipoUpgrade": "ESTADIO",
    "descricao": "Aumenta a capacidade e a receita de bilheteria.",
    "modificador": 0.05,
    "nivelAtual": 2,
    "nivelMaximo": 5
  }
]
```

---

### `GET /clubes/{id}/transferencias`

Lista as propostas de transferência de um clube, conforme o ponto de vista.

**Parâmetros**

| Nome | Local | Tipo | Obrigatório | Descrição |
|---|---|---|---|---|
| `id` | rota | Integer | sim | ID do clube |
| `tipoTransferencia` | query | String | sim | `enviada` ou `recebida` (também aceita `enviadas` / `recebidas`; não diferencia maiúsculas) |

- **enviada:** propostas feitas **pelo** clube, interessado em jogadores de outros clubes.
- **recebida:** propostas feitas por outros clubes **por jogadores** do clube.

**Resposta `200`** — lista de `PropostaTransferenciaResponse`

| Campo | Tipo | Descrição |
|---|---|---|
| `idPropostaTransferencia` | Integer | ID da proposta |
| `valorOferecido` | Float | Valor oferecido |
| `statusProposta` | `StatusProposta` | Situação da proposta |
| `revelado` | Boolean | Se a proposta já foi revelada ao jogador |
| `idJogador` | Integer | ID do jogador envolvido |
| `jogador` | [`JogadoresResponse`](#modelo-jogadoresresponse) | Dados do jogador |
| `idClubeExterior` | Integer \| null | ID do clube proponente |
| `clubeExterior` | `ClubeResponse` \| null | Clube proponente |
| `idClubeInterior` | Integer \| null | ID do clube dono do jogador |
| `clubeInterior` | `ClubeResponse` \| null | Clube dono do jogador |

**Exemplo** (`GET /clubes/1/transferencias?tipoTransferencia=recebida`)

```json
[
  {
    "idPropostaTransferencia": 7,
    "valorOferecido": 35000000.0,
    "statusProposta": "PENDENTE",
    "revelado": true,
    "idJogador": 101,
    "jogador": {
      "idJogador": 101,
      "nomeJogador": "Rafael Moura",
      "numeroCamisa": 9,
      "idade": 24,
      "posicaoPrincipal": "ATA",
      "overall": 82,
      "velocidade": 84,
      "forca": 76,
      "inteligencia": 78,
      "finalizacao": 85,
      "marcacao": 40,
      "passe": 70,
      "potencial": 88,
      "titular": 0,
      "moral": 80,
      "nacionalidade": "Brasileiro",
      "dispEmprestimo": false,
      "satisfacao": 74,
      "onfire": true,
      "valor": 40000000.0,
      "valorRescisao": 120000000.0,
      "salario": 450000.0,
      "tempoContrato": 30,
      "clubeIdClube": 1,
      "posicaoX": 80.0,
      "posicaoY": 50.0
    },
    "idClubeExterior": 5,
    "clubeExterior": {
      "idClube": 5,
      "nomeClube": "Flamengo",
      "orcamento": 90000000.0,
      "valorClube": 1200000000,
      "camisasVendidas": 300000,
      "qntTorcedores": 40000000,
      "reputacao": 90,
      "patrocinador_idPatrocinador": 2,
      "confiancaDiretoria": 70,
      "statusConfianca": "ESTAVEL",
      "eventoAtual": null,
      "capacidadeEstadio": 78000,
      "foto": "img/escudosClubes/brasileiraoSerieA/flamengo.png",
      "nomeEstadio": "Maracanã"
    },
    "idClubeInterior": 1,
    "clubeInterior": {
      "idClube": 1,
      "nomeClube": "Palmeiras",
      "orcamento": 22400000.0,
      "valorClube": 850000000,
      "camisasVendidas": 180000,
      "qntTorcedores": 18000000,
      "reputacao": 82,
      "patrocinador_idPatrocinador": 4,
      "confiancaDiretoria": 65,
      "statusConfianca": "ESTAVEL",
      "eventoAtual": "Boa gestão",
      "capacidadeEstadio": 43000,
      "foto": "img/escudosClubes/brasileiraoSerieA/palmeiras.png",
      "nomeEstadio": "Allianz Parque"
    }
  }
]
```

**Erros:** `400 Bad Request` quando `tipoTransferencia` não é `enviada`/`recebida` (mensagem: `tipoTransferencia deve ser 'enviada' ou 'recebida'`).

---

### `GET /clubes/{id}/treino`

Treinos escolhidos pelo clube, com o slot ocupado em cada um.

**Parâmetros de rota:** `id` (Integer) — ID do clube.

**Resposta `200`** — lista de `ClubeHasTreinoResponse`

| Campo | Tipo | Descrição |
|---|---|---|
| `idClube` | Integer | ID do clube |
| `clube` | `Clube` (entidade) | Clube completo (usa `id`, não `idClube`) |
| `idTreino` | Integer | ID do treino |
| `treino` | [`Treino`](#get-treinos) | Treino escolhido |
| `slot` | Integer | Posição do treino no plano semanal |

**Exemplo**

```json
[
  {
    "idClube": 1,
    "clube": {
      "id": 1,
      "nomeClube": "Palmeiras",
      "orcamento": 22400000.0,
      "valorClube": 850000000,
      "camisasVendidas": 180000,
      "qntTorcedores": 18000000,
      "reputacao": 82,
      "patrocinador_idPatrocinador": 4,
      "confiancaDiretoria": 65,
      "statusConfianca": "ESTAVEL",
      "eventoAtual": "Boa gestão",
      "capacidadeEstadio": 43000,
      "foto": "img/escudosClubes/brasileiraoSerieA/palmeiras.png",
      "nomeEstadio": "Allianz Parque"
    },
    "idTreino": 3,
    "treino": {
      "idTreino": 3,
      "nomeTreino": "Treino Físico",
      "descTreino": "Melhora velocidade e força do elenco.",
      "intensidade": 3,
      "data": null
    },
    "slot": 1
  }
]
```

---

### `GET /clubes/{id}/metaTemporada`

Metas da temporada do clube e o andamento de cada uma.

**Parâmetros de rota:** `id` (Integer) — ID do clube.

**Resposta `200`** — lista de `ClubeHasMetaTemporadaResponse`

| Campo | Tipo | Descrição |
|---|---|---|
| `idClube` | Integer | ID do clube |
| `clube` | `Clube` (entidade) | Clube completo (usa `id`) |
| `idMetaTemporada` | Integer | ID da meta |
| `metaTemporada` | `{ idMetaTemporada, descricao }` | Meta |
| `status` | `Status` (meta) | `DENTRO_DO_ESPERADO`, `ABAIXO_DO_ESPERADO`, `CONCLUIDO` ou `FALHOU` |

**Exemplo** (campo `clube` abreviado)

```json
[
  {
    "idClube": 1,
    "clube": { "id": 1, "nomeClube": "Palmeiras", "...": "..." },
    "idMetaTemporada": 2,
    "metaTemporada": {
      "idMetaTemporada": 2,
      "descricao": "Terminar entre os 4 primeiros do Brasileirão"
    },
    "status": "DENTRO_DO_ESPERADO"
  }
]
```

---

### `GET /clubes/{idClube}/noticiasDiretoria`

Recados da diretoria para o clube, do mais recente para o mais antigo (`dataRegistro` decrescente).

**Parâmetros de rota:** `idClube` (Integer) — ID do clube.

**Resposta `200`** — lista de `NoticiaDiretoriaResponse`

| Campo | Tipo | Descrição |
|---|---|---|
| `idNoticia` | Integer | ID do recado |
| `texto` | String | Texto do recado |
| `dataRegistro` | LocalDate | Data do recado |
| `idClube` | Integer | ID do clube |
| `modificador` | Integer | Quanto a confiança varia (em %) |
| `tipoModificador` | `TipoModificador` | `SOMA` (aumenta) ou `SUBTRACAO` (reduz) |

**Exemplo**

```json
[
  {
    "idNoticia": 31,
    "texto": "A diretoria aprovou a goleada no clássico.",
    "dataRegistro": "2026-10-20",
    "idClube": 1,
    "modificador": 5,
    "tipoModificador": "SOMA"
  }
]
```

---

### `GET /clubes/{idClube}/acaoDiretoria`

Ações de carreira que o técnico pode solicitar à diretoria. A lista é ordenada por `statusAcao`.

**Parâmetros de rota:** `idClube` (Integer) — ID do clube.

**Resposta `200`** — lista de `ClubeHasAcaoDiretoriaResponse`

| Campo | Tipo | Descrição |
|---|---|---|
| `idClube` | Integer | ID do clube |
| `clube` | `Clube` (entidade) | Clube completo (usa `id`) |
| `idAcaoDiretoria` | Integer | ID da ação |
| `acaoDiretoria` | `{ idAcaoDiretoria, titulo, requisito, efeito }` | Dados da ação |
| `statusAcao` | `StatusAcao` | `DISPONIVEL`, `EM_ANALISE` ou `CONCLUIDO` |

**Exemplo** (campo `clube` abreviado)

```json
[
  {
    "idClube": 1,
    "clube": { "id": 1, "nomeClube": "Palmeiras", "...": "..." },
    "idAcaoDiretoria": 1,
    "acaoDiretoria": {
      "idAcaoDiretoria": 1,
      "titulo": "Pedir reforços",
      "requisito": "Confiança acima de 60%",
      "efeito": "Libera orçamento extra para contratações"
    },
    "statusAcao": "DISPONIVEL"
  }
]
```

> O percentual mínimo de confiança aparece dentro do texto de `requisito` (ex.: "60%"); o front extrai esse número para decidir se o botão fica bloqueado.

---

## Competições

### `GET /competicoes`

Lista as competições cadastradas, com filtro opcional por tipo.

**Parâmetros**

| Nome | Local | Tipo | Obrigatório | Descrição |
|---|---|---|---|---|
| `tipo` | query | `TipoCompeticao` | não | `PONTOS_CORRIDOS`, `MATA_MATA` ou `MISTO`. Sem o filtro, retorna todas |

**Resposta `200`** — lista de competições

| Campo | Tipo | Descrição |
|---|---|---|
| `idCompeticao` | Integer | ID da competição |
| `nomeCompeticao` | String | Nome |
| `valorPremio` | Float | Prêmio total |
| `premioPorVitoria` | Float | Prêmio por vitória |
| `tipoCompeticao` | `TipoCompeticao` | Tipo |
| `nivelCompeticao` | `NivelCompeticao` | Nível |
| `ano` | Integer | Ano da edição |
| `statusCompeticao` | `StatusCompeticao` | Situação |

**Exemplo** (`GET /competicoes?tipo=PONTOS_CORRIDOS`)

```json
[
  {
    "idCompeticao": 1,
    "nomeCompeticao": "Brasileirão Série A",
    "valorPremio": 50000000.0,
    "premioPorVitoria": 500000.0,
    "tipoCompeticao": "PONTOS_CORRIDOS",
    "nivelCompeticao": "NACIONAL",
    "ano": 2026,
    "statusCompeticao": "EM_ANDAMENTO"
  }
]
```

---

### `GET /competicoes/{id}`

Busca uma competição pelo ID.

**Parâmetros de rota:** `id` (Integer) — ID da competição.

**Resposta `200`** — mesmos campos de um item de `GET /competicoes`.

```json
{
  "idCompeticao": 1,
  "nomeCompeticao": "Brasileirão Série A",
  "valorPremio": 50000000.0,
  "premioPorVitoria": 500000.0,
  "tipoCompeticao": "PONTOS_CORRIDOS",
  "nivelCompeticao": "NACIONAL",
  "ano": 2026,
  "statusCompeticao": "EM_ANDAMENTO"
}
```

Se a competição não existir, o corpo vem vazio.

---

### `GET /competicoes/{id}/clubes`

Clubes participantes de uma competição, em formato resumido (usado na seleção de clube do cadastro).

**Parâmetros de rota:** `id` (Integer) — ID da competição.

**Resposta `200`**

| Campo | Tipo | Descrição |
|---|---|---|
| `idClube` | Integer | ID do clube |
| `nomeClube` | String | Nome |
| `foto` | String | Caminho do escudo |
| `orcamento` | Float | Orçamento disponível |

```json
[
  {
    "idClube": 1,
    "nomeClube": "Palmeiras",
    "foto": "img/escudosClubes/brasileiraoSerieA/palmeiras.png",
    "orcamento": 22400000.0
  },
  {
    "idClube": 2,
    "nomeClube": "Bahia",
    "foto": "img/escudosClubes/brasileiraoSerieA/bahia.png",
    "orcamento": 15000000.0
  }
]
```

---

### `GET /competicoes/{id}/classificacao`

Tabela de classificação, em ordem **decrescente de pontos** (o líder vem primeiro).

**Parâmetros de rota:** `id` (Integer) — ID da competição.

**Resposta `200`**

| Campo | Tipo | Descrição |
|---|---|---|
| `clube_idClube` | Integer | ID do clube |
| `nomeClube` | String | Nome do clube |
| `competicao_idCompeticao` | Integer | ID da competição |
| `pontos` | Integer | Pontos acumulados |
| `faseAtual` | `FaseAtual` \| null | Fase atual (relevante em mata-mata) |

```json
[
  {
    "clube_idClube": 1,
    "nomeClube": "Palmeiras",
    "competicao_idCompeticao": 1,
    "pontos": 28,
    "faseAtual": null
  },
  {
    "clube_idClube": 5,
    "nomeClube": "Flamengo",
    "competicao_idCompeticao": 1,
    "pontos": 26,
    "faseAtual": null
  }
]
```

---

## Jogadores

### Modelo `JogadoresResponse`

Usado em `/jogadores/clube/{id}` e dentro das propostas de transferência.

| Campo | Tipo | Descrição |
|---|---|---|
| `idJogador` | Integer | ID do jogador |
| `nomeJogador` | String | Nome |
| `numeroCamisa` | Integer | Número da camisa |
| `idade` | Integer | Idade em anos |
| `posicaoPrincipal` | `PosicaoPrincipal` | Posição principal |
| `overall` | Integer | Nível geral |
| `velocidade` | Integer | Atributo de velocidade |
| `forca` | Integer | Atributo de força |
| `inteligencia` | Integer | Atributo de inteligência |
| `finalizacao` | Integer | Atributo de finalização |
| `marcacao` | Integer | Atributo de marcação |
| `passe` | Integer | Atributo de passe |
| `potencial` | Integer | Overall máximo que pode atingir |
| `titular` | Integer | Situação na escalação (convenção do front: `0` titular, `1` reserva, `2` não relacionado) |
| `moral` | Integer | Moral (0 a 100) |
| `nacionalidade` | String | Nacionalidade |
| `dispEmprestimo` | Boolean | Disponível para empréstimo |
| `satisfacao` | Integer | Satisfação com o clube (0 a 100) |
| `onfire` | Boolean | Em grande fase |
| `valor` | Float | Valor de mercado |
| `valorRescisao` | Float | Multa rescisória |
| `salario` | Float | Salário mensal |
| `tempoContrato` | Integer | Meses restantes de contrato |
| `clubeIdClube` | Integer | ID do clube do jogador |
| `posicaoX` | Float | Coordenada X no campo tático |
| `posicaoY` | Float | Coordenada Y no campo tático |

---

### `GET /jogadores/clube/{clube_idClube}`

Lista os jogadores de um clube.

**Parâmetros**

| Nome | Local | Tipo | Obrigatório | Descrição |
|---|---|---|---|---|
| `clube_idClube` | rota | Integer | sim | ID do clube |
| `todos` | query | Boolean | **sim** | `true`: todo o elenco. `false`: apenas jogadores com `titular` falso (veja [Observações](#observações-e-pontos-de-atenção)) |

**Resposta `200`** — lista de [`JogadoresResponse`](#modelo-jogadoresresponse)

**Exemplo** (`GET /jogadores/clube/1?todos=true`)

```json
[
  {
    "idJogador": 101,
    "nomeJogador": "Rafael Moura",
    "numeroCamisa": 9,
    "idade": 24,
    "posicaoPrincipal": "ATA",
    "overall": 82,
    "velocidade": 84,
    "forca": 76,
    "inteligencia": 78,
    "finalizacao": 85,
    "marcacao": 40,
    "passe": 70,
    "potencial": 88,
    "titular": 0,
    "moral": 80,
    "nacionalidade": "Brasileiro",
    "dispEmprestimo": false,
    "satisfacao": 74,
    "onfire": true,
    "valor": 40000000.0,
    "valorRescisao": 120000000.0,
    "salario": 450000.0,
    "tempoContrato": 30,
    "clubeIdClube": 1,
    "posicaoX": 80.0,
    "posicaoY": 50.0
  }
]
```

**Erros:** `400 Bad Request` se o parâmetro `todos` for omitido.

---

### `GET /jogadores/overall`

Todos os jogadores do jogo ranqueados por **overall** (maior para o menor). Jogadores com lesão ativa **não** entram na lista. Usado no mercado.

**Parâmetros:** nenhum.

**Resposta `200`** — lista de `JogadoresResponse.comClube`: os mesmos campos de [`JogadoresResponse`](#modelo-jogadoresresponse), acrescidos de `nomeClube` (String), posicionado logo após `clubeIdClube`.

**Exemplo**

```json
[
  {
    "idJogador": 230,
    "nomeJogador": "Bruno Tavares",
    "numeroCamisa": 10,
    "idade": 27,
    "posicaoPrincipal": "MEI",
    "overall": 89,
    "velocidade": 78,
    "forca": 70,
    "inteligencia": 92,
    "finalizacao": 80,
    "marcacao": 55,
    "passe": 90,
    "potencial": 89,
    "titular": 0,
    "moral": 85,
    "nacionalidade": "Brasileiro",
    "dispEmprestimo": false,
    "satisfacao": 80,
    "onfire": false,
    "valor": 95000000.0,
    "valorRescisao": 250000000.0,
    "salario": 900000.0,
    "tempoContrato": 36,
    "clubeIdClube": 5,
    "nomeClube": "Flamengo",
    "posicaoX": 52.0,
    "posicaoY": 50.0
  }
]
```

---

### `GET /jogadores/clube/{clube_idClube}/estatisticas`

Estatísticas de todos os jogadores de um clube, ordenadas por nome do jogador e, dentro de cada jogador, do ano mais recente para o mais antigo.

**Parâmetros de rota:** `clube_idClube` (Integer) — ID do clube.

**Resposta `200`** — lista de `EstatisticasJogadorCompeticaoResponse`

| Campo | Tipo | Descrição |
|---|---|---|
| `idJogador` | Integer | ID do jogador |
| `nomeJogador` | String | Nome |
| `nomeCompeticao` | String | Competição |
| `ano` | Integer | Ano |
| `jogos` | Integer | Jogos disputados |
| `gols` | Integer | Gols |
| `assistencias` | Integer | Assistências |
| `notaMedia` | Integer | Nota média |

```json
[
  {
    "idJogador": 101,
    "nomeJogador": "Rafael Moura",
    "nomeCompeticao": "Brasileirão Série A",
    "ano": 2026,
    "jogos": 12,
    "gols": 9,
    "assistencias": 3,
    "notaMedia": 7
  }
]
```

---

### `GET /jogador/{id}/estatistica`

Estatísticas de **um** jogador em todas as competições que disputou. Resposta no mesmo formato de `EstatisticasJogadorCompeticaoResponse` (acima).

**Parâmetros de rota:** `id` (Integer) — ID do jogador.

> Este endpoint possui `@CrossOrigin(origins = "http://localhost")`.

```json
[
  {
    "idJogador": 101,
    "nomeJogador": "Rafael Moura",
    "nomeCompeticao": "Brasileirão Série A",
    "ano": 2026,
    "jogos": 12,
    "gols": 9,
    "assistencias": 3,
    "notaMedia": 7
  }
]
```

---

### `GET /jogador/competicao/{id}/estatistica`

Estatísticas de todos os jogadores de uma **competição**, ordenadas por **gols** (maior para o menor), ou seja, a artilharia. Mesmo formato de `EstatisticasJogadorCompeticaoResponse`.

**Parâmetros de rota:** `id` (Integer) — ID da **competição** (e não do jogador).

```json
[
  {
    "idJogador": 101,
    "nomeJogador": "Rafael Moura",
    "nomeCompeticao": "Brasileirão Série A",
    "ano": 2026,
    "jogos": 12,
    "gols": 9,
    "assistencias": 3,
    "notaMedia": 7
  },
  {
    "idJogador": 230,
    "nomeJogador": "Bruno Tavares",
    "nomeCompeticao": "Brasileirão Série A",
    "ano": 2026,
    "jogos": 12,
    "gols": 6,
    "assistencias": 8,
    "notaMedia": 8
  }
]
```

---

### `GET /jogadores/clube/{clube_idClube}/lesoes`

Lesões de todos os jogadores de um clube (departamento médico).

**Parâmetros de rota:** `clube_idClube` (Integer) — ID do clube.

**Resposta `200`** — lista de `LesaoJogadorResponse`

| Campo | Tipo | Descrição |
|---|---|---|
| `idJogador` | Integer | ID do jogador lesionado |
| `idLesao` | Integer | ID da lesão |
| `nomeLesao` | String | Nome da lesão |
| `tempoLesionado` | Integer | Tempo de afastamento (o front exibe em dias) |
| `gravidade` | `Gravidade` | `LEVE`, `MODERADO` ou `GRAVE` |

```json
[
  {
    "idJogador": 101,
    "idLesao": 4,
    "nomeLesao": "Entorse no tornozelo",
    "tempoLesionado": 21,
    "gravidade": "MODERADO"
  }
]
```

---

### `GET /jogador/{id}/lesoes`

Lesões de um jogador específico. Retorna lista vazia se ele não estiver lesionado.

**Parâmetros de rota:** `id` (Integer) — ID do jogador.

**Resposta `200`** — lista de `LesaoResponse`

| Campo | Tipo | Descrição |
|---|---|---|
| `idLesao` | Integer | ID da lesão |
| `nomeLesao` | String | Nome |
| `tempoLesionado` | Integer | Tempo de afastamento |
| `gravidade` | `Gravidade` | Gravidade |

```json
[
  {
    "idLesao": 4,
    "nomeLesao": "Entorse no tornozelo",
    "tempoLesionado": 21,
    "gravidade": "MODERADO"
  }
]
```

---

## Partidas

### `GET /partidas/clube/{idClube}/proximosJogos`

Próximas partidas de um clube (como mandante ou visitante), ordenadas por data e horário. Retorna **no máximo 4** partidas, todas com data **posterior** à informada.

**Parâmetros**

| Nome | Local | Tipo | Obrigatório | Descrição |
|---|---|---|---|---|
| `idClube` | rota | Integer | sim | ID do clube |
| `dataPartida` | query | LocalDate | sim | Data de referência (`yyyy-MM-dd`). Só entram partidas **depois** dela |

**Resposta `200`**

| Campo | Tipo | Descrição |
|---|---|---|
| `idPartida` | Integer | ID da partida |
| `rodada` | Integer | Número da rodada |
| `mandanteIdClube` | Integer | ID do mandante |
| `nomeMandante` | String | Nome do mandante |
| `visitanteIdClube` | Integer | ID do visitante |
| `nomeVisitante` | String | Nome do visitante |
| `local` | String | Local da partida |
| `nomeEstadio` | String | Estádio do mandante |
| `dataPartida` | LocalDate | Data |
| `horario` | LocalTime | Horário |

**Exemplo** (`GET /partidas/clube/1/proximosJogos?dataPartida=2026-10-21`)

```json
[
  {
    "idPartida": 310,
    "rodada": 28,
    "mandanteIdClube": 1,
    "nomeMandante": "Palmeiras",
    "visitanteIdClube": 2,
    "nomeVisitante": "Bahia",
    "local": "São Paulo - SP",
    "nomeEstadio": "Allianz Parque",
    "dataPartida": "2026-10-25",
    "horario": "16:00:00"
  }
]
```

**Erros:** `400 Bad Request` se `dataPartida` for omitida ou estiver em formato inválido.

---

### `GET /partidas/clube/{idClube}/proximosJogosCalendario`

Todas as partidas futuras de um clube (sem limite de quantidade), com os dados completos dos clubes. Usado no Calendário.

**Parâmetros:** os mesmos de `/proximosJogos` (`idClube` na rota e `dataPartida` obrigatório na query; só partidas **depois** da data).

**Resposta `200`** — lista de `PartidaResponse`

| Campo | Tipo | Descrição |
|---|---|---|
| `idPartida` | Integer | ID da partida |
| `golsMandante` | Integer \| null | Gols do mandante |
| `golsVisitante` | Integer \| null | Gols do visitante |
| `rodada` | Integer | Rodada |
| `dataPartida` | LocalDate | Data |
| `statusPartida` | `StatusPartida` | `AGENDADA`, `EM_ANDAMENTO` ou `FINALIZADA` |
| `visitanteIdClube` | Integer | ID do visitante |
| `clubeVisitante` | `Clube` (entidade) | Visitante completo (usa `id`) |
| `mandanteIdClube` | Integer | ID do mandante |
| `clubeMandante` | `Clube` (entidade) | Mandante completo (usa `id`) |
| `horario` | LocalTime | Horário |
| `local` | String | Local |
| `competicaoIdCompeticao` | Integer | ID da competição |

**Exemplo**

```json
[
  {
    "idPartida": 310,
    "golsMandante": null,
    "golsVisitante": null,
    "rodada": 28,
    "dataPartida": "2026-10-25",
    "statusPartida": "AGENDADA",
    "visitanteIdClube": 2,
    "clubeVisitante": {
      "id": 2,
      "nomeClube": "Bahia",
      "orcamento": 15000000.0,
      "valorClube": 300000000,
      "camisasVendidas": 60000,
      "qntTorcedores": 9000000,
      "reputacao": 68,
      "patrocinador_idPatrocinador": null,
      "confiancaDiretoria": 50,
      "statusConfianca": "ESTAVEL",
      "eventoAtual": null,
      "capacidadeEstadio": 48000,
      "foto": "img/escudosClubes/brasileiraoSerieA/bahia.png",
      "nomeEstadio": "Arena Fonte Nova"
    },
    "mandanteIdClube": 1,
    "clubeMandante": {
      "id": 1,
      "nomeClube": "Palmeiras",
      "orcamento": 22400000.0,
      "valorClube": 850000000,
      "camisasVendidas": 180000,
      "qntTorcedores": 18000000,
      "reputacao": 82,
      "patrocinador_idPatrocinador": 4,
      "confiancaDiretoria": 65,
      "statusConfianca": "ESTAVEL",
      "eventoAtual": "Boa gestão",
      "capacidadeEstadio": 43000,
      "foto": "img/escudosClubes/brasileiraoSerieA/palmeiras.png",
      "nomeEstadio": "Allianz Parque"
    },
    "horario": "16:00:00",
    "local": "São Paulo - SP",
    "competicaoIdCompeticao": 1
  }
]
```

---

## Manager (técnico)

### `GET /manager/{id}`

Dados de um técnico.

**Parâmetros de rota:** `id` (Integer) — ID do manager.

**Resposta `200`** — `ManagerResponse`

| Campo | Tipo | Descrição |
|---|---|---|
| `idManager` | Integer | ID do técnico |
| `nomeManager` | String | Nome |
| `nacionalidade` | String | Nacionalidade |
| `foto` | String | Caminho da foto |
| `reputacao` | `Reputacao` | `INICIANTE`, `PROMISSOR`, `RENOMANDO` ou `LENDA` |
| `exp` | Integer | Experiência |
| `contratoFim` | Integer | Ano de fim do contrato |
| `idClube` | Integer | ID do clube atual |

```json
{
  "idManager": 1,
  "nomeManager": "Carlos Mendes",
  "nacionalidade": "brasileiro",
  "foto": "img/rostosManagers/manager-2.jpg",
  "reputacao": "INICIANTE",
  "exp": 0,
  "contratoFim": 2027,
  "idClube": 1
}
```

Se o técnico não existir, o corpo vem vazio.

---

### `GET /manager/{idManager}/titulos`

Títulos conquistados pelo técnico.

**Parâmetros de rota:** `idManager` (Integer).

**Resposta `200`** — lista de `TituloTecnicoResponse`

| Campo | Tipo | Descrição |
|---|---|---|
| `idManager` | Integer | ID do técnico |
| `nomeManager` | String | Nome do técnico |
| `idCompeticao` | Integer | ID da competição vencida |
| `nomeCompeticao` | String | Nome da competição |
| `ano` | Integer | Ano da conquista |

```json
[
  {
    "idManager": 1,
    "nomeManager": "Carlos Mendes",
    "idCompeticao": 1,
    "nomeCompeticao": "Brasileirão Série A",
    "ano": 2027
  }
]
```

---

### `GET /manager/{idManager}/historico`

Histórico de clubes comandados, do ano mais recente para o mais antigo.

**Parâmetros de rota:** `idManager` (Integer).

**Resposta `200`** — lista de `HistoricoManagerResponse`

| Campo | Tipo | Descrição |
|---|---|---|
| `idManager` | Integer | ID do técnico |
| `nomeManager` | String | Nome do técnico |
| `idClube` | Integer | ID do clube |
| `nomeClube` | String | Nome do clube |
| `foto` | String | Escudo do clube |
| `ano` | Integer | Ano da passagem |

```json
[
  {
    "idManager": 1,
    "nomeManager": "Carlos Mendes",
    "idClube": 1,
    "nomeClube": "Palmeiras",
    "foto": "img/escudosClubes/brasileiraoSerieA/palmeiras.png",
    "ano": 2026
  }
]
```

---

### `POST /manager/criar`

Cria um novo técnico (usado no fim do cadastro de carreira).

**Corpo da requisição** — `ManagerRequest`

| Campo | Tipo | Obrigatório | Descrição |
|---|---|---|---|
| `nomeManager` | String | sim | Nome do técnico |
| `nacionalidade` | String | sim | Ex.: `brasileiro`, `portugues`, `espanhol` |
| `foto` | String | sim | Caminho da foto, ex.: `img/rostosManagers/manager-1.jpg` |
| `reputacao` | `Reputacao` | sim | Valor inicial usado pelo jogo: `INICIANTE` |
| `exp` | Integer | sim | Experiência inicial (o jogo envia `0`) |
| `contratoFim` | Integer | sim | Ano de fim do contrato (o jogo envia `2027`) |
| `idClube` | Integer | sim | ID do clube do técnico |

**Exemplo de requisição**

```bash
curl -X POST http://localhost:8080/manager/criar \
  -H "Content-Type: application/json" \
  -d '{
    "nomeManager": "Carlos Mendes",
    "nacionalidade": "brasileiro",
    "foto": "img/rostosManagers/manager-2.jpg",
    "reputacao": "INICIANTE",
    "exp": 0,
    "contratoFim": 2027,
    "idClube": 1
  }'
```

**Resposta `201 Created`** — `ManagerResponse` com o `idManager` gerado

```json
{
  "idManager": 1,
  "nomeManager": "Carlos Mendes",
  "nacionalidade": "brasileiro",
  "foto": "img/rostosManagers/manager-2.jpg",
  "reputacao": "INICIANTE",
  "exp": 0,
  "contratoFim": 2027,
  "idClube": 1
}
```

---

## Propostas de emprego

### `GET /propostas-emprego`

Lista **todas** as propostas de emprego cadastradas, de todos os managers.

**Parâmetros:** nenhum.

**Resposta `200`** — lista de `PropostaEmpregoResponse`

| Campo | Tipo | Descrição |
|---|---|---|
| `idPropostaEmprego` | Integer | ID da proposta |
| `salarioOferecido` | Double | Salário mensal oferecido |
| `status` | `Status` | `PENDENTE`, `ACEITO` ou `RECUSADO` |
| `clube` | `ClubeResponse` | Clube que fez a proposta (campos do [`GET /clubes/{id}`](#get-clubesid)) |
| `manager` | Integer | ID do manager que recebeu a proposta |

```json
[
  {
    "idPropostaEmprego": 3,
    "salarioOferecido": 150000.0,
    "status": "PENDENTE",
    "clube": {
      "idClube": 2,
      "nomeClube": "Bahia",
      "orcamento": 15000000.0,
      "valorClube": 300000000,
      "camisasVendidas": 60000,
      "qntTorcedores": 9000000,
      "reputacao": 68,
      "patrocinador_idPatrocinador": null,
      "confiancaDiretoria": 50,
      "statusConfianca": "ESTAVEL",
      "eventoAtual": null,
      "capacidadeEstadio": 48000,
      "foto": "img/escudosClubes/brasileiraoSerieA/bahia.png",
      "nomeEstadio": "Arena Fonte Nova"
    },
    "manager": 1
  }
]
```

---

### `GET /propostas-emprego/{idManager}`

Propostas de emprego recebidas por um manager. Mesmo formato do endpoint anterior; retorna lista vazia (`[]`) se o manager não tiver propostas.

**Parâmetros de rota:** `idManager` (Integer).

---

## Notícias

### `GET /noticias`

Lista as **5 notícias mais recentes** de uma categoria, da mais recente para a mais antiga (`dataPublicacao` decrescente).

**Parâmetros**

| Nome | Local | Tipo | Obrigatório | Descrição |
|---|---|---|---|---|
| `categoria` | query | `Categoria` | **sim** | `IMPRENSA` ou `MERCADO` |
| `idClube` | query | Integer | só para `IMPRENSA` | Clube cujas notícias de imprensa serão listadas. Ignorado em `MERCADO` |

**Resposta `200`** — lista com até 5 `NoticiaResponse`

| Campo | Tipo | Descrição |
|---|---|---|
| `idNoticia` | Integer | ID da notícia |
| `titulo` | String | Título |
| `categoria` | `Categoria` | Categoria |
| `dataPublicacao` | LocalDateTime | Data e hora de publicação |
| `clubeIdClube` | Integer \| null | Clube relacionado |

**Exemplo** (`GET /noticias?categoria=IMPRENSA&idClube=1`)

```json
[
  {
    "idNoticia": 55,
    "titulo": "Torcida elogia a postura do técnico após a vitória no clássico",
    "categoria": "IMPRENSA",
    "dataPublicacao": "2026-10-21T14:30:00",
    "clubeIdClube": 1
  }
]
```

**Exemplo** (`GET /noticias?categoria=MERCADO`)

```json
[
  {
    "idNoticia": 60,
    "titulo": "Flamengo prepara oferta por atacante do Palmeiras",
    "categoria": "MERCADO",
    "dataPublicacao": "2026-10-20T09:10:00",
    "clubeIdClube": null
  }
]
```

**Erros:** `400 Bad Request` se `categoria` for omitida ou inválida.

---

### `GET /noticiasDiretoria`

Lista **todos** os recados da diretoria, de todos os clubes (sem ordenação definida). Mesmo formato de [`GET /clubes/{idClube}/noticiasDiretoria`](#get-clubesidclubenoticiasdiretoria).

**Parâmetros:** nenhum.

```json
[
  {
    "idNoticia": 31,
    "texto": "A diretoria aprovou a goleada no clássico.",
    "dataRegistro": "2026-10-20",
    "idClube": 1,
    "modificador": 5,
    "tipoModificador": "SOMA"
  }
]
```

---

## Patrocínios

### `GET /patrocinios`

Lista todas as propostas de patrocínio disponíveis no jogo.

**Parâmetros:** nenhum.

**Resposta `200`** — lista de `PatrocinadorResponse`

| Campo | Tipo | Descrição |
|---|---|---|
| `idPatrocinador` | Integer | ID do patrocinador |
| `nomePatrocinador` | String | Nome |
| `descricao` | String | Descrição da empresa |
| `duracao` | Integer | Duração do contrato, em meses |
| `valorMensal` | Float | Valor pago ao clube por mês |
| `multaRescisao` | Float | Multa de rescisão |
| `foto` | String | Caminho do logo |

```json
[
  {
    "idPatrocinador": 4,
    "nomePatrocinador": "Nike",
    "descricao": "Fornecedora global de material esportivo.",
    "duracao": 24,
    "valorMensal": 1500000.0,
    "multaRescisao": 8000000.0,
    "foto": "img/patrocinadores/nike.png"
  }
]
```

---

## Treinos

### `GET /treinos`

Catálogo geral de treinos disponíveis.

**Parâmetros:** nenhum.

**Resposta `200`** — lista de `TreinoResponse`

| Campo | Tipo | Descrição |
|---|---|---|
| `idTreino` | Integer | ID do treino |
| `nomeTreino` | String | Nome |
| `descTreino` | String | Descrição |
| `intensidade` | Integer | Intensidade do treino |
| `data` | LocalDate \| null | Data associada ao treino |

```json
[
  {
    "idTreino": 3,
    "nomeTreino": "Treino Físico",
    "descTreino": "Melhora velocidade e força do elenco.",
    "intensidade": 3,
    "data": null
  }
]
```

---

## Upgrades

### `GET /upgrades`

Catálogo geral de upgrades. Para ver o **nível** dos upgrades que um clube já possui, use [`GET /clubes/{id}/upgrades`](#get-clubesidupgrades).

**Parâmetros:** nenhum.

**Resposta `200`** — lista de `UpgradeResponse`

| Campo | Tipo | Descrição |
|---|---|---|
| `idUpgrade` | Integer | ID do upgrade |
| `nomeUpgrade` | String | Nome |
| `preco` | Float | Preço base |
| `tipoUpgrade` | `TipoUpgrade` | Tipo |
| `descricao` | String | Descrição |
| `modificador` | Float | Efeito aplicado ao clube por nível |
| `nivelMaximo` | Integer | Nível máximo |

```json
[
  {
    "idUpgrade": 1,
    "nomeUpgrade": "Estádio",
    "preco": 2000000.0,
    "tipoUpgrade": "ESTADIO",
    "descricao": "Aumenta a capacidade e a receita de bilheteria.",
    "modificador": 0.05,
    "nivelMaximo": 5
  }
]
```

---

## Erros

A API não define um formato próprio de erro. Os erros seguem o padrão do Spring Boot:

```json
{
  "timestamp": "2026-10-26T12:00:00.000+00:00",
  "status": 400,
  "error": "Bad Request",
  "path": "/clubes/1/transferencias"
}
```

| Status | Quando ocorre |
|---|---|
| `200 OK` | Consulta bem-sucedida |
| `201 Created` | Técnico criado em `POST /manager/criar` |
| `400 Bad Request` | Parâmetro obrigatório ausente (`todos`, `dataPartida`, `categoria`, `tipoTransferencia`), valor inválido de enum/data, ou `tipoTransferencia` diferente de `enviada`/`recebida` |
| `404 Not Found` | Rota inexistente |
| `500 Internal Server Error` | Erro não tratado, como `GET /clubes/{id}` com ID inexistente |

---

## Observações e pontos de atenção

1. **`id` vs `idClube`.** Respostas planas de clube (`/clubes/{id}`, propostas de transferência e de emprego, listagem de clubes da competição) usam `idClube`. Já o objeto `Clube` aninhado em `PartidaResponse`, `ClubeHasTreinoResponse`, `ClubeHasMetaTemporadaResponse` e `ClubeHasAcaoDiretoriaResponse` é a entidade JPA e usa `id`.
2. **`GET /jogadores/clube/{id}?todos=false`.** O filtro aplicado é `titular` falso. A documentação do código descreve o resultado como "reservas", enquanto um comentário no controller diz "titulares". Como o campo `titular` é numérico (o front usa `0` titular, `1` reserva, `2` não relacionado), vale confirmar qual valor a consulta realmente seleciona.
3. **Datas "posteriores".** Os dois endpoints de partidas usam `dataPartida > data informada` (estritamente depois). Um jogo marcado para a própria data de referência não é retornado.
4. **Respostas vazias.** Endpoints que retornam `Optional` (`/clubes/{id}/patrocinador`, `/competicoes/{id}`, `/manager/{id}`) não devolvem `404` quando não encontram o registro; o corpo vem vazio. O mesmo vale para `/clubes/{id}/estatisticasAno/{ano}`.
5. **`statusConfianca`.** A API usa `PESSIMO`, `INSTAVEL`, `ESTAVEL` e `EXCELENTE`; a tela de Diretoria do front mapeia textos para `ESTAVEL`, `ALTA`, `BAIXA` e `CRITICA`. Os valores precisam ser alinhados.
6. **Somente leitura.** Exceto `POST /manager/criar`, a API apenas consulta dados. Ações como aceitar proposta, melhorar upgrade, assinar patrocínio, confirmar treino e solicitar ação à diretoria ainda não têm endpoint de escrita.
7. **Paginação e filtros.** Nenhum endpoint de listagem é paginado; filtros e paginação do mercado são feitos no front sobre o resultado de `/jogadores/overall`.

---

## Resumo dos endpoints

| Método | Rota | Descrição |
|---|---|---|
| GET | `/clubes/{id}` | Dados completos do clube |
| GET | `/clubes/{id}/patrocinador` | Nome do patrocinador atual |
| GET | `/clubes/{id}/estatisticasAno` | Estatísticas por temporada |
| GET | `/clubes/{id}/estatisticasAno/{ano}` | Estatísticas de um ano |
| GET | `/clubes/{id}/upgrades` | Upgrades do clube e níveis |
| GET | `/clubes/{id}/transferencias?tipoTransferencia=` | Propostas enviadas/recebidas |
| GET | `/clubes/{id}/treino` | Treinos escolhidos pelo clube |
| GET | `/clubes/{id}/metaTemporada` | Metas da temporada |
| GET | `/clubes/{idClube}/noticiasDiretoria` | Recados da diretoria do clube |
| GET | `/clubes/{idClube}/acaoDiretoria` | Ações de carreira da diretoria |
| GET | `/competicoes?tipo=` | Lista de competições |
| GET | `/competicoes/{id}` | Dados de uma competição |
| GET | `/competicoes/{id}/clubes` | Clubes da competição |
| GET | `/competicoes/{id}/classificacao` | Tabela de classificação |
| GET | `/jogadores/clube/{id}?todos=` | Jogadores do clube |
| GET | `/jogadores/overall` | Ranking de jogadores por overall |
| GET | `/jogadores/clube/{id}/estatisticas` | Estatísticas dos jogadores do clube |
| GET | `/jogadores/clube/{id}/lesoes` | Lesões do clube |
| GET | `/jogador/{id}/estatistica` | Estatísticas de um jogador |
| GET | `/jogador/{id}/lesoes` | Lesões de um jogador |
| GET | `/jogador/competicao/{id}/estatistica` | Artilharia da competição |
| GET | `/partidas/clube/{idClube}/proximosJogos?dataPartida=` | Próximas 4 partidas |
| GET | `/partidas/clube/{idClube}/proximosJogosCalendario?dataPartida=` | Todas as partidas futuras |
| GET | `/manager/{id}` | Dados do técnico |
| GET | `/manager/{idManager}/titulos` | Títulos do técnico |
| GET | `/manager/{idManager}/historico` | Histórico de clubes do técnico |
| POST | `/manager/criar` | Cria um técnico |
| GET | `/propostas-emprego` | Todas as propostas de emprego |
| GET | `/propostas-emprego/{idManager}` | Propostas de emprego do técnico |
| GET | `/noticias?categoria=&idClube=` | Últimas 5 notícias da categoria |
| GET | `/noticiasDiretoria` | Todos os recados da diretoria |
| GET | `/patrocinios` | Propostas de patrocínio |
| GET | `/treinos` | Catálogo de treinos |
| GET | `/upgrades` | Catálogo de upgrades |

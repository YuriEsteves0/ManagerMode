package com.manager.api.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.manager.api.requests.ClubeHasAcaoDiretoriaRequest;
import com.manager.api.requests.ClubeHasTreinoRequest;
import com.manager.api.requests.ClubeHasUpgradeRequest;
import com.manager.api.responses.ClubeCompeticaoResponse;
import com.manager.api.responses.ClubeHasAcaoDiretoriaResponse;
import com.manager.api.responses.ClubeHasMetaTemporadaResponse;
import com.manager.api.responses.ClubeHasTreinoResponse;
import com.manager.api.responses.ClubeHasUpgradeResponse;
import com.manager.api.responses.ClubeResponse;
import com.manager.api.responses.EstatisticaAnoClubeResponse;
import com.manager.api.responses.NoticiaDiretoriaResponse;
import com.manager.api.responses.PatrocinadorResponse;
import com.manager.api.responses.PropostaTransferenciaResponse;
import com.manager.api.responses.UpgradeResponse;
import com.manager.api.service.ClubeCompeticaoService;
import com.manager.api.service.ClubeHasAcaoDiretoriaService;
import com.manager.api.service.ClubeHasMetaTemporadaService;
import com.manager.api.service.ClubeHasTreinoService;
import com.manager.api.service.ClubeHasUpgradeService;
import com.manager.api.service.ClubeService;
import com.manager.api.service.EstatisticasAnoClubeService;
import com.manager.api.service.NoticiaDiretoriaService;
import com.manager.api.service.PatrocinadorService;
import com.manager.api.service.PropostaTransferenciaService;

import org.springframework.web.bind.annotation.RequestBody;
import jakarta.validation.Valid;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "Clubes", description = "Dados, finanças, upgrades, treinos, metas e diretoria de um clube")
@RestController
public class ClubeController {

    private final ClubeService clubeService;
    private final PatrocinadorService patrocinadorService;
    private final EstatisticasAnoClubeService estatisticasAnoClubeService;
    private final ClubeHasUpgradeService clubeHasUpgradeService;
    private final PropostaTransferenciaService propostaTransferenciaService;
    private final ClubeHasTreinoService clubeHasTreinoService;
    private final ClubeHasMetaTemporadaService clubeHasMetaTemporadaService;
    private final NoticiaDiretoriaService noticiaDiretoriaService;
    private final ClubeHasAcaoDiretoriaService clubeAcaoDiretoriaService;

    public ClubeController(ClubeService clubeService, PatrocinadorService patrocinadorService, EstatisticasAnoClubeService estatisticasAnoClubeService, ClubeHasUpgradeService clubeHasUpgradeService, PropostaTransferenciaService propostaTransferenciaService, ClubeHasTreinoService clubeHasTreinoService, ClubeHasMetaTemporadaService clubeHasMetaTemporadaService, NoticiaDiretoriaService noticiaDiretoriaService, ClubeHasAcaoDiretoriaService clubeAcaoDiretoriaService) {
        this.clubeService = clubeService; 
        this.patrocinadorService = patrocinadorService;
        this.estatisticasAnoClubeService = estatisticasAnoClubeService;
        this.clubeHasUpgradeService = clubeHasUpgradeService;
        this.propostaTransferenciaService= propostaTransferenciaService;
        this.clubeHasTreinoService = clubeHasTreinoService;
        this.clubeHasMetaTemporadaService=clubeHasMetaTemporadaService;
        this.noticiaDiretoriaService = noticiaDiretoriaService;
        this.clubeAcaoDiretoriaService =clubeAcaoDiretoriaService;
    }

    /**
     * Busca os dados completos de um clube a partir do seu identificador.
     * <p>
     * Retorna as informações gerais do clube, como orçamento, valor de mercado,
     * reputação, torcida, patrocinador, estádio e o nível de confiança da diretoria.
     * </p>
     *
     * @param id Parâmetro usado como id do clube que será consultado
     * @return {@link ClubeResponse} refletindo os dados do clube, contendo:
     * 	<ul>
     * 		<li>Nome, foto e dados do estádio (nome e capacidade)</li>
     * 		<li>Dados financeiros (orçamento, valor do clube e camisas vendidas)</li>
     * 		<li>Dados de torcida e reputação (quantidade de torcedores e reputação)</li>
     * 		<li>Patrocinador atual (pode ser <strong>null</strong> caso não haja patrocinador)</li>
     * 		<li>Dados da diretoria (confiança, status de confiança e evento atual)</li>
     * 	</ul>
     * @throws RuntimeException caso nenhum clube seja encontrado com o <strong>id</strong> informado
     */
    @Operation(summary = "Busca um clube por ID", description = "Retorna os dados completos do clube: finanças, torcida, reputação, estádio, patrocinador e confiança da diretoria.")
    @Parameter(name = "id", description = "ID do clube", example = "1")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Clube encontrado")
    })
    @GetMapping("/clubes/{id}")
    public ClubeResponse buscarClubePorId(@PathVariable Integer id) {
        return clubeService.buscarClube(id);
    }
    
    /**
     * Busca o nome do patrocinador atual de um clube.
     *
     * @param id Parâmetro usado como id do clube que será consultado
     * @return {@link Optional} de {@link PatrocinadorResponse.Nome} contendo apenas o nome do patrocinador.
     * 	Retorna vazio caso o clube não exista ou não possua patrocinador
     */
    @Operation(summary = "Busca o patrocinador atual do clube", description = "Retorna apenas o nome do patrocinador. O corpo vem vazio se o clube não existir ou não tiver patrocinador.")
    @Parameter(name = "id", description = "ID do clube", example = "1")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Nome do patrocinador (ou corpo vazio)")
    })
    @GetMapping("/clubes/{id}/patrocinador")
    public Optional<PatrocinadorResponse.Nome> patrocinadorDoClubeNome(@PathVariable Integer id){
    	return patrocinadorService.buscarPorClube(id);
    }
    
    /**
     * Lista o histórico de estatísticas de um clube, ano a ano.
     * <p>
     * Cada item representa uma temporada do clube, com a campanha daquele ano.
     * </p>
     *
     * @param id Parâmetro usado como id do clube que será consultado
     * @return Lista de {@link EstatisticaAnoClubeResponse} contendo, por ano:
     * 	<ul>
     * 		<li>Jogos disputados</li>
     * 		<li>Vitórias, empates e derrotas</li>
     * 		<li>Gols feitos e gols sofridos</li>
     * 	</ul>
     */
    @Operation(summary = "Lista o histórico de estatísticas por ano", description = "Cada item é uma temporada do clube, com jogos, vitórias, empates, derrotas, gols feitos e gols sofridos.")
    @Parameter(name = "id", description = "ID do clube", example = "1")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Estatísticas por ano")
    })
    @GetMapping("/clubes/{id}/estatisticasAno")
    public List<EstatisticaAnoClubeResponse> listarEstatisticasAnoClube(@PathVariable Integer id){
    	return estatisticasAnoClubeService.listarEstatisticasAnoClube(id);
    }
    
    /**
     * Busca as estatísticas de um clube em um ano específico.
     * <p>
     * Caso o clube tenha mais de um registro no mesmo ano (ex: várias competições),
     * os valores são <strong>somados</strong> e retornados como um único resultado.
     * </p>
     *
     * @param id Parâmetro usado como id do clube que será consultado
     * @param ano Parâmetro usado como ano (temporada) das estatísticas. Ex: 2026
     * @return {@link EstatisticaAnoClubeResponse} com jogos, vitórias, empates, derrotas,
     * 	gols feitos e gols sofridos do ano informado.
     * 	Retorna <strong>null</strong> caso não exista nenhum registro para o clube naquele ano
     */
    @Operation(summary = "Busca as estatísticas de um ano", description = "Se o clube tiver mais de um registro no ano (várias competições), os valores são somados. O corpo vem vazio se não houver registro.")
    @Parameter(name = "id", description = "ID do clube", example = "1")
    @Parameter(name = "ano", description = "Ano (temporada) das estatísticas", example = "2026")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Estatísticas do ano (ou corpo vazio)")
    })
    @GetMapping("/clubes/{id}/estatisticasAno/{ano}")
    public EstatisticaAnoClubeResponse buscarEstatisticaPorClubeEAno(
            @PathVariable Integer id, 
            @PathVariable Integer ano) {
        return estatisticasAnoClubeService.buscarEstatisticaPorClubeEAno(id, ano);
    }
    
    /**
     * Lista todos os upgrades que um clube possui.
     * <p>
     * Une os dados do upgrade (nome, preço, tipo, descrição e modificador) com o
     * progresso do clube nele (nível atual e nível máximo).
     * </p>
     *
     * @param id Parâmetro usado como id do clube que será consultado
     * @return Lista de {@link ClubeHasUpgradeResponse} refletindo os upgrades do clube,
     * 	incluindo o <strong>nivelAtual</strong> e o <strong>nivelMaximo</strong> de cada um
     */
    @Operation(summary = "Lista os upgrades do clube", description = "Une os dados do upgrade (nome, preço, tipo, descrição e modificador) com o progresso do clube (nível atual e máximo).")
    @Parameter(name = "id", description = "ID do clube", example = "1")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Upgrades do clube")
    })
    @GetMapping("/clubes/{id}/upgrades")
    public List<ClubeHasUpgradeResponse> listarUpgradesClube(@PathVariable Integer id){
    	return clubeHasUpgradeService.listarUpgradesClubeComNome(id);
    }
    
    /**
     * Busca um upgrade específico de um clube, com o progresso do clube nele.
     * <p>
     * Mesmo formato de <strong>/clubes/{id}/upgrades</strong>, mas para um único upgrade.
     * </p>
     *
     * @param id Parâmetro usado como id do clube que será consultado
     * @param idUpgrade Parâmetro usado como id do upgrade que será consultado
     * @return {@link Optional} de {@link ClubeHasUpgradeResponse} contendo os dados do upgrade
     * 	(nome, preço, tipo, descrição e modificador) e o <strong>nivelAtual</strong> e o <strong>nivelMaximo</strong> do clube nele.
     * 	Retorna vazio caso o clube não possua o upgrade informado
     */
    @Operation(summary = "Busca um upgrade específico do clube", description = "Mesmo formato de /clubes/{id}/upgrades, mas para um único upgrade. O corpo vem vazio se o clube não possuir o upgrade.")
    @Parameter(name = "id", description = "ID do clube", example = "1")
    @Parameter(name = "idUpgrade", description = "ID do upgrade", example = "1")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Upgrade do clube (ou corpo vazio)")
    })
    @GetMapping("/clubes/{id}/upgrade/{idUpgrade}")
    public Optional<ClubeHasUpgradeResponse> buscarUpgradePorId(@PathVariable Integer id, @PathVariable Integer idUpgrade){
    	return clubeHasUpgradeService.listarUpgradeClubeComNome(id, idUpgrade);
    }
    
    /**
     * Busca todas as transferências (enviadas / recebidas) de um clube, conforme o parâmetro <strong>tipoTransferencia</strong>.
     *
     * @param id Parâmetro usado como id do clube que será consultado
     * @param tipoTransferencia Define o ponto de vista do clube na proposta (não diferencia maiúsculas de minúsculas).
     * 	Pode ser dois tipos:
     * 	<ul>
     * 		<li><strong>Enviada</strong>: propostas feitas pelo clube, interessado em jogadores de outros clubes</li>
     * 		<li><strong>Recebida</strong>: propostas feitas por outros clubes por jogadores do clube</li>
     * 	</ul>
     * @return Lista de {@link PropostaTransferenciaResponse} refletindo os dados da proposta de transferência
     * 	(valor oferecido, status, jogador envolvido e clubes de origem e destino)
     * @throws ResponseStatusException com status <strong>400 (Bad Request)</strong> caso o
     * 	<strong>tipoTransferencia</strong> não seja "enviada" nem "recebida"
     */
    @Operation(summary = "Lista as transferências do clube", description = "Retorna as propostas de transferência enviadas (o clube quer jogadores de outros clubes) ou recebidas (outros clubes querem jogadores do clube).")
    @Parameter(name = "id", description = "ID do clube", example = "1")
    @Parameter(name = "tipoTransferencia", description = "Ponto de vista do clube na proposta: 'enviada' ou 'recebida' (não diferencia maiúsculas de minúsculas)", example = "enviada")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Propostas de transferência"),
        @ApiResponse(responseCode = "400", description = "tipoTransferencia diferente de 'enviada' e 'recebida'", content = @Content)
    })
    @GetMapping("/clubes/{id}/transferencias")
    public List<PropostaTransferenciaResponse> listarTransferencias(
    		@PathVariable Integer id,
    		@RequestParam String tipoTransferencia) {
    	return propostaTransferenciaService.transferencia(id, tipoTransferencia);
    }
    
    /**
     * Lista os treinos configurados para um clube.
     * <p>
     * Cada item representa um treino ocupando um <strong>slot</strong> do clube.
     * </p>
     *
     * @param id Parâmetro usado como id do clube que será consultado
     * @return Lista de {@link ClubeHasTreinoResponse} contendo, por treino:
     * 	<ul>
     * 		<li>Dados do clube</li>
     * 		<li>ID e dados do treino (nome, descrição, intensidade e data)</li>
     * 		<li>Slot ocupado pelo treino</li>
     * 	</ul>
     */
    @Operation(summary = "Lista os treinos configurados do clube", description = "Cada item é um treino ocupando um slot do clube.")
    @Parameter(name = "id", description = "ID do clube", example = "1")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Treinos do clube")
    })
    @GetMapping("/clubes/{id}/treino")
    public List<ClubeHasTreinoResponse> listarTreinos(@PathVariable Integer id){
    	return clubeHasTreinoService.buscarPorClube(id);
    }
    
    /**
     * Lista as metas de temporada de um clube, com o andamento de cada uma.
     *
     * @param id Parâmetro usado como id do clube que será consultado
     * @return Lista de {@link ClubeHasMetaTemporadaResponse} contendo, por meta:
     * 	<ul>
     * 		<li>Dados do clube</li>
     * 		<li>ID e descrição da meta</li>
     * 		<li>Status da meta (dentro do esperado, abaixo do esperado, concluída ou falhou)</li>
     * 	</ul>
     */
    @Operation(summary = "Lista as metas de temporada do clube", description = "Retorna cada meta com o seu status (dentro do esperado, abaixo do esperado, concluída ou falhou).")
    @Parameter(name = "id", description = "ID do clube", example = "1")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Metas do clube")
    })
    @GetMapping("/clubes/{id}/metaTemporada")
    public List<ClubeHasMetaTemporadaResponse> listarMetas(@PathVariable Integer id){
    	return clubeHasMetaTemporadaService.buscarClube(id);
    }
    
    /**
     * Lista as notícias da diretoria de um clube.
     * <p>
     * O resultado vem ordenado pela data de registro, da mais recente para a mais antiga.
     * Para listar as notícias de <strong>todos</strong> os clubes, use <strong>/noticiasDiretoria</strong>.
     * </p>
     *
     * @param idClube Parâmetro usado como id do clube que será consultado
     * @return Lista de {@link NoticiaDiretoriaResponse} contendo, por notícia:
     * 	<ul>
     * 		<li>ID, texto e data de registro</li>
     * 		<li>ID do clube relacionado</li>
     * 		<li>Modificador e seu tipo (soma ou subtração)</li>
     * 	</ul>
     */
    @Operation(summary = "Lista as notícias da diretoria de um clube", description = "Ordenadas pela data de registro, da mais recente para a mais antiga. Para todos os clubes, use /noticiasDiretoria.")
    @Parameter(name = "idClube", description = "ID do clube", example = "1")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Notícias da diretoria")
    })
    @GetMapping("/clubes/{idClube}/noticiasDiretoria")
	public List<NoticiaDiretoriaResponse> listarPorClube(@PathVariable Integer idClube) {
		return noticiaDiretoriaService.buscarPorClube(idClube);
	}
    
    /**
     * Lista as ações da diretoria de um clube, com o status de cada uma.
     * <p>
     * O resultado vem ordenado pelo status da ação.
     * </p>
     *
     * @param idClube Parâmetro usado como id do clube que será consultado
     * @return Lista de {@link ClubeHasAcaoDiretoriaResponse} contendo, por ação:
     * 	<ul>
     * 		<li>Dados do clube</li>
     * 		<li>ID e dados da ação (título, requisito e efeito)</li>
     * 		<li>Status da ação (disponível, em análise ou concluída)</li>
     * 	</ul>
     */
    @Operation(summary = "Lista as ações da diretoria de um clube", description = "Ordenadas pelo status da ação (disponível, em análise ou concluída).")
    @Parameter(name = "idClube", description = "ID do clube", example = "1")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Ações da diretoria")
    })
    @GetMapping("/clubes/{idClube}/acaoDiretoria")
    public List<ClubeHasAcaoDiretoriaResponse> listarAcoes(@PathVariable Integer idClube){
    	return clubeAcaoDiretoriaService.listarAcoesClube(idClube);
    }
    
    /**
     * Atualiza o nível de um upgrade que o clube já possui.
     * <p>
     * O novo nível precisa estar entre <strong>0</strong> e o <strong>nivelMaximo</strong> do upgrade,
     * e <strong>não pode ser menor</strong> que o nível atual do clube (upgrades só sobem).
     * </p>
     *
     * @param idClube Parâmetro usado como id do clube dono do upgrade
     * @param idUpgrade Parâmetro usado como id do upgrade que será atualizado
     * @param request {@link ClubeHasUpgradeRequest} no corpo da requisição, contendo o novo <strong>nivelAtual</strong>
     * @return {@link ResponseEntity} com status <strong>200 (OK)</strong> e o {@link ClubeHasUpgradeResponse} já atualizado.
     * 	Retorna <strong>404 (Not Found)</strong> caso o clube não possua o upgrade informado
     * @throws ResponseStatusException com status <strong>400 (Bad Request)</strong> caso o nível esteja fora do intervalo
     * 	permitido ou seja menor que o nível atual, ou <strong>404 (Not Found)</strong> caso o upgrade não exista
     */
    @Operation(summary = "Atualiza o nível de um upgrade do clube", description = "O novo nível precisa estar entre 0 e o nível máximo do upgrade e não pode ser menor que o nível atual (upgrades só sobem).")
    @Parameter(name = "idClube", description = "ID do clube dono do upgrade", example = "1")
    @Parameter(name = "idUpgrade", description = "ID do upgrade a ser atualizado", example = "1")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Upgrade atualizado"),
        @ApiResponse(responseCode = "400", description = "Nível fora do intervalo permitido ou menor que o nível atual", content = @Content),
        @ApiResponse(responseCode = "404", description = "Clube não possui o upgrade informado", content = @Content)
    })
    @PutMapping("/clubes/{idClube}/upgrade/{idUpgrade}")
    public ResponseEntity<ClubeHasUpgradeResponse> updateUpgradeClube(
    		@PathVariable Integer idClube,
    		@PathVariable Integer idUpgrade,
    		@RequestBody @Valid ClubeHasUpgradeRequest request) {

    	return clubeHasUpgradeService.updateUpgrade(idClube, idUpgrade, request)
    			.map(ResponseEntity::ok)
    			.orElse(ResponseEntity.notFound().build());
    }
    
    /**
     * Salva os treinos de um clube, <strong>substituindo</strong> a configuração anterior.
     * <p>
     * Todos os treinos atuais do clube são removidos e a lista enviada passa a ser a nova configuração.
     * Tudo acontece em uma única transação: se algo falhar, a configuração anterior é mantida.
     * </p>
     *
     * @param id Parâmetro usado como id do clube que será atualizado
     * @param request {@link ClubeHasTreinoRequest.ClubeTreinosRequest} no corpo da requisição, contendo a lista de treinos,
     * 	cada um com o <strong>idTreino</strong> e o <strong>slot</strong> que ele vai ocupar
     * @return {@link ResponseEntity} com status <strong>204 (No Content)</strong> e sem corpo
     * @throws RuntimeException caso o clube ou algum dos treinos informados não seja encontrado
     */
    @Operation(summary = "Salva os treinos do clube", description = "Substitui toda a configuração anterior: os treinos atuais são removidos e a lista enviada passa a valer. Acontece em uma única transação.")
    @Parameter(name = "id", description = "ID do clube", example = "1")
    @ApiResponses({
        @ApiResponse(responseCode = "204", description = "Treinos salvos (sem corpo)", content = @Content)
    })
    @PutMapping("/clubes/{id}/treino")
    public ResponseEntity<Void> salvarTreino(@PathVariable Integer id, @Valid @RequestBody ClubeHasTreinoRequest.ClubeTreinosRequest request){
    	clubeHasTreinoService.atualizarOuSalvarTreino(id, request);
    	return ResponseEntity.noContent().build();
    }
    
    @PutMapping("/clubes/{id}/acoesDiretoria")
    public ResponseEntity<Void> salvarAcoes(@PathVariable Integer id, @Valid @RequestBody ClubeHasAcaoDiretoriaRequest request){
    	clubeAcaoDiretoriaService.atualizarStatusAcaoDiretoria(id, request);
    	return ResponseEntity.noContent().build();
    }
}
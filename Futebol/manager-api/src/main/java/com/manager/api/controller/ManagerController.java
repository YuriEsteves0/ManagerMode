package com.manager.api.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.manager.api.requests.ManagerRequest;
import com.manager.api.responses.HistoricoManagerResponse;
import com.manager.api.responses.ManagerResponse;
import com.manager.api.responses.TituloTecnicoResponse;
import com.manager.api.service.HistoricoManagerService;
import com.manager.api.service.ManagerService;
import com.manager.api.service.TituloTecnicoService;

import org.springframework.web.bind.annotation.RequestBody;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "Managers", description = "Técnicos, títulos e histórico de passagens")
@RestController
public class ManagerController{
	private ManagerService managerService;
	private TituloTecnicoService tituloService;
	private HistoricoManagerService historicoService;
	
	public ManagerController(ManagerService managerService, TituloTecnicoService tituloService, HistoricoManagerService historicoService) {
		this.managerService = managerService;
		this.tituloService = tituloService;
		this.historicoService = historicoService;
	}
	
	/**
	 * Busca os dados de um manager (técnico) a partir do seu identificador.
	 *
	 * @param id Parâmetro usado como id do manager que será consultado
	 * @return {@link Optional} de {@link ManagerResponse} contendo:
	 * 	<ul>
	 * 		<li>Nome, nacionalidade e foto</li>
	 * 		<li>Reputação e experiência</li>
	 * 		<li>Ano de fim do contrato e clube atual</li>
	 * 	</ul>
	 * 	Retorna vazio caso nenhum manager seja encontrado com o <strong>id</strong> informado
	 */
	@Operation(summary = "Busca um manager por ID", description = "Retorna nome, nacionalidade, foto, reputação, experiência, fim de contrato e clube atual. O corpo vem vazio se não existir.")
	@Parameter(name = "id", description = "ID do manager", example = "1")
	@ApiResponses({
	    @ApiResponse(responseCode = "200", description = "Manager encontrado (ou corpo vazio)")
	})
	@GetMapping("/manager/{id}")
	public Optional<ManagerResponse> buscarDadosManager(@PathVariable Integer id){
		return managerService.buscarDadosManager(id);
	}
	
	/**
	 * Lista os títulos conquistados por um manager.
	 *
	 * @param idManager Parâmetro usado como id do manager que será consultado
	 * @return Lista de {@link TituloTecnicoResponse} contendo, por título:
	 * 	<ul>
	 * 		<li>ID e nome do manager</li>
	 * 		<li>ID e nome da competição vencida</li>
	 * 		<li>Ano da conquista</li>
	 * 	</ul>
	 */
	@Operation(summary = "Lista os títulos de um manager", description = "Competições vencidas e o ano de cada conquista.")
	@Parameter(name = "idManager", description = "ID do manager", example = "1")
	@ApiResponses({
	    @ApiResponse(responseCode = "200", description = "Títulos do manager")
	})
	@GetMapping("/manager/{idManager}/titulos")
	public List<TituloTecnicoResponse> listarTitulosPorManager(@PathVariable Integer idManager){
		return tituloService.listarPorManager(idManager);
	}
	
	/**
	 * Lista o histórico de clubes que um manager já comandou.
	 * <p>
	 * Os resultados vêm ordenados do ano mais recente para o mais antigo.
	 * </p>
	 *
	 * @param idManager Parâmetro usado como id do manager que será consultado
	 * @return Lista de {@link HistoricoManagerResponse} contendo, por passagem:
	 * 	<ul>
	 * 		<li>ID e nome do manager</li>
	 * 		<li>ID, nome e foto (escudo) do clube</li>
	 * 		<li>Ano da passagem</li>
	 * 	</ul>
	 */
	@Operation(summary = "Lista o histórico de clubes de um manager", description = "Clubes que o manager já comandou, do ano mais recente para o mais antigo.")
	@Parameter(name = "idManager", description = "ID do manager", example = "1")
	@ApiResponses({
	    @ApiResponse(responseCode = "200", description = "Histórico do manager")
	})
	@GetMapping("/manager/{idManager}/historico")
	public List<HistoricoManagerResponse> listarHistoricoPorManager(@PathVariable Integer idManager){
		return historicoService.listarPorManager(idManager);
	}
	
	/**
	 * Cria um novo manager (técnico).
	 *
	 * @param request {@link ManagerRequest} no corpo da requisição, contendo:
	 * 	<ul>
	 * 		<li>Nome, nacionalidade e foto</li>
	 * 		<li>Reputação (iniciante, promissor, renomando ou lenda) e experiência</li>
	 * 		<li>Ano de fim do contrato e ID do clube</li>
	 * 	</ul>
	 * @return {@link ResponseEntity} com status <strong>201 (Created)</strong> e o {@link ManagerResponse}
	 * 	do manager criado, já com o <strong>id</strong> gerado
	 */
	@Operation(summary = "Cria um manager", description = "Cria um novo técnico e devolve o registro já com o ID gerado.")
	@ApiResponses({
	    @ApiResponse(responseCode = "201", description = "Manager criado", content = @Content)
	})
	@PostMapping("/manager/criar")
	public ResponseEntity<ManagerResponse> criarManager(@RequestBody ManagerRequest request){
		ManagerResponse criado = managerService.criarManager(request);
		return ResponseEntity.status(HttpStatus.CREATED).body(criado);
	}
}
package com.manager.api.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.manager.api.responses.PropostaEmpregoResponse;
import com.manager.api.service.PropostaEmpregoService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "Propostas de Emprego", description = "Propostas de clubes para managers")
@RestController
public class PropostaEmpregoController {
	private final PropostaEmpregoService service;

	public PropostaEmpregoController(PropostaEmpregoService service) {
		this.service = service;
	}

	/**
	 * Lista todas as propostas de emprego cadastradas, de todos os managers.
	 *
	 * @return Lista de {@link PropostaEmpregoResponse} contendo, por proposta:
	 * 	<ul>
	 * 		<li>ID da proposta e status</li>
	 * 		<li>Salário oferecido</li>
	 * 		<li>Dados completos do clube que fez a proposta ({@link ClubeResponse})</li>
	 * 		<li>ID do manager que recebeu a proposta</li>
	 * 	</ul>
	 */
	@Operation(summary = "Lista todas as propostas de emprego", description = "Propostas de todos os managers, com salário, status e dados do clube interessado.")
	@ApiResponses({
	    @ApiResponse(responseCode = "200", description = "Propostas de emprego")
	})
	@GetMapping("/propostas-emprego")
	public List<PropostaEmpregoResponse> listar() {
		return service.listar();
	}
	
	/**
	 * Lista as propostas de emprego recebidas por um manager específico.
	 *
	 * @param idManager Parâmetro usado como id do manager que será consultado
	 * @return Lista de {@link PropostaEmpregoResponse} refletindo as propostas do manager,
	 * 	com salário oferecido, status e os dados do clube interessado.
	 * 	Retorna uma lista vazia caso o manager não possua propostas
	 */
	@Operation(summary = "Lista as propostas de emprego de um manager", description = "Retorna lista vazia se o manager não tiver propostas.")
	@Parameter(name = "idManager", description = "ID do manager", example = "1")
	@ApiResponses({
	    @ApiResponse(responseCode = "200", description = "Propostas do manager")
	})
	@GetMapping("/propostas-emprego/{idManager}")
	public List<PropostaEmpregoResponse> listarPorManager(@PathVariable Integer idManager) {
		return service.listarPorManager(idManager);
	}
}
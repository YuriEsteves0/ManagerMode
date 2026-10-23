package com.manager.api.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.manager.api.responses.PropostaEmpregoResponse;
import com.manager.api.service.PropostaEmpregoService;

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
	@GetMapping("/propostas-emprego/{idManager}")
	public List<PropostaEmpregoResponse> listarPorManager(@PathVariable Integer idManager) {
		return service.listarPorManager(idManager);
	}
}
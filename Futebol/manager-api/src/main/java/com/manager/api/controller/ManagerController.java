package com.manager.api.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.manager.api.responses.HistoricoManagerResponse;
import com.manager.api.responses.ManagerResponse;
import com.manager.api.responses.TituloTecnicoResponse;
import com.manager.api.service.HistoricoManagerService;
import com.manager.api.service.ManagerService;
import com.manager.api.service.TituloTecnicoService;

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
	@GetMapping("/manager/{idManager}/historico")
	public List<HistoricoManagerResponse> listarHistoricoPorManager(@PathVariable Integer idManager){
		return historicoService.listarPorManager(idManager);
	}
}
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
	
	@GetMapping("/manager/{id}")
	public Optional<ManagerResponse> buscarDadosManager(@PathVariable Integer id){
		return managerService.buscarDadosManager(id);
	}
	
	@GetMapping("/manager/{idManager}/titulos")
	public List<TituloTecnicoResponse> listarTitulosPorManager(@PathVariable Integer idManager){
		return tituloService.listarPorManager(idManager);
	}
	
	@GetMapping("/manager/{idManager}/historico")
	public List<HistoricoManagerResponse> listarHistoricoPorManager(@PathVariable Integer idManager){
		return historicoService.listarPorManager(idManager);
	}
}
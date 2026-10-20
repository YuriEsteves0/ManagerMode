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

	@GetMapping("/propostas-emprego")
	public List<PropostaEmpregoResponse> listar() {
		return service.listar();
	}
	
	@GetMapping("/propostas-emprego/{idManager}")
	public List<PropostaEmpregoResponse> listarPorManager(@PathVariable Integer idManager) {
		return service.listarPorManager(idManager);
	}
}
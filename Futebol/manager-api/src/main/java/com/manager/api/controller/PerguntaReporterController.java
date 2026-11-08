package com.manager.api.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.manager.api.enums.resultado.TipoResultado;
import com.manager.api.model.PerguntasReporter;
import com.manager.api.service.PerguntasReporterService;

@RestController
public class PerguntaReporterController{
	private final PerguntasReporterService perguntasReporterService;
	
	public PerguntaReporterController(PerguntasReporterService perguntasReporterService) {
		this.perguntasReporterService=perguntasReporterService;
	}
	
	@GetMapping("/perguntas")
	public PerguntasReporter buscarPerguntaAleatoria(@RequestParam(required = true) String tipoResultado) {
		return perguntasReporterService.sortearPergunta(tipoResultado);
	}
}
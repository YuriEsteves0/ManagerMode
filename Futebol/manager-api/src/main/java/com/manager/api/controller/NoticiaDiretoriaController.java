package com.manager.api.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.manager.api.responses.NoticiaDiretoriaResponse;
import com.manager.api.service.NoticiaDiretoriaService;

@RestController
public class NoticiaDiretoriaController {
	private final NoticiaDiretoriaService service;

	public NoticiaDiretoriaController(NoticiaDiretoriaService service) {
		this.service = service;
	}

	@GetMapping("/noticiasDiretoria")
	public List<NoticiaDiretoriaResponse> listarTodasNoticias() {
		return service.listarTodas();
	}
}
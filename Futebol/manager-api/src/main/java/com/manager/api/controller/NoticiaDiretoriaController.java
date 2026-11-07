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

	/**
	 * Lista as notícias da diretoria de <strong>todos</strong> os clubes.
	 * <p>
	 * Para listar apenas as notícias de um clube, use <strong>/clubes/{idClube}/noticiasDiretoria</strong>.
	 * </p>
	 *
	 * @return Lista de {@link NoticiaDiretoriaResponse} contendo, por notícia:
	 * 	<ul>
	 * 		<li>ID, texto e data de registro</li>
	 * 		<li>ID do clube relacionado</li>
	 * 		<li>Modificador e seu tipo (soma ou subtração)</li>
	 * 	</ul>
	 */
	@GetMapping("/noticiasDiretoria")
	public List<NoticiaDiretoriaResponse> listarTodasNoticias() {
		return service.listarTodas();
	}
}
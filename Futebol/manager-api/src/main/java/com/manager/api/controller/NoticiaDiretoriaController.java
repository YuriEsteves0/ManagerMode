package com.manager.api.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.manager.api.responses.NoticiaDiretoriaResponse;
import com.manager.api.service.NoticiaDiretoriaService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "Notícias da Diretoria", description = "Notícias da diretoria que afetam a confiança no manager")
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
	@Operation(summary = "Lista as notícias da diretoria de todos os clubes", description = "Para um clube específico, use /clubes/{idClube}/noticiasDiretoria.")
	@ApiResponses({
	    @ApiResponse(responseCode = "200", description = "Notícias da diretoria")
	})
	@GetMapping("/noticiasDiretoria")
	public List<NoticiaDiretoriaResponse> listarTodasNoticias() {
		return service.listarTodas();
	}
}
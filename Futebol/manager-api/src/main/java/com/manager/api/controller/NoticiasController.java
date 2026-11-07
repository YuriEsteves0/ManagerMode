package com.manager.api.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.manager.api.enums.noticia.Categoria;
import com.manager.api.responses.NoticiaResponse;
import com.manager.api.service.NoticiaService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "Notícias", description = "Notícias de imprensa e de mercado")
@RestController
public class NoticiasController {
	private final NoticiaService noticiaService;
	
	public NoticiasController(NoticiaService noticiaService) {
		this.noticiaService = noticiaService;
	}
	
	/**
	 * Lista as 5 notícias mais recentes de uma categoria.
	 * <p>
	 * O resultado vem ordenado pela data de publicação, da mais recente para a mais antiga.
	 * </p>
	 *
	 * @param categoria Parâmetro <strong>obrigatório</strong> do tipo {@link Categoria}, pode ser:
	 * 	<ul>
	 * 		<li><strong>IMPRENSA</strong>: notícias sobre o clube informado em <strong>idClube</strong></li>
	 * 		<li><strong>MERCADO</strong>: notícias gerais do mercado da bola (o <strong>idClube</strong> é ignorado)</li>
	 * 	</ul>
	 * @param idClube Parâmetro usado como id do clube. Necessário apenas para a categoria <strong>IMPRENSA</strong>
	 * @return Lista de até 5 {@link NoticiaResponse} contendo ID, título, categoria, data de publicação e clube relacionado
	 */
	@Operation(summary = "Lista as 5 notícias mais recentes de uma categoria", description = "IMPRENSA traz notícias do clube informado em idClube. MERCADO traz notícias gerais do mercado da bola e ignora idClube.")
	@Parameter(name = "categoria", description = "Categoria das notícias", example = "IMPRENSA")
	@Parameter(name = "idClube", description = "ID do clube. Necessário apenas para a categoria IMPRENSA", example = "1")
	@ApiResponses({
	    @ApiResponse(responseCode = "200", description = "Até 5 notícias, da mais recente para a mais antiga")
	})
	@GetMapping("/noticias")
	public List<NoticiaResponse> listarNoticias(@RequestParam(required = true) Categoria categoria, @RequestParam(required = false) Integer idClube){
		if(categoria == Categoria.IMPRENSA) {
			return noticiaService.listarNoticiasDeImprensa(idClube);
		}else {
			return noticiaService.listarNoticiasDeMercado();
		}
	}
	
}
package com.manager.api.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.manager.api.responses.TreinoResponse;
import com.manager.api.service.TreinoService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "Treinos", description = "Catálogo de treinos")
@RestController
public class TreinoController{
	private final TreinoService treinoService;
	
	public TreinoController(TreinoService treinoService) {
		this.treinoService= treinoService;
	}
	
	/**
	 * Lista todos os treinos disponíveis no jogo.
	 * <p>
	 * Esse é o catálogo geral de treinos. Para ver os treinos que um clube já configurou,
	 * use <strong>/clubes/{id}/treino</strong>.
	 * </p>
	 *
	 * @return Lista de {@link TreinoResponse} contendo:
	 * 	<ul>
	 * 		<li>ID, nome e descrição do treino</li>
	 * 		<li>Intensidade</li>
	 * 		<li>Data</li>
	 * 	</ul>
	 */
	@Operation(summary = "Lista o catálogo de treinos", description = "Catálogo geral. Para os treinos configurados por um clube, use /clubes/{id}/treino.")
	@ApiResponses({
	    @ApiResponse(responseCode = "200", description = "Treinos disponíveis")
	})
	@GetMapping("/treinos")
	public List<TreinoResponse> listarTodos(){
		return treinoService.listarTreinos();
	}
}
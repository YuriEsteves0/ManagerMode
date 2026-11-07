package com.manager.api.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.manager.api.responses.TreinoResponse;
import com.manager.api.service.TreinoService;

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
	@GetMapping("/treinos")
	public List<TreinoResponse> listarTodos(){
		return treinoService.listarTreinos();
	}
}
package com.manager.api.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.manager.api.responses.PatrocinadorResponse;
import com.manager.api.service.PatrocinadorService;

@RestController
public class PatrocinioController{
	private final PatrocinadorService patrocinadorService;
	
	public PatrocinioController(PatrocinadorService patrocinadorService) {
		this.patrocinadorService = patrocinadorService;
	}
	
	/**
	 * Lista todos os patrocínios disponíveis no jogo.
	 *
	 * @return Lista de {@link PatrocinadorResponse} contendo:
	 * 	<ul>
	 * 		<li>ID, nome, descrição e foto do patrocinador</li>
	 * 		<li>Duração do contrato</li>
	 * 		<li>Valor mensal pago ao clube</li>
	 * 		<li>Multa de rescisão</li>
	 * 	</ul>
	 */
	@GetMapping("/patrocinios")
	public List<PatrocinadorResponse> listarPatrocinios(){
		return patrocinadorService.listarPatrocinios();
	}
}
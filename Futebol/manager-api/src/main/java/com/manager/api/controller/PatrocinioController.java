package com.manager.api.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.manager.api.responses.PatrocinadorResponse;
import com.manager.api.service.PatrocinadorService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "Patrocínios", description = "Patrocinadores disponíveis")
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
	@Operation(summary = "Lista os patrocínios disponíveis", description = "Nome, descrição, foto, duração do contrato, valor mensal e multa de rescisão.")
	@ApiResponses({
	    @ApiResponse(responseCode = "200", description = "Patrocínios disponíveis")
	})
	@GetMapping("/patrocinios")
	public List<PatrocinadorResponse> listarPatrocinios(){
		return patrocinadorService.listarPatrocinios();
	}
}
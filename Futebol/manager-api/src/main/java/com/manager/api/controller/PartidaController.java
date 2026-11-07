package com.manager.api.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.manager.api.responses.PartidaResponse;
import com.manager.api.service.PartidaService;

@RestController
public class PartidaController{
	private final PartidaService partidaService;
	
	public PartidaController(PartidaService partidaService) {
		this.partidaService = partidaService;
	}
	
	/**
	 * Lista as próximas partidas de um clube, seja como mandante ou como visitante.
	 * <p>
	 * Retorna no máximo as <strong>4 próximas partidas</strong>, ordenadas por data e horário.
	 * Apenas partidas com data <strong>posterior</strong> à informada são consideradas.
	 * </p>
	 *
	 * @param idClube Parâmetro usado como id do clube que será consultado
	 * @param dataPartida Parâmetro <strong>obrigatório</strong> usado como data de referência (formato yyyy-MM-dd).
	 * 	Ex: 2026-10-21
	 * @return Lista de {@link PartidaResponse.RodadaIdMandanteIdVisitanteLocalEstadioDataHorario} contendo:
	 * 	<ul>
	 * 		<li>ID da partida e rodada</li>
	 * 		<li>ID e nome do mandante e do visitante</li>
	 * 		<li>Local e nome do estádio</li>
	 * 		<li>Data e horário</li>
	 * 	</ul>
	 */
	@GetMapping("/partidas/clube/{idClube}/proximosJogos")
	public List<PartidaResponse.RodadaIdMandanteIdVisitanteLocalEstadioDataHorario> listarProximosJogos(@PathVariable Integer idClube, @RequestParam(required = true) LocalDate dataPartida){
		return partidaService.listarProximasPartidas(idClube, dataPartida);
	}
	
	/**
	 * Lista <strong>todas</strong> as partidas futuras de um clube, seja como mandante ou como visitante.
	 * <p>
	 * Diferente de <strong>/proximosJogos</strong>, não há limite de partidas e o retorno é completo,
	 * pensado para montar o calendário. Apenas partidas com data <strong>posterior</strong> à informada são consideradas,
	 * ordenadas por data e horário.
	 * </p>
	 *
	 * @param idClube Parâmetro usado como id do clube que será consultado
	 * @param dataPartida Parâmetro <strong>obrigatório</strong> usado como data de referência (formato yyyy-MM-dd).
	 * 	Ex: 2026-10-21
	 * @return Lista de {@link PartidaResponse} contendo, por partida:
	 * 	<ul>
	 * 		<li>ID, rodada, data, horário e local</li>
	 * 		<li>Placar (gols do mandante e do visitante) e status da partida</li>
	 * 		<li>Dados completos do mandante e do visitante</li>
	 * 		<li>ID da competição</li>
	 * 	</ul>
	 */
	@GetMapping("/partidas/clube/{idClube}/proximosJogosCalendario")
	public List<PartidaResponse> listarProximosJogosCalendario(@PathVariable Integer idClube, @RequestParam(required = true) LocalDate dataPartida){
		return partidaService.listarProximasPartidasCalendario(idClube, dataPartida);
	}
}
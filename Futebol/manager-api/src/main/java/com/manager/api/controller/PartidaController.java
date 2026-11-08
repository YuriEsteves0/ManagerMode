package com.manager.api.controller;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.manager.api.requests.AtualizarPartidaRequest;
import com.manager.api.requests.CriarCalendarioRequest;
import com.manager.api.responses.PartidaResponse;
import com.manager.api.service.PartidaService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;

@Tag(name = "Partidas", description = "Próximos jogos e calendário")
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
	@Operation(summary = "Lista as próximas 4 partidas de um clube", description = "Considera mandante e visitante, apenas partidas com data posterior à informada, ordenadas por data e horário.")
	@Parameter(name = "idClube", description = "ID do clube", example = "1")
	@Parameter(name = "dataPartida", description = "Data de referência (yyyy-MM-dd)", example = "2026-10-21")
	@ApiResponses({
	    @ApiResponse(responseCode = "200", description = "Próximas partidas (no máximo 4)")
	})
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
	@Operation(summary = "Lista todas as partidas futuras de um clube", description = "Sem limite de partidas e com dados completos de mandante e visitante, pensado para montar o calendário.")
	@Parameter(name = "idClube", description = "ID do clube", example = "1")
	@Parameter(name = "dataPartida", description = "Data de referência (yyyy-MM-dd)", example = "2026-10-21")
	@ApiResponses({
	    @ApiResponse(responseCode = "200", description = "Partidas futuras")
	})
	@GetMapping("/partidas/clube/{idClube}/proximosJogosCalendario")
	public List<PartidaResponse> listarProximosJogosCalendario(@PathVariable Integer idClube, @RequestParam(required = true) LocalDate dataPartida){
		return partidaService.listarProximasPartidasCalendario(idClube, dataPartida);
	}
	
	@GetMapping("/partidas/clube/{idClube}/proximaPartida")
	public Optional<PartidaResponse> buscarProximaPartida(@PathVariable Integer idClube, @RequestParam(required=true) LocalDate dataAtual){
		return partidaService.buscarProximaPartida(idClube,dataAtual);
	}
	
	@PostMapping("/partida/calendario")
	public ResponseEntity<Map<String, Object>> criarCalendario(
			@RequestBody CriarCalendarioRequest request) {
		int total = partidaService.criarCalendario(request.dataInicio());
		return ResponseEntity.status(HttpStatus.CREATED)
				.body(Map.of("sucesso", true, "partidasCriadas", total));
	}
	
	@GetMapping("/partida/{id}")
	public Optional<PartidaResponse> buscarPartida(@PathVariable Integer id){
		return partidaService.buscarPartida(id);
	}
	
	@PutMapping("/partida/placar")
	public ResponseEntity<Map<String, Object>> salvarDadosPartida(@Valid @RequestBody AtualizarPartidaRequest.atualizarComCartoes request){
		partidaService.atualizarPlacarPartida(request);
		return ResponseEntity.status(HttpStatus.OK).body(Map.of("sucesso", true));
	}
}
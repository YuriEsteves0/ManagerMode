package com.manager.api.responses;

import java.time.LocalDate;
import java.time.LocalTime;

import com.manager.api.enums.partida.StatusPartida;

public record PartidaResponse(
		Integer idPartida,
		Integer golsMandante,
		Integer golsVisitante,
		Integer rodada,
		LocalDate dataPartida,
		StatusPartida statusPartida,
		Integer visitanteIdClube,
		Integer mandanteIdClube,
		LocalTime horario,
		String local,
		Integer competicaoIdCompeticao
) {
	public record RodadaIdMandanteIdVisitanteLocalDataHorario(
			Integer idPartida,
			Integer rodada,
			Integer mandanteIdClube,
			Integer visitanteIdClube,
			String local,
			LocalDate dataPartida,
			LocalTime horario
	) {}
}
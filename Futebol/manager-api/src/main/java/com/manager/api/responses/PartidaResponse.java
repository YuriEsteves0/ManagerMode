package com.manager.api.responses;

import java.time.LocalDate;
import java.time.LocalTime;

import com.manager.api.enums.partida.StatusPartida;
import com.manager.api.model.Clube;

public record PartidaResponse(
		Integer idPartida,
		Integer golsMandante,
		Integer golsVisitante,
		Integer rodada,
		LocalDate dataPartida,
		StatusPartida statusPartida,
		Integer visitanteIdClube,
		Clube clubeVisitante,
		Integer mandanteIdClube,
		Clube clubeMandante,
		LocalTime horario,
		String local,
		Integer competicaoIdCompeticao
) {
	public record RodadaIdMandanteIdVisitanteLocalEstadioDataHorario(
	        Integer idPartida,
	        Integer rodada,
	        Integer mandanteIdClube,
	        String nomeMandante,
	        Integer visitanteIdClube,
	        String nomeVisitante,
	        String local,
	        String nomeEstadio,
	        LocalDate dataPartida,
	        LocalTime horario) {}
}
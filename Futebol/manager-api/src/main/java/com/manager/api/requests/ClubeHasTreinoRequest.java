package com.manager.api.requests;

import java.util.List;

public record ClubeHasTreinoRequest(){
	public record TreinoSlotRequest(
			Integer idTreino,
			Integer slot
	) {}

	public record ClubeTreinosRequest(
			List<TreinoSlotRequest> treinos
	) {}
}
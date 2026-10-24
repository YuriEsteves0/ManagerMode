package com.manager.api.responses;

import com.manager.api.model.Clube;
import com.manager.api.model.Treino;

public record ClubeHasTreinoResponse(
		Integer idClube,
		Clube clube,
		Integer idTreino,
		Treino treino,
		Integer slot
){}
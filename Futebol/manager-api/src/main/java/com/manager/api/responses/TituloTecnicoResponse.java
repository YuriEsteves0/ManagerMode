package com.manager.api.responses;

public record TituloTecnicoResponse(
		Integer idManager,
		String nomeManager,
		Integer idCompeticao,
		String nomeCompeticao,
		Integer ano
) {}
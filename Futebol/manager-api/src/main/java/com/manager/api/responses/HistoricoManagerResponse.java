package com.manager.api.responses;

public record HistoricoManagerResponse(
		Integer idManager,
		String nomeManager,
		Integer idClube,
		String nomeClube,
		String foto,
		Integer ano
) {}
package com.manager.api.responses;

public record EstatisticaAnoClubeResponse(
		Integer idEstatisticasAnoClube,
		Integer ano,
		Integer jogos,
		Integer vitorias,
		Integer empates,
		Integer derrotas,
		Integer golsFeitos,
		Integer golsSofridos,
		Integer clubeId
) {

}
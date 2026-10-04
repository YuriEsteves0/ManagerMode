package com.manager.api.responses;

public record EstatisticasJogadorCompeticaoResponse(
		Integer idJogador,
	    String nomeJogador,
	    String nomeCompeticao,
	    Integer ano,
	    Integer jogos,
	    Integer gols,
	    Integer assistencias,
	    Integer notaMedia
){
	
}

package com.manager.api.responses;

public record EstatisticasJogadorCompeticaoResponse(
        Integer idJogador,
        String nomeJogador,
        String nomeCompeticao,
        Integer ano,
        Integer jogos,
        Integer gols,
        Integer assistencias,
        Double notaMedia) {

    public EstatisticasJogadorCompeticaoResponse(Integer idJogador, String nomeJogador, String nomeCompeticao) {
        this(idJogador, nomeJogador, nomeCompeticao, 0, 0, 0, 0, 0.0);
    }
    
    public record atualizarDados(
    		Integer idJogador,
    		Integer idCompeticao,
    		Integer ano,
    		Integer jogos,
    		Integer gols,
    		Integer assistencias,
    		Double notaMedia
    ) {}
}
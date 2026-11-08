package com.manager.api.requests;

public record EstatisticasJogadorCompeticaoRequest() {
	public record atualizarDadosJogador(
			Integer idJogador,
			Integer idCompeticao,
			Integer ano, 
			Integer gols, // aqui so poe o valor a ser adicionado (tipo 4 = mais 4 gols no bd)
			Integer assistencias,
			Double notaPartida
	) {}
}
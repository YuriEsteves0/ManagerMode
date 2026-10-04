package com.manager.api.responses;

public record PatrocinadorResponse(
		Integer idPatrocinador,
		String nomePatrocinador,
		String descricao,
		Integer duracao,
		Float valorMensal,
		Float multaRescisao,
		String foto
){
	public record Nome(
			String nomePatrocinador
	) {}
}
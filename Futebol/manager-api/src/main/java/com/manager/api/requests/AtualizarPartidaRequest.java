package com.manager.api.requests;

import java.util.List;
import java.util.Map;

import com.manager.api.enums.cartoes.TipoCartoes;
import com.manager.api.model.Jogadores;

public record AtualizarPartidaRequest() {
	public record atualizarComCartoes(
		Integer idPartida,
		Integer golsMandante,
		Integer golsVisitante,
		Map<Integer, List<TipoCartoes>> cartoes // a chave é o id do jogador
	) {}
}

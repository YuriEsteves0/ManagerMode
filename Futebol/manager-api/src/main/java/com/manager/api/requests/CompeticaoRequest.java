package com.manager.api.requests;

public record CompeticaoRequest() {
	public record atualizarTabelaPontosCorridos(
			Integer idClube,
			Integer idCompeticao,
			Integer pontosAdicionados
	) {}
}
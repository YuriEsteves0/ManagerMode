package com.manager.api.requests;

import com.manager.api.enums.jogador.PosicaoPrincipal;

public record JogadoresRequest(){
	public record titularidade(
			Integer titular
	) {}
}
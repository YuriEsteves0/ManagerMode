package com.manager.api.requests;

import com.manager.api.enums.cartoes.TipoCartoes;

public record JogadorHasCartoesRequest(
		Integer idJogador,
		Integer idCartao,
		TipoCartoes cartao
) {}
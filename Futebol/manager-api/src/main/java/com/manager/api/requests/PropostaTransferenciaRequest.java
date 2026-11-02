package com.manager.api.requests;

import com.manager.api.enums.proposta.StatusProposta;
import com.manager.api.responses.ClubeResponse;
import com.manager.api.responses.JogadoresResponse;

public record PropostaTransferenciaRequest(
		Float valorOferecido,
		StatusProposta statusProposta,
		Boolean revelado,
		Integer idJogador,
		Integer idClubeExterior,
		Integer idClubeInterior
) {}
package com.manager.api.responses;

import com.manager.api.enums.proposta.StatusProposta;

public record PropostaTransferenciaResponse(
		Integer idPropostaTransferencia,
		Float valorOferecido,
		StatusProposta statusProposta,
		Boolean revelado,
		Integer idJogador,
		JogadoresResponse jogador,
		Integer idClubeExterior,
		ClubeResponse clubeExterior,
		Integer idClubeInterior,
		ClubeResponse clubeInterior
) {}
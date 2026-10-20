package com.manager.api.responses;

import com.manager.api.enums.manager.Status;

public record PropostaEmpregoResponse(
		Integer idPropostaEmprego,
		Double salarioOferecido,
		Status status,
		ClubeResponse clube,
		Integer manager
	) {}
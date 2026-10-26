package com.manager.api.responses;

import com.manager.api.enums.acaoDiretoria.StatusAcao;
import com.manager.api.model.AcaoDiretoria;
import com.manager.api.model.Clube;

public record ClubeHasAcaoDiretoriaResponse(
	Integer idClube,
	Clube clube,
	Integer idAcaoDiretoria,
	AcaoDiretoria acaoDiretoria,
	StatusAcao statusAcao
){}
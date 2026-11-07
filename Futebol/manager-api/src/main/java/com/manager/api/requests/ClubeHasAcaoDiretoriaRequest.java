package com.manager.api.requests;

import com.manager.api.enums.acaoDiretoria.StatusAcao;
import com.manager.api.model.AcaoDiretoria;
import com.manager.api.model.Clube;

public record ClubeHasAcaoDiretoriaRequest(
		Integer idClube,
		Integer idAcaoDiretoria,
		StatusAcao statusAcao
) {}
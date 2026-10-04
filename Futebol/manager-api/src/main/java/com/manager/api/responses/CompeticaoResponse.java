package com.manager.api.responses;

import com.manager.api.enums.competicao.NivelCompeticao;
import com.manager.api.enums.competicao.StatusCompeticao;
import com.manager.api.enums.competicao.TipoCompeticao;

public record CompeticaoResponse(
		Integer idCompeticao,
		String nomeCompeticao,
		float valorPremio,
		float premioPorVitoria,
		TipoCompeticao tipoCompeticao,
		NivelCompeticao nivelCompeticao,
		Integer ano,
		StatusCompeticao statusCompeticao
) {
	
}
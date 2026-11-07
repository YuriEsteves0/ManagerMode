package com.manager.api.responses;

import java.util.List;

import com.manager.api.enums.competicao.NivelCompeticao;
import com.manager.api.enums.competicao.StatusCompeticao;
import com.manager.api.enums.competicao.TipoCompeticao;
import com.manager.api.model.Clube;
import com.manager.api.requests.ClubeHasTreinoRequest.TreinoSlotRequest;

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
	public record clubesParticipantes(
			Integer idCompeticao,
			List<Clube> clubes
	) {}
}
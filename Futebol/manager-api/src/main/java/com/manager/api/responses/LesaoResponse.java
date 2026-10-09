package com.manager.api.responses;

import com.manager.api.enums.lesao.Gravidade;

public record LesaoResponse(
		Integer idLesao,
		String nomeLesao,
		Integer tempoLesionado,
		Gravidade gravidade
) {}

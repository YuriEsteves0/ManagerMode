package com.manager.api.responses;

import com.manager.api.enums.resultado.TipoResultado;

public record PerguntasReporterResponse(
		Integer idPergunta,
		String tituloPergunta,
		String resposta1,
		String resposta2,
		String resposta3,
		TipoResultado tipoResultado
) {}
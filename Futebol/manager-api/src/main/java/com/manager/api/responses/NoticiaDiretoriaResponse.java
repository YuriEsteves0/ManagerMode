package com.manager.api.responses;

import java.time.LocalDate;
import java.time.LocalDateTime;

import com.manager.api.enums.noticiaDiretoria.TipoModificador;

public record NoticiaDiretoriaResponse(
		Integer idNoticia,
		String texto,
		LocalDate dataRegistro,
		Integer idClube,
		Integer modificador,
		TipoModificador tipoModificador
){}
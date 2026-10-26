package com.manager.api.responses;

import java.time.LocalDate;

public record TreinoResponse(
		Integer idTreino,
		String nomeTreino,
		String descTreino,
		Integer intensidade,
		LocalDate data
) {}
package com.manager.api.responses;

import com.manager.api.enums.manager.Reputacao;

public record ManagerResponse(
	Integer idManager,
	String nomeManager,
	String nacionalidade,
	String foto,
	Reputacao reputacao,
	Integer exp,
	Integer contratoFim,
	Integer idClube
) {}
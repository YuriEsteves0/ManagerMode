package com.manager.api.requests;

import com.manager.api.enums.manager.Reputacao;

public record ManagerRequest(
	String nomeManager,
	String nacionalidade,
	String foto,
	Reputacao reputacao,
	Integer exp,
	Integer contratoFim,
	Integer idClube
) {}
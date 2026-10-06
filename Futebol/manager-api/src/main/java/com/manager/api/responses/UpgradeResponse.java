package com.manager.api.responses;

import com.manager.api.enums.upgrade.TipoUpgrade;

public record UpgradeResponse(
		Integer idUpgrade,
		String nomeUpgrade,
		Float preco,
		TipoUpgrade tipoUpgrade,
		String descricao,
		Float modificador,
		Integer nivelMaximo
) {}
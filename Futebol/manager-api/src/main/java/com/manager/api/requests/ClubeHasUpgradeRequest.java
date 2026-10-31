package com.manager.api.requests;

import com.manager.api.enums.upgrade.TipoUpgrade;

public record ClubeHasUpgradeRequest(
		Integer nivelAtual
) {}
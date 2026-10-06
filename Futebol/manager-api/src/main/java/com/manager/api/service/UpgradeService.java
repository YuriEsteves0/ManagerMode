package com.manager.api.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.manager.api.repository.UpgradeRepository;
import com.manager.api.responses.UpgradeResponse;

@Service
public class UpgradeService {
	private final UpgradeRepository upgradeRepository;

	public UpgradeService(UpgradeRepository upgradeRepository) {
		this.upgradeRepository = upgradeRepository;
	}

	public List<UpgradeResponse> listarUpgrades() {
		return upgradeRepository.findAll()
				.stream()
				.map(ur -> new UpgradeResponse(
						ur.getIdUpgrade(),
						ur.getNomeUpgrade(),
						ur.getPreco(),
						ur.getTipoUpgrade(),
						ur.getDescricao(),
						ur.getModificador(),
						ur.getNivelMaximo()
				))
				.toList();
	}
}
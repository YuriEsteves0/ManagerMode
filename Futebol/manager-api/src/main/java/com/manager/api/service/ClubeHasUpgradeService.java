package com.manager.api.service;

import java.util.List;
import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.manager.api.model.ClubeHasUpgrade;
import com.manager.api.model.ClubeHasUpgradeId;
import com.manager.api.model.Upgrade;
import com.manager.api.repository.ClubeHasUpgradeRepository;
import com.manager.api.repository.ClubeRepository;
import com.manager.api.repository.UpgradeRepository;
import com.manager.api.requests.ClubeHasUpgradeRequest;
import com.manager.api.responses.ClubeHasUpgradeResponse;

import jakarta.transaction.Transactional;

@Service
public class ClubeHasUpgradeService{
	private final ClubeHasUpgradeRepository clubeHasUpgradeRepository;
	private final UpgradeRepository upgradeRepository;
	private final ClubeRepository clubeRepository;

	public ClubeHasUpgradeService(ClubeHasUpgradeRepository clubeHasUpgradeRepository,
			UpgradeRepository upgradeRepository,
			ClubeRepository clubeRepository) {
		this.clubeHasUpgradeRepository = clubeHasUpgradeRepository;
		this.upgradeRepository = upgradeRepository;
		this.clubeRepository = clubeRepository;
	}
	
	public List<ClubeHasUpgrade> listarUpgradesClube(Integer clubeId){
		return clubeHasUpgradeRepository.findByIdClubeId(clubeId);
	}
	
	public List<ClubeHasUpgradeResponse> listarUpgradesClubeComNome(Integer clubeId){
		return clubeHasUpgradeRepository.buscarUpgradesDoClube(clubeId);
	}
	
	public Optional<ClubeHasUpgradeResponse> listarUpgradeClubeComNome(Integer clubeId, Integer upgradeId){
		return clubeHasUpgradeRepository.buscarUpgradeDoClube(clubeId, upgradeId);
	}
	
	@Transactional
	public Optional<ClubeHasUpgradeResponse> updateUpgrade(Integer clubeId, Integer upgradeId,
			ClubeHasUpgradeRequest request) {

		ClubeHasUpgradeId id = new ClubeHasUpgradeId(clubeId, upgradeId);

		Optional<ClubeHasUpgrade> opt = clubeHasUpgradeRepository.findById(id);
		if (opt.isEmpty()) {
			return Optional.empty();
		}

		ClubeHasUpgrade chu = opt.get();
		Upgrade upgrade = upgradeRepository.findById(upgradeId)
				.orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Upgrade não encontrado"));

		Integer novoNivel = request.nivelAtual();

		if (novoNivel < 0 || novoNivel > upgrade.getNivelMaximo()) {
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST,
					"Nível deve estar entre 0 e " + upgrade.getNivelMaximo());
		}

		if (novoNivel < chu.getNivelAtual()) {
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Não é possível diminuir o nível do upgrade");
		}

		chu.setNivelAtual(novoNivel);
		clubeHasUpgradeRepository.save(chu);

		return clubeHasUpgradeRepository.buscarUpgradeDoClube(clubeId, upgradeId);
	}
	
}
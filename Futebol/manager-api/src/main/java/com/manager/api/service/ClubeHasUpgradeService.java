package com.manager.api.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.manager.api.model.ClubeHasUpgrade;
import com.manager.api.repository.ClubeHasUpgradeRepository;
import com.manager.api.responses.ClubeHasUpgradeResponse;

@Service
public class ClubeHasUpgradeService{
	private final ClubeHasUpgradeRepository clubeHasUpgradeRepository;
	
	public ClubeHasUpgradeService(ClubeHasUpgradeRepository clubeHasUpgradeRepository) {
		this.clubeHasUpgradeRepository = clubeHasUpgradeRepository;
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
	
}
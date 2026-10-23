package com.manager.api.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.manager.api.responses.UpgradeResponse;
import com.manager.api.service.UpgradeService;

@RestController
public class UpgradeController{
	
	private final UpgradeService upgradeService;
	
	public UpgradeController(UpgradeService upgradeService) {
		this.upgradeService = upgradeService;
	}
	
	/**
	 * Lista todos os upgrades disponíveis no jogo.
	 * <p>
	 * Esse é o catálogo geral de upgrades. Para ver o nível dos upgrades
	 * que um clube já possui, use <strong>/clubes/{id}/upgrades</strong>.
	 * </p>
	 *
	 * @return Lista de {@link UpgradeResponse} contendo:
	 * 	<ul>
	 * 		<li>ID, nome, tipo e descrição do upgrade</li>
	 * 		<li>Preço</li>
	 * 		<li>Modificador (efeito aplicado ao clube)</li>
	 * 		<li>Nível máximo</li>
	 * 	</ul>
	 */
	@GetMapping("/upgrades")
	public List<UpgradeResponse> listarUpgrades(){
		return upgradeService.listarUpgrades();
	}
}
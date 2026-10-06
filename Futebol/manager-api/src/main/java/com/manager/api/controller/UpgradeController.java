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
	
	@GetMapping("/upgrades")
	public List<UpgradeResponse> listarUpgrades(){
		return upgradeService.listarUpgrades();
	}
}
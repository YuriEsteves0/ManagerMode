package com.manager.api.controller;

import java.util.Optional;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.manager.api.responses.ManagerResponse;
import com.manager.api.service.ManagerService;

@RestController
public class ManagerController{
	private ManagerService managerService;
	
	public ManagerController(ManagerService managerService) {
		this.managerService = managerService;
	}
	
	@GetMapping("/manager/{id}")
	public Optional<ManagerResponse> buscarDadosManager(@PathVariable Integer id){
		return managerService.buscarDadosManager(id);
	}
}
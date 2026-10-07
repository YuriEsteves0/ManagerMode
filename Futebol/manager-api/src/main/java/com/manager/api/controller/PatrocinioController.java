package com.manager.api.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.manager.api.responses.PatrocinadorResponse;
import com.manager.api.service.PatrocinadorService;

@RestController
public class PatrocinioController{
	private final PatrocinadorService patrocinadorService;
	
	public PatrocinioController(PatrocinadorService patrocinadorService) {
		this.patrocinadorService = patrocinadorService;
	}
	
	@GetMapping("/patrocinios")
	public List<PatrocinadorResponse> listarPatrocinios(){
		return patrocinadorService.listarPatrocinios();
	}
}
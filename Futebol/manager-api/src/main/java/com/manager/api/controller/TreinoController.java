package com.manager.api.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.manager.api.responses.TreinoResponse;
import com.manager.api.service.TreinoService;

@RestController
public class TreinoController{
	private final TreinoService treinoService;
	
	public TreinoController(TreinoService treinoService) {
		this.treinoService= treinoService;
	}
	
	@GetMapping("/treinos")
	public List<TreinoResponse> listarTodos(){
		return treinoService.listarTreinos();
	}
}
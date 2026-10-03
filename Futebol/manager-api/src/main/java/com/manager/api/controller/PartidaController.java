package com.manager.api.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.manager.api.responses.PartidaResponse;
import com.manager.api.service.PartidaService;

@RestController
public class PartidaController{
	private final PartidaService partidaService;
	
	public PartidaController(PartidaService partidaService) {
		this.partidaService = partidaService;
	}
	
	@GetMapping("/partidas/clube/{idClube}/proximosJogos")
	public List<PartidaResponse.RodadaIdMandanteIdVisitanteLocalDataHorario> listarProximosJogos(@PathVariable Integer idClube, @RequestParam(required = true) LocalDate dataPartida){
		return partidaService.listarProximasPartidas(idClube, dataPartida);
	}
}
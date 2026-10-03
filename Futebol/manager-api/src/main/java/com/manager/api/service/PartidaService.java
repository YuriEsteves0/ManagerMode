package com.manager.api.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.stereotype.Service;

import com.manager.api.repository.PartidaRepository;
import com.manager.api.responses.PartidaResponse;

@Service
public class PartidaService{
	private final PartidaRepository partidaRepository;
	
	public PartidaService(PartidaRepository partidaRepository) {
		this.partidaRepository = partidaRepository;
	}
	
	public List<PartidaResponse.RodadaIdMandanteIdVisitanteLocalDataHorario> listarProximasPartidas(Integer idClube, LocalDate dataPartida){
		return partidaRepository.buscarProximasPartidas(idClube, dataPartida);
	}
}
package com.manager.api.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.manager.api.repository.ClubeHasTreinoRepository;
import com.manager.api.responses.ClubeHasTreinoResponse;

@Service
public class ClubeHasTreinoService{
	private final ClubeHasTreinoRepository repository;
	
	public ClubeHasTreinoService(ClubeHasTreinoRepository repository) {
		this.repository = repository;
	}
	
	public List<ClubeHasTreinoResponse> buscarPorClube(Integer idClube){
		return repository.buscarPorClube(idClube)
				.stream()
				.map(cht -> new ClubeHasTreinoResponse(
						cht.getClube().getId(),
						cht.getClube(),
						cht.getTreino().getIdTreino(),
						cht.getTreino(),
						cht.getSlot()
						)).toList();
	}
	
}
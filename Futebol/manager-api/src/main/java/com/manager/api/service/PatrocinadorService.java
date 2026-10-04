package com.manager.api.service;

import java.util.Optional;

import org.springframework.stereotype.Service;

import com.manager.api.repository.PatrocinadorRepository;
import com.manager.api.responses.PatrocinadorResponse;

@Service
public class PatrocinadorService{
	private final PatrocinadorRepository patrocinadorRepository;
	
	public PatrocinadorService(PatrocinadorRepository patrocinadorRepository) {
		this.patrocinadorRepository = patrocinadorRepository;
	}
	
	public Optional<PatrocinadorResponse.Nome> buscarPorClube(Integer idClube){
		return patrocinadorRepository.buscarPorClube(idClube);
	}
	
}
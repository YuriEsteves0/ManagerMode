package com.manager.api.service;

import java.util.Optional;

import org.springframework.stereotype.Service;

import com.manager.api.repository.CompeticaoRepository;
import com.manager.api.responses.CompeticaoResponse;

@Service
public class CompeticaoService{
	private final CompeticaoRepository competicaoRepository;
	
	public CompeticaoService(CompeticaoRepository competicaoRepository) {
		this.competicaoRepository = competicaoRepository;
	}
	
	public Optional<CompeticaoResponse> buscarCompeticao(Integer idClube){
		return competicaoRepository.findByIdCompeticao(idClube);
	}
}
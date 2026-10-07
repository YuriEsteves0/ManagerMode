package com.manager.api.service;

import java.util.List;
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
	
	public List<PatrocinadorResponse> listarPatrocinios(){
		return patrocinadorRepository.findAll()
				.stream()
				.map(pr -> new PatrocinadorResponse(
						pr.getIdPatrocinador(),
						pr.getNomePatrocinador(),
						pr.getDescricao(),
						pr.getDuracao(),
						pr.getValorMensal(),
						pr.getMultaRescisao(),
						pr.getFoto()
				))
				.toList();
	}
	
}
package com.manager.api.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.manager.api.repository.TreinoRepository;
import com.manager.api.responses.TreinoResponse;

@Service
public class TreinoService{
	private final TreinoRepository treinoRepository;
	
	public TreinoService(TreinoRepository treinoRepository) {
		this.treinoRepository = treinoRepository;
	}
	
	public List<TreinoResponse> listarTreinos(){
		return treinoRepository.findAll()
				.stream()
				.map(tr -> new TreinoResponse(
						tr.getIdTreino(),
						tr.getNomeTreino(),
						tr.getDescTreino(),
						tr.getIntensidade(),
						tr.getData()
				))
				.toList();
	}
}
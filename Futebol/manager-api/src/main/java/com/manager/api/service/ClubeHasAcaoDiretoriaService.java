package com.manager.api.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.manager.api.model.Clube;
import com.manager.api.model.ClubeHasAcaoDiretoria;
import com.manager.api.repository.ClubeHasAcaoDiretoriaRepository;
import com.manager.api.requests.ClubeHasAcaoDiretoriaRequest;
import com.manager.api.responses.ClubeHasAcaoDiretoriaResponse;

@Service
public class ClubeHasAcaoDiretoriaService{
	private final ClubeHasAcaoDiretoriaRepository repository;
	
	public ClubeHasAcaoDiretoriaService(ClubeHasAcaoDiretoriaRepository repository) {
		this.repository = repository;
	}
	
	public List<ClubeHasAcaoDiretoriaResponse> listarAcoesClube(Integer idClube){
		return repository.findById_IdClubeOrderByStatusAcao(idClube)
				.stream()
				.map(cha -> new ClubeHasAcaoDiretoriaResponse(
						cha.getClube().getId(),
						cha.getClube(),
						cha.getAcaoDiretoria().getIdAcaoDiretoria(),
						cha.getAcaoDiretoria(),
						cha.getStatusAcao()
				))
				.toList();
	}
	
	public void atualizarStatusAcaoDiretoria(Integer idClube, ClubeHasAcaoDiretoriaRequest request) {
		ClubeHasAcaoDiretoria clube = repository.findById_IdClubeAndId_IdAcaoDiretoria(idClube, request.idAcaoDiretoria()).orElseThrow(() -> new RuntimeException("Treino e/ou clube não encontrados no sistema"));
		
		clube.setStatusAcao(request.statusAcao());
		repository.save(clube);
	}
}
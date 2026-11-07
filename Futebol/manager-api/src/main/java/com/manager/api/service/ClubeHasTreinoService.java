package com.manager.api.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.manager.api.model.Clube;
import com.manager.api.model.ClubeHasTreino;
import com.manager.api.model.Treino;
import com.manager.api.repository.ClubeHasTreinoRepository;
import com.manager.api.repository.ClubeRepository;
import com.manager.api.repository.TreinoRepository;
import com.manager.api.requests.ClubeHasTreinoRequest;
import com.manager.api.responses.ClubeHasTreinoResponse;
import com.manager.api.responses.TreinoResponse;

import jakarta.transaction.Transactional;

@Service
public class ClubeHasTreinoService{
	private final ClubeHasTreinoRepository repository;
	private final ClubeRepository clubeRepository;
	private final TreinoRepository treinoRepository;
	
	public ClubeHasTreinoService(ClubeHasTreinoRepository repository, ClubeRepository clubeRepository, TreinoRepository treinoRepository) {
		this.repository = repository;
		this.clubeRepository=clubeRepository;
		this.treinoRepository=treinoRepository;
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
	
	@Transactional
	public void atualizarOuSalvarTreino(Integer idClube, ClubeHasTreinoRequest.ClubeTreinosRequest request) {
		repository.deletarPorClube(idClube);
		
		Clube clube = clubeRepository.findById(idClube).orElseThrow(()-> new RuntimeException("Clube não encontrado"));
		List<ClubeHasTreino> lista = request.treinos().stream()
	            .map(item -> {
	                Treino treino = treinoRepository.findById(item.idTreino())
	                        .orElseThrow(() -> new RuntimeException("Treino não encontrado: " + item.idTreino()));

	                ClubeHasTreino ct = new ClubeHasTreino();
	                ct.setClube(clube);
	                ct.setTreino(treino);
	                ct.setSlot(item.slot());
	                return ct;
	            })
	            .toList();
		
		repository.saveAll(lista);
	}
	
}
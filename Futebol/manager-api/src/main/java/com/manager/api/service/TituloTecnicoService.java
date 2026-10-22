package com.manager.api.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.manager.api.repository.TituloTecnicoRepository;
import com.manager.api.responses.TituloTecnicoResponse;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TituloTecnicoService{
	private final TituloTecnicoRepository repository;
	
	@Transactional(readOnly = true)
	public List<TituloTecnicoResponse> listarPorManager(Integer idManager){
		return repository.findByManager_IdManager(idManager)
				.stream()
				.map(t -> new TituloTecnicoResponse(
						t.getManager().getIdManager(),
						t.getManager().getNomeManager(),
						t.getCompeticao().getIdCompeticao(),
						t.getCompeticao().getNomeCompeticao(),
						t.getAno()
					))
				.toList();
	}
}
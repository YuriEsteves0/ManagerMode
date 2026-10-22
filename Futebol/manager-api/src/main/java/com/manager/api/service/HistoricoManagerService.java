package com.manager.api.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.manager.api.repository.HistoricoManagerRepository;
import com.manager.api.responses.HistoricoManagerResponse;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class HistoricoManagerService{
	private final HistoricoManagerRepository repository;
	
	@Transactional(readOnly = true)
	public List<HistoricoManagerResponse> listarPorManager(Integer idManager){
		return repository.findByManager_IdManagerOrderByAnoDesc(idManager)
				.stream()
				.map(hm -> new HistoricoManagerResponse(
						hm.getManager().getIdManager(),
						hm.getManager().getNomeManager(),
						hm.getClube().getId(),
						hm.getClube().getNomeClube(),
						hm.getClube().getFoto(),
						hm.getAno()
				))
				.toList();
	}
}
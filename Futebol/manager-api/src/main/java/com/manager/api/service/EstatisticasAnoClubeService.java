package com.manager.api.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.manager.api.repository.EstatisticasAnoClubeRepository;
import com.manager.api.responses.EstatisticaAnoClubeResponse;

@Service
public class EstatisticasAnoClubeService{
	public final EstatisticasAnoClubeRepository estatisticasAnoClubeRepository;
	
	public EstatisticasAnoClubeService(EstatisticasAnoClubeRepository estatisticasAnoClubeRepository) {
		this.estatisticasAnoClubeRepository = estatisticasAnoClubeRepository;
	}
	
	public List<EstatisticaAnoClubeResponse> listarEstatisticasAnoClube(Integer clubeId){
		return estatisticasAnoClubeRepository.findByClubeId(clubeId);
	}
}
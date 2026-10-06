package com.manager.api.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.manager.api.model.EstatisticasAnoClube;
import com.manager.api.responses.EstatisticaAnoClubeResponse;

public interface EstatisticasAnoClubeRepository extends JpaRepository<EstatisticasAnoClube, Integer>{
	List<EstatisticaAnoClubeResponse> findByClubeId(Integer clubeId);
}
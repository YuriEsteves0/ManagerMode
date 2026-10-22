package com.manager.api.repository;

import java.util.List;

import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

import com.manager.api.model.HistoricoManager;
import com.manager.api.model.HistoricoManagerId;

public interface HistoricoManagerRepository extends JpaRepository<HistoricoManager, HistoricoManagerId>{
	@EntityGraph(attributePaths = {"manager","clube"})
	List<HistoricoManager> findAll();
	
	@EntityGraph(attributePaths = {"manager","clube"})
	List<HistoricoManager> findByManager_IdManagerOrderByAnoDesc(Integer idManager);
}
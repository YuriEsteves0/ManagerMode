package com.manager.api.repository;

import java.util.List;

import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

import com.manager.api.model.PropostaEmprego;
import com.manager.api.responses.PropostaEmpregoResponse;

public interface PropostaEmpregoRepository extends JpaRepository<PropostaEmprego, Integer> {
	
	@EntityGraph(attributePaths = "clube")
	List<PropostaEmprego> findAll();
	
	List<PropostaEmprego> findByManagerIdManager(Integer idManager);
}
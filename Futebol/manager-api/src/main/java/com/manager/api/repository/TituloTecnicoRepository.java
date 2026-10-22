package com.manager.api.repository;

import java.util.List;

import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

import com.manager.api.model.TituloTecnico;
import com.manager.api.model.TituloTecnicoId;

public interface TituloTecnicoRepository extends JpaRepository<TituloTecnico, TituloTecnicoId>{
	@EntityGraph(attributePaths = {"manager","competicao"})
	List<TituloTecnico> findAll();
	
	@EntityGraph(attributePaths = {"manager","competicao"})
	List<TituloTecnico> findByManager_IdManager(Integer idManager);
}
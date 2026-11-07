package com.manager.api.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.manager.api.model.ClubeHasAcaoDiretoria;
import com.manager.api.model.ClubeHasAcaoDiretoriaId;
import com.manager.api.responses.ClubeHasAcaoDiretoriaResponse;

public interface ClubeHasAcaoDiretoriaRepository extends JpaRepository<ClubeHasAcaoDiretoria, ClubeHasAcaoDiretoriaId> {

	// Retorna a listagem completa das ações de carreira
	List<ClubeHasAcaoDiretoria> findById_IdClubeOrderByStatusAcao(Integer idClube);
	
	// Retorna apenas uma ação de carreira
	Optional<ClubeHasAcaoDiretoria> findById_IdClubeAndId_IdAcaoDiretoria(Integer idClube, Integer idAcaoDiretoria);
	
}
package com.manager.api.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.manager.api.model.ClubeHasTreino;
import com.manager.api.model.ClubeHasTreinoId;
import com.manager.api.responses.ClubeHasTreinoResponse;

public interface ClubeHasTreinoRepository extends JpaRepository<ClubeHasTreino, ClubeHasTreinoId>{
	@Query("SELECT ct FROM ClubeHasTreino ct " +
		       "JOIN FETCH ct.clube " +
		       "JOIN FETCH ct.treino " +
		       "WHERE ct.id.clubeId = :idClube")
		List<ClubeHasTreino> buscarPorClube(@Param("idClube") Integer idClube);
}
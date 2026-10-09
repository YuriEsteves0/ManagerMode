package com.manager.api.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.manager.api.model.JogadorLesao;
import com.manager.api.model.Lesao;
import com.manager.api.model.LesaoId;
import com.manager.api.responses.LesaoJogadorResponse;
import com.manager.api.responses.LesaoResponse;

public interface JogadorHasLesaoRepository extends JpaRepository<JogadorLesao, LesaoId> {

	@Query("""
	        SELECT new com.manager.api.responses.LesaoResponse(
	            l.idLesao, l.nomeLesao, l.tempoLesionado, l.gravidade)
	        FROM JogadorLesao jl
	        JOIN Lesao l ON l.idLesao = jl.id.idLesao
	        WHERE jl.id.idJogador = :jogadorId
	        """)
	List<LesaoResponse> listarLesoesJogador(@Param("jogadorId") Integer jogadorId);
	
	@Query("""
	        SELECT new com.manager.api.responses.LesaoJogadorResponse(
	            j.idJogador, l.idLesao, l.nomeLesao, l.tempoLesionado, l.gravidade)
	        FROM JogadorLesao jl
	        JOIN Lesao l ON l.idLesao = jl.id.idLesao
	        JOIN Jogadores j ON j.idJogador = jl.id.idJogador
	        WHERE j.clubeIdClube = :clubeId
	        """)
	List<LesaoJogadorResponse> listarLesoesPorClube(@Param("clubeId") Integer clubeId);
}
package com.manager.api.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.manager.api.model.EstatisticaJogador;
import com.manager.api.model.EstatisticaJogadorId;
import com.manager.api.responses.EstatisticasJogadorCompeticaoResponse;

public interface EstatisticasJogadorCompeticaoRepository extends JpaRepository<EstatisticaJogador, EstatisticaJogadorId> {
	@Query("""
	SELECT new com.manager.api.responses.EstatisticasJogadorCompeticaoResponse(
	    j.idJogador, j.nomeJogador, c.nomeCompeticao,
	    e.ano, e.jogos, e.gols, e.assistencias, e.notaMedia)
	FROM EstatisticaJogador e
	JOIN e.jogador j
	JOIN e.competicao c
	WHERE j.idJogador = :idJogador
	""")
	List<EstatisticasJogadorCompeticaoResponse> buscarPorJogador(@Param("idJogador") Integer idJogador);
	
	@Query("""
		    SELECT new com.manager.api.responses.EstatisticasJogadorCompeticaoResponse(
		        j.idJogador, j.nomeJogador, c.nomeCompeticao,
		        e.ano, e.jogos, e.gols, e.assistencias, e.notaMedia)
		    FROM EstatisticaJogador e
		    JOIN e.jogador j
		    JOIN e.competicao c
		    WHERE e.id.competicaoId = :idCompeticao ORDER BY e.gols DESC
		    """)
		List<EstatisticasJogadorCompeticaoResponse> buscarTodosJogadores(@Param("idCompeticao") Integer idCompeticao);

	@Query("""
		    SELECT new com.manager.api.responses.EstatisticasJogadorCompeticaoResponse(
		        j.idJogador, j.nomeJogador, c.nomeCompeticao,
		        e.ano, e.jogos, e.gols, e.assistencias, e.notaMedia)
		    FROM EstatisticaJogador e
		    JOIN e.jogador j
		    JOIN e.competicao c
		    WHERE j.clubeIdClube = :idClube
		    ORDER BY j.nomeJogador, e.ano DESC
		    """)
		List<EstatisticasJogadorCompeticaoResponse> buscarPorClube(@Param("idClube") Integer idClube);
	
}
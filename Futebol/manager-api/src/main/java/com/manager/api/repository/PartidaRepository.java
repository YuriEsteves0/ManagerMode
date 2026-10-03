package com.manager.api.repository;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.manager.api.model.Partida;
import com.manager.api.responses.PartidaResponse;

public interface PartidaRepository extends JpaRepository<Partida, Integer>{

	@Query("""
			SELECT new com.manager.api.responses.PartidaResponse$RodadaIdMandanteIdVisitanteLocalDataHorario(
				p.idPartida, p.rodada, p.mandanteIdClube, p.visitanteIdClube, p.local, p.dataPartida, p.horario)
			FROM Partida p
			WHERE (p.mandanteIdClube = :idClube OR p.visitanteIdClube = :idClube)
			  AND p.dataPartida > :dataPartida
			ORDER BY p.dataPartida ASC, p.horario ASC
			""")
		List<PartidaResponse.RodadaIdMandanteIdVisitanteLocalDataHorario> buscarProximasPartidas(
			@Param("idClube") Integer idClube,
			@Param("dataPartida") LocalDate dataPartida);
}
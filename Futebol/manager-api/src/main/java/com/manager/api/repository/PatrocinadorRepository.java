package com.manager.api.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.manager.api.model.Patrocinador;
import com.manager.api.responses.PatrocinadorResponse;

public interface  PatrocinadorRepository extends JpaRepository<Patrocinador, Integer>{
	@Query("""
		    SELECT new com.manager.api.responses.PatrocinadorResponse$Nome(p.nomePatrocinador)
		    FROM Clube c
		    JOIN Patrocinador p ON p.idPatrocinador = c.patrocinador_idPatrocinador
		    WHERE c.id = :idClube
		    """)
		Optional<PatrocinadorResponse.Nome> buscarPorClube(@Param("idClube") Integer idClube);
}
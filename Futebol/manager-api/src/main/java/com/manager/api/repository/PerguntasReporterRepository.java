package com.manager.api.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.manager.api.enums.resultado.TipoResultado;
import com.manager.api.model.PerguntasReporter;

public interface PerguntasReporterRepository extends JpaRepository<PerguntasReporter, Integer> {

    @Query(value = "SELECT * FROM perguntas_reporter WHERE tipoResultado = :tipo ORDER BY RAND() LIMIT 1",
           nativeQuery = true)
    Optional<PerguntasReporter> buscarAleatoriaPorTipo(@Param("tipo") String tipo);
}
package com.manager.api.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.manager.api.model.EstatisticasAnoClube;
import com.manager.api.responses.EstatisticaAnoClubeResponse;

public interface EstatisticasAnoClubeRepository extends JpaRepository<EstatisticasAnoClube, Integer>{
    
    List<EstatisticaAnoClubeResponse> findByClubeId(Integer clubeId);

    @Query("SELECT new com.manager.api.responses.EstatisticaAnoClubeResponse(" +
            "MAX(e.id), " +
            "e.ano, " +
            "CAST(SUM(e.jogos) AS int), " +
            "CAST(SUM(e.vitorias) AS int), " +
            "CAST(SUM(e.empates) AS int), " +
            "CAST(SUM(e.derrotas) AS int), " +
            "CAST(SUM(e.golsFeitos) AS int), " +
            "CAST(SUM(e.golsSofridos) AS int), " +
            "e.clubeId) " +
            "FROM EstatisticasAnoClube e " +
            "WHERE e.clubeId = :clubeId AND e.ano = :ano " +
            "GROUP BY e.ano, e.clubeId")
     Optional<EstatisticaAnoClubeResponse> findEstatisticaPorClubeEAno(
             @Param("clubeId") Integer clubeId, 
             @Param("ano") Integer ano
     );
}
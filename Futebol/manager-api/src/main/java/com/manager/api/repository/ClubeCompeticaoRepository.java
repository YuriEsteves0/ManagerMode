package com.manager.api.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.manager.api.model.ClubeCompeticao;
import com.manager.api.model.ClubeCompeticaoId;

public interface ClubeCompeticaoRepository extends JpaRepository<ClubeCompeticao, ClubeCompeticaoId> {

    @Query("SELECT cc FROM ClubeCompeticao cc WHERE cc.competicao.idCompeticao = :competicaoId")
    List<ClubeCompeticao> findByCompeticao_Id(@Param("competicaoId") Integer competicaoId);

    @Query("""
        SELECT cc FROM ClubeCompeticao cc
        WHERE cc.competicao.idCompeticao = :competicaoId
        ORDER BY cc.pontos DESC
        """)
    List<ClubeCompeticao> findByCompeticao_IdOrderByPontosDesc(@Param("competicaoId") Integer competicaoId);
}
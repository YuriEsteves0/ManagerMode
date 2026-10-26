package com.manager.api.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.manager.api.model.ClubeHasMetaTemporada;
import com.manager.api.model.ClubeHasMetaTemporadaId;

public interface ClubeHasMetaTemporadaRepository
        extends JpaRepository<ClubeHasMetaTemporada, ClubeHasMetaTemporadaId> {

    @Query("SELECT c FROM ClubeHasMetaTemporada c WHERE c.id.idClube = :idClube")
    List<ClubeHasMetaTemporada> buscarPorClube(@Param("idClube") Integer idClube);
}
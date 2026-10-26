package com.manager.api.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.manager.api.model.ClubeHasAcaoDiretoria;
import com.manager.api.model.ClubeHasAcaoDiretoriaId;
import com.manager.api.responses.ClubeHasAcaoDiretoriaResponse;

public interface ClubeHasAcaoDiretoriaRepository extends JpaRepository<ClubeHasAcaoDiretoria, ClubeHasAcaoDiretoriaId> {

List<ClubeHasAcaoDiretoria> findById_IdClubeOrderByStatusAcao(Integer idClube);
}
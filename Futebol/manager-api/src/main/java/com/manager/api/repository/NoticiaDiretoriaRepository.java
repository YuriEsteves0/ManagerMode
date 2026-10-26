package com.manager.api.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.manager.api.model.NoticiaDiretoria;

public interface NoticiaDiretoriaRepository extends JpaRepository<NoticiaDiretoria, Integer> {

	List<NoticiaDiretoria> findByIdClubeOrderByDataRegistroDesc(Integer idClube);
}
package com.manager.api.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.manager.api.model.Jogadores;

public interface JogadoresRepository extends JpaRepository<Jogadores, Integer>{
	List<Jogadores> findByClubeIdClubeAndTitularFalse(Integer clubeIdClube);
}
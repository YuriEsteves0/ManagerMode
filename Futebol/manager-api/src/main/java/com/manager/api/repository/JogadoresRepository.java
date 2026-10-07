package com.manager.api.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.manager.api.model.Jogadores;
import com.manager.api.responses.JogadoresResponse;

public interface JogadoresRepository extends JpaRepository<Jogadores, Integer>{
	List<JogadoresResponse> findByClubeIdClubeAndTitularFalse(Integer clubeIdClube);
	List<JogadoresResponse> findByClubeIdClube(Integer clubeIdClube);
}
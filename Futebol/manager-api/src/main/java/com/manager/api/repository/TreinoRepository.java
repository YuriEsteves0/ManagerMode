package com.manager.api.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.manager.api.model.Treino;

public interface TreinoRepository extends JpaRepository<Treino, Integer>{
	
}
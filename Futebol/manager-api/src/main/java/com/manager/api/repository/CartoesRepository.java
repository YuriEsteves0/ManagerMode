package com.manager.api.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.manager.api.model.Cartoes;

public interface CartoesRepository extends JpaRepository<Cartoes, Integer> {
}
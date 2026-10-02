package com.manager.api.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.manager.api.model.Clube;

public interface ClubeRepository extends JpaRepository<Clube, Integer>{
    
}

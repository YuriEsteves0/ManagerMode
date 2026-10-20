package com.manager.api.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.manager.api.model.Manager;
import com.manager.api.responses.ManagerResponse;

public interface ManagerRepository extends JpaRepository<Manager, Integer>{
	public Optional<ManagerResponse> findByIdManager(Integer idManager);
}
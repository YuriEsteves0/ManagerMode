package com.manager.api.service;

import java.util.Optional;

import org.springframework.stereotype.Service;

import com.manager.api.repository.ManagerRepository;
import com.manager.api.responses.ManagerResponse;

@Service
public class ManagerService{
	private final ManagerRepository managerRepository;
	
	public ManagerService(ManagerRepository managerRepository) {
		this.managerRepository = managerRepository;
	}
	
	public Optional<ManagerResponse> buscarDadosManager(Integer idManager){
		return managerRepository.findByIdManager(idManager);
	}
}
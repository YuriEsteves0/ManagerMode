package com.manager.api.service;

import java.util.Optional;

import org.springframework.stereotype.Service;

import com.manager.api.model.Manager;
import com.manager.api.repository.ManagerRepository;
import com.manager.api.requests.ManagerRequest;
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

	public ManagerResponse criarManager(ManagerRequest request) {
		Manager manager = new Manager();
		
		manager.setNomeManager(request.nomeManager());
		manager.setNacionalidade(request.nacionalidade());
		manager.setFoto(request.foto());
		manager.setReputacao(request.reputacao());
		manager.setExp(request.exp());
		manager.setContratoFim(request.contratoFim());
		manager.setIdClube(request.idClube());
		
		Manager salvo = managerRepository.save(manager);
		
		return new ManagerResponse(
				salvo.getIdManager(),
				salvo.getNomeManager(),
				salvo.getNacionalidade(),
				salvo.getFoto(),
				salvo.getReputacao(),
				salvo.getExp(),
				salvo.getContratoFim(),
				salvo.getIdClube()
				);
	}

}
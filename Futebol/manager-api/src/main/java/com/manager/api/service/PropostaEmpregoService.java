package com.manager.api.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.manager.api.model.Clube;
import com.manager.api.model.PropostaEmprego;
import com.manager.api.repository.PropostaEmpregoRepository;
import com.manager.api.responses.ClubeResponse;
import com.manager.api.responses.PropostaEmpregoResponse;

@Service
public class PropostaEmpregoService {
	private final PropostaEmpregoRepository repository;

	public PropostaEmpregoService(PropostaEmpregoRepository repository) {
		this.repository = repository;
	}

	@Transactional(readOnly = true)
	public List<PropostaEmpregoResponse> listar() {
		return repository.findAll()
				.stream()
				.map(this::toResponse)
				.toList();
	}
	
	@Transactional(readOnly = true)
	public List<PropostaEmpregoResponse> listarPorManager(Integer idManager) {
		return repository.findByManagerIdManager(idManager)
				.stream()
				.map(this::toResponse)
				.toList();
	}

	private PropostaEmpregoResponse toResponse(PropostaEmprego p) {
		Clube c = p.getClube();
		ClubeResponse clube = new ClubeResponse(
			c.getId(), c.getNomeClube(), c.getOrcamento(), c.getValorClube(),
			c.getCamisasVendidas(), c.getQntTorcedores(), c.getReputacao(),
			c.getPatrocinador_idPatrocinador(), c.getConfiancaDiretoria(), c.getStatusConfianca(),
			c.getEventoAtual(), c.getCapacidadeEstadio(), c.getFoto(), c.getNomeEstadio()
		);
		return new PropostaEmpregoResponse(
			p.getIdPropostaEmprego(),
			p.getSalarioOferecido(),
			p.getStatus(),
			clube,
			p.getManager().getIdManager()
		);
	}
}
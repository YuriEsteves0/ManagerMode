package com.manager.api.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.manager.api.model.NoticiaDiretoria;
import com.manager.api.repository.NoticiaDiretoriaRepository;
import com.manager.api.responses.NoticiaDiretoriaResponse;

@Service
public class NoticiaDiretoriaService{
	private final NoticiaDiretoriaRepository repository;

	public NoticiaDiretoriaService(NoticiaDiretoriaRepository repository) {
		this.repository = repository;
	}
	
	public List<NoticiaDiretoriaResponse> buscarPorClube(Integer idClube) {
	    return repository.findByIdClubeOrderByDataRegistroDesc(idClube)
	            .stream()
	            .map(this::paraResponse)
	            .toList();
	}

	public List<NoticiaDiretoriaResponse> listarTodas() {
	    return repository.findAll()
	            .stream()
	            .map(this::paraResponse)
	            .toList();
	}

	private NoticiaDiretoriaResponse paraResponse(NoticiaDiretoria nd) {
	    return new NoticiaDiretoriaResponse(
	            nd.getIdNoticia(),
	            nd.getTexto(),
	            nd.getDataRegistro(),
	            nd.getIdClube(),
	            nd.getModificador(),
	            nd.getTipoModificador()
	    		);
	}
}
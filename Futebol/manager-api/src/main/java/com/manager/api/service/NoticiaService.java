package com.manager.api.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.manager.api.enums.noticia.Categoria;
import com.manager.api.repository.NoticiaRepository;
import com.manager.api.responses.NoticiaResponse;

@Service
public class NoticiaService{
	private final NoticiaRepository noticiaRepository;
	
	public NoticiaService(NoticiaRepository noticiaRepository) {
		this.noticiaRepository = noticiaRepository;
	}
	
	public List<NoticiaResponse> listarNoticiasDeMercado(){
		return noticiaRepository.findByCategoria(Categoria.MERCADO);
	}
	
}
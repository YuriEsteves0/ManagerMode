package com.manager.api.service;

import org.springframework.stereotype.Service;

import com.manager.api.enums.resultado.TipoResultado;
import com.manager.api.model.PerguntasReporter;
import com.manager.api.repository.PerguntasReporterRepository;

@Service
public class PerguntasReporterService{
	private final PerguntasReporterRepository perguntasReporterRepository;
	
	public PerguntasReporterService(PerguntasReporterRepository perguntasReporterRepository) {
		this.perguntasReporterRepository=perguntasReporterRepository;
	}
	
	public PerguntasReporter sortearPergunta(String tipo){
		return perguntasReporterRepository.buscarAleatoriaPorTipo(tipo).orElseThrow(() -> new RuntimeException("Pergunta não encontrada para o tipo: " + tipo));
	}
}
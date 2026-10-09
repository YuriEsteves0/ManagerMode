package com.manager.api.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.manager.api.repository.JogadorHasLesaoRepository;
import com.manager.api.responses.LesaoJogadorResponse;
import com.manager.api.responses.LesaoResponse;

@Service
public class JogadorLesaoService {
    private final JogadorHasLesaoRepository repository;

    public JogadorLesaoService(JogadorHasLesaoRepository repository) {
        this.repository = repository;
    }

    public List<LesaoResponse> listarLesoesJogador(Integer jogadorId) {
        return repository.listarLesoesJogador(jogadorId);
    }

    public List<LesaoJogadorResponse> listarLesoesPorClube(Integer clubeId) {
        return repository.listarLesoesPorClube(clubeId);
    }
}
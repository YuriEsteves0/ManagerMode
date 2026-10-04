package com.manager.api.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.manager.api.repository.EstatisticasJogadorCompeticaoRepository;
import com.manager.api.responses.EstatisticasJogadorCompeticaoResponse;

@Service
public class EstatisticaJogadoresService {

    private final EstatisticasJogadorCompeticaoRepository repository;

    public EstatisticaJogadoresService(EstatisticasJogadorCompeticaoRepository repository) {
        this.repository = repository;
    }

    public List<EstatisticasJogadorCompeticaoResponse> estatisticas(Integer id) {
        return repository.buscarPorJogador(id);
    }
    
    public List<EstatisticasJogadorCompeticaoResponse> estatisticasFull(Integer idCompeticao) {
        return repository.buscarTodosJogadores(idCompeticao);
    
    }
}
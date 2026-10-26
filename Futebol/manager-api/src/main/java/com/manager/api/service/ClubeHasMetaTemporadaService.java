package com.manager.api.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.manager.api.repository.ClubeHasMetaTemporadaRepository;
import com.manager.api.responses.ClubeHasMetaTemporadaResponse;

@Service
public class ClubeHasMetaTemporadaService {
    private final ClubeHasMetaTemporadaRepository repository;

    public ClubeHasMetaTemporadaService(ClubeHasMetaTemporadaRepository repository) {
        this.repository = repository;
    }

    public List<ClubeHasMetaTemporadaResponse> buscarClube(Integer idClube) {
        return repository.buscarPorClube(idClube).stream()
            .map(c -> new ClubeHasMetaTemporadaResponse(
                c.getId().getIdClube(),
                c.getClube(),
                c.getId().getIdMetaTemporada(),
                c.getMetaTemporada(),
                c.getStatus()))
            .toList();
    }
}
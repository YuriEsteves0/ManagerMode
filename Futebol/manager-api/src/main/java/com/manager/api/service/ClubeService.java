package com.manager.api.service;

import org.springframework.stereotype.Service;

import com.manager.api.model.Clube;
import com.manager.api.repository.ClubeRepository;
import com.manager.api.responses.ClubeResponse;

@Service 
public class ClubeService {
    public ClubeRepository repository;

    public ClubeService(ClubeRepository repository){
        this.repository = repository;
    }

    public ClubeResponse buscarClube(Integer clubeID){
        Clube clube = repository.findById(clubeID)
            .orElseThrow(() -> new RuntimeException("Clube não encontrado!"));

        return new ClubeResponse(
            clube.getId(),
            clube.getNomeClube(),
            clube.getOrcamento(),
            clube.getValorClube(),
            clube.getCamisasVendidas(),
            clube.getQntTorcedores(),
            clube.getReputacao(),
            clube.getPatrococinadorIdPatrocinador() != null ? clube.getPatrococinadorIdPatrocinador() : null,
            clube.getConfiancaDiretoria(),
            clube.getStatusConfianca(),
            clube.getEventoAtual(),
            clube.getCapacidadeEstadio(),
            clube.getFoto()
        );
    }
}

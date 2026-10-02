package com.manager.api.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.manager.api.model.Clube;
import com.manager.api.model.ClubeCompeticao;
import com.manager.api.repository.ClubeCompeticaoRepository;
import com.manager.api.repository.ClubeRepository;
import com.manager.api.responses.ClubeCompeticaoResponse;
import com.manager.api.responses.ClubeResponse;
import com.manager.api.service.ClubeCompeticaoService;
import com.manager.api.service.ClubeService;

@RestController
public class ClubeController {
    private final ClubeCompeticaoRepository clubeCompeticaoRepository;

    private final ClubeService clubeService;
    private final ClubeCompeticaoService clubeCompeticaoService;

    public ClubeController(ClubeCompeticaoRepository clubeCompeticaoRepository, ClubeCompeticaoService clubeCompeticaoService, ClubeService clubeService) {
        this.clubeCompeticaoRepository = clubeCompeticaoRepository;
        this.clubeCompeticaoService = clubeCompeticaoService; 
        this.clubeService = clubeService; 
    }

    @GetMapping("/competicoes/{id}/clubes")
    public List<ClubeCompeticaoResponse.ClubeResponse.ClubeFotoNomeResponse> listarClubesDaCompeticao(@PathVariable Integer id) {
//        return clubeCompeticaoRepository.findByCompeticao_Id(id)
//                .stream()
//                .map(ClubeCompeticao::getClube)
//                .toList();
    	return clubeCompeticaoService.listarClubeFotoNome(id);
    }

    @GetMapping("/competicoes/{id}/classificacao")
    public List<ClubeCompeticaoResponse.IdClubeIdCompeticaoPontosFaseAtual> classificacao(@PathVariable Integer id){
        return clubeCompeticaoService.listarClassificacao(id);
    }

    @GetMapping("/clubes/{id}")
    public ClubeResponse buscarClubePorId(@PathVariable Integer id) {
        return clubeService.buscarClube(id);
    }
}

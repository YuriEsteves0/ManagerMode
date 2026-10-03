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

    private final ClubeService clubeService;

    public ClubeController(ClubeService clubeService) {
        this.clubeService = clubeService; 
    }

    /**
     * @param id Parâmetro recebido e usado como variavel para realizar os métodos do {@link ClubeService}
     * @return O mesmo retorno de {@link ClubeCompeticaoService#listarClubeFotoNome(Integer)} 
     */
    @GetMapping("/clubes/{id}")
    public ClubeResponse buscarClubePorId(@PathVariable Integer id) {
        return clubeService.buscarClube(id);
    }
}

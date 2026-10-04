package com.manager.api.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.manager.api.responses.ClubeResponse;
import com.manager.api.responses.PatrocinadorResponse;
import com.manager.api.service.ClubeCompeticaoService;
import com.manager.api.service.ClubeService;
import com.manager.api.service.PatrocinadorService;

@RestController
public class ClubeController {

    private final ClubeService clubeService;
    private final PatrocinadorService patrocinadorService;

    public ClubeController(ClubeService clubeService, PatrocinadorService patrocinadorService) {
        this.clubeService = clubeService; 
        this.patrocinadorService = patrocinadorService;
    }

    /**
     * @param id Parâmetro recebido e usado como variavel para realizar os métodos do {@link ClubeService}
     * @return O mesmo retorno de {@link ClubeCompeticaoService#listarClubeFotoNome(Integer)} 
     */
    @GetMapping("/clubes/{id}")
    public ClubeResponse buscarClubePorId(@PathVariable Integer id) {
        return clubeService.buscarClube(id);
    }
    
    @GetMapping("/clubes/{id}/patrocinador")
    public Optional<PatrocinadorResponse.Nome> patrocinadorDoClubeNome(@PathVariable Integer id){
    	return patrocinadorService.buscarPorClube(id);
    }
    
}

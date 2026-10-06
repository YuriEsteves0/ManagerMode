package com.manager.api.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.manager.api.model.ClubeHasUpgrade;
import com.manager.api.responses.ClubeHasUpgradeResponse;
import com.manager.api.responses.ClubeResponse;
import com.manager.api.responses.EstatisticaAnoClubeResponse;
import com.manager.api.responses.PatrocinadorResponse;
import com.manager.api.responses.UpgradeResponse;
import com.manager.api.service.ClubeCompeticaoService;
import com.manager.api.service.ClubeHasUpgradeService;
import com.manager.api.service.ClubeService;
import com.manager.api.service.EstatisticasAnoClubeService;
import com.manager.api.service.PatrocinadorService;

@RestController
public class ClubeController {

    private final ClubeService clubeService;
    private final PatrocinadorService patrocinadorService;
    private final EstatisticasAnoClubeService estatisticasAnoClubeService;
    private final ClubeHasUpgradeService clubeHasUpgradeService;

    public ClubeController(ClubeService clubeService, PatrocinadorService patrocinadorService, EstatisticasAnoClubeService estatisticasAnoClubeService, ClubeHasUpgradeService clubeHasUpgradeService) {
        this.clubeService = clubeService; 
        this.patrocinadorService = patrocinadorService;
        this.estatisticasAnoClubeService = estatisticasAnoClubeService;
        this.clubeHasUpgradeService = clubeHasUpgradeService;
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
    
    @GetMapping("/clubes/{id}/estatisticasAno")
    public List<EstatisticaAnoClubeResponse> listarEstatisticasAnoClube(@PathVariable Integer id){
    	return estatisticasAnoClubeService.listarEstatisticasAnoClube(id);
    }
    
    @GetMapping("/clubes/{id}/upgrades")
    public List<ClubeHasUpgradeResponse> listarUpgradesClube(@PathVariable Integer id){
    	return clubeHasUpgradeService.listarUpgradesClubeComNome(id);
    }
}

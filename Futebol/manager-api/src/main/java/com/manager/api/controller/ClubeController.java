package com.manager.api.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.manager.api.model.ClubeHasUpgrade;
import com.manager.api.responses.ClubeCompeticaoResponse;
import com.manager.api.responses.ClubeHasUpgradeResponse;
import com.manager.api.responses.ClubeResponse;
import com.manager.api.responses.EstatisticaAnoClubeResponse;
import com.manager.api.responses.PatrocinadorResponse;
import com.manager.api.responses.PropostaTransferenciaResponse;
import com.manager.api.responses.UpgradeResponse;
import com.manager.api.service.ClubeCompeticaoService;
import com.manager.api.service.ClubeHasUpgradeService;
import com.manager.api.service.ClubeService;
import com.manager.api.service.EstatisticasAnoClubeService;
import com.manager.api.service.PatrocinadorService;
import com.manager.api.service.PropostaTransferenciaService;

@RestController
public class ClubeController {

    private final ClubeService clubeService;
    private final PatrocinadorService patrocinadorService;
    private final EstatisticasAnoClubeService estatisticasAnoClubeService;
    private final ClubeHasUpgradeService clubeHasUpgradeService;
    private final PropostaTransferenciaService propostaTransferenciaService;

    public ClubeController(ClubeService clubeService, PatrocinadorService patrocinadorService, EstatisticasAnoClubeService estatisticasAnoClubeService, ClubeHasUpgradeService clubeHasUpgradeService, PropostaTransferenciaService propostaTransferenciaService) {
        this.clubeService = clubeService; 
        this.patrocinadorService = patrocinadorService;
        this.estatisticasAnoClubeService = estatisticasAnoClubeService;
        this.clubeHasUpgradeService = clubeHasUpgradeService;
        this.propostaTransferenciaService= propostaTransferenciaService;
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
    
    @GetMapping("/clubes/{id}/estatisticasAno/{ano}")
    public EstatisticaAnoClubeResponse buscarEstatisticaPorClubeEAno(
            @PathVariable Integer id, 
            @PathVariable Integer ano) {
        return estatisticasAnoClubeService.buscarEstatisticaPorClubeEAno(id, ano);
    }
    
    @GetMapping("/clubes/{id}/upgrades")
    public List<ClubeHasUpgradeResponse> listarUpgradesClube(@PathVariable Integer id){
    	return clubeHasUpgradeService.listarUpgradesClubeComNome(id);
    }
    
    /**
     * Busca todas as transferencias (enviadas / recebidas) por um parâmetro <strong>tipoTransferencia</strong>.
     * @param id Parâmetro usado como id do clube do jogador
     * @param idExterior Parâmetro usado como id do clube interessado
     * @param tipoTransferencia pode ser dois tipos:
     * 	<ul>
     * 		<li>Enviada</li>
     *      <li>Recebida</li>
     * 	</ul>
     * @return Lista de {@link PropostaTransferenciaResponse} refletindo os dados da proposta de transferência
     */
    @GetMapping("/clubes/{id}/transferencias")
    public List<PropostaTransferenciaResponse> listarTransferencias(
    		@PathVariable Integer id,
    		@RequestParam String tipoTransferencia) {
    	return propostaTransferenciaService.transferencia(id, tipoTransferencia);
    }
}

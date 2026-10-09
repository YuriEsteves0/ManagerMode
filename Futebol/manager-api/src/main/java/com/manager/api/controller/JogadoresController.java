package com.manager.api.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.manager.api.repository.JogadorHasLesaoRepository;
import com.manager.api.responses.EstatisticasJogadorCompeticaoResponse;
import com.manager.api.responses.JogadoresResponse;
import com.manager.api.responses.LesaoJogadorResponse;
import com.manager.api.responses.LesaoResponse;
import com.manager.api.service.EstatisticaJogadoresService;
import com.manager.api.service.JogadorLesaoService;
import com.manager.api.service.JogadoresService;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;

@RestController
public class JogadoresController {

    private final JogadoresService jogadoresService;
    private final EstatisticaJogadoresService estatisticaJogadoresService;
    private final JogadorLesaoService jogadorLesaoService;

    public JogadoresController(JogadoresService jogadoresService, EstatisticaJogadoresService estatisticaJogadoresService, JogadorLesaoService jogadorLesaoService) {
		this.jogadoresService = jogadoresService;
		this.estatisticaJogadoresService = estatisticaJogadoresService;
		this.jogadorLesaoService = jogadorLesaoService;
    }

    @Operation(
        summary = "Lista jogadores por clube", 
        description = "Retorna uma lista resumida contendo ID, nome, número da camisa e status de titularidade dos jogadores pertencentes ao clube especificado."
    )
    @GetMapping("/jogadores/clube/{clube_idClube}")
    public List<JogadoresResponse> listarJogadoresPorClube(
            @PathVariable Integer clube_idClube, @RequestParam Boolean todos) {
    	if (todos) {
    		return jogadoresService.listarPorClubeFull(clube_idClube);
    	} else {
    		// AQUI RETORNA OS JOGADORES TITULARES
    		return jogadoresService.listarPorClube(clube_idClube);
    	}
    }
    
    @GetMapping("/jogadores/overall")
    public List<JogadoresResponse.comClube> listarJogadoresPorOverAll(){
    	return jogadoresService.listarPorOverall();
    }
    
    @GetMapping("/jogadores/clube/{clube_idClube}/estatisticas")
    public List<EstatisticasJogadorCompeticaoResponse> listarEstatisticasJogadoresPorClube(
            @PathVariable Integer clube_idClube) {
        return estatisticaJogadoresService.estatisticasPorClube(clube_idClube);
    }
    
    @CrossOrigin(origins="http://localhost")
    @GetMapping("/jogador/{id}/estatistica")
    public List<EstatisticasJogadorCompeticaoResponse> estatisticaJogador(@PathVariable Integer id) {
        return estatisticaJogadoresService.estatisticas(id);
    }
    
    @GetMapping("/jogador/competicao/{id}/estatistica")
    public List<EstatisticasJogadorCompeticaoResponse> estatisticaJogadorFull(@PathVariable Integer id) {
        return estatisticaJogadoresService.estatisticasFull(id);
    }
    
    @GetMapping("/jogadores/clube/{clube_idClube}/lesoes")
    public List<LesaoJogadorResponse> listarLesoesPorClube(@PathVariable Integer clube_idClube) {
        return jogadorLesaoService.listarLesoesPorClube(clube_idClube);
    }

    @GetMapping("/jogador/{id}/lesoes")
    public List<LesaoResponse> listarLesoesJogador(@PathVariable Integer id) {
        return jogadorLesaoService.listarLesoesJogador(id);
    }
}
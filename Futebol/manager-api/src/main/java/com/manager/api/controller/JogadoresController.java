package com.manager.api.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
import com.manager.api.requests.JogadoresRequest;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import jakarta.validation.Valid;

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
    /**
     * Lista os jogadores de um clube, conforme o parâmetro <strong>todos</strong>.
     *
     * @param clube_idClube Parâmetro usado como id do clube dono dos jogadores
     * @param todos Define quais jogadores serão retornados:
     * 	<ul>
     * 		<li><strong>true</strong>: todo o elenco (titulares e reservas)</li>
     * 		<li><strong>false</strong>: apenas os jogadores <strong>não titulares</strong> (reservas)</li>
     * 	</ul>
     * @return Lista de {@link JogadoresResponse} refletindo os dados dos jogadores
     * 	(atributos, overall, potencial, moral, contrato, valor, salário e posição em campo)
     */
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
    
    /**
     * Lista os jogadores do jogo ranqueados por <strong>overall</strong>, do maior para o menor.
     * <p>
     * Jogadores que possuem alguma lesão ativa <strong>não</strong> são incluídos no ranking.
     * </p>
     *
     * @return Lista de {@link JogadoresResponse.comClube} refletindo os dados do jogador
     * 	acrescidos do <strong>nome do clube</strong> ao qual ele pertence
     */
    @GetMapping("/jogadores/overall")
    public List<JogadoresResponse.comClube> listarJogadoresPorOverAll(){
    	return jogadoresService.listarPorOverall();
    }
    
    /**
     * Lista as estatísticas de todos os jogadores de um clube.
     * <p>
     * Os resultados vêm ordenados pelo nome do jogador e, dentro de cada jogador,
     * do ano mais recente para o mais antigo.
     * </p>
     *
     * @param clube_idClube Parâmetro usado como id do clube dono dos jogadores
     * @return Lista de {@link EstatisticasJogadorCompeticaoResponse} contendo, por jogador, competição e ano:
     * 	<ul>
     * 		<li>Jogos, gols e assistências</li>
     * 		<li>Nota média</li>
     * 	</ul>
     */
    @GetMapping("/jogadores/clube/{clube_idClube}/estatisticas")
    public List<EstatisticasJogadorCompeticaoResponse> listarEstatisticasJogadoresPorClube(
            @PathVariable Integer clube_idClube) {
        return estatisticaJogadoresService.estatisticasPorClube(clube_idClube);
    }
    
    /**
     * Lista as estatísticas de um jogador em todas as competições que disputou.
     *
     * @param id Parâmetro usado como id do jogador que será consultado
     * @return Lista de {@link EstatisticasJogadorCompeticaoResponse} contendo, por competição e ano:
     * 	<ul>
     * 		<li>Nome da competição e ano</li>
     * 		<li>Jogos, gols e assistências</li>
     * 		<li>Nota média</li>
     * 	</ul>
     */
    @CrossOrigin(origins="http://localhost")
    @GetMapping("/jogador/{id}/estatistica")
    public List<EstatisticasJogadorCompeticaoResponse> estatisticaJogador(@PathVariable Integer id) {
        return estatisticaJogadoresService.estatisticas(id);
    }
    
    /**
     * Lista as estatísticas de todos os jogadores de uma competição.
     * <p>
     * Os resultados vêm ordenados pelo número de <strong>gols</strong>, do maior para o menor
     * (artilharia da competição).
     * </p>
     *
     * @param id Parâmetro usado como id da <strong>competição</strong> (e não do jogador)
     * @return Lista de {@link EstatisticasJogadorCompeticaoResponse} contendo jogos, gols,
     * 	assistências e nota média de cada jogador na competição
     */
    @GetMapping("/jogador/competicao/{id}/estatistica")
    public List<EstatisticasJogadorCompeticaoResponse> estatisticaJogadorFull(@PathVariable Integer id) {
        return estatisticaJogadoresService.estatisticasFull(id);
    }
    
    /**
     * Lista as lesões de todos os jogadores de um clube (departamento médico).
     *
     * @param clube_idClube Parâmetro usado como id do clube dono dos jogadores
     * @return Lista de {@link LesaoJogadorResponse} contendo:
     * 	<ul>
     * 		<li>ID do jogador lesionado</li>
     * 		<li>ID e nome da lesão</li>
     * 		<li>Tempo de lesão</li>
     * 		<li>Gravidade da lesão</li>
     * 	</ul>
     */
    @GetMapping("/jogadores/clube/{clube_idClube}/lesoes")
    public List<LesaoJogadorResponse> listarLesoesPorClube(@PathVariable Integer clube_idClube) {
        return jogadorLesaoService.listarLesoesPorClube(clube_idClube);
    }

    /**
     * Lista as lesões de um jogador específico.
     *
     * @param id Parâmetro usado como id do jogador que será consultado
     * @return Lista de {@link LesaoResponse} contendo ID, nome, tempo de lesão e gravidade de cada lesão.
     * 	Retorna uma lista vazia caso o jogador não esteja lesionado
     */
    @GetMapping("/jogador/{id}/lesoes")
    public List<LesaoResponse> listarLesoesJogador(@PathVariable Integer id) {
        return jogadorLesaoService.listarLesoesJogador(id);
    }
    
    @PutMapping("/jogador/{id}")
    public ResponseEntity<JogadoresResponse> atualizarTitularidadeJogador(@PathVariable Integer id, @RequestBody @Valid JogadoresRequest.titularidade request){
    	return ResponseEntity.ok(jogadoresService.atualizarPorId(id, request));
    }
}
package com.manager.api.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.manager.api.repository.JogadorHasLesaoRepository;
import com.manager.api.responses.EstatisticasJogadorCompeticaoResponse;
import com.manager.api.responses.JogadorHasCartoesResponse;
import com.manager.api.responses.JogadoresResponse;
import com.manager.api.responses.LesaoJogadorResponse;
import com.manager.api.responses.LesaoResponse;
import com.manager.api.service.EstatisticaJogadoresService;
import com.manager.api.service.JogadorHasCartoesService;
import com.manager.api.service.JogadorLesaoService;
import com.manager.api.service.JogadoresService;
import com.manager.api.requests.JogadorHasCartoesRequest;
import com.manager.api.requests.JogadoresRequest;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import jakarta.validation.Valid;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "Jogadores", description = "Elenco, ranking, estatísticas e lesões dos jogadores")
@RestController
public class JogadoresController {

    private final JogadoresService jogadoresService;
    private final EstatisticaJogadoresService estatisticaJogadoresService;
    private final JogadorLesaoService jogadorLesaoService;
    private final JogadorHasCartoesService jogadorHasCartoesService;

    public JogadoresController(JogadoresService jogadoresService, EstatisticaJogadoresService estatisticaJogadoresService, JogadorLesaoService jogadorLesaoService, JogadorHasCartoesService jogadorHasCartoesService) {
		this.jogadoresService = jogadoresService;
		this.estatisticaJogadoresService = estatisticaJogadoresService;
		this.jogadorLesaoService = jogadorLesaoService;
		this.jogadorHasCartoesService=jogadorHasCartoesService;
    }

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
    @Operation(summary = "Lista jogadores por clube", description = "Com todos=true retorna o elenco completo. Com todos=false retorna apenas os jogadores que não são titulares.")
    @Parameter(name = "clube_idClube", description = "ID do clube dono dos jogadores", example = "1")
    @Parameter(name = "todos", description = "true = elenco completo; false = apenas não titulares", example = "true")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Jogadores do clube")
    })
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
    @Operation(summary = "Ranking de jogadores por overall", description = "Do maior para o menor overall, já com o nome do clube. Jogadores com lesão ativa ficam fora do ranking.")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Ranking de jogadores")
    })
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
    @Operation(summary = "Lista as estatísticas dos jogadores de um clube", description = "Ordenadas pelo nome do jogador e, dentro de cada um, do ano mais recente para o mais antigo.")
    @Parameter(name = "clube_idClube", description = "ID do clube dono dos jogadores", example = "1")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Estatísticas dos jogadores")
    })
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
    @Operation(summary = "Lista as estatísticas de um jogador", description = "Todas as competições e anos que o jogador disputou: jogos, gols, assistências e nota média.")
    @Parameter(name = "id", description = "ID do jogador", example = "1")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Estatísticas do jogador")
    })
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
    @Operation(summary = "Lista a artilharia de uma competição", description = "Estatísticas de todos os jogadores da competição, ordenadas por gols (do maior para o menor).")
    @Parameter(name = "id", description = "ID da competição (e não do jogador)", example = "1")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Estatísticas da competição")
    })
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
    @Operation(summary = "Lista as lesões de um clube", description = "Departamento médico: lesões de todos os jogadores do clube.")
    @Parameter(name = "clube_idClube", description = "ID do clube dono dos jogadores", example = "1")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Lesões do clube")
    })
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
    @Operation(summary = "Lista as lesões de um jogador", description = "Retorna lista vazia se o jogador não estiver lesionado.")
    @Parameter(name = "id", description = "ID do jogador", example = "1")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Lesões do jogador")
    })
    @GetMapping("/jogador/{id}/lesoes")
    public List<LesaoResponse> listarLesoesJogador(@PathVariable Integer id) {
        return jogadorLesaoService.listarLesoesJogador(id);
    }
    
    /**
     * Atualiza a titularidade de um jogador.
     *
     * @param id Parâmetro usado como id do jogador que será atualizado
     * @param request {@link JogadoresRequest.titularidade} no corpo da requisição, contendo o novo valor de <strong>titular</strong>
     * @return {@link ResponseEntity} com status <strong>200 (OK)</strong> e o {@link JogadoresResponse} do jogador já atualizado
     * @throws ResponseStatusException com status <strong>404 (Not Found)</strong> caso nenhum jogador seja encontrado com o <strong>id</strong> informado
     */
    @Operation(summary = "Atualiza a titularidade de um jogador", description = "Altera apenas o campo titular e devolve o jogador já atualizado.")
    @Parameter(name = "id", description = "ID do jogador", example = "1")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Jogador atualizado"),
        @ApiResponse(responseCode = "404", description = "Jogador não encontrado", content = @Content)
    })
    @PutMapping("/jogador/{id}")
    public ResponseEntity<JogadoresResponse> atualizarTitularidadeJogador(@PathVariable Integer id, @RequestBody @Valid JogadoresRequest.titularidade request){
    	return ResponseEntity.ok(jogadoresService.atualizarPorId(id, request));
    }
    
    @GetMapping("/jogador/{id}/cartoes")
    public List<JogadorHasCartoesResponse> buscarCartoesJogador(@PathVariable Integer id){
    	return jogadorHasCartoesService.buscarCartaoJogador(id);
    }
    
    @PostMapping("/jogador/{id}/cartoes")
    public ResponseEntity<JogadoresResponse> adicionarCartaoJogador(@PathVariable Integer id, @RequestBody @Valid JogadorHasCartoesRequest request){
    	return ResponseEntity.ok(jogadorHasCartoesService.adicionarCartaoJogador(id, request));
    }
}
package com.manager.api.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.manager.api.enums.competicao.TipoCompeticao;
import com.manager.api.model.Competicao;
import com.manager.api.repository.CompeticaoRepository;
import com.manager.api.responses.ClubeCompeticaoResponse;
import com.manager.api.responses.CompeticaoResponse;
import com.manager.api.service.ClubeCompeticaoService;
import com.manager.api.service.CompeticaoService;

@RestController
public class CompeticaoController {

    private final CompeticaoRepository competicaoRepository;
    private final CompeticaoService competicaoService;
    private final ClubeCompeticaoService clubeCompeticaoService;

    public CompeticaoController(CompeticaoRepository competicaoRepository, CompeticaoService competicaoService, ClubeCompeticaoService clubeCompeticaoService) {
        this.competicaoRepository = competicaoRepository;
        this.competicaoService = competicaoService;
        this.clubeCompeticaoService = clubeCompeticaoService;
    }

    /**
     * Lista as competições cadastradas, com filtro opcional por tipo.
     * <p>
     * Caso o filtro não seja informado, retorna todas as competições registradas.
     * </p>
     *
     * @param tipo Parâmetro <strong>opcional</strong> do tipo {@link TipoCompeticao}, pode ser:
     * 	<ul>
     * 		<li>PONTOS_CORRIDOS</li>
     * 		<li>MATA_MATA</li>
     * 		<li>MISTO</li>
     * 	</ul>
     * @return Lista de {@link Competicao} correspondentes ao filtro aplicado, ou a lista completa caso nenhum filtro seja informado
     */
    @GetMapping("/competicoes")
    public List<Competicao> listarCompeticoes(@RequestParam(required = false) TipoCompeticao tipo) {
        if (tipo != null) {
            return competicaoRepository.findByTipoCompeticao(tipo);
        }
        return competicaoRepository.findAll();
    }
    
    /**
     * Busca os dados de uma competição a partir do seu identificador.
     *
     * @param id Parâmetro usado como id da competição que será consultada
     * @return {@link Optional} de {@link CompeticaoResponse} contendo:
     * 	<ul>
     * 		<li>Nome, ano e status da competição (não iniciada, em andamento ou finalizada)</li>
     * 		<li>Tipo (pontos corridos, mata-mata ou misto) e nível (nacional, continental ou estadual)</li>
     * 		<li>Valor do prêmio e prêmio por vitória</li>
     * 	</ul>
     * 	Retorna vazio caso nenhuma competição seja encontrada com o <strong>id</strong> informado
     */
    @GetMapping("/competicoes/{id}")
    public Optional<CompeticaoResponse> buscarCompeticao(@PathVariable Integer id){
    	return competicaoService.buscarCompeticao(id);
    }
    
    /**
     * Lista os clubes participantes de uma competição, em formato resumido.
     * <p>
     * Traz apenas o necessário para exibição e seleção de clubes.
     * </p>
     *
     * @param id Parâmetro usado como id da competição que será consultada
     * @return Lista de {@link ClubeCompeticaoResponse.ClubeResponse.ClubeFotoNomeResponse} contendo:
     * 	<ul>
     * 		<li>ID e nome do clube</li>
     * 		<li>Foto (escudo) do clube</li>
     * 		<li>Orçamento disponível</li>
     * 	</ul>
     */
    @GetMapping("/competicoes/{id}/clubes")
    public List<ClubeCompeticaoResponse.ClubeResponse.ClubeFotoNomeResponse> listarClubesDaCompeticao(@PathVariable Integer id) {
        return clubeCompeticaoService.listarClubeFotoNome(id);
    }

    /**
     * Busca a tabela de classificação de uma competição.
     * <p>
     * Os clubes são retornados em ordem <strong>decrescente de pontos</strong>,
     * ou seja, o líder da competição vem primeiro.
     * </p>
     *
     * @param id Parâmetro usado como id da competição que será consultada
     * @return Lista de {@link ClubeCompeticaoResponse.IdClubeIdCompeticaoPontosFaseAtual} contendo:
     * 	<ul>
     * 		<li>ID e nome do clube</li>
     * 		<li>ID da competição</li>
     * 		<li>Pontos acumulados</li>
     * 		<li>Fase atual do clube na competição</li>
     * 	</ul>
     */
    @GetMapping("/competicoes/{id}/classificacao")
    public List<ClubeCompeticaoResponse.IdClubeIdCompeticaoPontosFaseAtual> classificacao(@PathVariable Integer id) {
        return clubeCompeticaoService.listarClassificacao(id);
    }
}
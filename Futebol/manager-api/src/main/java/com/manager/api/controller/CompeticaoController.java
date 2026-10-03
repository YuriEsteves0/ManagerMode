package com.manager.api.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.manager.api.enums.competicao.TipoCompeticao;
import com.manager.api.model.Competicao;
import com.manager.api.repository.CompeticaoRepository;
import com.manager.api.responses.ClubeCompeticaoResponse;
import com.manager.api.service.ClubeCompeticaoService;

@RestController
public class CompeticaoController {

    private final CompeticaoRepository competicaoRepository;
    private final ClubeCompeticaoService clubeCompeticaoService;

    public CompeticaoController(CompeticaoRepository competicaoRepository, ClubeCompeticaoService clubeCompeticaoService) {
        this.competicaoRepository = competicaoRepository;
        this.clubeCompeticaoService = clubeCompeticaoService;
    }

    /**
     * Endpoint para listagem de competições cadastradas.
     * <p>
     * Permite a filtragem opcional por tipo de competição. Caso o filtro não seja
     * informado, retorna todas as competições registradas.
     * 
     * @param tipo Filtro opcional do tipo {@link TipoCompeticao} para restringir a busca
     * @return Lista de objetos {@link Competicao} correspondentes ao filtro aplicado ou a lista completa
     */
    @GetMapping("/competicoes")
    public List<Competicao> listarCompeticoes(@RequestParam(required = false) TipoCompeticao tipo) {
        if (tipo != null) {
            return competicaoRepository.findByTipoCompeticao(tipo);
        }
        return competicaoRepository.findAll();
    }
    
/**
     * Retorna a lista enxuta de todos os clubes participantes de uma competição específica.
     * <p>
     * Fornece informações básicas necessárias para exibição e seleção de clubes 
     * (ID, nome, escudo e orçamento).
     * 
     * @param id Identificador único da competição
     * @return Lista formatada conforme {@link ClubeCompeticaoService#listarClubeFotoNome(Integer)}
     */
    @GetMapping("/competicoes/{id}/clubes")
    public List<ClubeCompeticaoResponse.ClubeResponse.ClubeFotoNomeResponse> listarClubesDaCompeticao(@PathVariable Integer id) {
        return clubeCompeticaoService.listarClubeFotoNome(id);
    }

    /**
     * Retorna a tabela de classificação resumida de uma competição.
     * <p>
     * Traz os clubes ordenados de forma decrescente pela pontuação acumulada.
     * 
     * @param id Identificador único da competição
     * @return Lista formatada conforme {@link ClubeCompeticaoService#listarClassificacao(Integer)}
     */
    @GetMapping("/competicoes/{id}/classificacao")
    public List<ClubeCompeticaoResponse.IdClubeIdCompeticaoPontosFaseAtual> classificacao(@PathVariable Integer id) {
        return clubeCompeticaoService.listarClassificacao(id);
    }
}
package com.manager.api.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.manager.api.repository.ClubeCompeticaoRepository;
import com.manager.api.responses.ClubeCompeticaoResponse;

@Service
public class ClubeCompeticaoService {

    private final ClubeCompeticaoRepository repository;

    public ClubeCompeticaoService(ClubeCompeticaoRepository repository) {
        this.repository = repository;
    }

    /**
     * Busca todos os dados de classificação dos clubes em uma determinada competição,
     * ordenados de forma decrescente pela pontuação.
     * <p>
     * Dados retornados:
     * <ul>
     *   <li>ID do clube</li>
     *   <li>ID da competição</li>
     *   <li>Quantidade de pontos acumulados</li>
     *   <li>Fase atual na competição</li>
     *   <li>Status de eliminação (booleano)</li>
     * </ul>
     * 
     * @param competicaoId Identificador único da competição
     * @return Lista de {@link ClubeCompeticaoResponse} ordenada decrescentemente por pontos
     */
    public List<ClubeCompeticaoResponse> listarClassificacaoFull(Integer competicaoId) {
        return repository.findByCompeticao_IdOrderByPontosDesc(competicaoId)
            .stream()
            .map(cc -> new ClubeCompeticaoResponse(
                cc.getClube().getId(),
                cc.getCompeticao().getIdCompeticao(),
                cc.getPontos(),
                cc.getFaseAtual(),
                cc.getEliminado()
            ))
            .toList();
    }

    /**
     * Busca dados resumidos da classificação dos clubes em uma determinada competição,
     * ordenados de forma decrescente pela pontuação.
     * <p>
     * Dados retornados:
     * <ul>
     *   <li>ID do clube</li>
     *   <li>Nome do clube</li>
     *   <li>ID da competição</li>
     *   <li>Quantidade de pontos acumulados</li>
     *   <li>Fase atual na competição</li>
     * </ul>
     * 
     * @param competicaoId Identificador único da competição
     * @return Lista de {@link ClubeCompeticaoResponse.IdClubeIdCompeticaoPontosFaseAtual} ordenada decrescentemente por pontos
     */
    public List<ClubeCompeticaoResponse.IdClubeIdCompeticaoPontosFaseAtual> listarClassificacao(Integer competicaoId) {
        return repository.findByCompeticao_IdOrderByPontosDesc(competicaoId)
            .stream()
            .map(cc -> new ClubeCompeticaoResponse.IdClubeIdCompeticaoPontosFaseAtual(
                cc.getClube().getId(),
                cc.getClube().getNomeClube(),
                cc.getCompeticao().getIdCompeticao(),
                cc.getPontos(),
                cc.getFaseAtual()
            ))
            .toList();
    }

    /**
     * Busca dados enxutos dos clubes que participam de uma competição específica.
     * <p>
     * Dados retornados:
     * <ul>
     *   <li>ID do clube</li>
     *   <li>Nome do clube</li>
     *   <li>URL/Caminho do escudo do clube</li>
     *   <li>Orçamento disponível do clube</li>
     * </ul>
     * 
     * @param competicaoId Identificador único da competição
     * @return Lista de {@link ClubeCompeticaoResponse.ClubeResponse.ClubeFotoNomeResponse}
     */
    public List<ClubeCompeticaoResponse.ClubeResponse.ClubeFotoNomeResponse> listarClubeFotoNome(Integer competicaoId) {
        return repository.findByCompeticao_Id(competicaoId)
            .stream()
            .map(cc -> new ClubeCompeticaoResponse.ClubeResponse.ClubeFotoNomeResponse(
                cc.getClube().getId(),
                cc.getClube().getNomeClube(),
                cc.getClube().getFoto(),
                cc.getClube().getOrcamento()
            ))
            .toList();
    }
}
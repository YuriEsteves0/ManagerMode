package com.manager.api.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.manager.api.model.ClubeHasUpgrade;
import com.manager.api.responses.ClubeCompeticaoResponse;
import com.manager.api.responses.ClubeHasTreinoResponse;
import com.manager.api.responses.ClubeHasUpgradeResponse;
import com.manager.api.responses.ClubeResponse;
import com.manager.api.responses.EstatisticaAnoClubeResponse;
import com.manager.api.responses.PatrocinadorResponse;
import com.manager.api.responses.PropostaTransferenciaResponse;
import com.manager.api.responses.UpgradeResponse;
import com.manager.api.service.ClubeCompeticaoService;
import com.manager.api.service.ClubeHasTreinoService;
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
    private final ClubeHasTreinoService clubeHasTreinoService;

    public ClubeController(ClubeService clubeService, PatrocinadorService patrocinadorService, EstatisticasAnoClubeService estatisticasAnoClubeService, ClubeHasUpgradeService clubeHasUpgradeService, PropostaTransferenciaService propostaTransferenciaService, ClubeHasTreinoService clubeHasTreinoService) {
        this.clubeService = clubeService; 
        this.patrocinadorService = patrocinadorService;
        this.estatisticasAnoClubeService = estatisticasAnoClubeService;
        this.clubeHasUpgradeService = clubeHasUpgradeService;
        this.propostaTransferenciaService= propostaTransferenciaService;
        this.clubeHasTreinoService = clubeHasTreinoService;
    }

    /**
     * Busca os dados completos de um clube a partir do seu identificador.
     * <p>
     * Retorna as informações gerais do clube, como orçamento, valor de mercado,
     * reputação, torcida, patrocinador, estádio e o nível de confiança da diretoria.
     * </p>
     *
     * @param id Parâmetro usado como id do clube que será consultado
     * @return {@link ClubeResponse} refletindo os dados do clube, contendo:
     * 	<ul>
     * 		<li>Nome, foto e dados do estádio (nome e capacidade)</li>
     * 		<li>Dados financeiros (orçamento, valor do clube e camisas vendidas)</li>
     * 		<li>Dados de torcida e reputação (quantidade de torcedores e reputação)</li>
     * 		<li>Patrocinador atual (pode ser <strong>null</strong> caso não haja patrocinador)</li>
     * 		<li>Dados da diretoria (confiança, status de confiança e evento atual)</li>
     * 	</ul>
     * @throws RuntimeException caso nenhum clube seja encontrado com o <strong>id</strong> informado
     */
    @GetMapping("/clubes/{id}")
    public ClubeResponse buscarClubePorId(@PathVariable Integer id) {
        return clubeService.buscarClube(id);
    }
    
    /**
     * Busca o nome do patrocinador atual de um clube.
     *
     * @param id Parâmetro usado como id do clube que será consultado
     * @return {@link Optional} de {@link PatrocinadorResponse.Nome} contendo apenas o nome do patrocinador.
     * 	Retorna vazio caso o clube não exista ou não possua patrocinador
     */
    @GetMapping("/clubes/{id}/patrocinador")
    public Optional<PatrocinadorResponse.Nome> patrocinadorDoClubeNome(@PathVariable Integer id){
    	return patrocinadorService.buscarPorClube(id);
    }
    
    /**
     * Lista o histórico de estatísticas de um clube, ano a ano.
     * <p>
     * Cada item representa uma temporada do clube, com a campanha daquele ano.
     * </p>
     *
     * @param id Parâmetro usado como id do clube que será consultado
     * @return Lista de {@link EstatisticaAnoClubeResponse} contendo, por ano:
     * 	<ul>
     * 		<li>Jogos disputados</li>
     * 		<li>Vitórias, empates e derrotas</li>
     * 		<li>Gols feitos e gols sofridos</li>
     * 	</ul>
     */
    @GetMapping("/clubes/{id}/estatisticasAno")
    public List<EstatisticaAnoClubeResponse> listarEstatisticasAnoClube(@PathVariable Integer id){
    	return estatisticasAnoClubeService.listarEstatisticasAnoClube(id);
    }
    
    /**
     * Busca as estatísticas de um clube em um ano específico.
     * <p>
     * Caso o clube tenha mais de um registro no mesmo ano (ex: várias competições),
     * os valores são <strong>somados</strong> e retornados como um único resultado.
     * </p>
     *
     * @param id Parâmetro usado como id do clube que será consultado
     * @param ano Parâmetro usado como ano (temporada) das estatísticas. Ex: 2026
     * @return {@link EstatisticaAnoClubeResponse} com jogos, vitórias, empates, derrotas,
     * 	gols feitos e gols sofridos do ano informado.
     * 	Retorna <strong>null</strong> caso não exista nenhum registro para o clube naquele ano
     */
    @GetMapping("/clubes/{id}/estatisticasAno/{ano}")
    public EstatisticaAnoClubeResponse buscarEstatisticaPorClubeEAno(
            @PathVariable Integer id, 
            @PathVariable Integer ano) {
        return estatisticasAnoClubeService.buscarEstatisticaPorClubeEAno(id, ano);
    }
    
    /**
     * Lista todos os upgrades que um clube possui.
     * <p>
     * Une os dados do upgrade (nome, preço, tipo, descrição e modificador) com o
     * progresso do clube nele (nível atual e nível máximo).
     * </p>
     *
     * @param id Parâmetro usado como id do clube que será consultado
     * @return Lista de {@link ClubeHasUpgradeResponse} refletindo os upgrades do clube,
     * 	incluindo o <strong>nivelAtual</strong> e o <strong>nivelMaximo</strong> de cada um
     */
    @GetMapping("/clubes/{id}/upgrades")
    public List<ClubeHasUpgradeResponse> listarUpgradesClube(@PathVariable Integer id){
    	return clubeHasUpgradeService.listarUpgradesClubeComNome(id);
    }
    
    /**
     * Busca todas as transferências (enviadas / recebidas) de um clube, conforme o parâmetro <strong>tipoTransferencia</strong>.
     *
     * @param id Parâmetro usado como id do clube que será consultado
     * @param tipoTransferencia Define o ponto de vista do clube na proposta (não diferencia maiúsculas de minúsculas).
     * 	Pode ser dois tipos:
     * 	<ul>
     * 		<li><strong>Enviada</strong>: propostas feitas pelo clube, interessado em jogadores de outros clubes</li>
     * 		<li><strong>Recebida</strong>: propostas feitas por outros clubes por jogadores do clube</li>
     * 	</ul>
     * @return Lista de {@link PropostaTransferenciaResponse} refletindo os dados da proposta de transferência
     * 	(valor oferecido, status, jogador envolvido e clubes de origem e destino)
     * @throws ResponseStatusException com status <strong>400 (Bad Request)</strong> caso o
     * 	<strong>tipoTransferencia</strong> não seja "enviada" nem "recebida"
     */
    @GetMapping("/clubes/{id}/transferencias")
    public List<PropostaTransferenciaResponse> listarTransferencias(
    		@PathVariable Integer id,
    		@RequestParam String tipoTransferencia) {
    	return propostaTransferenciaService.transferencia(id, tipoTransferencia);
    }
    
    @GetMapping("/clubes/{id}/treino")
    public List<ClubeHasTreinoResponse> listarTreinos(@PathVariable Integer id){
    	return clubeHasTreinoService.buscarPorClube(id);
    }
}

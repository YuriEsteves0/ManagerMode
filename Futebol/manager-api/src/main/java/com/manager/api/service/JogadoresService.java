package com.manager.api.service;


import java.util.List;

import org.springframework.stereotype.Service;

import com.manager.api.repository.JogadoresRepository;
import com.manager.api.responses.JogadoresResponse;

@Service
public class JogadoresService{
	private final JogadoresRepository jogadoresRepository;
	
	public JogadoresService(JogadoresRepository jogadoresRepository) {
		this.jogadoresRepository = jogadoresRepository;
	}
	
	
	/**
     * Busca os dados resumidos dos jogadores pertencentes a um determinado clube.
     * <p>
     * Dados retornados:
     * <ul>
     *   <li>ID do jogador</li>
     *   <li>Nome do jogador</li>
     *   <li>Número da camisa</li>
     *   <li>Status de titularidade (booleano)</li>
     * </ul>
     * 
     * @param clubeId Identificador único do clube
     * @return Lista de {@link JogadoresResponse.NomeCamisaTitular} contendo os dados resumidos dos jogadores
     */
    public List<JogadoresResponse> listarPorClube(Integer clubeId) {
        return jogadoresRepository.findByClubeIdClubeAndTitularFalse(clubeId);
    }
    
    public List<JogadoresResponse> listarPorClubeFull(Integer clubeId){
    	return jogadoresRepository.findByClubeIdClube(clubeId);
    }
    
    public List<JogadoresResponse.comClube> listarPorOverall(){
    	return jogadoresRepository.findAllByOrderByOverallDesc();
    }
}
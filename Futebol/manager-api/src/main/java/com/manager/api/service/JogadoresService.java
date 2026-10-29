package com.manager.api.service;


import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.manager.api.model.Jogadores;
import com.manager.api.repository.JogadoresRepository;
import com.manager.api.requests.JogadoresRequest;
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
    
    public JogadoresResponse atualizarPorId(Integer id, JogadoresRequest.titularidade request) {
    	Jogadores jogador = jogadoresRepository.findById(id).orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Jogador não encontrado!"));
    	
    	jogador.setTitular(request.titular());
    	
    	Jogadores atualizado = jogadoresRepository.save(jogador);
    	
    	return new JogadoresResponse(
    			atualizado.getIdJogador(),
    			atualizado.getNomeJogador(),
    			atualizado.getNumeroCamisa(),
    			atualizado.getIdade(),
    			atualizado.getPosicaoPrincipal(),
    			atualizado.getOverall(),
    			atualizado.getVelocidade(),
    			atualizado.getForca(),
    			atualizado.getInteligencia(),
    			atualizado.getFinalizacao(),
    			atualizado.getMarcacao(),
    			atualizado.getPasse(),
    			atualizado.getPotencial(),
    			atualizado.getTitular(),
    			atualizado.getMoral(),
    			atualizado.getNacionalidade(),
    			atualizado.getDispEmprestimo(),
    			atualizado.getSatisfacao(),
    			atualizado.getOnfire(),
    			atualizado.getValor(),
    			atualizado.getValorRescisao(),
    			atualizado.getSalario(),
    			atualizado.getTempoContrato(),
    			atualizado.getClubeIdClube(),
    			atualizado.getPosicaoX(),
    			atualizado.getPosicaoY()
    	);
    }
    
}
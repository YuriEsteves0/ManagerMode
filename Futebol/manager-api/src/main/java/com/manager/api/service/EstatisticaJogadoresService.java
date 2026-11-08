package com.manager.api.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.manager.api.model.Competicao;
import com.manager.api.model.EstatisticaJogador;
import com.manager.api.model.EstatisticaJogadorId;
import com.manager.api.model.Jogadores;
import com.manager.api.repository.CompeticaoRepository;
import com.manager.api.repository.EstatisticasJogadorCompeticaoRepository;
import com.manager.api.repository.JogadoresRepository;
import com.manager.api.requests.EstatisticasJogadorCompeticaoRequest;
import com.manager.api.responses.EstatisticasJogadorCompeticaoResponse;

import jakarta.transaction.Transactional;

@Service
public class EstatisticaJogadoresService {

	private final EstatisticasJogadorCompeticaoRepository repository;
	private final JogadoresRepository jogadoresRepository;
	private final CompeticaoRepository competicaoRepository;

	public EstatisticaJogadoresService(EstatisticasJogadorCompeticaoRepository repository,
	                                   JogadoresRepository jogadoresRepository,
	                                   CompeticaoRepository competicaoRepository) {
	    this.repository = repository;
	    this.jogadoresRepository = jogadoresRepository;
	    this.competicaoRepository = competicaoRepository;
	}

    public List<EstatisticasJogadorCompeticaoResponse> estatisticas(Integer id) {
        return repository.buscarPorJogador(id);
    }


    public List<EstatisticasJogadorCompeticaoResponse> estatisticasFull(Integer idCompeticao) {
        List<EstatisticasJogadorCompeticaoResponse> lista = repository.buscarTodosJogadores(idCompeticao);

        boolean ninguemMarcou = lista.isEmpty()
                || lista.get(0).gols() == null
                || lista.get(0).gols() == 0;

        if (ninguemMarcou) {
            List<EstatisticasJogadorCompeticaoResponse> base = lista.isEmpty()
                    ? new ArrayList<>(repository.buscarJogadoresDaCompeticao(idCompeticao))
                    : new ArrayList<>(lista);

            Collections.shuffle(base);
            return base.subList(0, Math.min(5, base.size()));
        }

        // Há artilheiros: devolve só os 5 primeiros (a lista já vem ordenada por gols)
        return lista.subList(0, Math.min(5, lista.size()));
    }
    
    public List<EstatisticasJogadorCompeticaoResponse> estatisticasPorClube(Integer idClube) {
        return repository.buscarPorClube(idClube);
    }
    
    @Transactional
    public EstatisticasJogadorCompeticaoResponse.atualizarDados atualizarDadosJogador(
            Integer idJogador, Integer idCompeticao,
            EstatisticasJogadorCompeticaoRequest.atualizarDadosJogador request) {

    	EstatisticaJogadorId id = new EstatisticaJogadorId();
    	id.setJogadorId(idJogador);
    	id.setCompeticaoId(idCompeticao);

    	EstatisticaJogador ej = repository.findById(id).orElseGet(() -> {
    	    Jogadores jogador = jogadoresRepository.findById(idJogador)
    	            .orElseThrow(() -> new ResponseStatusException(
    	                    HttpStatus.NOT_FOUND, "Jogador não encontrado!"));
    	    Competicao competicao = competicaoRepository.findById(idCompeticao)
    	            .orElseThrow(() -> new ResponseStatusException(
    	                    HttpStatus.NOT_FOUND, "Competição não encontrada!"));

    	    EstatisticaJogador novo = new EstatisticaJogador();
    	    novo.setId(id);
    	    novo.setJogador(jogador);       // necessário por causa do @MapsId
    	    novo.setCompeticao(competicao); // idem
    	    novo.setAno(competicao.getAno());
    	    novo.setJogos(0);
    	    novo.setGols(0);
    	    novo.setAssistencias(0);
    	    novo.setNotaMedia(0.0);
    	    return novo;
    	});
    	
    	int jogosAntes = ej.getJogos() == null ? 0 : ej.getJogos();
    	double mediaAntes = ej.getNotaMedia() == null ? 0.0 : ej.getNotaMedia();

    	// média acumulada (calcular ANTES de atualizar os jogos)
    	double novaMedia = (mediaAntes * jogosAntes + request.notaPartida()) / (jogosAntes + 1);

    	ej.setJogos(jogosAntes + 1);
    	ej.setNotaMedia(Math.round(novaMedia * 10.0) / 10.0);

    	int golsAtuais = ej.getGols() == null ? 0 : ej.getGols();
    	ej.setGols(golsAtuais + request.gols());

    	int assistAtuais = ej.getAssistencias() == null ? 0 : ej.getAssistencias();
    	ej.setAssistencias(assistAtuais + request.assistencias());

    	EstatisticaJogador salvo = repository.save(ej);

    	return new EstatisticasJogadorCompeticaoResponse.atualizarDados(
    			idJogador,
    			idCompeticao,
    			salvo.getAno(),
    			salvo.getJogos(),
    			salvo.getGols(),
    			salvo.getAssistencias(),
    			salvo.getNotaMedia());
    
    }
}
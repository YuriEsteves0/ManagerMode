package com.manager.api.service;

import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.manager.api.model.ClubeCompeticao;
import com.manager.api.model.ClubeCompeticaoId;
import com.manager.api.repository.ClubeCompeticaoRepository;
import com.manager.api.repository.CompeticaoRepository;
import com.manager.api.requests.CompeticaoRequest;
import com.manager.api.responses.ClubeCompeticaoResponse;
import com.manager.api.responses.CompeticaoResponse;

import jakarta.transaction.Transactional;

@Service
public class CompeticaoService{
	private final CompeticaoRepository competicaoRepository;
	private final ClubeCompeticaoRepository clubeCompeticaoRepository;
	
	public CompeticaoService(CompeticaoRepository competicaoRepository, ClubeCompeticaoRepository clubeCompeticaoRepository) {
		this.competicaoRepository = competicaoRepository;
		this.clubeCompeticaoRepository=clubeCompeticaoRepository;
	}
	
	public Optional<CompeticaoResponse> buscarCompeticao(Integer idClube){
		return competicaoRepository.findByIdCompeticao(idClube);
	}
	
	@Transactional
	public ClubeCompeticaoResponse.IdClubeIdCompeticaoPontosFaseAtual atualizarTabela(Integer idClube, CompeticaoRequest.atualizarTabelaPontosCorridos request) {
	    ClubeCompeticaoId id = new ClubeCompeticaoId();
	    id.setClubeID(idClube);
	    id.setCompeticaoID(request.idCompeticao());

	    ClubeCompeticao cc = clubeCompeticaoRepository.findById(id)
	            .orElseThrow(() -> new ResponseStatusException(
	                    HttpStatus.NOT_FOUND, "Clube não encontrado nessa competição"));

	    int pontosAtuais = cc.getPontos() == null ? 0 : cc.getPontos();
	    cc.setPontos(pontosAtuais + request.pontosAdicionados());

	    ClubeCompeticao salvo = clubeCompeticaoRepository.save(cc);

	    return new ClubeCompeticaoResponse.IdClubeIdCompeticaoPontosFaseAtual(
	            idClube,
	            salvo.getClube().getNomeClube(),
	            request.idCompeticao(),
	            salvo.getPontos(),
	            salvo.getFaseAtual());
	}
}
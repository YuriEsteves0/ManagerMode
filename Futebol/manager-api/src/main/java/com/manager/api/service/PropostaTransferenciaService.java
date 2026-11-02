package com.manager.api.service;

import java.util.List;
import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.manager.api.enums.proposta.StatusProposta;
import com.manager.api.model.Clube;
import com.manager.api.model.Jogadores;
import com.manager.api.model.PropostaTransferencia;
import com.manager.api.repository.ClubeRepository;
import com.manager.api.repository.JogadoresRepository;
import com.manager.api.repository.PropostaTransferenciaRepository;
import com.manager.api.requests.PropostaTransferenciaRequest;
import com.manager.api.responses.ClubeResponse;
import com.manager.api.responses.JogadoresResponse;
import com.manager.api.responses.PropostaTransferenciaResponse;

import jakarta.transaction.Transactional;

@Service
public class PropostaTransferenciaService{
	private final PropostaTransferenciaRepository propostaRepository;
    private final JogadoresRepository jogadorRepository;
    private final ClubeRepository clubeRepository;

    public PropostaTransferenciaService(PropostaTransferenciaRepository propostaRepository, JogadoresRepository jogadorRepository, ClubeRepository clubeRepository) {
        this.propostaRepository = propostaRepository;
        this.jogadorRepository = jogadorRepository;
        this.clubeRepository = clubeRepository;
    }
    
//    public Optional<PropostaTransferenciaResponse> buscarTransferenciaJogador(Integer idJogador, Integer idClube, String tipoTransferencia){
//    	String tipo = tipoTransferencia == null ? "" : tipoTransferencia.trim().toLowerCase();
//    	
//    	Optional<PropostaTransferencia> proposta = switch(tipo) {
//	    	case "recebida","recebidas" -> propostaRepository.findByJogador_IdJogadorAndClubeInterior_Id(idJogador, idClube);
//	    	case "enviada","enviadas" -> propostaRepository.findByJogador_IdJogadorAndClubeExterior_Id(idJogador, idClube);
//	    	default -> throw new ResponseStatusException(HttpStatus.BAD_REQUEST,
//					"tipoTransferencia deve ser 'enviada' ou 'recebida'");
//    	};
//    	
//    	return proposta;
//    }
	
	public List<PropostaTransferenciaResponse> transferencia(Integer idClube, String tipoTransferencia) {
		String tipo = tipoTransferencia == null ? "" : tipoTransferencia.trim().toLowerCase();

		List<PropostaTransferencia> propostas = switch (tipo) {
			case "recebida", "recebidas" -> propostaRepository.findByClubeInterior_Id(idClube);
			case "enviada", "enviadas"   -> propostaRepository.findByClubeExterior_Id(idClube);
			default -> throw new ResponseStatusException(HttpStatus.BAD_REQUEST,
					"tipoTransferencia deve ser 'enviada' ou 'recebida'");
		};

		return propostas.stream().map(this::toResponse).toList();
	}

	private PropostaTransferenciaResponse toResponse(PropostaTransferencia pt) {
		Clube ext = pt.getClubeExterior();
		Clube inte = pt.getClubeInterior();
		return new PropostaTransferenciaResponse(
				pt.getIdPropostaTransferencia(),
				pt.getValorOferecido(),
				pt.getStatusProposta(),
				pt.getRevelado(),
				pt.getJogador().getIdJogador(),
				toJogadorResponse(pt.getJogador()),
				ext != null ? ext.getId() : null,
				toClubeResponse(ext),
				inte != null ? inte.getId() : null,
				toClubeResponse(inte)
		);
	}

	private ClubeResponse toClubeResponse(Clube c) {
		if(c == null) return null;
	    return new ClubeResponse(
	            c.getId(), c.getNomeClube(), c.getOrcamento(), c.getValorClube(),
	            c.getCamisasVendidas(), c.getQntTorcedores(), c.getReputacao(),
	            c.getPatrocinador_idPatrocinador(), c.getConfiancaDiretoria(),
	            c.getStatusConfianca(), c.getEventoAtual(), c.getCapacidadeEstadio(),
	            c.getFoto(), c.getNomeEstadio()
	    );
	}
	
	private JogadoresResponse toJogadorResponse(Jogadores j) {
	    return new JogadoresResponse(
	            j.getIdJogador(), j.getNomeJogador(), j.getNumeroCamisa(), j.getIdade(),
	            j.getPosicaoPrincipal(), j.getOverall(), j.getVelocidade(), j.getForca(),
	            j.getInteligencia(), j.getFinalizacao(), j.getMarcacao(), j.getPasse(),
	            j.getPotencial(), j.getTitular(), j.getMoral(), j.getNacionalidade(),
	            j.getDispEmprestimo(), j.getSatisfacao(), j.getOnfire(), j.getValor(),
	            j.getValorRescisao(), j.getSalario(), j.getTempoContrato(),
	            j.getClubeIdClube(), j.getPosicaoX(), j.getPosicaoY()
	    );
	}
	
	@Transactional
	public PropostaTransferenciaResponse criarPropostaTransferencia(PropostaTransferenciaRequest request) {
		Jogadores jogador = jogadorRepository.findById(request.idJogador()).orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Jogador não encontrado!"));
		Clube clubeJogador = clubeRepository.findById(request.idClubeInterior()).orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Clube do jogador não encontrado"));
		Clube clubeExterior = clubeRepository.findById(request.idClubeExterior()).orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Clube externo não encontrado!"));
	
		if (propostaRepository.existsByJogador_IdJogadorAndClubeExterior_IdAndStatusProposta(jogador.getIdJogador(), clubeExterior.getId(), StatusProposta.PENDENTE)) {
			throw new ResponseStatusException(HttpStatus.CONFLICT, "Já existe proposta pendente deste clube para este jogador!");
		}
		
		PropostaTransferencia proposta = new PropostaTransferencia();
		proposta.setJogador(jogador);
		proposta.setClubeExterior(clubeExterior);
		proposta.setClubeInterior(clubeJogador);
		proposta.setRevelado(true);
		proposta.setValorOferecido(request.valorOferecido());
		proposta.setStatusProposta(request.statusProposta());
		
		PropostaTransferencia salva = propostaRepository.save(proposta);
		return toResponse(salva);
		
	}
	
}
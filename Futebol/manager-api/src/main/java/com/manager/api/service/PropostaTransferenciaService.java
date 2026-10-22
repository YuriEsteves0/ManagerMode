package com.manager.api.service;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.manager.api.model.Clube;
import com.manager.api.model.Jogadores;
import com.manager.api.model.PropostaTransferencia;
import com.manager.api.repository.PropostaTransferenciaRepository;
import com.manager.api.responses.ClubeResponse;
import com.manager.api.responses.JogadoresResponse;
import com.manager.api.responses.PropostaTransferenciaResponse;

@Service
public class PropostaTransferenciaService{
	private final PropostaTransferenciaRepository repository;
	
	public PropostaTransferenciaService(PropostaTransferenciaRepository repository) {
		this.repository = repository;
	}
	
	public List<PropostaTransferenciaResponse> transferencia(Integer idClube, String tipoTransferencia) {
		String tipo = tipoTransferencia == null ? "" : tipoTransferencia.trim().toLowerCase();

		List<PropostaTransferencia> propostas = switch (tipo) {
			case "recebida", "recebidas" -> repository.findByClubeInterior_Id(idClube);
			case "enviada", "enviadas"   -> repository.findByClubeExterior_Id(idClube);
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
}
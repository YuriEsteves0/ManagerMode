package com.manager.api.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.manager.api.requests.PropostaTransferenciaRequest;
import com.manager.api.responses.PropostaTransferenciaResponse;
import com.manager.api.service.PropostaTransferenciaService;


import jakarta.validation.Valid;

@RestController
@CrossOrigin(origins="http://localhost")
public class PropostaTransferenciaController{
	private final PropostaTransferenciaService propostaTransferenciaService;
	
	public PropostaTransferenciaController(PropostaTransferenciaService propostaTransferenciaService) {
		this.propostaTransferenciaService=propostaTransferenciaService;
	}
	
	/**
	 * Cria uma proposta de transferência por um jogador.
	 * <p>
	 * O <strong>idClubeExterior</strong> é o clube que faz a oferta e o <strong>idClubeInterior</strong> é o clube dono do jogador.
	 * A proposta é sempre criada como <strong>revelada</strong>, independentemente do valor enviado em <strong>revelado</strong>.
	 * </p>
	 *
	 * @param request {@link PropostaTransferenciaRequest} no corpo da requisição, contendo:
	 * 	<ul>
	 * 		<li>Valor oferecido e status da proposta</li>
	 * 		<li>ID do jogador</li>
	 * 		<li>ID do clube que faz a oferta (exterior) e do clube dono do jogador (interior)</li>
	 * 	</ul>
	 * @return {@link ResponseEntity} com status <strong>201 (Created)</strong> e a {@link PropostaTransferenciaResponse} criada
	 * @throws ResponseStatusException com status <strong>404 (Not Found)</strong> caso o jogador ou algum dos clubes não exista,
	 * 	ou <strong>409 (Conflict)</strong> caso o clube que faz a oferta já tenha uma proposta <strong>pendente</strong> por esse jogador
	 */
	@PostMapping("/propostaTransferencia")
	public ResponseEntity<PropostaTransferenciaResponse> criarProposta(@Valid @RequestBody PropostaTransferenciaRequest request){
		PropostaTransferenciaResponse response = propostaTransferenciaService.criarPropostaTransferencia(request);
		return ResponseEntity.status(HttpStatus.CREATED).body(response);
	}
	
	/**
	 * Atualiza o status de uma proposta de transferência existente.
	 * <p>
	 * A proposta é localizada pela combinação <strong>idJogador</strong> + <strong>idClubeExterior</strong>,
	 * e apenas o <strong>statusProposta</strong> é alterado. Propostas já <strong>recusadas</strong> ou <strong>feitas</strong> não podem mais ser alteradas.
	 * </p>
	 *
	 * @param request {@link PropostaTransferenciaRequest} no corpo da requisição, contendo o ID do jogador,
	 * 	o ID do clube que fez a oferta e o novo <strong>statusProposta</strong>
	 * @return {@link ResponseEntity} com status <strong>201 (Created)</strong> e a {@link PropostaTransferenciaResponse} já atualizada
	 * @throws ResponseStatusException com status <strong>404 (Not Found)</strong> caso a proposta não exista,
	 * 	ou <strong>409 (Conflict)</strong> caso ela já esteja finalizada (recusada ou feita)
	 */
	@PutMapping("/propostaTransferencia")
	public ResponseEntity<PropostaTransferenciaResponse> atualizarProposta(@Valid @RequestBody PropostaTransferenciaRequest request){
		PropostaTransferenciaResponse response = propostaTransferenciaService.atualizarProposta(request);
		return ResponseEntity.status(HttpStatus.CREATED).body(response);
	}
}
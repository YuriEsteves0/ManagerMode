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
	
	@PostMapping("/propostaTransferencia")
	public ResponseEntity<PropostaTransferenciaResponse> criarProposta(@Valid @RequestBody PropostaTransferenciaRequest request){
		PropostaTransferenciaResponse response = propostaTransferenciaService.criarPropostaTransferencia(request);
		return ResponseEntity.status(HttpStatus.CREATED).body(response);
	}
	
//	@GetMapping("/propostaTransferencia/{id}")
//	public List<PropostaTransferenciaResponse> listarPropostas(@PathVariable Integer id){
//		return propostaTransferenciaService.transferencia(id, null)
//	}
	
	@PutMapping("/propostaTransferencia")
	public ResponseEntity<PropostaTransferenciaResponse> atualizarProposta(@Valid @RequestBody PropostaTransferenciaRequest request){
		PropostaTransferenciaResponse response = propostaTransferenciaService.atualizarProposta(request);
		return ResponseEntity.status(HttpStatus.CREATED).body(response);
	}
}
package com.manager.api.model;

import java.io.Serializable;

import jakarta.persistence.Column;

public class PropostaTransferenciaId implements Serializable{
	@Column(name="jogador_idJogador")
	private Integer idJogador;
	@Column(name="clube_idClube")
	private Integer idClube;
}
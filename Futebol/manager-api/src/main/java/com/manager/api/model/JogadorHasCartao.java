package com.manager.api.model;

import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name="jogador_has_cartoes")
@Data
public class JogadorHasCartao{
	@EmbeddedId
	private JogadorHasCartoesId id;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@MapsId("idJogador")
	@JoinColumn(name = "idJogador")
	private Jogadores jogador;
	
	
	@ManyToOne(fetch=FetchType.LAZY)
	@MapsId("idCartoes")                 // era "idCartao"
	@JoinColumn(name="idCartoes")
	private Cartoes cartoes;

	@Column(name="data")
	private LocalDate data;
}
package com.manager.api.model;

import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name="jogador_has_cartoes")
@Data
public class JogadorHasCartao{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "idJogadorHasCartoes")
	private Integer id;

	@ManyToOne
	@JoinColumn(name = "idJogador")
	private Jogadores jogador;

	@ManyToOne
	@JoinColumn(name = "idCartoes")
	private Cartoes cartoes;

	private LocalDate data;
}
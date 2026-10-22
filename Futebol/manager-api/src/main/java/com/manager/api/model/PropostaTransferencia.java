package com.manager.api.model;

import java.sql.Types;

import org.hibernate.annotations.JdbcTypeCode;

import com.manager.api.enums.proposta.StatusProposta;

import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name="proposta_transferencia")
@Getter @Setter
public class PropostaTransferencia {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="idPropostaTransferencia")
	private Integer idPropostaTransferencia;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="jogador_idJogador")
	private Jogadores jogador;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="clube_idClube_exterior")
	private Clube clubeExterior;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="clube_idClube_interior")
	private Clube clubeInterior;

	@JdbcTypeCode(Types.TINYINT)
	@Column(name="revelado")
	private Boolean revelado;

	@Enumerated(EnumType.STRING)
	@Column(name="statusProposta")
	private StatusProposta statusProposta;

	@Column(name="valorOferecido")
	private Float valorOferecido;
}
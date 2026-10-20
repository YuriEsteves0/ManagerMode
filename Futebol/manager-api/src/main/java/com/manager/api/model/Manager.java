package com.manager.api.model;

import com.manager.api.enums.manager.Reputacao;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name="manager")
public class Manager{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="idManager")
	private Integer idManager;

	@Column(name="nomeManager")
	private String nomeManager;
	
	@Column(name="nacionalidade")
	private String nacionalidade;
	
	@Column(name="foto")
	private String foto;
	
	@Enumerated(EnumType.STRING)
	@Column(name="reputacao")
	private Reputacao reputacao;
	
	@Column(name="exp")
	private Integer exp;
	
	@Column(name="contratoFim")
	private Integer contratoFim;
	
	@Column(name="clube_idClube")
	private Integer idClube;
}
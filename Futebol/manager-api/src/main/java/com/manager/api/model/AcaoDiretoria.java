package com.manager.api.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name="acao_diretoria")
public class AcaoDiretoria{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="idAcaoDiretoria")
	private Integer idAcaoDiretoria;
	
	@Column(name="titulo")
	private String titulo;
	
	@Column(name="requisito")
	private String requisito;
	
	@Column(name="efeito")
	private String efeito;
}
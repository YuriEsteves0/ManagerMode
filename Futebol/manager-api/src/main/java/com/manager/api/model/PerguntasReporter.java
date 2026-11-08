package com.manager.api.model;

import com.manager.api.enums.resultado.TipoResultado;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name="perguntas_reporter")
@Data
public class PerguntasReporter{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="idPergunta")
	private Integer idPergunta;
	
	@Column(name="tituloPergunta")
	private String tituloPergunta;
	
	@Column(name="resposta1")
	private String resposta1;

	@Column(name="resposta2")
	private String resposta2;
	
	@Column(name="resposta3")
	private String resposta3;
	
	@Enumerated(EnumType.STRING)
	@Column(name="tipoResultado")
	private TipoResultado tipoResultado;
}
package com.manager.api.model;

import com.manager.api.enums.lesao.Gravidade;

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
@Data
@Table(name="lesao")
public class Lesao{
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="idLesao")
    private Integer idLesao;
	
	@Column(name="nomeLesao")
	private String nomeLesao;
	
	@Column(name="tempoLesionado")
	private Integer tempoLesionado;
	
	@Enumerated(EnumType.STRING)
	@Column(name="gravidade")
	private Gravidade gravidade;
	
}
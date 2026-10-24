package com.manager.api.model;

import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name="treino")
public class Treino{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "idTreino")
	private Integer idTreino;
	
	@Column(name="nomeTreino")
	private String nomeTreino;
	
	@Column(name="descTreino")
	private String descTreino;
	
	@Column(name="intensidade")
	private Integer intensidade;

	@Column(name="data")
	private LocalDate data;
	
}
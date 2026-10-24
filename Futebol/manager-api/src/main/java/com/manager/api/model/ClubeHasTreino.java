package com.manager.api.model;

import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name="clube_has_treino")
public class ClubeHasTreino{
	@EmbeddedId
	private ClubeHasTreinoId id = new ClubeHasTreinoId(); 

	@ManyToOne(fetch = FetchType.LAZY)
	@MapsId("clubeId")
	@JoinColumn(name = "clube_idClube")
	private Clube clube;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@MapsId("treinoId")
	@JoinColumn(name = "treino_idTreino")
	private Treino treino;
	
	@Column(name="slot")
	private Integer slot;
}
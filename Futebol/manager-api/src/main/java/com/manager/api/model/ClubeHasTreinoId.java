package com.manager.api.model;

import java.io.Serializable;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Embeddable
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ClubeHasTreinoId implements Serializable{
	@Column(name="clube_idClube")
	private Integer clubeId;
	
	@Column(name="treino_idTreino")
	private Integer treinoId;
	
}
package com.manager.api.model;

import java.io.Serializable;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.Data;

@Embeddable
@Data
public class TituloTecnicoId implements Serializable{
	@Column(name="competicao_idCompeticao")
	private Integer idCompeticao;
	@Column(name="manager_idManager")
	private Integer idManager;
}
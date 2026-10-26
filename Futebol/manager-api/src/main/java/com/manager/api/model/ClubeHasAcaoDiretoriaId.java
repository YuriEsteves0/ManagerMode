package com.manager.api.model;

import java.io.Serializable;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.Data;

@Embeddable
@Data
public class ClubeHasAcaoDiretoriaId implements Serializable{
	@Column(name="clube_idClube")
	private Integer idClube;

	@Column(name="acao_diretoria_idAcaoDiretoria")
	private Integer idAcaoDiretoria;
}
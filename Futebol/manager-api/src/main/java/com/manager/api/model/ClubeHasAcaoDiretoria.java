package com.manager.api.model;

import com.manager.api.enums.acaoDiretoria.StatusAcao;

import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name="clube_has_acao_diretoria")
public class ClubeHasAcaoDiretoria{
	@EmbeddedId
	private ClubeHasAcaoDiretoriaId id;
	
	@ManyToOne
	@MapsId("idClube")
	@JoinColumn(name="clube_idClube")
	private Clube clube;

	@ManyToOne
	@MapsId("idAcaoDiretoria")
	@JoinColumn(name="acao_diretoria_idAcaoDiretoria")
	private AcaoDiretoria acaoDiretoria;
	
	@Enumerated(EnumType.STRING)
	@Column(name="statusAcao")
	private StatusAcao statusAcao;
}
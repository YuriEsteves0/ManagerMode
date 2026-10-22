package com.manager.api.model;

import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name="titulo_tecnico")
@Getter @Setter
public class TituloTecnico{
	@EmbeddedId
	private TituloTecnicoId id;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@MapsId("idManager")
	@JoinColumn(name="manager_idManager")
	private Manager manager;

	@ManyToOne(fetch=FetchType.LAZY)
	@MapsId("idCompeticao")
	@JoinColumn(name = "competicao_idCompeticao")
	private Competicao competicao;
	
	@Column(name="ano")
	private Integer ano;
}
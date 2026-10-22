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
@Table(name="historico_tecnico")
@Getter @Setter
public class HistoricoManager{
	@EmbeddedId
	private HistoricoManagerId id;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@MapsId("idManager")
	@JoinColumn(name = "manager_idManager")
	private Manager manager;
	
	
	@ManyToOne(fetch=FetchType.LAZY)
	@MapsId("idClube")
	@JoinColumn(name="clube_idClube")
	private Clube clube;

	@Column(name="ano")
	private Integer ano;
}
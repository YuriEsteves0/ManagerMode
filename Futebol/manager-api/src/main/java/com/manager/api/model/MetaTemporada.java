package com.manager.api.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name="meta_temporada")
public class MetaTemporada{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="idMetaTemporada")
	private Integer idMetaTemporada;
	
	@Column(name="descricao")
	private String descricao;
}
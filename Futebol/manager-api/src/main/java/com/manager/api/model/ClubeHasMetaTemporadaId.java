package com.manager.api.model;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import jakarta.persistence.Entity;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Embeddable
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ClubeHasMetaTemporadaId{
	@Column(name="clube_idClube")
	private Integer idClube;

	@Column(name="meta_temporada_idMetaTemporada")
	private Integer idMetaTemporada;
}
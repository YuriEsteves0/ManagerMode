package com.manager.api.model;

import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name="clube_has_upgrade")
@Data
public class ClubeHasUpgrade{
	@EmbeddedId
	private ClubeHasUpgradeId id;
	
	@Column(name="nivelAtual")
	Integer nivelAtual;
}
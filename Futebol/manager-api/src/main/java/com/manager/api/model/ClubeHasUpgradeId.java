package com.manager.api.model;

import java.io.Serializable;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.Data;

@Embeddable
@Data
public class ClubeHasUpgradeId implements Serializable{
	@Column(name="clube_idClube")
	Integer clubeId;
	
	@Column(name="upgrade_idUpgrade")
	Integer upgradeId;	
}
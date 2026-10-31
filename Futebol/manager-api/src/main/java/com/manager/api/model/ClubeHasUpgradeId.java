package com.manager.api.model;

import java.io.Serializable;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Embeddable
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ClubeHasUpgradeId implements Serializable{
	@Column(name="clube_idClube")
	Integer clubeId;
	
	@Column(name="upgrade_idUpgrade")
	Integer upgradeId;	
}
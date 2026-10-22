package com.manager.api.model;

import java.io.Serializable;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.Data;

@Embeddable
@Data
public class HistoricoManagerId implements Serializable{
	@Column(name="manager_idManager")
	private Integer idManager;
	
	@Column(name="clube_idClube")
	private Integer idClube;
}

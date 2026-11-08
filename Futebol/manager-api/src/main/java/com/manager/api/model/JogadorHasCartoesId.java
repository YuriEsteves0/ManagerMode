package com.manager.api.model;

import java.io.Serializable;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Embeddable
@Data
@NoArgsConstructor
@AllArgsConstructor
public class JogadorHasCartoesId implements Serializable {

	@Column(name = "idJogador")
	private Integer idJogador;

	@Column(name = "idCartoes")
	private Integer idCartoes;
}
package com.manager.api.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name="estatisticas_ano_clube")
@Data
public class EstatisticasAnoClube {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="idEstatisticasAnoClube")
	private Integer idEstatisticasAnoClube;

	@Column(name="ano")
	private Integer ano;

	@Column(name="jogos")
	private Integer jogos;

	@Column(name="vitorias")
	private Integer vitorias;

	@Column(name="empates")
	private Integer empates;

	@Column(name="derrotas")
	private Integer derrotas;

	@Column(name="golsFeitos")
	private Integer golsFeitos;

	@Column(name="golsSofridos")
	private Integer golsSofridos;

	@Column(name="clube_idClube")
	private Integer clubeId;
}
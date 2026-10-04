package com.manager.api.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name="patrocinador")
@Data
public class Patrocinador{
	@Id
	@Column(name="idPatrocinador")
	private Integer idPatrocinador;
	
	 @Column(name = "nomePatrocinador")
	 private String nomePatrocinador;

	 @Column(name = "descricao")
	 private String descricao;

	 @Column(name = "duracao")
	 private Integer duracao;

	 @Column(name = "valorMensal")
	 private Float valorMensal;

	 @Column(name = "multaRescisao")
	 private Float multaRescisao;

	 @Column(name = "foto")
	 private String foto;
}
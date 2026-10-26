package com.manager.api.model;

import java.time.LocalDate;
import java.time.LocalDateTime;

import com.manager.api.enums.noticiaDiretoria.TipoModificador;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name="noticia_diretoria")
public class NoticiaDiretoria{

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="idNoticia")
	private Integer idNoticia;
	
	@Column(name="texto")
	public String texto;
	
	@Column(name="data_registro")
	public LocalDate dataRegistro;
	
	@Column(name="clube_idClube")
	public Integer idClube;
	
	@Column(name="modificador")
	public Integer modificador;
	
	@Enumerated(EnumType.STRING)
	@Column(name="tipoModificador")
	public TipoModificador tipoModificador;
}
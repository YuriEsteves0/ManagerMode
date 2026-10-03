package com.manager.api.model;

import com.manager.api.enums.noticia.Categoria;

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
@Table(name="noticia")
@Data
public class Noticia{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="idNoticia")
	private Integer idNoticia;
	
	@Column(name="titulo")
	private String titulo;
	
    @Enumerated(EnumType.STRING)
	@Column(name="categoria")
    private Categoria categoria;
    
    @Column(name="dataPublicacao")
    private Integer dataPublicacao;
    
    @Column(name = "clube_idClube")
    private Integer clubeIdClube;
}
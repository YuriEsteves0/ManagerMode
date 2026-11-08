package com.manager.api.model;

import com.manager.api.enums.cartoes.TipoCartoes;

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
@Table(name="cartao")
@Data
public class Cartoes{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer idCartao;
	
	@Enumerated(EnumType.STRING)
	@Column(name="tipoCartao")
	private TipoCartoes tipoCartoes;
}
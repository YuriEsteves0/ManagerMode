package com.manager.api.model;

import com.manager.api.enums.manager.Status;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "proposta_emprego")
public class PropostaEmprego {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "idPropostaEmprego")
	private Integer idPropostaEmprego;

	@Column(name = "salarioOferecido")
	private Double salarioOferecido;

	@Enumerated(EnumType.STRING)
	@Column(name="status")
	private Status status;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "clube_idClube")
	private Clube clube;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "manager_idManager")
	private Manager manager;
}
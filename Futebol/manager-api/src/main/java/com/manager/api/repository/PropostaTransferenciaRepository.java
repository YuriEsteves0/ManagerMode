package com.manager.api.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.manager.api.model.PropostaTransferencia;

public interface PropostaTransferenciaRepository extends JpaRepository<PropostaTransferencia, Integer> {
	List<PropostaTransferencia> findByClubeInterior_Id(Integer idClube);
	List<PropostaTransferencia> findByClubeExterior_Id(Integer idClube);
}
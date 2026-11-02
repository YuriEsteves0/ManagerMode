package com.manager.api.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.manager.api.enums.proposta.StatusProposta;
import com.manager.api.model.PropostaTransferencia;

public interface PropostaTransferenciaRepository extends JpaRepository<PropostaTransferencia, Integer> {
	List<PropostaTransferencia> findByClubeInterior_Id(Integer idClube);
	List<PropostaTransferencia> findByClubeExterior_Id(Integer idClube);
	Optional<PropostaTransferencia> findByJogador_IdJogadorAndClubeInterior_Id(Integer idJogador, Integer idClube);
	Optional<PropostaTransferencia> findByJogador_IdJogadorAndClubeExterior_Id(Integer idJogador, Integer idClube);
	boolean existsByJogador_IdJogadorAndClubeExterior_IdAndStatusProposta(
		    Integer idJogador, Integer idClubeExterior, StatusProposta statusProposta);
}
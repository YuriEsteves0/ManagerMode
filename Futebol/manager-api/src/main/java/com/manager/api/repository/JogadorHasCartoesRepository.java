package com.manager.api.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.manager.api.model.JogadorHasCartao;
import com.manager.api.model.JogadorHasCartoesId;

public interface JogadorHasCartoesRepository extends JpaRepository<JogadorHasCartao, JogadorHasCartoesId> {

	@Query("SELECT j FROM JogadorHasCartao j WHERE j.id.idJogador = :idJogador")
	List<JogadorHasCartao> buscarPorJogador(@Param("idJogador") Integer idJogador);
}
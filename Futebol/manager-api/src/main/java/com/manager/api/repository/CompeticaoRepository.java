package com.manager.api.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.manager.api.enums.competicao.TipoCompeticao;
import com.manager.api.model.Competicao;

public interface CompeticaoRepository extends JpaRepository<Competicao, Integer> {
    List<Competicao> findByTipoCompeticao(TipoCompeticao tipo);
}

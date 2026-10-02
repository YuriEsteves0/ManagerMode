package com.manager.api.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.manager.api.model.ClubeCompeticao;
import com.manager.api.model.ClubeCompeticaoId;

public interface ClubeCompeticaoRepository extends JpaRepository<ClubeCompeticao, ClubeCompeticaoId>{
    List<ClubeCompeticao> findByCompeticao_Id(Integer competicaoId);
    List<ClubeCompeticao> findByCompeticao_IdOrderByPontosDesc(Integer competicaoId);
    
}

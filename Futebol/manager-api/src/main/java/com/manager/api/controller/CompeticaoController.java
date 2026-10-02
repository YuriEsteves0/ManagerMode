package com.manager.api.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.manager.api.enums.competicao.TipoCompeticao;
import com.manager.api.model.Competicao;
import com.manager.api.repository.CompeticaoRepository;

@RestController 
public class CompeticaoController {
    // Faz a conexão com o banco de dados
    private final CompeticaoRepository competicaoRepository;

    public CompeticaoController(CompeticaoRepository competicaoRepository){
        this.competicaoRepository = competicaoRepository;
    }

    @GetMapping("/competicoes")
    public List<Competicao> listarCompeticoes(@RequestParam(required = false) TipoCompeticao tipo){
        if(tipo != null){
            return competicaoRepository.findByTipoCompeticao(tipo);
        }
        return competicaoRepository.findAll();
    }

}

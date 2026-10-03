package com.manager.api.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.manager.api.responses.JogadoresResponse;
import com.manager.api.service.JogadoresService;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;

@RestController
public class JogadoresController {

    private final JogadoresService jogadoresService;

    public JogadoresController(JogadoresService jogadoresService) {
        this.jogadoresService = jogadoresService;
    }

    @Operation(
        summary = "Lista jogadores por clube", 
        description = "Retorna uma lista resumida contendo ID, nome, número da camisa e status de titularidade dos jogadores pertencentes ao clube especificado."
    )
    @GetMapping("/jogadores/clube/{clube_idClube}")
    public List<JogadoresResponse.NomeCamisaTitular> listarJogadoresPorClube(
            @PathVariable Integer clube_idClube) {
        return jogadoresService.listarPorClube(clube_idClube);
    }
}
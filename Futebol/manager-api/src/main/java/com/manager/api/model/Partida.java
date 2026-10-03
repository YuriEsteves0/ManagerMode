package com.manager.api.model;

import java.time.LocalDate;
import java.time.LocalTime;

import com.manager.api.enums.partida.StatusPartida;

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
@Table(name = "partida")
@Data
public class Partida {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idPartida")
    private Integer idPartida;

    @Column(name = "golsMandante")
    private Integer golsMandante;

    @Column(name = "golsVisitante")
    private Integer golsVisitante;

    @Column(name = "rodada")
    private Integer rodada;

    @Column(name = "dataPartida")
    private LocalDate dataPartida;

    @Enumerated(EnumType.STRING)
    @Column(name = "statusPartida")
    private StatusPartida statusPartida;

    @Column(name = "visitanteIdClube")
    private Integer visitanteIdClube;

    @Column(name = "mandanteIdClube")
    private Integer mandanteIdClube;

    @Column(name = "horario")
    private LocalTime horario;

    @Column(name = "local")
    private String local;

    @Column(name = "competicao_idCompeticao")
    private Integer competicaoIdCompeticao;
}
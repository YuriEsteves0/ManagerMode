package com.manager.api.model;

import java.sql.Types;

import org.hibernate.annotations.JdbcTypeCode;

import com.manager.api.enums.clube.FaseAtual;

import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "clube_competicao")
@Data
public class ClubeCompeticao {
    @EmbeddedId
    private ClubeCompeticaoId id;

    @ManyToOne
    @MapsId("competicaoID")
    @JoinColumn(name = "competicao_idCompeticao")
    private Competicao competicao;

    @ManyToOne
    @MapsId("clubeID")
    @JoinColumn(name = "clube_idClube")
    private Clube clube;

    @Column(name = "pontos")
    private Integer pontos;

    @Enumerated(EnumType.STRING)
    @Column(name = "faseAtual")
    private FaseAtual faseAtual;

    @JdbcTypeCode(Types.TINYINT)
    @Column(name = "eliminado")
    private Boolean eliminado;
}

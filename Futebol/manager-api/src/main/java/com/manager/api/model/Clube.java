package com.manager.api.model;

import com.manager.api.enums.clube.StatusConfianca;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity 
@Table (name="clube")
@Data 
public class Clube {
    @Id 
    @Column(name="idClube")
    private Integer id;

    @Column(name="nomeClube")
    private String nomeClube;

    @Column(name="orcamento")
    private Float orcamento;

    @Column(name="valorClube")
    private Long valorClube;

    @Column(name="camisasVendidas")
    private Integer camisasVendidas;

    @Column(name="qntTorcedores")
    private Integer qntTorcedores;

    @Column(name="reputacao")
    private Integer reputacao;

    @Column(name="patrocinador_idPatrocinador")
    private Integer patrocinador_idPatrocinador;

    @Column(name = "confiancaDiretoria")
    private Integer confiancaDiretoria;

    @Enumerated(EnumType.STRING)
    @Column(name="statusConfianca")
    private StatusConfianca statusConfianca;

    @Column(name="eventoAtual")
    private String eventoAtual;

    @Column(name="capacidadeEstadio")
    private Integer capacidadeEstadio;

    @Column(name="foto")
    private String foto;
    
    @Column(name="nomeEstadio")
    private String nomeEstadio;

}

package com.manager.api.model;

import com.manager.api.enums.competicao.NivelCompeticao;
import com.manager.api.enums.competicao.StatusCompeticao;
import com.manager.api.enums.competicao.TipoCompeticao;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity 
@Table (name="competicao")
@Data 
public class Competicao {
    @Id 
    @Column(name="idCompeticao") 
    private Integer idCompeticao;

    @Column(name = "nomeCompeticao")
    private String nomeCompeticao;

    @Column(name="valorPremio")
    private Float valorPremio;

    @Column(name="premioPorVitoria")
    private Float premioPorVitoria;

    @Enumerated(EnumType.STRING) // ADICIONAR ISSO AQUI É IMPORTANTE!
    @Column(name="tipoCompeticao")
    private TipoCompeticao tipoCompeticao;

    @Enumerated(EnumType.STRING)
    @Column (name = "nivelCompeticao")
    private NivelCompeticao nivelCompeticao;
    
    @Column(name="ano")
    private Integer ano;
    
    @Enumerated (EnumType.STRING)
    @Column (name = "statusCompeticao")
    private StatusCompeticao statusCompeticao;
}

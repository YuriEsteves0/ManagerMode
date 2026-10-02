package com.manager.api.model;

import java.io.Serializable;

import jakarta.persistence.Column;

public class ClubeCompeticaoId implements Serializable{
    @Column (name="competicao_idCompeticao")
    private Integer competicaoID;

    @Column(name="clube_idClube")
    private Integer clubeID;
}

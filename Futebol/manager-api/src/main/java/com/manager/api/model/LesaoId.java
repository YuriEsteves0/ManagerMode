package com.manager.api.model;

import java.io.Serializable;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.Data;

@Embeddable
@Data
public class LesaoId implements Serializable {

    @Column(name = "lesao_idLesao")
    private Integer idLesao;

    @Column(name = "jogador_idJogador")
    private Integer idJogador;
}
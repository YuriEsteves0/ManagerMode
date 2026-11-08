package com.manager.api.model;

import java.io.Serializable;
import java.util.Objects;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.Data;

@Embeddable
@Data
public class EstatisticaJogadorId implements Serializable {

	@Column(name = "jogador_idJogador")
    private Integer jogadorId;

    @Column(name = "competicao_idCompeticao")
    private Integer competicaoId;
}
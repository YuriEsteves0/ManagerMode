package com.manager.api.model;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name = "jogador_lesao")
public class JogadorLesao {

    @EmbeddedId
    private LesaoId id;
}
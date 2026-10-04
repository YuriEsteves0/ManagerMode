package com.manager.api.model;

import com.manager.api.model.EstatisticaJogadorId;

import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.Table;

@Entity
@Table(name = "estatisticas_jogador_competicao")
public class EstatisticaJogador {

	@EmbeddedId
    private EstatisticaJogadorId id;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("jogadorId")
    @JoinColumn(name = "jogador_idJogador")
    private Jogadores jogador;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("competicaoId")
    @JoinColumn(name = "competicao_idCompeticao")
    private Competicao competicao;

    @Column(name = "ano")
    private Integer ano;
    
    @Column(name = "jogos")
    private Integer jogos;
    
    @Column(name = "gols")
    private Integer gols;
    
    @Column(name = "assistencias")
    private Integer assistencias;

    @Column(name = "notaMedia")
    private Integer notaMedia;
}
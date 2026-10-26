package com.manager.api.model;

import com.manager.api.enums.metaTemporada.Status;

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
@Data
@Table(name="clube_has_meta_temporada")
public class ClubeHasMetaTemporada {
    @EmbeddedId
    private ClubeHasMetaTemporadaId id;

    @ManyToOne
    @MapsId("idClube")
    @JoinColumn(name="clube_idClube")
    private Clube clube;

    @ManyToOne
    @MapsId("idMetaTemporada")
    @JoinColumn(name="meta_temporada_idMetaTemporada")
    private MetaTemporada metaTemporada;

    @Enumerated(EnumType.STRING)
    @Column(name="status")
    private Status status;
}
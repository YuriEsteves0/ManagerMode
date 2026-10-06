package com.manager.api.model;

import com.manager.api.enums.upgrade.TipoUpgrade;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "upgrade")
@Data
public class Upgrade {

    @Id
    @Column(name = "idUpgrade")
    private Integer idUpgrade;

    @Column(name = "nomeUpgrade")
    private String nomeUpgrade;

    @Column(name = "preco")
    private Float preco;

    @Enumerated(EnumType.STRING)
    @Column(name = "tipoUpgrade")
    private TipoUpgrade tipoUpgrade;

    @Column(name = "descricao")
    private String descricao;

    @Column(name = "modificador")
    private Float modificador;

    @Column(name = "nivelMaximo")
    private Integer nivelMaximo;
}
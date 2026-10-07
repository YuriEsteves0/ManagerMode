package com.manager.api.model;

import com.manager.api.enums.jogador.PosicaoPrincipal;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "jogador")
@Data
public class Jogadores {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idJogador")
    private Integer idJogador;

    @Column(name = "nomeJogador", length = 45)
    private String nomeJogador;
    
    @Column(name="numeroCamisa")
    private Integer numeroCamisa;

    @Column(name = "idade")
    private Integer idade;

    @Enumerated(EnumType.STRING)
    @Column(name = "posicao_principal")
    private PosicaoPrincipal posicaoPrincipal;

    @Column(name = "overall")
    private Integer overall;

    @Column(name = "velocidade")
    private Integer velocidade;

    @Column(name = "forca")
    private Integer forca;

    @Column(name = "inteligencia")
    private Integer inteligencia;

    @Column(name = "finalizacao")
    private Integer finalizacao;

    @Column(name = "marcacao")
    private Integer marcacao;

    @Column(name = "passe")
    private Integer passe;

    @Column(name = "potencial")
    private Integer potencial;

    @Column(name = "titular", columnDefinition = "TINYINT(1)")
    private Boolean titular;

    @Column(name = "moral")
    private Integer moral;

    @Column(name = "nacionalidade")
    private String nacionalidade;

    @Column(name = "dispEmprestimo", columnDefinition = "TINYINT(1)")
    private Boolean dispEmprestimo;

    @Column(name = "satisfacao")
    private Integer satisfacao;

    @Column(name = "onfire", columnDefinition = "TINYINT(1)")
    private Boolean onfire;

    @Column(name = "valor")
    private Float valor;

    @Column(name = "valorRescisao")
    private Float valorRescisao;
    
    @Column(name = "salario")
    private Float salario;

    @Column(name = "tempoContrato")
    private Integer tempoContrato;

    @Column(name = "clube_idClube")
    private Integer clubeIdClube;

    @Column(name = "posicaoX")
    private Float posicaoX;

    @Column(name = "posicaoY")
    private Float posicaoY;
}
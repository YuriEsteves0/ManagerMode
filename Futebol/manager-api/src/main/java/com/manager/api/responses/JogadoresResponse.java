package com.manager.api.responses;

import com.manager.api.enums.jogador.PosicaoPrincipal;

/**
 * Representa a resposta com os dados detalhados de um jogador.
 *
 * @param idJogador Identificador único do jogador.
 * @param nomeJogador Nome completo ou de exibição do jogador.
 * @param numeroCmisa Número da camisa do jogador.
 * @param idade Idade do jogador em anos.
 * @param posicaoPrincipal Posição principal de atuação do jogador em campo.
 * @param overall Atributo geral do jogador (nível global de habilidade).
 * @param velocidade Atributo de velocidade e aceleração.
 * @param forca Atributo de força física e combate corpóreo.
 * @param inteligencia Atributo de tomada de decisão e visão de jogo.
 * @param finalizacao Atributo de precisão e potência de chute a gol.
 * @param marcacao Atributo de capacidade defensiva e desarme.
 * @param passe Atributo de precisão em passes curtos e longos.
 * @param potencial Nível máximo de overall que o jogador pode atingir.
 * @param titular Indica se o jogador faz parte do time titular principal.
 * @param moral Nível atual de moral e motivação do jogador.
 * @param nacionalidade País de origem/nacionalidade do jogador.
 * @param dispEmprestimo Indica se o jogador está disponível para ser emprestado.
 * @param satisfacao Nível de satisfação do jogador com o clube/contrato.
 * @param onfire Indica se o jogador está em uma fase excepcional ou momento de iluminação.
 * @param valor Valor estimado do jogador para mercado de transferências.
 * @param valorRescisao Valor estipulado da multa rescisória do contrato.
 * @param tempoContrato Tempo restante de contrato (geralmente em meses ou temporadas).
 * @param clubeIdClube Identificador único do clube ao qual o jogador pertence.
 * @param posicaoX Coordenada X para posicionamento no mapa/tática em campo.
 * @param posicaoY Coordenada Y para posicionamento no mapa/tática em campo.
 */
public record JogadoresResponse(
    Integer idJogador,
    String nomeJogador,
    Integer numeroCamisa,
    Integer idade,
    PosicaoPrincipal posicaoPrincipal,
    Integer overall,
    Integer velocidade,
    Integer forca,
    Integer inteligencia,
    Integer finalizacao,
    Integer marcacao,
    Integer passe,
    Integer potencial,
    Boolean titular,
    Integer moral,
    String nacionalidade,
    Boolean dispEmprestimo,
    Integer satisfacao,
    Boolean onfire,
    Float valor,
    Float valorRescisao,
    Float salario,
    Integer tempoContrato,
    Integer clubeIdClube,
    Float posicaoX,
    Float posicaoY
) {
	/**
	 * @param idJogador Identificador único do jogador.
	 * @param nomeJogador Nome completo ou de exibição do jogador.
	 * @param numeroCmisa Número da camisa do jogador.
	 * @param titular Indica se o jogador faz parte do time titular principal.
	 */
	public record NomeCamisaTitular(
			Integer idJogador,
		    String nomeJogador,
		    Integer numeroCamisa,
		    Boolean titular
	) {}
	
	public record comClube(
			Integer idJogador,
		    String nomeJogador,
		    Integer numeroCamisa,
		    Integer idade,
		    PosicaoPrincipal posicaoPrincipal,
		    Integer overall,
		    Integer velocidade,
		    Integer forca,
		    Integer inteligencia,
		    Integer finalizacao,
		    Integer marcacao,
		    Integer passe,
		    Integer potencial,
		    Boolean titular,
		    Integer moral,
		    String nacionalidade,
		    Boolean dispEmprestimo,
		    Integer satisfacao,
		    Boolean onfire,
		    Float valor,
		    Float valorRescisao,
		    Float salario,
		    Integer tempoContrato,
		    Integer clubeIdClube,
		    String nomeClube,
		    Float posicaoX,
		    Float posicaoY
	) {}
}
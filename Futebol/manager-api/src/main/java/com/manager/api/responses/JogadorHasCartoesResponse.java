package com.manager.api.responses;

import java.time.LocalDate;

import com.manager.api.model.Cartoes;
import com.manager.api.model.Jogadores;

public record JogadorHasCartoesResponse(
		Integer idJogadorHasCartoes,
		Integer idJogador,
		Jogadores jogador,
		Integer idCartao,
		Cartoes cartao,
		LocalDate data
) {}
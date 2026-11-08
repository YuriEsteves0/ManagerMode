package com.manager.api.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.stereotype.Service;

import com.manager.api.model.Cartoes;
import com.manager.api.model.JogadorHasCartao;
import com.manager.api.model.Jogadores;
import com.manager.api.repository.CartoesRepository;
import com.manager.api.repository.JogadorHasCartoesRepository;
import com.manager.api.repository.JogadoresRepository;
import com.manager.api.requests.JogadorHasCartoesRequest;
import com.manager.api.responses.JogadorHasCartoesResponse;

import jakarta.transaction.Transactional;

@Service
public class JogadorHasCartoesService {
	private final JogadorHasCartoesRepository jogadorHasCartoesRepository;
	private final JogadoresRepository jogadoresRepository;
	private final CartoesRepository cartoesRepository;

	public JogadorHasCartoesService(JogadorHasCartoesRepository jogadorHasCartoesRepository,
			JogadoresRepository jogadoresRepository,
			CartoesRepository cartoesRepository) {
		this.jogadorHasCartoesRepository = jogadorHasCartoesRepository;
		this.jogadoresRepository = jogadoresRepository;
		this.cartoesRepository = cartoesRepository;
	}

	public List<JogadorHasCartoesResponse> buscarCartaoJogador(Integer idJogador) {
		return jogadorHasCartoesRepository.buscarPorJogador(idJogador).stream()
				.map(j -> new JogadorHasCartoesResponse(
						j.getJogador().getIdJogador(),
						j.getJogador(),
						j.getCartoes().getIdCartao(),
						j.getCartoes(),
						j.getData()))
			.toList();
	}

	@Transactional
	public JogadorHasCartoesResponse adicionarCartaoJogador(Integer idJogador, JogadorHasCartoesRequest request) {
		Jogadores jogador = jogadoresRepository.findById(idJogador)
			.orElseThrow(() -> new RuntimeException("Jogador não encontrado!"));

		Cartoes cartao = cartoesRepository.findById(request.idCartao())
			.orElseThrow(() -> new RuntimeException("Cartão não encontrado!"));

		JogadorHasCartao novo = new JogadorHasCartao();
		novo.setJogador(jogador);
		novo.setCartoes(cartao);
		novo.setData(LocalDate.now());

		jogadorHasCartoesRepository.save(novo);

		return new JogadorHasCartoesResponse(
			idJogador,
			jogador,
			cartao.getIdCartao(),
			cartao,
			novo.getData());
	}
}
package com.manager.api.service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.stereotype.Service;

import com.manager.api.enums.partida.StatusPartida;
import com.manager.api.model.Clube;
import com.manager.api.model.Competicao;
import com.manager.api.model.Partida;
import com.manager.api.repository.ClubeCompeticaoRepository;
import com.manager.api.repository.CompeticaoRepository;
import com.manager.api.repository.PartidaRepository;
import com.manager.api.responses.PartidaResponse;

import jakarta.transaction.Transactional;

@Service
public class PartidaService {

	private final PartidaRepository partidaRepository;
	private final ClubeCompeticaoRepository clubeCompeticaoRepository;
	private final CompeticaoRepository competicaoRepository;

	public PartidaService(PartidaRepository partidaRepository,
			ClubeCompeticaoRepository clubeCompeticaoRepository,
			CompeticaoRepository competicaoRepository) {
		this.partidaRepository = partidaRepository;
		this.clubeCompeticaoRepository = clubeCompeticaoRepository;
		this.competicaoRepository = competicaoRepository;
	}

	public List<PartidaResponse.RodadaIdMandanteIdVisitanteLocalEstadioDataHorario> listarProximasPartidas(Integer idClube, LocalDate dataPartida) {
		return partidaRepository.buscarProximasPartidas(idClube, dataPartida)
				.stream()
				.limit(4)
				.toList();
	}

	public List<PartidaResponse> listarProximasPartidasCalendario(Integer idClube, LocalDate dataPartida) {
		return partidaRepository.buscarPartidasFuturas(idClube, dataPartida);
	}

	@Transactional
	public int criarCalendario(LocalDate dataInicio) {
		int total = 0;

		for (Competicao competicao : competicaoRepository.findAll()) {

			Integer idCompeticao = competicao.getIdCompeticao();

			// não gera duas vezes
			if (partidaRepository.existsByCompeticaoIdCompeticao(idCompeticao)) {
				continue;
			}

			List<Clube> clubes = clubeCompeticaoRepository
					.findByCompeticao_Id(idCompeticao)
					.stream()
					.map(cc -> cc.getClube())
					.toList();

			if (clubes.size() < 2) {
				continue;
			}

			List<Partida> partidas = gerarPontosCorridos(idCompeticao, clubes, dataInicio);
			partidaRepository.saveAll(partidas);
			total += partidas.size();
		}
		return total;
	}

	private List<Partida> gerarPontosCorridos(Integer idCompeticao, List<Clube> clubes, LocalDate dataInicio) {
		List<Clube> times = new ArrayList<>(clubes);
		Collections.shuffle(times); // calendário diferente a cada temporada

		// número ímpar: adiciona uma "folga" (null) pra fechar as duplas
		if (times.size() % 2 != 0) {
			times.add(null);
		}

		int n = times.size();
		int rodadasTurno = n - 1;
		List<Partida> partidas = new ArrayList<>();

		for (int r = 0; r < rodadasTurno; r++) {
			for (int i = 0; i < n / 2; i++) {
				Clube a = times.get(i);
				Clube b = times.get(n - 1 - i);

				// quem enfrenta a folga não joga nessa rodada
				if (a == null || b == null) {
					continue;
				}

				// alterna o mando pra ninguém jogar sempre em casa
				Clube mandante = ((r + i) % 2 == 0) ? a : b;
				Clube visitante = (mandante == a) ? b : a;

				// turno
				partidas.add(novaPartida(idCompeticao, r + 1,
						dataInicio.plusWeeks(r), mandante, visitante));

				// returno: mesmo confronto, mando invertido
				partidas.add(novaPartida(idCompeticao, r + 1 + rodadasTurno,
						dataInicio.plusWeeks(r + rodadasTurno), visitante, mandante));
			}

			// gira: o último vai pra posição 1 (o índice 0 fica fixo)
			times.add(1, times.remove(n - 1));
		}
		return partidas;
	}

	private Partida novaPartida(Integer idCompeticao, int rodada, LocalDate data,
			Clube mandante, Clube visitante) {
		Partida p = new Partida();
		p.setCompeticaoIdCompeticao(idCompeticao);
		p.setRodada(rodada);
		p.setDataPartida(data);
		p.setHorario(LocalTime.of(16, 0));
		p.setMandanteIdClube(mandante.getId());
		p.setVisitanteIdClube(visitante.getId());
		p.setLocal(mandante.getNomeEstadio());
		p.setStatusPartida(StatusPartida.AGENDADA);
		p.setGolsMandante(0);
		p.setGolsVisitante(0);
		return p;
	}
}
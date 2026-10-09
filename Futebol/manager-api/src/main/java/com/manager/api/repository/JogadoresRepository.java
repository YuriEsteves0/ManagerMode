package com.manager.api.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.manager.api.model.Jogadores;
import com.manager.api.responses.JogadoresResponse;

public interface JogadoresRepository extends JpaRepository<Jogadores, Integer>{
	List<JogadoresResponse> findByClubeIdClubeAndTitularFalse(Integer clubeIdClube);
	List<JogadoresResponse> findByClubeIdClube(Integer clubeIdClube);
	
	@Query("""
		    select new com.manager.api.responses.JogadoresResponse$comClube(
		        j.idJogador, j.nomeJogador, j.numeroCamisa, j.idade, j.posicaoPrincipal,
		        j.overall, j.velocidade, j.forca, j.inteligencia, j.finalizacao,
		        j.marcacao, j.passe, j.potencial, j.titular, j.moral, j.nacionalidade,
		        j.dispEmprestimo, j.satisfacao, j.onfire, j.valor, j.valorRescisao,
		        j.salario, j.tempoContrato, j.clubeIdClube, c.nomeClube,
		        j.posicaoX, j.posicaoY
		    )
		    from Jogadores j
		    join Clube c on c.id = j.clubeIdClube
		    where not exists (
		        select 1 from JogadorLesao jl
		        where jl.id.idJogador = j.idJogador
		    )
		    order by j.overall desc
		""")
		List<JogadoresResponse.comClube> findAllByOrderByOverallDesc();
}
package com.manager.api.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.manager.api.enums.noticia.Categoria;
import com.manager.api.model.Noticia;
import com.manager.api.responses.NoticiaResponse;

public interface NoticiaRepository extends JpaRepository<Noticia, Integer>{
	/**
     * Busca uma lista de notícias filtradas por categoria.
     * <p>
     * Atualmente usado para a parte de transferências na pagina inicial
     *
     * @param categoria a categoria das notícias a serem pesquisadas
     * @return uma lista de objetos {@link NoticiaResponse} pertencentes à categoria informada
     */
    public List<NoticiaResponse> findTop5ByCategoriaOrderByDataPublicacaoDesc(Categoria categoria);

    /**
     * Busca uma lista de notícias filtradas por categoria e pelo ID do clube associado.
     * <p>
     * Atualmente usado para a parte de imprensa na pagina inicial
     *
     * @param categoria a categoria das notícias a serem pesquisadas
     * @param clube_IdClube o identificador único do clube associado às notícias
     * @return uma lista de objetos {@link NoticiaResponse} que correspondem à categoria e ao clube especificados
     */
    public List<NoticiaResponse> findTop5ByCategoriaAndClubeIdClubeOrderByDataPublicacaoDesc(Categoria categoria, Integer clubeIdClube);

}
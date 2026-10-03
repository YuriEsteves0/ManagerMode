package com.manager.api.responses;

import com.manager.api.enums.noticia.Categoria;

/**
 * @param idNoticia
 * @param titulo
 * @param categoria
 * @param dataPublicacao
 * @param clube_idClube
 */
public record NoticiaResponse(
	    Integer idNoticia,
	    String titulo,
	    Categoria categoria,
	    Integer dataPublicacao,
	    Integer clubeIdClube
	) {}
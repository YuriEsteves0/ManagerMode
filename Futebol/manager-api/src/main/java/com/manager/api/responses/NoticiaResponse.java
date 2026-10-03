package com.manager.api.responses;

import java.time.LocalDateTime;

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
	    LocalDateTime dataPublicacao,
	    Integer clubeIdClube
	) {}
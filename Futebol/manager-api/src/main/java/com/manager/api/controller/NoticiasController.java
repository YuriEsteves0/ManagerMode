package com.manager.api.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.manager.api.enums.noticia.Categoria;
import com.manager.api.responses.NoticiaResponse;
import com.manager.api.service.NoticiaService;

@RestController
public class NoticiasController {
	private final NoticiaService noticiaService;
	
	public NoticiasController(NoticiaService noticiaService) {
		this.noticiaService = noticiaService;
	}
	
	@GetMapping("/noticias")
	public List<NoticiaResponse> listarNoticias(@RequestParam(required = true) Categoria categoria, @RequestParam(required = false) Integer idClube){
		if(categoria == Categoria.IMPRENSA) {
			return noticiaService.listarNoticiasDeImprensa(idClube);
		}else {
			return noticiaService.listarNoticiasDeMercado();
		}
	}
	
}
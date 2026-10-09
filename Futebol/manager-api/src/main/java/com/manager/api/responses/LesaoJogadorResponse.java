package com.manager.api.responses;

import com.manager.api.enums.lesao.Gravidade;

public record LesaoJogadorResponse(
        Integer idJogador,
        Integer idLesao,
        String nomeLesao,
        Integer tempoLesionado,
        Gravidade gravidade
) {}
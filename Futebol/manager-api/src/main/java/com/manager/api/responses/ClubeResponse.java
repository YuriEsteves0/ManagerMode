package com.manager.api.responses;

import com.manager.api.enums.clube.StatusConfianca;

// Full response
public record ClubeResponse(
    Integer idClube,
    String nomeClube,
    Float orcamento,
    Long valorClube,
    Integer camisasVendidas,
    Integer qntTorcedores,
    Integer reputacao,
    Integer patrocinador_idPatrocinador,
    Integer confiancaDiretoria,
    StatusConfianca statusConfianca,
    String eventoAtual,
    Integer capacidadeEstadio,
    String foto,
    String nomeEstadio
) {
    
}

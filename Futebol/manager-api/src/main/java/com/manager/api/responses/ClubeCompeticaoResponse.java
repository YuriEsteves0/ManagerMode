package com.manager.api.responses;

import com.manager.api.enums.clube.FaseAtual;

/**
 * Representa os dados da tabela intermediária entre clube e competição.
 * Representa a situação do clube em determinada competição.
 *
 * Usado nas telas:
 * 
 * @param clube_idClube Identificador do clube
 * @param competicao_idCompeticao Identificador da competição
 * @param pontos Quantidade de pontos que o clube específico pontuou
 * @param faseAtual Qual fase da competição o clube está
 * @param eliminado Booleano que representa se o clube foi eliminado ou não da competição
 */
public record ClubeCompeticaoResponse(
    Integer clube_idClube,
    Integer competicao_idCompeticao,
    Integer pontos,
    FaseAtual faseAtual, 
    Boolean eliminado
) {
    
    /**
     * Resumo com id, competição, pontos e fase atual.
     * 
     * @param clube_idClube Identificador do clube
     * @param competicao_idCompeticao Identificador da competição
     * @param pontos Quantidade de pontos que o clube pontuou
     * @param faseAtual Fase atual do clube na competição
     */
    public record IdClubeIdCompeticaoPontosFaseAtual(
        Integer clube_idClube,
        Integer competicao_idCompeticao,
        Integer pontos,
        FaseAtual faseAtual
    ){}

    /**
     * Representa os dados completos da classe Clube.
     * <p>
     * Usado nas telas:
     * 
     * @param idClube Identificador do clube
     * @param nomeClube Nome do clube
     * @param orcamento Valor bruto (antes de passar pela função de arredondamento) que o clube tem disponível para gastos
     * @param valorClube Valor bruto (antes de passar pela função de arredondamento) que o clube vale
     * @param camisasVendidas Valor bruto (antes de passar pela função de arredondamento) que o clube arrecadou com vendas de camisas
     * @param qntTorcedores Quantidade de torcedores do clube
     * @param reputacao Valor de 0-100 que dita a popularidade do clube. Maior popularidade = melhores jogadores querendo jogar no clube
     * @param patrocinador_idPatrocinador Chave estrangeira para patrocinador
     * @param confiancaDiretoria Valor de 0-100 (%) que dita a confiança da diretoria no manager
     * @param statusConfianca Status que se baseia na confiança da diretoria
     * @param eventoAtual Eventos aleatórios que podem alavancar ou penalizar o manager em relação à confiança da diretoria
     * @param capacidadeEstadio Valor referente à quantidade de torcedores máxima no estádio do clube
     * @param foto URL da foto do clube (ex: img\escudosClubes\brasileiraoSerieA\bahia.png)
     */
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
            String statusConfianca,
            String eventoAtual,
            Integer capacidadeEstadio,
            String foto
    ){
        /**
         * Representa os dados mais enxutos da classe Clube.
         * 
         * Usado nas telas: Cadastro 3
         * 
         * @param idClube Identificador do clube
         * @param nomeClube Nome do clube
         * @param foto URL da foto do clube (ex: img\escudosClubes\brasileiraoSerieA\bahia.png)
         * @param orcamento Valor bruto (antes de passar pela função de arredondamento) que o clube tem disponível para gastos
         */
        public record ClubeFotoNomeResponse(
                Integer idClube,
                String nomeClube,
                String foto,
                Float orcamento
        ) {}
    }
}
<?php

require_once 'Clube.php';

class EstadoJogo {
    public string $nome;
    public string $nacionalidade;
    public string $modo;
    public string $liga;
    public int $idManager;
    public Clube $clube;
    public DateTime $dataInicio; 
    public DateTime $dataAtual;

    public function __construct(array $dados = []) {
        $this->nome = $dados['nome'] ?? '';
        $this->nacionalidade = $dados['nacionalidade'] ?? '';
        $this->modo = $dados['modo'] ?? '';
        $this->liga = $dados['liga'] ?? '';
        $this->idManager = isset($dados['idManager']) ? (int)$dados['idManager'] : 0;

        if (isset($dados['data_inicio']) && !empty($dados['data_inicio'])) {
            $this->dataInicio = new DateTime($dados['data_inicio']);
        } else {
            $this->dataInicio = new DateTime();
        }

        if (isset($dados['data_atual']) && !empty($dados['data_atual'])) {
            $this->dataAtual = new DateTime($dados['data_atual']);
        } else {
            $this->dataAtual = new DateTime();
        }

        $dadosClube = [
            'id'                        => $dados['clube_id'] ?? $dados['clube']['id'] ?? 0,
            'nomeClube'                 => $dados['clube_nome'] ?? $dados['clube']['nomeClube'] ?? '',
            'orcamento'                 => $dados['clube']['orcamento'] ?? 0,
            'valorClube'                => $dados['clube']['valorClube'] ?? 0,
            'camisasVendidas'           => $dados['clube']['camisasVendidas'] ?? 0,
            'qntTorcedores'             => $dados['clube']['qntTorcedores'] ?? 0,
            'reputacao'                 => $dados['clube']['reputacao'] ?? 0,
            'patrocinador_idPatrocinador' => $dados['clube']['patrocinador_idPatrocinador'] ?? null,
            'confiancaDiretoria'        => $dados['clube']['confiancaDiretoria'] ?? 50,
            'statusConfianca'           => $dados['clube']['statusConfianca'] ?? 'ESTAVEL',
            'eventoAtual'               => $dados['clube']['eventoAtual'] ?? null,
            'capacidadeEstadio'         => $dados['clube']['capacidadeEstadio'] ?? 0,
            'foto'                      => $dados['clube_foto'] ?? $dados['clube']['foto'] ?? '',
            'nomeEstadio'               => $dados['clube']['nomeEstadio'] ?? ''
        ];

        $this->clube = new Clube($dadosClube);
    }
}
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
    public string $tipoMonetario;

    public function __construct(array $dados = []) {
        $this->nome = $dados['nome'] ?? '';
        $this->nacionalidade = $dados['nacionalidade'] ?? '';
        $this->modo = $dados['modo'] ?? '';
        $this->liga = $dados['liga'] ?? '';
        $this->idManager = isset($dados['idManager']) ? (int)$dados['idManager'] : 0;
        $this->tipoMonetario = "R$";

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

        var_dump($dados);

        $apiService = new ApiService();
        $dadosClube = $apiService->get("/clubes/{$dados['clube_id']}");

        $dadosClube = [
            'id'                        => $dadosClube['idClube'] ?? $dadosClube['clube']['id'] ?? 0,
            'nomeClube'                 => $dadosClube['nomeClube'] ?? $dadosClube['clube']['nomeClube'] ?? '',
            'orcamento'                 => $dadosClube['orcamento'] ?? 0,
            'valorClube'                => $dadosClube['valorClube'] ?? 0,
            'camisasVendidas'           => $dadosClube['camisasVendidas'] ?? 0,
            'qntTorcedores'             => $dadosClube['qntTorcedores'] ?? 0,
            'reputacao'                 => $dadosClube['reputacao'] ?? 0,
            'patrocinador_idPatrocinador' => $dadosClube['patrocinador_idPatrocinador'] ?? null,
            'confiancaDiretoria'        => $dadosClube['confiancaDiretoria'] ?? 50,
            'statusConfianca'           => $dadosClube['statusConfianca'] ?? 'ESTAVEL',
            'eventoAtual'               => $dadosClube['eventoAtual'] ?? null,
            'capacidadeEstadio'         => $dadosClube['capacidadeEstadio'] ?? 0,
            'foto'                      => $dadosClube['foto'] ?? $dadosClube['clube']['foto'] ?? '',
            'nomeEstadio'               => $dadosClube['nomeEstadio'] ?? ''
        ];

        $this->clube = new Clube($dadosClube);
    }
}
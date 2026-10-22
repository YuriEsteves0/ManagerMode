<?php

class Clube {
    public int $id;
    public string $nomeClube;
    public float $orcamento;
    public int $valorClube;
    public int $camisasVendidas;
    public int $qntTorcedores;
    public int $reputacao;
    public ?int $patrocinadorId;
    public int $confiancaDiretoria;
    public string $statusConfianca;
    public ?string $eventoAtual;
    public int $capacidadeEstadio;
    public string $foto;
    public string $nomeEstadio;

    public function __construct(array $dadosClube = []) {
        $this->id = isset($dadosClube['id']) ? (int)$dadosClube['id'] : 0;
        $this->nomeClube = $dadosClube['nomeClube'] ?? '';
        $this->orcamento = isset($dadosClube['orcamento']) ? (float)$dadosClube['orcamento'] : 0.0;
        $this->valorClube = isset($dadosClube['valorClube']) ? (int)$dadosClube['valorClube'] : 0;
        $this->camisasVendidas = isset($dadosClube['camisasVendidas']) ? (int)$dadosClube['camisasVendidas'] : 0;
        $this->qntTorcedores = isset($dadosClube['qntTorcedores']) ? (int)$dadosClube['qntTorcedores'] : 0;
        $this->reputacao = isset($dadosClube['reputacao']) ? (int)$dadosClube['reputacao'] : 0;
        $this->patrocinadorId = isset($dadosClube['patrocinador_idPatrocinador']) ? (int)$dadosClube['patrocinador_idPatrocinador'] : null;
        $this->confiancaDiretoria = isset($dadosClube['confiancaDiretoria']) ? (int)$dadosClube['confiancaDiretoria'] : 50;
        $this->statusConfianca = $dadosClube['statusConfianca'] ?? 'ESTAVEL';
        $this->eventoAtual = $dadosClube['eventoAtual'] ?? null;
        $this->capacidadeEstadio = isset($dadosClube['capacidadeEstadio']) ? (int)$dadosClube['capacidadeEstadio'] : 0;
        $this->foto = $dadosClube['foto'] ?? '';
        $this->nomeEstadio = $dadosClube['nomeEstadio'] ?? '';
    }
}
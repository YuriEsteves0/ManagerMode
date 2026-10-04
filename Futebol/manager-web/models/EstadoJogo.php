<?php

require_once 'Clube.php';

class EstadoJogo {
    public string $nome;
    public string $nacionalidade;
    public string $modo;
    public string $liga;
    public Clube $clube;
    public DateTime $dataInicio; 

    public function __construct(array $dados = []) {
        $this->nome = $dados['nome'] ?? '';
        $this->nacionalidade = $dados['nacionalidade'] ?? '';
        $this->modo = $dados['modo'] ?? '';
        $this->liga = $dados['liga'] ?? '';

        if (isset($dados['data_inicio'])) {
            $this->dataInicio = new DateTime($dados['data_inicio']);
        } else {
            $this->dataInicio = new DateTime();
        }

        $dadosClube = [
            'id'        => $dados['clube_id'] ?? $dados['clube']['id'] ?? 0,
            'nomeClube' => $dados['clube_nome'] ?? $dados['clube']['nomeClube'] ?? '',
            'foto'      => $dados['clube_foto'] ?? $dados['clube']['foto'] ?? ''
        ];

        $this->clube = new Clube($dadosClube);
    }
}
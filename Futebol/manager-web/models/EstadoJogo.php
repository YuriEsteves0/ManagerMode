<?php

require_once 'Clube.php';

class EstadoJogo {
    public string $nome;
    public string $nacionalidade;
    public string $modo;
    public string $liga;
    public Clube $clube;

    public function __construct(array $dados = []) {
        $this->nome = $dados['nome'] ?? '';
        $this->nacionalidade = $dados['nacionalidade'] ?? '';
        $this->modo = $dados['modo'] ?? '';
        $this->liga = $dados['liga'] ?? '';

        // Monta o objeto Clube mapeando tanto o seu array antigo quanto um array aninhado
        $dadosClube = [
            'id'        => $dados['clube_id'] ?? $dados['clube']['id'] ?? 0,
            'nomeClube' => $dados['clube_nome'] ?? $dados['clube']['nomeClube'] ?? '',
            'foto'      => $dados['clube_foto'] ?? $dados['clube']['foto'] ?? ''
        ];

        $this->clube = new Clube($dadosClube);
    }
}
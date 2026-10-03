<?php

class Clube {
    public int $id;
    public string $nomeClube;
    public string $foto;

    public function __construct(array $dadosClube = []) {
        $this->id = isset($dadosClube['id']) ? (int)$dadosClube['id'] : 0;
        $this->nomeClube = $dadosClube['nomeClube'] ?? '';
        $this->foto = $dadosClube['foto'] ?? '';
    }
}
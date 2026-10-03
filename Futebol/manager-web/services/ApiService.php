<?php 

class ApiService{
    private string $baseURL;

    public function __construct(string $baseURL = "http://localhost:8080"){
        $this->baseURL = $baseURL;
    }

    public function get(string $endpoint, array $params = []): ?array{
        $url = $this->baseURL . $endpoint;

        if(!empty($params)){
            $url .= '?' . http_build_query($params);
        }

        $ch = curl_init($url);

        curl_setopt_array($ch, [
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_TIMEOUT => 5,
            CURLOPT_HTTPHEADER => [
                'Accept: application/json',
                'Content-Type: application/json'
            ]
            ]);

        $response = curl_exec($ch);

        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);

        curl_close($ch);

        if($httpCode === 200 && $response){
            return json_decode($response, true);
        }

        return null;

    }

    public function getClassificacaoProxima(int $idLiga, int $idClubeJogador, int $limite = 5): array{
        // 1. Busca os dados completos da API
        $classificacao = $this->get("/competicoes/{$idLiga}/classificacao") ?? [];

        if (empty($classificacao)) {
            return [];
        }

        // 2. Encontra a posição do jogador
        $indexJogador = -1;
        foreach ($classificacao as $index => $item) {
            if (($item['clube_idClube'] ?? null) == $idClubeJogador) {
                $indexJogador = $index;
                break;
            }
        }

        if ($indexJogador === -1) {
            return array_slice($classificacao, 0, $limite);
        }

        // 3. Aplica o recorte (janela móvel)
        $total = count($classificacao);
        $inicio = max(0, $indexJogador - 2);

        if ($inicio + $limite > $total) {
            $inicio = max(0, $total - $limite);
        }

        return array_slice($classificacao, $inicio, $limite);
    }

}

?>
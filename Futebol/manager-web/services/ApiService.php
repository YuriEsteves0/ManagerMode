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

}


?>
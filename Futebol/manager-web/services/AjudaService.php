<?php

// Envia o pedido de ajuda do jogador para o Apito (config/apito.php).
class AjudaService
{
    private const CATEGORIAS = ['Erro', 'Dúvida', 'Sugestão', 'Outro'];
    private const TELAS = [
        'Criação de manager',
        'Início',
        'Equipe',
        'Estatísticas',
        'Patrocínios',
        'Central de elenco',
        'Mercado',
        'Propostas recebidas',
        'Propostas enviadas',
        'Calendário',
        'Treino',
        'Diretoria',
        'Carreira',
        'Partida',
        'Imprensa',
        'Configurações',
        'Outra',
    ];
    private const INTERVALO_SEGUNDOS = 10; // evita enviar o mesmo pedido várias vezes seguidas

    private array $config;

    public function __construct(?array $config = null)
    {
        $this->config = $config ?? (require __DIR__ . '/../config/apito.php');
    }

    /** Valida o formulário e manda para o Apito. Devolve ['ok' => bool, 'status' => int, 'erro' => ?string]. */
    public function enviarPedido(array $in): array
    {
        $categoria = trim((string)($in['categoria'] ?? ''));
        $tela      = trim((string)($in['tela'] ?? ''));
        $titulo    = trim((string)($in['titulo'] ?? ''));
        $descricao = trim((string)($in['descricao'] ?? ''));
        $email     = mb_strtolower(trim((string)($in['email'] ?? '')));

        if (!in_array($categoria, self::CATEGORIAS, true)) return $this->falha(422, 'Escolha o tipo do pedido.');
        // a tela só vale para erros; nos outros tipos o campo é ignorado
        if ($categoria !== 'Erro') $tela = '';
        if ($categoria === 'Erro' && !in_array($tela, self::TELAS, true)) return $this->falha(422, 'Informe a tela onde ocorreu o erro.');
        if (mb_strlen($titulo) < 3 || mb_strlen($titulo) > 140) return $this->falha(422, 'Informe um assunto (de 3 a 140 caracteres).');
        if (mb_strlen($descricao) < 10) return $this->falha(422, 'Descreva melhor o que aconteceu (mínimo de 10 caracteres).');
        if (mb_strlen($descricao) > 2000) return $this->falha(422, 'A descrição está muito longa (máximo de 2000 caracteres).');
        if (!filter_var($email, FILTER_VALIDATE_EMAIL) || mb_strlen($email) > 120) return $this->falha(422, 'Informe um e-mail válido para contato.');

        $agora = time();
        if ($agora - (int)($_SESSION['ajuda_ultimo_envio'] ?? 0) < self::INTERVALO_SEGUNDOS) {
            return $this->falha(429, 'Aguarde alguns segundos antes de enviar outro pedido.');
        }

        $url   = (string)($this->config['url'] ?? '');
        $token = (string)($this->config['token'] ?? '');
        if ($url === '' || $token === '') {
            error_log('[ajuda] config/apito.php sem url ou token.');
            return $this->falha(500, 'O envio de pedidos ainda não está configurado.');
        }

        $descricaoEnvio = $descricao;
        if ($tela !== '') {
            $descricaoEnvio = 'Tela onde ocorreu o erro: ' . $tela . "\n\n" . $descricao;
        }

        $corpo = json_encode([
            'titulo'     => $titulo,
            'descricao'  => $descricaoEnvio,
            'email'      => $email,
            'categoria'  => $categoria,
            'origem'     => (string)($this->config['origem'] ?? 'ManagerMode'),
        ], JSON_UNESCAPED_UNICODE);

        $ch = curl_init($url);
        curl_setopt_array($ch, [
            CURLOPT_POST           => true,
            CURLOPT_POSTFIELDS     => $corpo,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_CONNECTTIMEOUT => 3,
            CURLOPT_TIMEOUT        => 6,
            CURLOPT_HTTPHEADER     => [
                'Accept: application/json',
                'Content-Type: application/json',
                'X-Apito-Token: ' . $token,
            ],
        ]);
        $resposta = curl_exec($ch);
        $codigo   = (int)curl_getinfo($ch, CURLINFO_HTTP_CODE);
        $erroCurl = curl_error($ch);
        curl_close($ch);

        if ($resposta === false) {
            error_log('[ajuda] Apito inacessível: ' . $erroCurl);
            return $this->falha(502, 'Não consegui enviar agora. Tente de novo em alguns minutos.');
        }
        if ($codigo !== 201 && $codigo !== 200) {
            error_log('[ajuda] Apito respondeu ' . $codigo . ': ' . $resposta);
            return $this->falha(502, 'Não consegui enviar agora. Tente de novo em alguns minutos.');
        }

        $_SESSION['ajuda_ultimo_envio'] = $agora;
        return ['ok' => true, 'status' => 201, 'erro' => null];
    }

    private function falha(int $status, string $mensagem): array
    {
        return ['ok' => false, 'status' => $status, 'erro' => $mensagem];
    }
}

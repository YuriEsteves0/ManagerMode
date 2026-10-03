# Guia de Instalação — ManagerMode

O projeto tem 3 partes que precisam estar rodando juntas:

| Parte | Tecnologia | Pasta | Endereço padrão |
|---|---|---|---|
| Banco de dados | MySQL/MariaDB | `BD/manager.sql` | `localhost:3306` |
| API | Java 17 + Spring Boot | `Futebol/manager-api` | `http://localhost:8080` |
| Front-end | PHP + CSS | `Futebol/manager-web` | `http://localhost/...` (Apache) |

O front-end (PHP) consome a API, e a API consome o banco. Por isso a ordem de inicialização é: **banco → API → front-end**.

---

## 1. Pré-requisitos

- **XAMPP** (Apache + MySQL/MariaDB + PHP 8.x): https://www.apachefriends.org
- **JDK 17** ou superior (ex.: Eclipse Temurin 17)
- **Git** ou GitHub Desktop (para clonar o repositório)
- Opcional: Eclipse/STS ou IntelliJ para rodar a API pela IDE (precisa do plugin do **Lombok**)

Confira as versões no terminal:

```bash
java -version      # deve mostrar 17 ou maior
php -v             # deve mostrar 8.x (o XAMPP traz o seu próprio PHP)
```

---

## 2. Baixar o projeto

```bash
git clone https://github.com/<seu-usuario>/ManagerMode.git
```

Ou baixe o ZIP pelo GitHub e extraia.

---

## 3. Banco de dados

1. Abra o **XAMPP Control Panel** e inicie o **MySQL** (e o **Apache**, que vamos usar no passo 5).
2. Acesse http://localhost/phpmyadmin.
3. Clique em **Novo** e crie um banco chamado exatamente `manager` (collation `utf8mb4_general_ci` ou `utf8_general_ci`).
4. Selecione o banco `manager`, vá na aba **Importar**, escolha o arquivo `BD/manager.sql` e clique em **Importar**.
5. Confira se as tabelas apareceram (`clube`, `competicao`, `jogador`, `noticia`, `partida`, etc.).

> O arquivo `manager.sql` **não cria o banco**, só as tabelas. Por isso o passo 3 é obrigatório.

---

## 4. API (Spring Boot)

### 4.1 Configurar a conexão

Abra `Futebol/manager-api/src/main/resources/application.properties` e confira:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/manager?useSSL=false&serverTimezone=UTC
spring.datasource.username=root
spring.datasource.password=
```

O padrão do XAMPP é usuário `root` e senha vazia. Se você definiu senha no MySQL, coloque em `spring.datasource.password`.

### 4.2 Rodar

Pelo terminal, dentro de `Futebol/manager-api`:

```powershell
.\mvnw.cmd spring-boot:run
```

(No Linux/Mac: `./mvnw spring-boot:run`.)

Ou pela IDE: abra a pasta `manager-api` como projeto Maven e execute a classe principal com **Run as → Java Application** (ou *Spring Boot App*).

### 4.3 Testar

Com a API no ar, estes endereços devem responder:

- http://localhost:8080/swagger-ui.html — documentação interativa da API
- http://localhost:8080/competicoes — lista de competições

---

## 5. Front-end (PHP)

1. Copie a pasta `Futebol/manager-web` para dentro do `htdocs` do XAMPP, por exemplo:
   `C:\xampp\htdocs\futebol\Futebol\manager-web`
2. Com o **Apache** ligado, acesse:
   `http://localhost/futebol/Futebol/manager-web/`
3. Faça o cadastro (nome, nacionalidade, liga e clube). Ao finalizar, você cai na tela inicial com elenco, tabela, transferências e imprensa.

> Sempre acesse por `http://localhost/...`. Abrir o arquivo direto no navegador (`file://`) ou com o servidor embutido sem a API no ar **não funciona**.

O front chama a API em `http://localhost:8080` (definido no construtor da classe `ApiService`, em `manager-web/services/ApiService.php`). Se mudar a porta da API, mude lá também.

---

## 6. Solução de problemas

### Banco de dados

**`Unknown database 'manager'`**
O banco não foi criado. Refaça o passo 3 (crie o banco `manager` antes de importar).

**`Access denied for user 'root'@'localhost'`**
A senha do MySQL não bate com a do `application.properties`. Ajuste `spring.datasource.password`.

**`Communications link failure` / `Connection refused`**
O MySQL não está rodando ou está em outra porta. Inicie o MySQL no XAMPP e confirme a porta 3306 no `application.properties`.

**`Schema-validation: missing column ...` / `wrong column type ...`**
Com `spring.jpa.hibernate.ddl-auto=validate`, a API confere se as entidades Java batem com as tabelas. Esse erro significa que o banco está desatualizado em relação ao código. Reimporte o `manager.sql` mais recente (apague o banco `manager`, crie de novo e importe). Pontos que costumam dar problema:
- `noticia.dataPublicacao` precisa ser `datetime` (a entidade usa `LocalDateTime`)
- `partida` precisa da coluna `competicao_idCompeticao`

### API

**`Port 8080 was already in use`**
Outro programa usa a 8080 (o Tomcat do XAMPP é um suspeito comum). Opções:
- Pare o outro programa, ou
- Adicione `server.port=8081` no `application.properties` e troque `http://localhost:8080` por `http://localhost:8081` no `ApiService.php`.

**`release version 17 not supported` / `invalid target release: 17`**
O Maven está usando um JDK mais antigo. Instale o JDK 17+ e confira o `JAVA_HOME`:

```powershell
echo $env:JAVA_HOME
java -version
```

**`'mvnw.cmd' is not recognized` (PowerShell)**
Use `.\mvnw.cmd` (com o `.\` na frente) e rode dentro da pasta `manager-api`.

**Erros de `cannot find symbol` / métodos `get`/`set` não encontrados (Eclipse/STS)**
O Lombok não está instalado na IDE. Instale o Lombok (rodando o `lombok.jar` e apontando para a IDE) e reinicie. Pelo terminal com `mvnw` isso não acontece.

**API sobe, mas o endpoint devolve erro 500**
Olhe o console da API (o `show-sql` está ligado, então a query com problema aparece). Na maioria das vezes é banco desatualizado (veja *Schema-validation* acima).

### Front-end (PHP)

**`Call to undefined function curl_init()`**
A extensão cURL está desativada. Abra o `php.ini` (XAMPP: *Config → PHP (php.ini)* no painel do Apache), remova o `;` da linha `extension=curl`, salve e reinicie o Apache.

**`Failed opening required '../models/EstadoJogo.php'`**
Caminho relativo errado. No `Cadastro3Controller.php`, use `require_once __DIR__ . '/../models/EstadoJogo.php';`.

**Tela inicial vazia (sem elenco, tabela ou notícias)**
Nesta ordem:
1. A API está no ar? Teste http://localhost:8080/competicoes.
2. Você fez o cadastro? Os dados vêm da sessão; se abriu `?pag=inicio` direto, não há clube selecionado.
3. O banco tem dados de jogadores e notícias para o clube escolhido?
4. A porta no `ApiService.php` bate com a da API?

**`__PHP_Incomplete_Class` ou erro ao ler `$_SESSION['estado_jogo']`**
A classe `EstadoJogo` precisa ser carregada **antes** do `session_start()` no `index.php`. Depois de corrigir, apague os cookies do site (ou abra em aba anônima) e refaça o cadastro, pois a sessão antiga ficou corrompida.

**`Warning: Undefined array key "carreira"`**
Alguma página ainda usa o formato antigo `$_SESSION['carreira']`. Troque por `$_SESSION['estado_jogo']` (objeto: `->clube->id`, `->clube->nomeClube`, etc.).

**CSS ou imagens não carregam**
Confira se você está acessando pelo `index.php` da pasta `manager-web` e se a pasta `assets/` foi copiada junto.

**Acentos aparecendo errados (`Ã§`, `Ã£`)**
Salve os arquivos PHP em UTF-8 e confirme que o banco foi importado com `utf8`/`utf8mb4`.

**Apache não inicia (porta 80 ou 443 em uso)**
Outro programa (Skype, IIS, VMware) está usando a porta. Feche-o ou mude a porta do Apache em *Config → httpd.conf* (`Listen 80` → `Listen 8081`) e acesse `http://localhost:8081/...`.

---

## 7. Resumo rápido

1. Iniciar **MySQL** e **Apache** no XAMPP
2. Criar o banco `manager` e importar `BD/manager.sql`
3. `cd Futebol/manager-api` → `.\mvnw.cmd spring-boot:run`
4. Copiar `manager-web` para o `htdocs` e abrir `http://localhost/.../manager-web/`
5. Fazer o cadastro e jogar

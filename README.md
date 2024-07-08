# Contact List App

Este é um projeto de exemplo para uma aplicação de lista de contatos desenvolvida em Ruby on Rails.

## Funcionalidades

- Cadastro, edição, visualização e exclusão de contatos.
- Pesquisa de contatos por nome ou CPF.
- Integração com API ViaCEP para preenchimento automático de endereço.
- Integração com Google Maps para exibição de localização dos contatos.

## Configuração do Ambiente

### Pré-requisitos

Certifique-se de ter as seguintes ferramentas instaladas em seu sistema:

- Ruby >= 3.3.3
- Rails >= 7.0
- PostgreSQL (ou outro banco de dados compatível com Rails)

### Instalação

1. Clonar o repositório:

   ```bash
   git clone git@github.com:ewertoncodes/contact_list_app.git
   cd contact_list_app

2. Instalar dependências:

Certifique-se de ter Ruby e Rails instalados no seu sistema. Você pode usar gerenciadores de versão como rbenv, rvm, asdf ou instalar diretamente.


3. Configurar banco de dados:

Copie o arquivo de configuração do banco de dados:

```bash
cp config/database.yml.sample config/database.yml
```
Edite config/database.yml conforme necessário para configurar suas credenciais de banco de dados.

4. Configurar variáveis de ambiente:

Crie um arquivo .env na raiz do projeto:
```bash
touch .env
```

Adicione a seguinte variável de ambiente no arquivo `.env`:


```bash
GOOGLE_MAPS_API_KEY=sua_chave_aqui
```
5. Instale as gems e Inicialize o banco de dados:

``` bash
bundle install
rails db:create
rails db:migrate
``` 
6. Executar o servidor localmente:
``` bash
./bin/dev
```
Acesse o aplicativo em http://localhost:3000 e comece a usar a aplicação de lista de contatos!


7. Usando o mailcatcher para simular uma caixa de entrada de emails:

``` bash
    gem install mailcatcher
    
    mailcatcher

    http://127.0.0.1:1080/ #abra no navegar 
    smtp://127.0.0.1:1025 
``` 



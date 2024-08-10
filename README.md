# 🎟️ Ticketease

**Ticketease** é uma plataforma moderna de gerenciamento de chamados, desenvolvida para facilitar a vida de equipes de suporte. Nosso sistema não só organiza e prioriza os chamados, como também garante que você nunca perca um prazo, enviando notificações por email quando um chamado está prestes a vencer. Além disso, você pode visualizar facilmente os dados de desempenho através de gráficos dinâmicos.

## 🚀 Funcionalidades Principais

- **📑 Gestão de Chamados:** Crie, edite e acompanhe chamados em tempo real.
- **⏰ Notificações de Vencimento:** Receba alertas automáticos via email antes que um chamado vença.
- **⚡ Priorização Inteligente:** Classifique os chamados com base em prioridade, garantindo que os mais críticos sejam tratados primeiro.
- **📊 Gráficos e Relatórios:** Visualize o desempenho da sua equipe e o volume de chamados com gráficos detalhados. ( Em construção )
- **📚 Histórico Completo:** Acompanhe todas as ações e interações com cada chamado. ( Em construção )

## 🛠️ Tecnologias Utilizadas

### Backend
- **Linguagem:** Ruby
- **Framework:** Ruby On Rails
- **Banco de Dados:** PostgreSQL

### Frontend
- **Linguagem:** Javascript
- **Framework:** Vue
- **Estilização:** Quasar

## 🧑‍💻 Como Executar

Clone o repositório:

```
git clone https://github.com/joao-carlos-pereira-alves/ticketease-core
```

Entre no diretório:

```
cd ticketease-core
```

Instale as dependências:

```
mix ecto.setup
mix ecto.migrate
```

Inicie o postgreSQL pelo docker-compose:

```
docker-compose -f docker-compose.dev.yml up --build
```

Inicie o servidor de desenvolvimento:

```
mix phx.server
```

🤝 Contribuições
Contribuições são super bem-vindas! Se você tem uma ideia ou encontrou um bug, sinta-se à vontade para abrir uma issue ou enviar um pull request.

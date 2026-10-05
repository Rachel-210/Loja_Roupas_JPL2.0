# 🛍️ Sistema de Gerenciamento e Relatório de Vendas 


## 📋 1. Identificação
* **👤 Aluna:** Lia Rachel Ferreira de Sousa
* **📚 Disciplina:** Projeto de Banco de Dados
* **👨‍🏫 Professor:**  Anderson Soares Costa

---

## 🚀 2. Sobre o Projeto
Esta aplicação consiste em um sistema web full-stack desenvolvido para o gerenciamento de um e-commerce de vestuário e acessórios. 

**O problema que ela resolve:** O sistema automatiza o fluxo operacional da loja, permitindo o cadastro e controle de estoque de produtos em tempo real, o registro seguro de pedidos de clientes e a visualização centralizada de relatórios consolidados de vendas, garantindo integridade transacional através de regras implementadas diretamente no banco de dados.

---

## 🛠️ 3. Tecnologias Utilizadas
* 🐍 **Python / Flask** (Back-end, rotas e controle de requisições HTTP)
* 🐘 **PostgreSQL** (Gerenciamento do banco de dados relacional e persistência)
* 🌐 **HTML5 / Jinja2 / Bootstrap 5** (Interface web e renderização de templates)

---

## 🗄️️ 4. Banco de Dados

### ⚙️ SGBD Utilizado
* **PostgreSQL**

### 📊 Principais Tabelas
* 🏷️ **`categorias`**: Organiza os produtos por classificações (ex: Camisetas, Calças, Acessórios).
* 📦 **`produtos`**: Armazena o inventário de itens disponíveis na loja, controlando preços, descrições e o saldo atual de estoque.
* 👥 **`clientes`**: Mantém o cadastro dos clientes da loja, armazenando nome e e-mail único.
* 🧾 **`vendas`**: Registra o cabeçalho de cada compra efetuada, ligando o cliente comprador, a data/hora e o valor total da transação.
* 🛒 **`itens_venda`**: Detalha os produtos específicos adquiridos em cada venda, guardando a quantidade exata e o preço unitário praticado no momento da compra.

---

## 🧠 5. Recursos Avançados do Banco e suas Aplicações no Sistema

* **👁️ View (`vw_relatorio_vendas`)**
  * **Onde é utilizada:** Na página inicial de relatórios do sistema (`/`).
  * **Para que serve:** Realiza junções (`JOINs`) automáticas entre as tabelas de vendas, clientes, itens e produtos no nível do banco. Sua função é alimentar diretamente a tabela da interface web exibindo de forma clara, consolidada e legível cada venda realizada, detalhando o cliente, o produto comprado, a quantidade e o valor total sem sobrecarregar a aplicação Python com regras complexas de consulta.

* **📐 Function (`fn_calcular_subtotal`)**
  * **Onde é utilizada:** Nos bastidores do banco de dados, acionada internamente durante a execução da procedure de venda.
  * **Para que serve:** Encapsula a lógica matemática central responsável por calcular o valor parcial (subtotal) de cada item comprado, multiplicando a quantidade informada pelo preço unitário do produto.

* **🛡️ Procedure (`pr_realizar_venda`)**
  * **Onde é utilizada:** Na rota de cadastro de nova venda (`/venda/nova`), acionada quando o usuário preenche o formulário e clica em "Finalizar Venda".
  * **Para que serve:** É o coração transacional do sistema. Ela valida com segurança se há estoque suficiente para atender o pedido antes de prosseguir (lançando uma exceção e bloqueando a operação caso o estoque seja menor que a quantidade desejada). Caso haja disponibilidade, ela calcula o valor total utilizando a function, insere os registros nas tabelas de vendas e itens, e executa a **baixa automática e imediata no estoque** do produto correspondente.

---

## ⚙️ 6. Como Executar o Projeto

Siga os passos abaixo para rodar a aplicação em sua máquina local:

1. **Configurar o Banco de Dados:** No PostgreSQL, crie um banco de dados (por exemplo, `Loja_Roupas`) e execute os scripts de criação de tabelas, inserção de dados iniciais, View, Function e Procedure.
2. **Instalar as Dependências:** Abra o terminal na pasta do projeto e instale as bibliotecas necessárias listadas no projeto (`Flask` e `psycopg2-binary`):
   ```bash
   pip install -r requirements.txt

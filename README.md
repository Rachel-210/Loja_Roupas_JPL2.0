# 🛍️ Sistema de Gerenciamento e Relatório de Vendas 


## 📋 1. Identificação
* **👤 Aluna:** Lia Rachel Ferreira de Sousa
* **📚 Disciplina:** Projeto de Banco de Dados
* **👨‍🏫 Professor:**  Anderson Soares Costa

---

## 🚀 2. Sobre o Projeto
Esta aplicação consiste em um sistema web full-stack desenvolvido para o gerenciamento de um e-commerce de vestuário e acessórios. 

**O problema que ela resolve:** O sistema automatiza o fluxo operacional da loja, permitindo o cadastro e controle de estoque de produtos em tempo real, o registro seguro de pedidos de clientes e a visualização centralizada de relatórios consolidados de vendas, garantindo integridade transacional através de regras implementadas diretamente no banco de dados.

### 🖼️ 2.1. Demonstração Visual da Interface

* **Tela Inicial / Relatório de Vendas:**  
  * <div align="center">
  <img src="./imagens/relatorio.png" width="500">
</div>

* **Catálogo de Produtos:**  
  * `![Produtos e Estoque](caminho/para/print_produtos.png)`

* **Cadastro de Nova Venda:**  
  * `![Nova Venda](caminho/para/print_nova_venda.png)`

### 📹 2.2. Vídeo de Apresentação
* **Link da Apresentação:** 

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
  * **Estrutura no Banco:**
    ```sql
    CREATE OR REPLACE VIEW vw_relatorio_vendas AS
    SELECT 
        v.id AS venda_id,
        c.nome AS cliente_nome,
        c.email AS cliente_email,
        p.nome AS produto,
        iv.quantidade AS quantidade,
        v.data_venda,
        v.valor_total
    FROM vendas v
    JOIN clientes c ON v.cliente_id = c.id
    JOIN itens_venda iv ON v.id = iv.venda_id
    JOIN produtos p ON iv.produto_id = p.id;
    ```

* **📐 Function (`fn_calcular_subtotal`)**
  * **Onde é utilizada:** Nos bastidores do banco de dados, acionada internamente durante a execução da procedure de venda.
  * **Para que serve:** Encapsula a lógica matemática central responsável por calcular o valor parcial (subtotal) de cada item comprado, multiplicando a quantidade informada pelo preço unitário do produto.
  * **Estrutura no Banco:**
    ```sql
    CREATE OR REPLACE FUNCTION fn_calcular_subtotal(p_quantidade INT, p_preco NUMERIC)
    RETURNS NUMERIC AS $$
    BEGIN
        RETURN p_quantidade * p_preco;
    END;
    $$ LANGUAGE plpgsql;
    ```

* **🛡️ Procedure (`pr_realizar_venda`)**
  * **Onde é utilizada:** Na rota de cadastro de nova venda (`/venda/nova`), acionada quando o usuário preenche o formulário e clica em "Finalizar Venda".
  * **Para que serve:** É o coração transacional do sistema. Ela valida com segurança se há estoque suficiente para atender o pedido antes de prosseguir (lançando uma exceção e bloqueando a operação caso o estoque seja menor que a quantidade desejada). Caso haja disponibilidade, ela calcula o valor total utilizando a function, insere os registros nas tabelas de vendas e itens, e executa a **baixa automática e imediata no estoque** do produto correspondente.
  * **Estrutura no Banco:**
    ```sql
    CREATE OR REPLACE PROCEDURE pr_realizar_venda(
        p_cliente_id INT,
        p_produto_id INT,
        p_quantidade INT
    )
    AS $$
    DECLARE
        v_preco NUMERIC;
        v_estoque_atual INT;
        v_venda_id INT;
        v_valor_total NUMERIC;
    BEGIN
        SELECT preco, estoque INTO v_preco, v_estoque_atual
        FROM produtos WHERE id = p_produto_id;

        IF v_estoque_atual < p_quantidade THEN
            RAISE EXCEPTION 'Estoque insuficiente para o produto. Disponível: %', v_estoque_atual;
        END IF;

        v_valor_total := fn_calcular_subtotal(p_quantidade, v_preco);

        INSERT INTO vendas (cliente_id, valor_total) 
        VALUES (p_cliente_id, v_valor_total)
        RETURNING id INTO v_venda_id;

        INSERT INTO itens_venda (venda_id, produto_id, quantidade, preco_unitario)
        VALUES (v_venda_id, p_produto_id, p_quantidade, v_preco);

        UPDATE produtos 
        SET estoque = estoque - p_quantidade 
        WHERE id = p_produto_id;
    END;
    $$ LANGUAGE plpgsql;
    ```

---

## ⚙️ 6. Como Executar o Projeto

Siga os passos abaixo para rodar a aplicação em sua máquina local:

1. **Configurar o Banco de Dados:** No PostgreSQL, crie um banco de dados (por exemplo, `Loja_Roupas`) e execute os scripts de criação de tabelas, inserção de dados iniciais, View, Function e Procedure.
2. **Instalar as Dependências:** Abra o terminal na pasta do projeto e instale as bibliotecas necessárias listadas no projeto (`Flask` e `psycopg2-binary`):
   ```bash
   pip install -r requirements.txt

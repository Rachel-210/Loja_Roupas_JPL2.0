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
    -- Verifica o estoque e preço do produto
    SELECT preco, estoque INTO v_preco, v_estoque_atual
    FROM produtos WHERE id = p_produto_id;

    IF v_estoque_atual < p_quantidade THEN
        RAISE EXCEPTION 'Estoque insuficiente para o produto. Disponível: %', v_estoque_atual;
    END IF;

    -- Calcula o valor total usando a nossa Function
    v_valor_total := fn_calcular_subtotal(p_quantidade, v_preco);

    -- Insere a venda
    INSERT INTO vendas (cliente_id, valor_total) 
    VALUES (p_cliente_id, v_valor_total)
    RETURNING id INTO v_venda_id;

    -- Insere o item da venda
    INSERT INTO itens_venda (venda_id, produto_id, quantidade, preco_unitario)
    VALUES (v_venda_id, p_produto_id, p_quantidade, v_preco);

    -- Atualiza o estoque do produto
    UPDATE produtos 
    SET estoque = estoque - p_quantidade 
    WHERE id = p_produto_id;
    
END;
$$ LANGUAGE plpgsql;

CALL pr_realizar_venda(3, 2, 2);

CALL pr_realizar_venda(4, 4, 1);

CALL pr_realizar_venda(5, 7, 1);

CALL pr_realizar_venda(6, 14, 3);

CALL pr_realizar_venda(1, 8, 1);

CALL pr_realizar_venda(2, 13, 2);

CALL pr_realizar_venda(3, 10, 1);
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

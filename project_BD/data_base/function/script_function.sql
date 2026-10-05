CREATE OR REPLACE FUNCTION fn_calcular_subtotal(p_quantidade INT, p_preco NUMERIC)
RETURNS NUMERIC AS $$
BEGIN
    RETURN p_quantidade * p_preco;
END;
$$ LANGUAGE plpgsql;

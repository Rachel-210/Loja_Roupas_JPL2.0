-- Categorias
INSERT INTO categorias (nome) VALUES 
('Camisetas'), 
('Calças'), 
('Casacos e Moletons'), 
('Vestidos e Saias'), 
('Bermudas e Shorts'),
('Acessórios');

-- Produtos
INSERT INTO produtos (nome, preco, estoque, categoria_id) VALUES 
-- Camisetas (Categoria 1)
('Camiseta Oversized Minimalista Branca', 89.90, 25, 1),
('Camiseta Estampada Vintage Rock', 99.90, 18, 1),
('Camiseta Básica Algodão Pima', 79.90, 30, 1),

-- Calças (Categoria 2)
('Calça Jeans Wide Leg Cintura Alta', 159.90, 12, 2),
('Calça Alfaiataria Slim Comfort', 189.90, 10, 2),
('Calça Jogger Moletom Urban', 139.90, 15, 2),

-- Casacos e Moletons (Categoria 3)
('Moletom com Capuz Comfort Preto', 199.90, 14, 3),
('Jaqueta Bomber Oversized', 249.90, 8, 3),
('Cardigan de Tricô Midi', 169.90, 9, 3),

-- Vestidos e Saias (Categoria 4)
('Vestido Midi Slip Dress Saten', 179.90, 11, 4),
('Saia Jeans Midi Com Fenda', 129.90, 13, 4),

-- Bermudas e Shorts (Categoria 5)
('Bermuda Jeans Rústica', 119.90, 20, 5),
('Shorts Linho Cintura Alta', 99.90, 22, 5),

-- Acessórios (Categoria 6)
('Boné Dad Hat Minimalista', 59.90, 25, 6),
('Cinto de Couro Sintético', 79.90, 15, 6);

-- Clientes
INSERT INTO clientes (nome, email) VALUES 
('Ana Souza', 'ana.souza@email.com'),
('Carlos Lima', 'carlos.lima@email.com'),
('Mariana Ribeiro', 'mariana.ribeiro@email.com'),
('Lucas Gabriel Santos', 'lucas.gabriel@email.com'),
('Beatriz Costa', 'beatriz.costa@email.com'),
('Matheus Henrique', 'matheus.henrique@email.com');

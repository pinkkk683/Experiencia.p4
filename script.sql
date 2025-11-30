-- ******************************************************
-- 1. INSERÇÃO DE DADOS (INSERT INTO)
-- ******************************************************

-- 1.1. Inserir Administradores (ADMINISTRADOR)
INSERT INTO ADMINISTRADOR (id_admin, nome, cpf, email, telefone) VALUES
(1, 'Roberto Gerente', '111.111.111-11', 'roberto@imoveis.com', '(11) 99111-1111'),
(2, 'Ana Supervisora', '222.222.222-22', 'ana@imoveis.com', '(11) 99222-2222');

-- 1.2. Inserir Imóveis (IMÓVEL)
-- Nota: Assumimos que a tabela IMÓVEL possui id_admin como FK, conforme a regra de "Possui_Imovel" (1:N)
INSERT INTO IMÓVEL (id_imovel, endereco, numero, complemento, bairro, cidade, uf, cep, area, valor_aluguel_base, id_admin) VALUES
(101, 'Rua das Flores', 120, 'Apto 101', 'Jardim Amplo', 'São Paulo', 'SP', '01000-000', 65.50, 1500.00, 1),
(102, 'Avenida Principal', 500, 'Casa 2', 'Centro', 'São Paulo', 'SP', '02000-000', 120.00, 2800.00, 1),
(103, 'Rua Teste', 30, 'Sala Comercial 3', 'Berrini', 'São Paulo', 'SP', '03000-000', 40.00, 1800.00, 2);

-- 1.3. Inserir Inquilinos (INQUILINO)
INSERT INTO INQUILINO (id_inquilino, nome, cpf, telefone, email) VALUES
(10, 'Julia Silva', '333.333.333-33', '(11) 99333-3333', 'julia.silva@email.com'),
(11, 'Pedro Santos', '444.444.444-44', '(11) 99444-4444', 'pedro.santos@email.com');

-- 1.4. Inserir Contratos (CONTRATO)
INSERT INTO CONTRATO (id_contrato, id_imovel, id_inquilino, id_admin, data_inicio, data_fim, valor_aluguel, dia_vencimento, status_contrato) VALUES
-- Contrato Ativo da Julia (Imóvel 101, Admin 1)
(1, 101, 10, 1, '2024-03-01', NULL, 1550.00, 5, 'ativo'),
-- Contrato Encerrado do Pedro (Imóvel 102, Admin 1)
(2, 102, 11, 1, '2023-01-15', '2024-01-15', 2800.00, 10, 'encerrado'),
-- Contrato Ativo do Pedro (Imóvel 103, Admin 2)
(3, 103, 11, 2, '2024-05-01', NULL, 1850.00, 15, 'ativo');

-- 1.5. Inserir Pagamentos (PAGAMENTO)
INSERT INTO PAGAMENTO (id_pagamento, id_contrato, mes_referencia, data_vencimento, data_pagamento, valor_pago, metodo_pagamento, status_pagamento) VALUES
(1001, 1, '2024-10-01', '2024-10-05', '2024-10-03', 1550.00, 'PIX', 'pago'),           -- Contrato 1 (Julia) - Pago
(1002, 1, '2024-11-01', '2024-11-05', NULL, NULL, NULL, 'pendente'),                      -- Contrato 1 (Julia) - Pendente/Atrasado
(1003, 3, '2024-09-01', '2024-09-15', '2024-09-20', 1900.00, 'Boleto', 'pago'),         -- Contrato 3 (Pedro) - Pago com multa
(1004, 2, '2024-01-01', '2024-01-10', '2024-01-09', 2800.00, 'TED', 'pago');            -- Contrato 2 (Pedro) - Último Pagamento

-- ******************************************************
-- 2. CONSULTAS DE DADOS (SELECT)
-- ******************************************************

-- Consulta 1: Pagamentos Atrasados/Pendentes (Usa JOIN, WHERE, ORDER BY, LIMIT)
SELECT
    I.nome AS Inquilino,
    C.id_contrato,
    P.mes_referencia,
    P.data_vencimento
FROM PAGAMENTO P
JOIN CONTRATO C ON P.id_contrato = C.id_contrato
JOIN INQUILINO I ON C.id_inquilino = I.id_inquilino
WHERE P.status_pagamento = 'pendente'
ORDER BY P.data_vencimento
LIMIT 10;

-- Consulta 2: Histórico de Pagamentos de um Imóvel (Usa JOIN e WHERE)
SELECT
    P.data_pagamento,
    P.valor_pago,
    I.nome AS Inquilino,
    P.mes_referencia
FROM PAGAMENTO P
JOIN CONTRATO C ON P.id_contrato = C.id_contrato
JOIN INQUILINO I ON C.id_inquilino = I.id_inquilino
WHERE C.id_imovel = 101
ORDER BY P.data_pagamento DESC;

-- Consulta 3: Contratos Ativos por Administrador (Usa JOIN e WHERE)
SELECT
    C.id_contrato,
    I.nome AS Inquilino,
    M.endereco || ', ' || M.numero AS Endereco_Imovel,
    C.valor_aluguel
FROM CONTRATO C
JOIN INQUILINO I ON C.id_inquilino = I.id_inquilino
JOIN IMÓVEL M ON C.id_imovel = M.id_imovel
WHERE C.status_contrato = 'ativo' AND C.id_admin = 1;

-- ******************************************************
-- 3. MANIPULAÇÃO DE DADOS (UPDATE E DELETE)
-- ******************************************************

-- 3.1. Atualizar um Pagamento Pendente para Pago (UPDATE)
UPDATE PAGAMENTO
SET data_pagamento = '2024-11-06',
    valor_pago = 1550.00,
    metodo_pagamento = 'PIX',
    status_pagamento = 'pago'
WHERE id_pagamento = 1002;

-- 3.2. Reajustar o Valor do Aluguel de um Contrato Específico (UPDATE)
UPDATE CONTRATO
SET valor_aluguel = 1900.00 -- Novo valor
WHERE id_contrato = 3;

-- 3.3. Atualizar o E-mail de um Administrador (UPDATE)
UPDATE ADMINISTRADOR
SET email = 'roberto.novo@imoveis.com'
WHERE id_admin = 1;

-- 3.4. Excluir um Pagamento Inserido Incorretamente (DELETE)
DELETE FROM PAGAMENTO
WHERE id_pagamento = 1004;

-- 3.5. Excluir um Imóvel que não possui contratos (DELETE com WHERE)
-- Note: Esta operação falhará se o imóvel estiver ligado a um contrato ativo, dependendo da regra ON DELETE da FK.
DELETE FROM IMÓVEL
WHERE id_imovel = 102;

-- 3.6. Excluir um Inquilino que Não Possui Contratos Ativos ou Encerrados (DELETE)
-- Se houver restrição ON DELETE, a operação só será bem sucedida se o inquilino
-- não estiver referenciado por nenhuma FK na tabela CONTRATO.
DELETE FROM INQUILINO
WHERE id_inquilino = 10;
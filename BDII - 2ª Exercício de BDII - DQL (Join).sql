-- RELATÓRIO 1 (Não consguir)
SELECT 
    e.nome AS 'Nome Empregado',
    e.cpf AS 'CPF Empregado',
    e.dataAdm AS 'Data Admissão',
    e.salario AS 'Salário',
    d.nome AS 'Departamento',
    t.numero AS 'Número de Telefone'
FROM 
    petshop.Empregado e
JOIN 
    petshop.Departamento d ON e.Departamento_idDepartamento = d.idDepartamento
LEFT JOIN 
    petshop.Telefone t ON e.cpf = t.Empregado_cpf
WHERE 
    e.dataAdm BETWEEN '2019-01-01' AND '2022-03-31'
ORDER BY 
    e.dataAdm DESC;


-- RELATÓRIO 2
SELECT 
    e.nome AS `Nome Empregado`, 
    e.cpf AS `CPF Empregado`, 
    e.dataAdm AS `Data Admissão`, 
    concat('R$ ', format(e.salario, 2, 'de_DE')) AS "Salário",
    e.Departamento_idDepartamento AS `Departamento`, 
    e.email AS `Número de Telefone`
FROM 
    petshop.Empregado e
WHERE 
    e.salario < (SELECT AVG(salario) FROM petshop.Empregado)
ORDER BY 
    e.nome ASC;
    
    
-- RELATÓRIO 3
    SELECT 
    d.nome AS `Departamento`, 
    COUNT(e.cpf) AS `Quantidade de Empregados`, 
	concat('R$ ', format(AVG(e.salario), 2, 'de_DE')) " Média Salárial",
    concat('R$ ', format(AVG(e.comissao), 2, 'de_DE')) `Média da Comissão`
FROM 
    petshop.Departamento d
LEFT JOIN 
    petshop.Empregado e ON d.idDepartamento = e.Departamento_idDepartamento
GROUP BY 
    d.idDepartamento, d.nome
ORDER BY 
    d.nome ASC;


-- RETLATÓRIO 4
SELECT 
    e.nome AS `Nome Empregado`, 
    e.cpf AS `CPF Empregado`, 
    e.sexo AS `Sexo`, 
    e.salario AS `Salário`, 
    COUNT(v.idVenda) AS `Quantidade Vendas`, 
    SUM(v.valor) AS `Total Valor Vendido`, 
    SUM(v.comissao) AS `Total Comissão das Vendas`
FROM 
    petshop.Empregado e
LEFT JOIN 
    petshop.Venda v ON e.cpf = v.Empregado_cpf
GROUP BY 
    e.cpf, e.nome, e.sexo, e.salario
ORDER BY 
    `Quantidade Vendas` DESC;


-- RELATÓRIO 5
SELECT 
    e.nome AS 'Nome Empregado',
    e.cpf AS 'CPF Empregado',
    e.sexo AS 'Sexo',
    e.salario AS 'Salário',
    COUNT(v.idVenda) AS 'Quantidade Vendas com Serviço', 
	CONCAT('R$ ', format(   SUM(isv.valor * isv.quantidade) , 2, 'de_DE')) AS 'Total Valor Vendido com Serviço',
    CONCAT('R$ ', format(   SUM(v.comissao)  , 2, 'de_DE')) AS 'Total Comissão das Vendas com Serviço'
FROM 
    Empregado e
JOIN 
    itensServico isv ON e.cpf = isv.Empregado_cpf
JOIN 
    Venda v ON v.idVenda = isv.Venda_idVenda
GROUP BY 
    e.nome, e.cpf, e.sexo, e.salario
ORDER BY 
    `Quantidade Vendas com Serviço` DESC;


-- RELATÓRIO 6
SELECT
    p.nome AS 'Nome do Pet',
    v.data AS 'Data do Serviço',
    s.nome AS 'Nome do Serviço',
    isv.quantidade AS 'Quantidade',
    concat('R$ ', format(isv.valor, 2, 'de_DE')) "Valor",
    e.nome AS 'Empregado que realizou o Serviço'
FROM
    itensServico isv
JOIN
    PET p ON p.idPET = isv.PET_idPET
JOIN
    Servico s ON s.idServico = isv.Servico_idServico
JOIN
    Venda v ON v.idVenda = isv.Venda_idVenda
JOIN
    Empregado e ON e.cpf = isv.Empregado_cpf
ORDER BY
    v.data DESC;
    
    
    -- RELATÓRIO 7
    SELECT
    v.data AS 'Data da Venda',
    concat('R$ ', format(v.valor, 2, 'de_DE')) "Valor",
    concat('R$ ', format(v.desconto, 2, 'de_DE')) AS 'Desconto',
    concat('R$ ', format(v.valor - IFNULL(v.desconto, 0), 2, 'de_DE')) AS 'Valor Final',
    e.nome AS 'Empregado que realizou a venda'
FROM
    Venda v
JOIN
    Empregado e ON e.cpf = v.Empregado_cpf
JOIN
    Cliente c ON c.cpf = v.Cliente_cpf
ORDER BY
    v.data DESC;


-- RELATÓRIO 8
SELECT
    s.nome AS "Nome Serviço",
    SUM(its.quantidade) AS "Quant Vendas",
	concat('R$ ', format(SUM(its.valor), 2, 'de_DE')) AS "Total Valor Vendido"
FROM
    itensServico its
JOIN
    Servico s ON s.idServico = its.Servico_idServico
GROUP BY
    s.nome
ORDER BY
    "Quant Vendas" DESC
LIMIT 10;


-- RELATÓRIO 9 
SELECT
    fp.tipo AS `Tipo Forma Pagamento`,
    COUNT(fp.idFormaPgVenda) AS `Quantidade Vendas`,
    concat('R$ ', format(SUM(fp.valorPago), 2, 'de_DE')) AS `Total Valor Vendido`
FROM
    FormaPgVenda fp
JOIN
    Venda v ON v.idVenda = fp.Venda_idVenda
GROUP BY
    fp.tipo
ORDER BY
    `Quantidade Vendas` DESC;


-- RELATÓIO 10
SELECT
    DATE(v.data) AS `Data Venda`,
    COUNT(v.idVenda) AS `Quantidade de Vendas`,
    concat('R$ ', format(SUM(v.valor), 2, 'de_DE')) AS `Valor Total Venda` 
FROM
    Venda v
GROUP BY
    DATE(v.data)
ORDER BY
    `Data Venda` DESC;
    
    
-- RELATÓRIO 11
SELECT 
    p.nome AS 'Nome Produto',
    concat('R$ ', format( p.valorVenda, 2, 'de_DE')) AS 'Valor Produto',
    p.marca AS 'Categoria do Produto', -- Supondo que 'marca' representa a categoria
    f.nome AS 'Nome Fornecedor',
    f.email AS 'Email Fornecedor',
    t.numero AS 'Telefone Fornecedor'
FROM 
    petshop.Produtos p
JOIN 
    petshop.ItensCompra ic ON p.idProduto = ic.Produtos_idProduto
JOIN 
    petshop.Compras c ON ic.Compras_idCompra = c.idCompra
JOIN 
    petshop.Fornecedor f ON c.Fornecedor_cpf_cnpj = f.cpf_cnpj
LEFT JOIN 
    petshop.Telefone t ON f.cpf_cnpj = t.Fornecedor_cpf_cnpj
ORDER BY 
    p.nome;
    
    
-- RELATÓRIO 12
   SELECT
    p.nome AS 'Nome Produto',
     CAST(SUM(iv.quantidade) AS UNSIGNED) AS 'Quantidade (Total) Vendas',
	concat('R$ ', format(SUM(iv.valor), 2, 'de_DE')) AS 'Valor Total Recebido pela Venda do Produto'
FROM
    petshop.Produtos p
JOIN
    petshop.ItensVendaProd iv ON p.idProduto = iv.Produto_idProduto
JOIN
    petshop.Venda v ON iv.Venda_idVenda = v.idVenda
GROUP BY
    p.idProduto, p.nome
ORDER BY
    `Quantidade (Total) Vendas` DESC;

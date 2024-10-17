SELECT 
    nome AS `Nome Empregado`, 
    cpf AS `CPF Empregado`, 
    dataAdm AS `Data Admissão`, 
    salario AS `Salário`, 
    Departamento_idDepartamento AS `Departamento`, 
	numero AS `Número de Telefone`
FROM 
    petshop.Empregado
WHERE 
    dataAdm BETWEEN '2019-01-01' AND '2022-03-31'
ORDER BY 
    dataAdm DESC;



SELECT 
    e.nome AS `Nome Empregado`, 
    e.cpf AS `CPF Empregado`, 
    e.dataAdm AS `Data Admissão`, 
    e.salario AS `Salário`, 
    e.Departamento_idDepartamento AS `Departamento`, 
    e.email AS `Número de Telefone`
FROM 
    petshop.Empregado e
WHERE 
    e.salario < (SELECT AVG(salario) FROM petshop.Empregado)
ORDER BY 
    e.nome ASC;
    
    
    
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


SELECT 
    e.nome AS 'Nome Empregado',
    e.cpf AS 'CPF Empregado',
    e.sexo AS 'Sexo',
    e.salario AS 'Salário',
    COUNT(v.idVenda) AS 'Quantidade Vendas com Serviço',
    SUM(isv.valor * isv.quantidade) AS 'Total Valor Vendido com Serviço',
    SUM(v.comissao) AS 'Total Comissão das Vendas com Serviço'
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


SELECT
    p.nome AS 'Nome do Pet',
    v.data AS 'Data do Serviço',
    s.nome AS 'Nome do Serviço',
    isv.quantidade AS 'Quantidade',
    isv.valor AS 'Valor',
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
    
    
    
    SELECT
    v.data AS 'Data da Venda',
    v.valor AS 'Valor',
    v.desconto AS 'Desconto',
    (v.valor - IFNULL(v.desconto, 0)) AS 'Valor Final',
    e.nome AS 'Empregado que realizou a venda'
FROM
    Venda v
JOIN
    Empregado e ON e.cpf = v.Empregado_cpf
JOIN
    Cliente c ON c.cpf = v.Cliente_cpf
ORDER BY
    v.data DESC;



SELECT
    s.nome AS "Nome Serviço",
    SUM(its.quantidade) AS "Quant Vendas",
    SUM(its.valor) AS "Total Valor Vendido"
FROM
    itensServico its
JOIN
    Servico s ON s.idServico = its.Servico_idServico
GROUP BY
    s.nome
ORDER BY
    "Quant Vendas" DESC
LIMIT 10;



SELECT
    fp.tipo AS `Tipo Forma Pagamento`,
    COUNT(fp.idFormaPgVenda) AS `Quantidade Vendas`,
    SUM(fp.valorPago) AS `Total Valor Vendido`
FROM
    FormaPgVenda fp
JOIN
    Venda v ON v.idVenda = fp.Venda_idVenda
GROUP BY
    fp.tipo
ORDER BY
    `Quantidade Vendas` DESC;



SELECT
    DATE(v.data) AS `Data Venda`,
    COUNT(v.idVenda) AS `Quantidade de Vendas`,
    SUM(v.valor) AS `Valor Total Venda`
FROM
    Venda v
GROUP BY
    DATE(v.data)
ORDER BY
    `Data Venda` DESC;
    
    
    
    
SELECT
    p.nome AS 'Nome Produto',
    p.valorVenda AS 'Valor Produto',
    c.nome AS 'Categoria do Produto',
    f.nome AS 'Nome Fornecedor',
    f.email AS 'Email Fornecedor',
    t.numero AS 'Telefone Fornecedor'
FROM
    petshop.Produtos p
JOIN
    petshop.Categorias c ON p.idCategoria = c.idCategoria -- Supondo que exista uma tabela de Categorias
JOIN
    petshop.Fornecedor f ON p.idFornecedor = f.cpf_cnpj 
LEFT JOIN
    petshop.Telefone t ON f.cpf_cnpj = t.Fornecedor_cpf_cnpj
ORDER BY
    p.nome ASC;

    
    
   SELECT
    p.nome AS 'Nome Produto',
    SUM(iv.quantidade) AS 'Quantidade (Total) Vendas',
    SUM(iv.valor) AS 'Valor Total Recebido pela Venda do Produto'
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

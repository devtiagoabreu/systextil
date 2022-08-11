--SALDO ESTOQUE EM METROS
SELECT
    ProdutoCodigo,
    ProdutoDescricao,
    Situacao,
    Cor,
    CorDescricao,
    Desenho, 
    Variante, 
    Categoria,
    SUM(ISNULL(Metros,0)) AS Metros 
FROM 
    vwSaldoTecidosEstoque 
WHERE 
    ProdutoCodigo LIKE '%'+ '' +'%' AND 
    Situacao LIKE '%'+ '' +'%' AND 
    Cor LIKE '%'+ '' +'%' AND 
    Desenho LIKE '%'+ '' +'%' AND 
    Variante LIKE '%'+ '' +'%' AND 
    Categoria LIKE '%'+ '' +'%'
GROUP BY
    ProdutoCodigo,
    ProdutoDescricao,
    Situacao,
    Cor,
    CorDescricao,
    Desenho, 
    Variante, 
    Categoria

--

SELECT
    CP.Nro_Rolo,
    CP.Nro_Peca,
	CP.Produto AS ProdutoCodigo,
	Produtos.Descricao AS ProdutoDescricao,
	CP.Situacao,
	CP.Cor,
	Car_Cores.Descricao AS CorDescricao,
	CP.Desenho,
	CP.Variante,
	Categoria_Tinto AS Categoria,
	ISNULL(CP.Metros,0) AS Metros
FROM 
	DBMicrodata.dbo.Cte_Peca CP 
	LEFT JOIN DBMicrodata.dbo.CTE_Baixa CB ON CP.Empresa=CB.Empresa and CP.Situacao=CB.Situacao and CP.Nro_Rolo=CB.Nro_Rolo and CP.Nro_Peca=CB.Nro_Peca
	INNER JOIN DBMicrodata.dbo.Produtos ON Produtos.Codigo = CP.Produto
	INNER JOIN DBMicrodata.dbo.Produtos_Tecidos ON Produtos_Tecidos.Produto = CP.Produto
	INNER JOIN DBMicrodata.dbo.Car_Cores ON Car_Cores.Codigo = CP.Cor
WHERE
	CP.Gaveta IN ('013') AND
	CP.Empresa like '01' AND 
	CP.Situacao like '%' AND 
	CP.Nro_Rolo like '%' AND 
	CP.Nro_Peca like '%' AND 
	CP.Produto like '%' AND 
	Cor like '%' AND 
	Desenho like '%' AND 
	Categoria_Tinto Like '%' AND 
	IsNull(Variante, '') Like '%' AND
	CB.Data_Saida IS NULL
-- CARGA DE MATÉRIA PRIMA - FIOS POR IMPORTAÇÃO DE ROMANEIO DE FIOS - 009503

SELECT 
	CF.Documento AS NFe,
	CF.Serie AS Serie,
	CONVERT(DATE,GETDATE()) AS Data_Emissao,
	'009503' AS Romaneio_Fornecedor,
	CP.CGC_Cliente AS Codigo_Fornecedor,
	CP.Razao_Nome_Cliente AS Razao_Social_Fornecedor,
	CF.Produto AS Codigo_Produto_Microdata,
	P.Descricao AS Narrativa_Produto_Microdata,
	'' AS Codigo_Produto_Fornecedor,
	'' AS Codigo_Produto_Systextil,
	'' AS Narrativa_Produto_Systextil,
	CF.Lote AS Lote_Fornecedor,
	'' AS Lote_Systextil,
	CF.Codigo_Caixa AS Codigo_Caixa_Fornecedor,
	'' AS Codigo_Caixa_ProConfer,
	CF.Peso AS Peso_Liquido,
	(CF.Peso_Bruto + 0) AS Peso_Bruto,
	'0' AS Tara
FROM
	DBMicrodata.dbo.RET_CXSFIOS CF
	INNER JOIN DBMicrodata.dbo.CLIENTES_PRINCIPAL CP ON CP.Codigo = CF.Fornecedor 
	INNER JOIN DBMicrodata.dbo.Produtos P ON CF.Produto = P.Codigo
WHERE
	CP.CGC_Cliente <> '' and 
	CF.Codigo_Caixa+CF.Entrada_Caixa IN (
	'0231806001',
'0231769001',
'0231752001'
	);
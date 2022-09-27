-- CARGA DE MATÉRIA PRIMA - FIOS POR IMPORTAÇÃO DE ROMANEIO DE FIOS

SELECT
	CF.Documento AS NFe,
	CF.Serie AS Serie,
	CONVERT(DATE,GETDATE()) AS Data_Emissao,
	'001' AS Romaneio_Fornecedor,
	CP.CGC_Cliente AS Codigo_Fornecedor,
	CP.Razao_Nome_Cliente AS Razao_Social_Fornecedor,
	CF.Produto AS Codigo_Produto_Fornecedor,
	'7-00004-001-000019' AS Codigo_Produto_Systextil,
	'FIO 4/1 DESFIBRADO CAFÉ' AS Narrativa_Produto_Systextil,
	CF.Lote AS Lote_Fornecedor,
	CF.Codigo_Caixa AS Codigo_Caixa_Fornecedor,
	'' AS Codigo_Caixa_ProConfer,
	CF.Peso AS Peso_Liquido,
	(CF.Peso_Bruto + 0) AS Peso_Bruto,
	'0' AS Tara
FROM
	DBMicrodata.dbo.RET_CXSFIOS CF
	LEFT JOIN DBMicrodata.dbo.Ret_BaixaCxsFios ON Ret_BaixaCxsFios.Codigo_Caixa = CF.Codigo_Caixa 
	INNER JOIN DBMicrodata.dbo.CLIENTES_PRINCIPAL CP ON CP.Codigo = CF.Fornecedor 
WHERE 
CF.Codigo_Caixa NOT IN (SELECT Codigo_Caixa FROM DBMicrodata.dbo.Ret_BaixaCxsFios) AND
Documento like '%'+'4084' AND
Lote = '2982001006' and
produto = 'FS1512'


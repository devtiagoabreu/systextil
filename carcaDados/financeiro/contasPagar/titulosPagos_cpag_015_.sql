--TITULOS PAGOS - CPAG_015

SELECT
	TNF.Tipo_Fornec Tipo_Fornecedor, 
	TNF.Serie, 
	TF.Razao_Nome_Cliente AS Fornecedor, 
	TF.Codigo_Cliente AS CNPJ_,
	TF.CGC_Cliente AS CGC,
	TP.Vencimento, 
	TP.Empresa, 
	TF.Codigo AS CodFor,
	TNF.Data_Emissao, 
	TNF.Documento AS Titulo, 
	TP.Parcela Parcelas, 
	SUM(ISNULL(TB.Valor_Pago,0)) AS Pago, 
	SUM(ISNULL(TB.Juros_Pagos,0)) AS Juros, 
	SUM(ISNULL(TB.Desconto_Recebido,0)) AS Desconto, 
	TB.Data_Baixa AS Data_Baixa, 
	SUM(ISNULL(TB.Valor_Liquido,0)) AS Liquido, 
	TB.Cod_Historico AS Hist, 
	TB.Complemento, TB.Nr_Cheque, 
	H.Tipo_Hist_Historicos AS Tipo_Hist, 
	TB.Nr_Banco, H.Nome_Hist_Historicos AS Nome_Hist 
FROM 
	NF_Entradas AS TNF 
	INNER JOIN NFE_Parcelas AS TP ON (TP.Empresa=TNF.Empresa AND TP.Documento=TNF.Documento AND TP.Tipo_Fornec=TNF.Tipo_Fornec AND TP.Fornecedor=TNF.Fornecedor AND TP.Serie=TNF.Serie) 
	INNER JOIN Pag_Baixas AS TB ON (TB.Empresa=TP.Empresa AND TB.Documento=TP.Documento AND TB.Parcela=TP.Parcela AND TB.Tipo_Fornec=TP.Tipo_Fornec AND TB.Fornecedor=TP.Fornecedor AND TB.Serie=TP.Serie) 
	INNER JOIN Pag_Historicos H ON (H.Cod_Historico_Historicos=TB.Cod_Historico) 
	INNER JOIN Clientes_Principal AS TF ON (TF.Tipo=TNF.Tipo_Fornec AND TF.Codigo=TNF.Fornecedor AND (Tipo_Entidade = 'A' OR Tipo_Entidade='F')) 
WHERE 
	(Data_Baixa>='2022-01-01T00:00:00' AND Data_Baixa<='2022-09-30T00:00:00') AND 
	(TP.Empresa IN ('01' , '02')) 
GROUP BY 
	TNF.Tipo_Fornec, 
	TNF.Serie, 
	TF.Razao_Nome_Cliente, 
	TF.Codigo_Cliente,
	TF.CGC_Cliente,
	TP.Vencimento, 
	TP.Empresa, 
	TF.Codigo, 
	TNF.Data_Emissao, 
	TNF.Documento, 
	TP.Parcela, 
	TB.Data_Baixa, 
	TB.Cod_Historico, 
	TB.Complemento, 
	TB.Nr_Cheque, 
	H.Tipo_Hist_Historicos, 
	TB.Nr_Banco, 
	H.Nome_Hist_Historicos 
ORDER BY 
	TF.Razao_Nome_Cliente

--TITULOS PAGOS - CPAG_015

SELECT
	TNF.Tipo_Fornec Tipo_Fornecedor, 
	TNF.Serie, 
	TF.Razao_Nome_Cliente AS Fornecedor, 
	TP.Vencimento, 
	TP.Empresa, 
	TF.Codigo AS CodFor, 
	TNF.Data_Emissao, 
	TNF.Documento AS Titulo, 
	TP.Parcela Parcelas, 
	SUM(IsNull(TB.Valor_Pago,0)) AS Pago, 
	SUM(IsNull(TB.Juros_Pagos,0)) AS Juros, 
	SUM(IsNull(TB.Desconto_Recebido,0)) AS Desconto, 
	TB.Data_Baixa AS Data_Baixa, 
	SUM(IsNull(TB.Valor_Liquido,0)) AS Liquido, 
	TB.Cod_Historico AS Hist, 
	TB.Complemento, TB.Nr_Cheque, 
	H.Tipo_Hist_Historicos AS Tipo_Hist, 
	TB.Nr_Banco, H.Nome_Hist_Historicos AS Nome_Hist 
FROM 
	NF_Entradas AS TNF 
	Inner Join NFE_Parcelas AS TP ON (TP.Empresa=TNF.Empresa and TP.Documento=TNF.Documento and TP.Tipo_Fornec=TNF.Tipo_Fornec and TP.Fornecedor=TNF.Fornecedor and TP.Serie=TNF.Serie) 
	Inner Join Pag_Baixas AS TB ON (TB.Empresa=TP.Empresa and TB.Documento=TP.Documento and TB.Parcela=TP.Parcela and TB.Tipo_Fornec=TP.Tipo_Fornec and TB.Fornecedor=TP.Fornecedor and TB.Serie=TP.Serie) 
	Inner Join Pag_Historicos H ON (H.Cod_Historico_Historicos=TB.Cod_Historico) Inner Join Clientes_Principal AS TF ON (TF.Tipo=TNF.Tipo_Fornec and TF.Codigo=TNF.Fornecedor and (Tipo_Entidade = 'A' or Tipo_Entidade='F')) 
WHERE 
	(Data_Baixa>='2022-01-01T00:00:00' and Data_Baixa<='2022-09-30T00:00:00') AND 
	(TP.Empresa in ('01' , '02')) 
GROUP BY 
	TNF.Tipo_Fornec, 
	TNF.Serie, 
	TF.Razao_Nome_Cliente, 
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

--CARGA DE CONTAS A PAGAR - TÍTULOS BAIXADOS - EM HOMOLOGAÇÃO

SELECT
	TF.Codigo_Cliente,
	TF.Razao_Nome_Cliente,
	H.Tipo_Hist_Historicos,
	H.Nome_Hist_Historicos,
	TNF.Documento AS DUPL_FOR_NRDUPPAG,
	TP.Parcela AS DUPL_FOR_NO_PARC,
	SUBSTRING(REPLACE(REPLACE(REPLACE(TF.CGC_Cliente,'.',''),'/',''),'-',''),1,8) AS DUPL_FOR_FOR_CLI9,
	SUBSTRING(REPLACE(REPLACE(REPLACE(TF.CGC_Cliente,'.',''),'/',''),'-',''),9,4) AS DUPL_FOR_FOR_CLI4,
	SUBSTRING(REPLACE(REPLACE(REPLACE(TF.CGC_Cliente,'.',''),'/',''),'-',''),13,2) AS DUPL_FOR_FOR_CLI2,
	CASE TP.Empresa 
		WHEN '01' THEN '11'
		ELSE '32'
	END	AS DUPL_FOR_TIPO_TIT, 
	'01' AS SEQUENCIA_PAGTO,
	FORMAT(TB.Data_Baixa, 'dd/MM/yyyy') AS DATA_PAGAMENTO, 
	TNF.Documento AS NUMERO_DOCUMENTO,
	CASE H.Tipo_Hist_Historicos 
		WHEN '1' THEN '210'
		ELSE '215'
	END	AS CODIGO_HISTORICO,
	SUM(ISNULL(TB.Juros_Pagos,0)) AS VALOR_JUROS,
	SUM(ISNULL(TB.Desconto_Recebido,0)) AS VALOR_DESCONTOS,
	SUM(ISNULL(TB.Valor_Pago,0)) AS VALOR_PAGO,
	TF.Banco_Cliente AS CD_PORTA_COD_PORT,
	TF.CCorrente AS CD_PORTA_NR_CONTA,
	'0' AS NUMERO_LOTE,
	'1000' AS CODIGO_DEPTO,
	'901' AS CODIGO_TRANSACAO,
	FORMAT(TB.Data_Baixa, 'dd/MM/yyyy') AS DATA_BAIXA,
	'0' AS NUM_CONTABIL, 
	FORMAT(TB.Data_Baixa, 'dd/MM/yyyy') AS DATA_PG_REAL,
	'901' AS TRANSACAO, 
	SUM(ISNULL(TB.Valor_Pago,0)) AS VALOR_PAGO_MOEDA,
	SUM(ISNULL(TB.Juros_Pagos,0)) AS VLR_JUROS_MOEDA,
	SUM(ISNULL(TB.Desconto_Recebido,0)) AS VLR_DESCONTOS_MOEDA,
	'03' AS TIPO_PAGAMENTO 
FROM 
	NF_Entradas AS TNF 
	INNER JOIN NFE_Parcelas AS TP ON (TP.Empresa=TNF.Empresa AND TP.Documento=TNF.Documento AND TP.Tipo_Fornec=TNF.Tipo_Fornec AND TP.Fornecedor=TNF.Fornecedor AND TP.Serie=TNF.Serie) 
	INNER JOIN Pag_Baixas AS TB ON (TB.Empresa=TP.Empresa AND TB.Documento=TP.Documento AND TB.Parcela=TP.Parcela AND TB.Tipo_Fornec=TP.Tipo_Fornec AND TB.Fornecedor=TP.Fornecedor AND TB.Serie=TP.Serie) 
	INNER JOIN Pag_Historicos H ON (H.Cod_Historico_Historicos=TB.Cod_Historico) 
	INNER JOIN Clientes_Principal AS TF ON (TF.Tipo=TNF.Tipo_Fornec AND TF.Codigo=TNF.Fornecedor AND (Tipo_Entidade = 'A' OR Tipo_Entidade='F')) 
WHERE 
	(Data_Baixa>='2021-12-01T00:00:00' AND Data_Baixa<='2022-10-30T00:00:00') AND 
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
	TF.Banco_Cliente,
	TF.CCorrente,
	H.Nome_Hist_Historicos 
ORDER BY 
	TF.Razao_Nome_Cliente













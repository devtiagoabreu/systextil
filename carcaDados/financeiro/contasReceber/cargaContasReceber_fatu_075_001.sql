--cargaContasReceber_fatu_075_001

SELECT
	B.Empresa AS NR_TITUL_CODEMPR,
	SUBSTRING(REPLACE(REPLACE(REPLACE(NF.Cliente_NF,'.',''),'/',''),'-',''),1,8) AS NR_TITUL_CLI_DUP_CGC_CLI9,
	SUBSTRING(REPLACE(REPLACE(REPLACE(NF.Cliente_NF,'.',''),'/',''),'-',''),9,4) AS NR_TITUL_CLI_DUP_CGC_CLI4,
	SUBSTRING(REPLACE(REPLACE(REPLACE(NF.Cliente_NF,'.',''),'/',''),'-',''),13,2) AS NR_TITUL_CLI_DUP_CGC_CLI2,
	'0' AS NR_TITUL_COD_TIT, 
	NP.Documento_Parcelas AS NR_TITUL_NUM_DUP,
	NP.Parcela_Parcelas AS NR_TITUL_SEQ_DUP,
	'0' AS SEQ_PAGAMENTO,
	FORMAT(MAX(B.Data_Baixa), 'dd/MM/yyyy') AS DATA_PAGAMENTO,
	SUM(ISNULL(B.Valor_Liquido,0)) AS VALOR_PAGO,
	'0' AS HISTORICO_PGTO,
	'0' AS NUMERO_DOCUMENTO,
	SUM(ISNULL(B.Juros_Recebidos,0)) AS VALOR_JUROS,
	SUM(ISNULL(B.Desconto_Concedido,0)) AS VALOR_DESCONTOS,
	NP.Banco_Parcelas AS PORTADOR,
	'' AS CONTA_CORRENTE,
	FORMAT(MAX(B.Data_Baixa), 'dd/MM/yyyy') AS DATA_CREDITO,
	'0' AS DOCTO_PAGTO,
	SUM(ISNULL(B.Valor_Recebido,0)) AS VALOR_PAGO_MOEDA,
	SUM(ISNULL(B.Desconto_Concedido,0)) AS VLR_DESCONTO_MOEDA,
	SUM(ISNULL(B.Juros_Recebidos,0)) AS VLR_JUROS_MOEDA
FROM 
	DBMicrodata.dbo.Notas_Fiscais_Rec NF 
	INNER JOIN DBMicrodata.dbo.Notas_Fiscais_Parcelas NP ON (NF.Nr_Empresa_NF=NP.Empresa_Parcelas and NF.Nr_Documento_NF=NP.Documento_Parcelas and NF.Serie=NP.Serie)    
    INNER JOIN DBMicrodata.dbo.Rec_Baixas B ON (B.Empresa=NP.Empresa_Parcelas and B.Documento=NP.Documento_Parcelas and B.Serie=NP.Serie and B.Parcela=NP.Parcela_Parcelas)
    INNER JOIN DBMicrodata.dbo.Clientes_Principal C ON (C.Codigo_Cliente=NF.Cliente_NF) 
WHERE	
	NF.Emissao_NF BETWEEN '2022-09-01 00:00:00' AND '2022-09-30 00:00:00'                       
GROUP BY 
	NF.Cliente_NF, 
	C.Razao_Nome_Cliente, 
	B.Empresa,
	NP.Documento_Parcelas,
	NP.Parcela_Parcelas, 
	B.Documento, 
	B.Serie, 
	B.Parcela, 
	NF.Emissao_NF, 
	NP.Vencimento_Parcelas, 
	NP.Banco_Parcelas, 
	NP.Operacao_Parcelas, 
	NP.Valor_Parcelas    




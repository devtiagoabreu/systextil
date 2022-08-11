SELECT 
	NP.Empresa_Parcelas AS CODIGO_EMPRESA,
	SUBSTRING(REPLACE(REPLACE(REPLACE(NP.Cliente,'.',''),'/',''),'-',''),1,8) AS CLI_DUP_CGC_CLI9,
	SUBSTRING(REPLACE(REPLACE(REPLACE(NP.Cliente,'.',''),'/',''),'-',''),9,4) AS CLI_DUP_CGC_CLI4,
	SUBSTRING(REPLACE(REPLACE(REPLACE(NP.Cliente,'.',''),'/',''),'-',''),13,2) AS CLI_DUP_CGC_CLI2,
	'0' AS TIPO_TITULO,
	NP.Documento_Parcelas AS NUM_DUPLICATA,
	NP.Parcela_Parcelas AS SEQ_DUPLICATAS,
	FORMAT(NP.Vencimento_Parcelas, 'dd/MM/yyyy') AS DATA_VENC_DUPLIC,
	FORMAT(NP.Vencimento_Parcelas, 'dd/MM/yyyy') AS DATA_PRORROGACAO,
	FORMAT(NP.Vencimento_Parcelas, 'dd/MM/yyyy') AS DATA_EMISSAO,
	'' AS PREVISAO, 
	REPLACE(NP.Valor_Parcelas,'.',',') AS VALOR_DUPLICATA,
	'0' AS SITUACAO_DUPLIC,
	NP.Banco_Parcelas AS PORTADOR_DUPLIC,
	PF.Pedido AS PEDIDO_VENDA,
	NP.Nosso_Nr_Parcelas AS NR_TITULO_BANCO,
	NV.Vendedor_NF_Vendedores AS COD_REP_CLIENTE,
	NV.Inc_Vend_Parcela AS POSICAO_DUPLIC,
	'' AS COD_HISTORICO,
	'' AS COMPL_HISTORICO,
	'1' AS COD_LOCAL,
	'0' AS MOEDA_TITULO,
	REPLACE(NP.Valor_Parcelas,'.',',') AS VALOR_MOEDA,
	'1' AS COD_TRANSACAO,
	'0' AS CODIGO_CONTABIL,
	'0' AS NUM_CONTABIL,
	REPLACE(ISNULL(NP.Valor_Parcelas,0),'.',',') AS SALDO_DUPLICATA,
	SUBSTRING(NP.Nr_Conta_Age_Parcelas,6,4) AS CONTA_CORRENTE,
	'0' AS NUMERO_REMESSA,
	REPLACE(RC.Porcentagem_Comissoes,'.',',') AS PERCENTUAL_COMIS,
	REPLACE(NV.Valor_Comissao_NF_Vend,'.',',') AS VALOR_COMIS,
	REPLACE(NP.Valor_Parcelas,'.',',') AS BASE_CALC_COMIS,
	'100' AS PERC_COMIS_CREC,
	CASE CONVERT(VARCHAR(10),RC.Porcentagem_Comissoes)
		WHEN '0.0000' THEN '0'
		WHEN '1.0000' THEN '1'
		WHEN '2.0000' THEN '2'
		WHEN '3.0000' THEN '3'
		WHEN '4.0000' THEN '4'
		WHEN '5.0000' THEN '5'		
		WHEN '6.0000' THEN '6'		
		WHEN '7.0000' THEN '7'		
		WHEN '8.0000' THEN '8'		
		ELSE '9'
	END	AS TIPO_COMISSAO,
	'0' AS CODIGO_ADMINISTR,
	'0' AS COMISSAO_ADMINISTR,
	'0' AS PERC_COMIS_CREC_ADM,
	'2' AS SEQ_END_COBRANCA,
	'' AS OBSERVACAO,
	SUBSTRING(REPLACE(REPLACE(REPLACE(NP.Cliente,'.',''),'/',''),'-',''),1,8) AS CLI9RESPTIT,
	SUBSTRING(REPLACE(REPLACE(REPLACE(NP.Cliente,'.',''),'/',''),'-',''),9,4) AS CLI4RESPTIT,
	SUBSTRING(REPLACE(REPLACE(REPLACE(NP.Cliente,'.',''),'/',''),'-',''),13,2) AS CLI2RESPTIT,
	'0' AS COD_FORMA_PAGTO
FROM
	Notas_Fiscais_Parcelas AS NP
	INNER JOIN Notas_Fiscais_Vendedores_Parcelas AS NV ON 
		NV.Doc_NF_Vendedores = NP.Documento_Parcelas AND
		NV.Serie = NP.Serie AND
		NV.Inc_Vend_Parcela = NP.Inc_Parcela AND
		NV.Empresa_NF_Vendedores = NP.Empresa_Parcelas
	INNER JOIN Rec_Comissoes RC ON RC.tipo_comissoes = NV.Tipo_Comissao_NF_Vend AND
		RC.Vendedor_Comissoes = NV.Vendedor_NF_Vendedores
	LEFT JOIN Fat_Pedido AS PF ON 
	  PF.Nr_Nota = NP.Documento_Parcelas AND
	  PF.Serie = NP.Serie AND
	  PF.Cliente = NP.Cliente 
WHERE
	NV.Empresa_NF_Vendedores IN ('01') and
	NP.Vencimento_Parcelas BETWEEN '2022-07-15 00:00:00' AND '2022-07-15 00:00:00' --AND
	--PF.Data_Nota BETWEEN '2022-07-15 00:00:00' AND '2022-12-31 00:00:00' 
	--NV.Doc_NF_Vendedores='000003' and 
	----NV.Parcela_NF_Vendedores='01' and 
	--NV.Serie='1  55' 
ORDER BY
	NP.Documento_Parcelas DESC,
	NP.Serie,
	NP.Id_Parcela
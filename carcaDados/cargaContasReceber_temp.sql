--regra de négócio
--Notas_Fiscais_Vendedores_Parcelas --> tabela que contém tipo de comissão (Tipo_Comissao_NF_Vend) 
--que provém da tabela "Rec_Comissoes" onde os campo "tipo_comissoes" e "porcentagem_comissoes" se encontram
--select referente a essa regra UTILIZANDO A NOTA '000003'

SELECT
	RC.porcentagem_comissoes,
	*
FROM
	Notas_Fiscais_Vendedores_Parcelas AS NV
	INNER JOIN Rec_Comissoes RC ON RC.tipo_comissoes = NV.Tipo_Comissao_NF_Vend
WHERE 
	Empresa_NF_Vendedores='01' and 
	Doc_NF_Vendedores='000003' and 
	Parcela_NF_Vendedores='01' and 
	Serie='1  55' 
ORDER BY
	Vendedor_NF_Vendedores 
go


--saber a porcentagem de comissão de determinada parcela
SELECT	
	*
FROM
	Notas_Fiscais_Parcelas AS NP
	INNER JOIN Notas_Fiscais_Vendedores_Parcelas AS NV ON NV.Id_Parcela = NP.Id_Parcela
WHERE	

--PARCELAS DO DOCUMENTO
SELECT 
	*, 
	Agencia_Parcelas+Dig_Age_Parcelas+Nr_Conta_Age_Parcelas+Dig_Conta_Age_Parcelas Nro_Agencia 
FROM 
	Notas_Fiscais_Parcelas 
WHERE 
	Empresa_Parcelas='01' and 
	Documento_Parcelas='025897' and Serie='1  55' 
ORDER BY 
	Parcela_Parcelas
	
--COMISSAO DA PARCELA
SELECT
	* 
FROM 
	Notas_Fiscais_Vendedores_Parcelas 
WHERE 
	Empresa_NF_Vendedores='01' and 
	Doc_NF_Vendedores='025897' and 
	Parcela_NF_Vendedores='03' and 
	Serie='1  55' 
ORDER BY
	Vendedor_NF_Vendedores
	
--VIEW DAS DUAS TABELAS ACIMA

SELECT DISTINCT
	Notas_Fiscais_Parcelas.Empresa_Parcelas AS CODIGO_EMPRESA,
	SUBSTRING(REPLACE(REPLACE(REPLACE(Notas_Fiscais_Parcelas.Cliente,'.',''),'/',''),'-',''),1,8) AS CLI_DUP_CGC_CLI9,
	SUBSTRING(REPLACE(REPLACE(REPLACE(Notas_Fiscais_Parcelas.Cliente,'.',''),'/',''),'-',''),9,4) AS CLI_DUP_CGC_CLI4,
	SUBSTRING(REPLACE(REPLACE(REPLACE(Notas_Fiscais_Parcelas.Cliente,'.',''),'/',''),'-',''),13,2) AS CLI_DUP_CGC_CLI2,
	'0' AS TIPO_TITULO,
	Notas_Fiscais_Parcelas.Documento_Parcelas AS NUM_DUPLICATA,
	Notas_Fiscais_Parcelas.Parcela_Parcelas AS SEQ_DUPLICATAS,
	FORMAT(Notas_Fiscais_Parcelas.Vencimento_Parcelas, 'dd/MM/yyyy') AS DATA_VENC_DUPLIC,
	FORMAT(Notas_Fiscais_Parcelas.Vencimento_Parcelas, 'dd/MM/yyyy') AS DATA_PRORROGACAO,
	FORMAT(Notas_Fiscais_Parcelas.Vencimento_Parcelas, 'dd/MM/yyyy') AS DATA_EMISSAO,
	'' AS PREVISAO, 
	REPLACE(Notas_Fiscais_Parcelas.Valor_Parcelas,'.',',') AS VALOR_DUPLICATA,
	'0' AS SITUACAO_DUPLIC,
	Notas_Fiscais_Parcelas.Banco_Parcelas AS PORTADOR_DUPLIC,
	Fat_Pedido.Pedido AS PEDIDO_VENDA,
	Notas_Fiscais_Parcelas.Nosso_Nr_Parcelas AS NR_TITULO_BANCO,
	Notas_Fiscais_Vendedores_Parcelas.Vendedor_NF_Vendedores AS COD_REP_CLIENTE,
	Notas_Fiscais_Vendedores_Parcelas.Inc_Vend_Parcela AS POSICAO_DUPLIC,
	'' AS COD_HISTORICO,
	'' AS COMPL_HISTORICO,
	'1' AS COD_LOCAL,
	'0' AS MOEDA_TITULO,
	REPLACE(Notas_Fiscais_Parcelas.Valor_Parcelas,'.',',') AS VALOR_MOEDA,
	'1' AS COD_TRANSACAO,
	'0' AS CODIGO_CONTABIL,
	'0' AS NUM_CONTABIL,
	REPLACE(ISNULL(Rec_Baixas.Valor_Liquido,0),'.',',') AS SALDO_DUPLICATA,
	Notas_Fiscais_Parcelas.Nr_Conta_Age_Parcelas AS CONTA_CORRENTE,
	'???' AS NUMERO_REMESSA,
	REPLACE(CONVERT(DECIMAL(18,2),ROUND(((Notas_Fiscais_Vendedores_Parcelas.Valor_Comissao_NF_Vend / Notas_Fiscais_Parcelas.Valor_Parcelas) * 100),4)),'.',',') AS PERCENTUAL_COMIS,
	Notas_Fiscais_Vendedores_Parcelas.Valor_Comissao_NF_Vend AS VALOR_COMIS,
	Notas_Fiscais_Parcelas.Valor_Parcelas AS BASE_CALC_COMIS,
	'100' AS PERC_COMIS_CREC,
	'???' AS TIPO_COMISSAO,
	'0' AS CODIGO_ADMINISTR,
	'0' AS COMISSAO_ADMINISTR,
	'0' AS PERC_COMIS_CREC_ADM,
	'2' AS SEQ_END_COBRANCA,
	'' AS OBSERVACAO,
	SUBSTRING(REPLACE(REPLACE(REPLACE(Notas_Fiscais_Parcelas.Cliente,'.',''),'/',''),'-',''),1,8) AS CLI9RESPTIT,
	SUBSTRING(REPLACE(REPLACE(REPLACE(Notas_Fiscais_Parcelas.Cliente,'.',''),'/',''),'-',''),9,4) AS CLI4RESPTIT,
	SUBSTRING(REPLACE(REPLACE(REPLACE(Notas_Fiscais_Parcelas.Cliente,'.',''),'/',''),'-',''),13,2) AS CLI2RESPTIT,
	'0' AS COD_FORMA_PAGTO
FROM 
	Notas_Fiscais_Parcelas
	INNER JOIN Notas_Fiscais_Vendedores_Parcelas ON 
	  Notas_Fiscais_Vendedores_Parcelas.Empresa_NF_Vendedores = Notas_Fiscais_Parcelas.Empresa_Parcelas AND
	  Notas_Fiscais_Vendedores_Parcelas.Doc_NF_Vendedores = Notas_Fiscais_Parcelas.Documento_Parcelas AND
	  Notas_Fiscais_Vendedores_Parcelas.Serie = Notas_Fiscais_Parcelas.Serie AND
	  Notas_Fiscais_Vendedores_Parcelas.Inc_Vend_Parcela = Notas_Fiscais_Parcelas.Parcela_Parcelas
	INNER JOIN Fat_Pedido ON 
	  Fat_Pedido.Nr_Nota = Notas_Fiscais_Parcelas.Documento_Parcelas
	LEFT JOIN Rec_Baixas ON  
	  Rec_Baixas.Documento = Notas_Fiscais_Parcelas.Documento_Parcelas
	LEFT JOIN Rec_Historicos ON  
	  Rec_Historicos.Cod_Historico_Historicos = Rec_Baixas.Cod_Historico
WHERE
	Notas_Fiscais_Parcelas.Tem_Baixas IS NULL
--WHERE 
--	Notas_Fiscais_Parcelas.Empresa_Parcelas='01' and 
	--Notas_Fiscais_Parcelas.Documento_Parcelas='025897' and Notas_Fiscais_Parcelas.Serie='1  55' 
ORDER BY 
	Parcela_Parcelas


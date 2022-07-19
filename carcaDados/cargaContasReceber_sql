SELECT
	PF.Pedido,
	NP.Vencimento_Parcelas,
	NP.Tem_Baixas,
	NP.Empresa_Parcelas,
	NP.Cliente,	
	NP.Documento_Parcelas,
	NP.Serie,
	NP.Id_Parcela,
	NV.Inc_Vend_Parcela,
	NP.Valor_Parcelas,
	NV.Tipo_Comissao_NF_Vend,
	RC.Porcentagem_Comissoes,
	NV.Valor_Comissao_NF_Vend,
	NV.Vendedor_NF_Vendedores,
	*
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
	NV.Empresa_NF_Vendedores IN ('01', '02') and
	NP.Vencimento_Parcelas BETWEEN '2021-01-01 00:00:00' AND '2025-12-31 00:00:00' --AND
	--PF.Data_Nota BETWEEN '2022-07-15 00:00:00' AND '2022-12-31 00:00:00' 
	--NV.Doc_NF_Vendedores='000003' and 
	----NV.Parcela_NF_Vendedores='01' and 
	--NV.Serie='1  55' 
ORDER BY
	NP.Documento_Parcelas DESC,
	NP.Serie,
	NP.Id_Parcela
	
	
--tipos de comissão
SELECT DISTINCT
	NV.Vendedor_NF_Vendedores AS VENDEDOR, 
	NV.Tipo_Comissao_NF_Vend AS TIPO_COMISSAO,
	RC.Porcentagem_Comissoes AS PORCENTAGEM
	
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
	NV.Empresa_NF_Vendedores IN ('01', '02') and
	NP.Vencimento_Parcelas BETWEEN '2021-01-01 00:00:00' AND '2025-12-31 00:00:00' --AND
	--PF.Data_Nota BETWEEN '2022-07-15 00:00:00' AND '2022-12-31 00:00:00' 
	--NV.Doc_NF_Vendedores='000003' and 
	----NV.Parcela_NF_Vendedores='01' and 
	--NV.Serie='1  55' 
	
--tipos de comissão
SELECT DISTINCT
	NV.Tipo_Comissao_NF_Vend AS TIPO_COMISSAO,
	RC.Porcentagem_Comissoes AS PORCENTAGEM
	
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
	NV.Empresa_NF_Vendedores IN ('01', '02') and
	NP.Vencimento_Parcelas BETWEEN '2021-01-01 00:00:00' AND '2025-12-31 00:00:00' --AND
	--PF.Data_Nota BETWEEN '2022-07-15 00:00:00' AND '2022-12-31 00:00:00' 
	--NV.Doc_NF_Vendedores='000003' and 
	----NV.Parcela_NF_Vendedores='01' and 
	--NV.Serie='1  55' 



--GERANDO ID ÚNICO PATA COMISSÃO
	
--tipos de comissão
SELECT DISTINCT
	NV.Vendedor_NF_Vendedores + NV.Tipo_Comissao_NF_Vend AS ID_COMISSAO,
	NV.Vendedor_NF_Vendedores AS VENDEDOR, 
	NV.Tipo_Comissao_NF_Vend AS TIPO_COMISSAO,
	RC.Porcentagem_Comissoes AS PORCENTAGEM,
	CONVERT(DECIMAL(18,2),ROUND(((RC.Porcentagem_Comissoes)),2)) AS ARREDONDANDO,
	REPLACE(CONVERT(DECIMAL(18,2),ROUND(((RC.Porcentagem_Comissoes)),2)),'.','') AS ID_COMISSAO_NOVO,
	SUBSTRING(CONVERT(VARCHAR(10),RC.Porcentagem_Comissoes), 1, 4) AS ARREDONDANDO_,
	REPLACE(SUBSTRING((CONVERT(VARCHAR(10),RC.Porcentagem_Comissoes)), 1, 4),'.','') AS ID_COMISSAO_NOVO_,
	CASE CONVERT(VARCHAR(10),RC.Porcentagem_Comissoes)
		WHEN '0.0000' THEN '0'
		WHEN '1.0000' THEN '1'
		WHEN '1.2000' THEN 'A'
		WHEN '1.5000' THEN 'B'		
		WHEN '2.0000' THEN '2'
		WHEN '2.1172' THEN 'C'
		WHEN '2.2083' THEN 'D'
		WHEN '2.5000' THEN 'E'
		WHEN '2.5690' THEN 'F'
		WHEN '2.5948' THEN 'G'
		WHEN '2.8509' THEN 'H'		
		WHEN '3.0000' THEN '3'
		WHEN '3.4433' THEN 'I'
		WHEN '3.5000' THEN 'J'
		WHEN '3.6308' THEN 'K'
		WHEN '3.7224' THEN 'L'
		WHEN '3.8512' THEN 'M'		
		WHEN '4.0000' THEN '4'
		WHEN '4.7100' THEN 'N'
		WHEN '4.8054' THEN 'O'		
		WHEN '5.0000' THEN '5'		
		WHEN '6.0000' THEN '6'		
		WHEN '7.0000' THEN '7'		
		WHEN '8.0000' THEN '8'		
		WHEN '9.0000' THEN '9'
		
		ELSE '00'
	END	AS TIPO_COMISSAO_WOW
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
	NV.Empresa_NF_Vendedores IN ('01', '02') and
	NP.Vencimento_Parcelas BETWEEN '2021-01-01 00:00:00' AND '2025-12-31 00:00:00' --AND
	--PF.Data_Nota BETWEEN '2022-07-15 00:00:00' AND '2022-12-31 00:00:00' 
	--NV.Doc_NF_Vendedores='000003' and 
	----NV.Parcela_NF_Vendedores='01' and 
	--NV.Serie='1  55' 

	
	
--sql pronto para carca de dados	
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
	NP.Nr_Conta_Age_Parcelas AS CONTA_CORRENTE,
	'0' AS NUMERO_REMESSA,
	REPLACE(RC.Porcentagem_Comissoes,'.',',') AS PERCENTUAL_COMIS,
	REPLACE(NV.Valor_Comissao_NF_Vend,'.',',') AS VALOR_COMIS,
	REPLACE(NP.Valor_Parcelas,'.',',') AS BASE_CALC_COMIS,
	'100' AS PERC_COMIS_CREC,
	CASE CONVERT(VARCHAR(10),RC.Porcentagem_Comissoes)
		WHEN '0.0000' THEN '0'
		WHEN '1.0000' THEN '1'
		WHEN '1.2000' THEN 'A'
		WHEN '1.5000' THEN 'B'		
		WHEN '2.0000' THEN '2'
		WHEN '2.1172' THEN 'C'
		WHEN '2.2083' THEN 'D'
		WHEN '2.5000' THEN 'E'
		WHEN '2.5690' THEN 'F'
		WHEN '2.5948' THEN 'G'
		WHEN '2.8509' THEN 'H'		
		WHEN '3.0000' THEN '3'
		WHEN '3.4433' THEN 'I'
		WHEN '3.5000' THEN 'J'
		WHEN '3.6308' THEN 'K'
		WHEN '3.7224' THEN 'L'
		WHEN '3.8512' THEN 'M'		
		WHEN '4.0000' THEN '4'
		WHEN '4.7100' THEN 'N'
		WHEN '4.8054' THEN 'O'		
		WHEN '5.0000' THEN '5'		
		WHEN '6.0000' THEN '6'		
		WHEN '7.0000' THEN '7'		
		WHEN '8.0000' THEN '8'		
		WHEN '9.0000' THEN '9'
		ELSE '0'
	END	AS TIPO_COMISSAO_WOW,
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
	

--resultado do primeiro estudo de caso (todas as parcelas baixadas e em aberto) - foi identificado que no início algumas parcelas estão com 2 ou mais vendedores

SELECT
	PF.Pedido,
	NP.Vencimento_Parcelas,
	NP.Tem_Baixas,
	NP.Empresa_Parcelas,
	NP.Cliente,	
	NP.Documento_Parcelas,
	NP.Serie,
	NP.Id_Parcela,
	NV.Inc_Vend_Parcela,
	NP.Valor_Parcelas,
	NV.Tipo_Comissao_NF_Vend,
	RC.Porcentagem_Comissoes,
	NV.Valor_Comissao_NF_Vend,
	NV.Vendedor_NF_Vendedores,
	*
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


--inserindo o primeiro estudo de caso na tabela systêxtil de contas a receber: fatu_070 

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
	NP.Nr_Conta_Age_Parcelas AS CONTA_CORRENTE,
	'0' AS NUMERO_REMESSA,
	REPLACE(RC.Porcentagem_Comissoes,'.',',') AS PERCENTUAL_COMIS,
	REPLACE(NV.Valor_Comissao_NF_Vend,'.',',') AS VALOR_COMIS,
	REPLACE(NP.Valor_Parcelas,'.',',') AS BASE_CALC_COMIS,
	'100' AS PERC_COMIS_CREC,
	'0' AS TIPO_COMISSAO,
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


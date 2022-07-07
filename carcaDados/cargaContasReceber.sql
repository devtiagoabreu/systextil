--tabela de contas a receber systextil: fatu_070 
--tabela de contas recebidas systextil: fatu_075 


--vw_Rec_DuplicatasEmAberto | DBMicrodata
SELECT np.Empresa_Parcelas Empresa, nr.idDocumento, nr.Cliente_NF CNPJ_CPF, cp.Razao_Nome_Cliente Cliente,     
	np.Documento_Parcelas Nota_Fiscal, np.Serie, np.Parcela_Parcelas Desdobro,     
    nr.Emissao_NF Emissao, np.Vencimento_Parcelas Vencimento, Banco_Parcelas Banco,   
    Operacao_Parcelas Operacao,     
    (
		SUM(ISNULL(np.Valor_Parcelas, 0)) -    
		(
			SELECT isnull(SUM(IsNull(rb.Valor_Liquido, 0)), 0)    
			FROM Rec_Baixas rb  
			WHERE rb.Empresa = np.Empresa_Parcelas
			AND rb.Documento = np.Documento_Parcelas 
			AND rb.Parcela = np.Parcela_Parcelas 
			AND rb.Serie=np.Serie
		)
	) AS Valor  
	FROM Notas_Fiscais_Rec nr  
    INNER JOIN Notas_Fiscais_Parcelas np 
		ON nr.Nr_Empresa_NF = np.Empresa_Parcelas 
		AND nr.Nr_Documento_NF = np.Documento_Parcelas 
		AND nr.Serie=np.Serie 
    LEFT JOIN Clientes_Principal cp 
		ON cp.Codigo_Cliente = nr.Cliente_NF  
	GROUP BY np.Empresa_Parcelas, nr.idDocumento, nr.Cliente_NF, cp.Razao_Nome_Cliente, 
	np.Documento_Parcelas, np.Parcela_Parcelas, np.serie, nr.Emissao_NF,  
    np.Vencimento_Parcelas, Banco_Parcelas, Operacao_Parcelas  
	HAVING 
	(
		SUM(ISNULL(np.Valor_Parcelas, 0)) -  
		(
			SELECT isnull(SUM(IsNull(rb.Valor_Liquido, 0)), 0)  
			FROM Rec_Baixas rb  
			WHERE rb.Empresa = np.Empresa_Parcelas AND  
			rb.Documento = np.Documento_Parcelas AND  
			rb.Parcela = np.Parcela_Parcelas and rb.Serie=np.Serie
		)
	) > 0

--refatorando vw
SELECT
	np.Empresa_Parcelas Empresa, 
	nr.idDocumento, 
	nr.Cliente_NF CNPJ_CPF, 
	cp.Razao_Nome_Cliente Cliente,  
	np.Documento_Parcelas Nota_Fiscal, 
	np.Serie, 
	np.Parcela_Parcelas Desdobro,     
	nr.Emissao_NF Emissao, 
	np.Vencimento_Parcelas Vencimento, 
	Banco_Parcelas Banco,   
	Operacao_Parcelas Operacao,     
	(SUM(ISNULL(np.Valor_Parcelas, 0)) - (
		SELECT 
			isnull(SUM(IsNull(rb.Valor_Liquido, 0)), 0)    
		FROM 
			Rec_Baixas rb  
		WHERE 
			rb.Empresa = np.Empresa_Parcelas
			AND rb.Documento = np.Documento_Parcelas 
			AND rb.Parcela = np.Parcela_Parcelas 
			AND rb.Serie=np.Serie
		)
	) AS Valor  
FROM 
	Notas_Fiscais_Rec nr  
	INNER JOIN Notas_Fiscais_Parcelas np ON nr.Nr_Empresa_NF = np.Empresa_Parcelas 
	AND nr.Nr_Documento_NF = np.Documento_Parcelas 
	AND nr.Serie=np.Serie 
	LEFT JOIN Clientes_Principal cp ON cp.Codigo_Cliente = nr.Cliente_NF  
GROUP BY 
	np.Empresa_Parcelas, 
	nr.idDocumento, 
	nr.Cliente_NF, 
	cp.Razao_Nome_Cliente, 
	np.Documento_Parcelas, 
	np.Parcela_Parcelas, 
	np.serie, nr.Emissao_NF,  
	np.Vencimento_Parcelas, 
	Banco_Parcelas, 
	Operacao_Parcelas  
HAVING 
	(SUM(ISNULL(np.Valor_Parcelas, 0)) - (
		SELECT 
			isnull(SUM(IsNull(rb.Valor_Liquido, 0)), 0)  
		FROM 
			Rec_Baixas rb  
		WHERE 
			rb.Empresa = np.Empresa_Parcelas AND  
			rb.Documento = np.Documento_Parcelas AND  
			rb.Parcela = np.Parcela_Parcelas and rb.Serie=np.Serie
		)
	) > 0


--vw base do sistema microdata
SELECT 
	Nota_Fiscal AS QtdeDoc,
    Valor AS ValorTotal,
	Vencimento
FROM 
	DBMicrodata.dbo.VW_Rec_DuplicatasEmAberto
WHERE
	Empresa = '01';

--trazendo todos os campos da vw base
SELECT 
	Empresa,
	idDocumento,
	CNPJ_CPF,
	Cliente,
	Nota_Fiscal,
	Serie,
	Desdobro,
	Emissao,
	Vencimento,
	Banco,
	Operacao,
	Valor,
FROM 
	DBMicrodata.dbo.VW_Rec_DuplicatasEmAberto
WHERE
	Empresa = '01';
	
	
SELECT 
	'001' AS CODIGO_EMPRESA, 
	SUBSTRING(REPLACE(REPLACE(REPLACE(DA.CNPJ_CPF,'.',''),'/',''),'-',''),1,8) AS CLI_DUP_CGC_CLI9, 
	SUBSTRING(REPLACE(REPLACE(REPLACE(DA.CNPJ_CPF,'.',''),'/',''),'-',''),9,4) AS CLI_DUP_CGC_CLI4,
	SUBSTRING(REPLACE(REPLACE(REPLACE(DA.CNPJ_CPF,'.',''),'/',''),'-',''),13,2) AS CLI_DUP_CGC_CLI2,
	'0' AS TIPO_TITULO,
	REPLACE(REPLACE(REPLACE(REPLACE(DA.Nota_Fiscal + DA.Serie,'.',''),'/',''),'-',''),' ','') AS NUM_DUPLICATA,
	DA.Desdobro AS SEQ_DUPLICATAS,
	FORMAT(DA.Vencimento, 'dd/MM/yyyy') AS DATA_VENC_DUPLIC,
	'' AS DATA_PRORROGACAO,
	FORMAT(DA.Emissao, 'dd/MM/yyyy') AS DATA_EMISSAO,
	'' AS PREVISAO,
	DA.Valor AS VALOR_DUPLICATA,
	'0' AS SITUACAO_DUPLIC,
	DA.Banco AS PORTADOR_DUPLIC,
	'0' AS PEDIDO_VENDA,
	NP.Nosso_Nr_Parcelas AS NR_TITULO_BANCO,
	'' AS COD_REP_CLIENTE,
	'' AS POSICAO_DUPLIC,
	'' AS COD_HISTORICO,
	'' AS COMPL_HISTORICO,
	'' AS COD_LOCAL,
	0 AS MOEDA_TITULO,
	DA.Valor AS VALOR_MOEDA,
	'' AS COD_TRANSACAO,
	'' AS CODIGO_CONTABIL,
	'' AS NUM_CONTABIL,
	'' AS SALDO_DUPLICATA,
	'' AS CONTA_CORRENTE,
	'' AS NUMERO_REMESSA,
	'' AS PERCENTUAL_COMIS,
	'' AS VALOR_COMIS,
	'' AS BASE_CALC_COMIS,
	'' AS PERC_COMIS_CREC,
	'' AS TIPO_COMISSAO,
	'' AS CODIGO_ADMINISTR,
	'' AS COMISSAO_ADMINISTR,
	'' AS PERC_COMIS_CREC_ADM,
	'' AS SEQ_END_COBRANCA,
	'' AS OBSERVACAO,
	SUBSTRING(REPLACE(REPLACE(REPLACE(DA.CNPJ_CPF,'.',''),'/',''),'-',''),1,8) AS CLI9RESPTIT, 
	SUBSTRING(REPLACE(REPLACE(REPLACE(DA.CNPJ_CPF,'.',''),'/',''),'-',''),9,4) AS CLI4RESPTIT,
	SUBSTRING(REPLACE(REPLACE(REPLACE(DA.CNPJ_CPF,'.',''),'/',''),'-',''),13,2) AS CLI2RESPTIT,
	'0' AS COD_FORMA_PAGTO
FROM 
	DBMicrodata.dbo.VW_Rec_DuplicatasEmAberto DA
	INNER JOIN DBMicrodata.dbo.Notas_Fiscais_Parcelas NP ON NP.Empresa_Parcelas = DA.Empresa AND
	NP.Documento_Parcelas = DA.Nota_Fiscal AND
	NP.Serie = DA.Serie
WHERE
	Empresa = '01';	
	
	



GO



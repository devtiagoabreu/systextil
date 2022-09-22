--CARGA DE DADOS FINANCEIRO

--DBMicrodata.dbo.VW_Rec_Duplicata_Aberto --> fatu_075
--DBMicrodata.dbo.VW_Rec_Duplicata_Baixadas  --> fatu_070

--RECEBER - BAIXADAS
SELECT
	Cliente,
	Razao_Nome_Cliente,
	Empresa,
	Documento,
	Serie,
	Parcela,
	Emissao,
	Vencimento,
	Maior_Data_Baixa,
	Bco,
	Operacao,
	Valor,
	Valor_Baixas,
	Soma_Juros,
	Soma_Desconto
FROM
	DBMicrodata.dbo.VW_Rec_Duplicata_Baixadas
WHERE
	--Maior_Data_Baixa BETWEEN '2022-09-01 00:00:00' AND '2022-09-30 00:00:00'
	Emissao BETWEEN '2022-09-01 00:00:00' AND '2022-09-30 00:00:00'


SELECT 
	NF.Cliente_NF Cliente, 
	C.Razao_Nome_Cliente, 
	B.Empresa, 
	B.Documento, 
	B.Serie, 
	B.Parcela, 
	NF.Emissao_NF Emissao, 
	NP.Vencimento_Parcelas Vencimento, 
    Max(B.Data_Baixa) Maior_Data_Baixa, 
    NP.Banco_Parcelas Bco, 
    NP.Operacao_Parcelas Operacao,      
    IsNull(NP.Valor_Parcelas,0) Valor, 
    SUM(IsNull(B.Valor_Recebido,0)) Valor_Baixas,
    SUM(IsNull(B.Juros_Recebidos,0)) Soma_Juros, 
    SUM(IsNull(B.Desconto_Concedido,0)) Soma_Desconto            
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
	B.Documento, 
	B.Serie, 
	B.Parcela, 
	NF.Emissao_NF, 
	NP.Vencimento_Parcelas, 
	NP.Banco_Parcelas, 
	NP.Operacao_Parcelas, 
	NP.Valor_Parcelas    


SELECT
	B.Empresa AS NR_TITUL_CODEMPR,
	SUBSTRING(REPLACE(REPLACE(REPLACE(NF.Cliente_NF,'.',''),'/',''),'-',''),1,8) AS NR_TITUL_CLI_DUP_CGC_CLI9,
	SUBSTRING(REPLACE(REPLACE(REPLACE(NF.Cliente_NF,'.',''),'/',''),'-',''),9,4) AS NR_TITUL_CLI_DUP_CGC_CLI4,
	SUBSTRING(REPLACE(REPLACE(REPLACE(NF.Cliente_NF,'.',''),'/',''),'-',''),13,2) AS NR_TITUL_CLI_DUP_CGC_CLI2,
	'0' AS NR_TITUL_COD_TIT, 
	NP.Documento_Parcelas AS NR_TITUL_NUM_DUP,
	NP.Parcela_Parcelas AS NR_TITUL_SEQ_DUP,
	'0' AS SEQ_PAGAMENTO,
	FORMAT(Max(B.Data_Baixa), 'dd/MM/yyyy') AS DATA_PAGAMENTO,
	SUM(IsNull(B.Valor_Liquido,0)) AS VALOR_PAGO,
	'0' AS HISTORICO_PGTO,
	'0' AS NUMERO_DOCUMENTO,
	SUM(IsNull(B.Juros_Recebidos,0)) AS VALOR_JUROS,
	SUM(IsNull(B.Desconto_Concedido,0)) AS VALOR_DESCONTOS,
	NP.Banco_Parcelas AS PORTADOR,
	'' AS CONTA_CORRENTE,
	FORMAT(Max(B.Data_Baixa), 'dd/MM/yyyy') AS DATA_CREDITO,
	'0' AS DOCTO_PAGTO,
	SUM(IsNull(B.Valor_Recebido,0)) AS VALOR_PAGO_MOEDA,
	SUM(IsNull(B.Desconto_Concedido,0)) AS VLR_DESCONTO_MOEDA,
	SUM(IsNull(B.Juros_Recebidos,0)) AS VLR_JUROS_MOEDA
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






--RECEBER - EM ABERTO





























--duplicatas recebidas - contas a receber
SELECT
	*
FROM
	DBMicrodata.dbo.VW_Rec_Duplicata_Baixadas
WHERE
	Empresa IN ('01') AND
	--Emissao BETWEEN '2022-01-01 00:00:00' AND '2023-01-30 00:00:00' AND
	Maior_Data_Baixa BETWEEN '2022-09-01 00:00:00' AND '2022-09-19 00:00:00'
	
	
--duplicatas em aberto - contas a receber
SELECT
	*
FROM
	DBMicrodata.dbo.VW_Rec_DuplicatasEmAberto
WHERE
	Empresa IN ('01') AND
	Emissao BETWEEN '2022-09-01 00:00:00' AND '2022-09-19 00:00:00' --AND
	--Vencimento BETWEEN '2022-09-01 00:00:00' AND '2022-09-30 00:00:00'


--Títulos em aberto - contas a pagar
SELECT
	*
FROM
	DBMicrodata.dbo.VW_Pag_Titulo_Aberto
WHERE
	Empresa IN ('01') AND
	--Emissao BETWEEN '2022-01-01 00:00:00' AND '2023-01-30 00:00:00' AND
	Vencimento BETWEEN '2022-09-01 00:00:00' AND '2022-09-30 00:00:00'









SELECT
 * 
FROM 
	--DBPromoda.dbo.vwDREPagamentos
	DBPromoda.dbo.vwKPIDuplicatasRecebidas
	--DBPromoda.dbo.vwFinanceiroContasPagar
	--DBPromoda.dbo.vwFinanceiroContasReceber
	--DBPromoda.dbo.vwKPIFinanceiroInadimplenciaDuplicatasEmAberto
	--DBPromoda.dbo.vwKPIListagemDeBaixas --(baixa de pagamentos)
	--DBPromoda.dbo.vwListagemContasPagarBaixas
	
	
SELECT
	--np.*,
	--nv.*,
	--pf.*,
	 --rc.*,
	 NP.Documento_Parcelas,
	 NP.Tem_Baixas,
	NP.Empresa_Parcelas AS NR_TITUL_CODEMPR,
	SUBSTRING(REPLACE(REPLACE(REPLACE(NP.Cliente,'.',''),'/',''),'-',''),1,8) AS NR_TITUL_CLI_DUP_CGC_CLI9,
	SUBSTRING(REPLACE(REPLACE(REPLACE(NP.Cliente,'.',''),'/',''),'-',''),9,4) AS NR_TITUL_CLI_DUP_CGC_CLI4,
	SUBSTRING(REPLACE(REPLACE(REPLACE(NP.Cliente,'.',''),'/',''),'-',''),13,2) AS NR_TITUL_CLI_DUP_CGC_CLI2,
	'0' AS NR_TITUL_COD_TIT,
	NP.Documento_Parcelas AS NR_TITUL_NUM_DUP,
	NP.Parcela_Parcelas AS NR_TITUL_SEQ_DUP,
	--SEQ_PAGAMENTO	NUMBER(3)	N	0	.
	--DATA_PAGAMENTO	DATE	Y		. --FORMAT(NP.Vencimento_Parcelas, 'dd/MM/yyyy') AS DATA_VENC_DUPLIC,
	REPLACE(NP.Valor_Parcelas,'.',',') AS VALOR_PAGO,
	'0' AS SITUACAO_DUPLIC,
	NP.Banco_Parcelas AS PORTADOR_DUPLIC,
	PF.Pedido AS PEDIDO_VENDA,
	NP.Nosso_Nr_Parcelas AS NR_TITULO_BANCO,
	NV.Vendedor_NF_Vendedores AS COD_REP_CLIENTE,
	'01' AS POSICAO_DUPLIC,
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
	'0' AS COD_FORMA_PAGTO--,
	--NP.Tem_Baixas
FROM
	DBMicrodata.dbo.Notas_Fiscais_Rec NF 
	INNER JOIN DBMicrodata.dbo.Notas_Fiscais_Parcelas AS NP ON (NF.Nr_Empresa_NF=NP.Empresa_Parcelas and NF.Nr_Documento_NF=NP.Documento_Parcelas and NF.Serie=NP.Serie)
	INNER JOIN DBMicrodata.dbo.Rec_Baixas B ON (B.Empresa=NP.Empresa_Parcelas and B.Documento=NP.Documento_Parcelas and B.Serie=NP.Serie and B.Parcela=NP.Parcela_Parcelas)
	INNER JOIN DBMicrodata.dbo.Notas_Fiscais_Vendedores_Parcelas AS NV ON 
		NV.Doc_NF_Vendedores = NP.Documento_Parcelas AND
		NV.Serie = NP.Serie AND
		NV.Inc_Vend_Parcela = NP.Inc_Parcela AND
		NV.Empresa_NF_Vendedores = NP.Empresa_Parcelas
	INNER JOIN DBMicrodata.dbo.Rec_Comissoes RC ON RC.tipo_comissoes = NV.Tipo_Comissao_NF_Vend AND
		RC.Vendedor_Comissoes = NV.Vendedor_NF_Vendedores
	LEFT JOIN DBMicrodata.dbo.Fat_Pedido AS PF ON 
	  PF.Nr_Nota = NP.Documento_Parcelas AND
	  PF.Serie = NP.Serie AND
	  PF.Cliente = NP.Cliente 
WHERE
	--NV.Empresa_NF_Vendedores IN ('01') and
	--NP.Vencimento_Parcelas BETWEEN  '2022-09-01 00:00:00' AND '2022-09-30 00:00:00' --AND
	PF.Data_Nota BETWEEN '2022-09-01 00:00:00' AND '2022-09-30 00:00:00'
	--NV.Doc_NF_Vendedores='000003' and 
	----NV.Parcela_NF_Vendedores='01' and 
	--NV.Serie='1  55' 
	AND NP.Tem_Baixas = 'S'
	--AND NP.Tem_Baixas IS NULL
ORDER BY
	NP.Documento_Parcelas DESC,
	NP.Serie,
	NP.Id_Parcela






SELECT
	*

FROM
	--DBMicrodata.dbo.VW_Rec_DuplicatasEmAberto
	DBMicrodata.dbo.VW_Rec_Duplicata_Baixadas
	--DBPromoda.dbo.vwKPIDuplicatasRecebidas
	
WHERE
	--Empresa IN ('01') AND
	Emissao BETWEEN '2022-09-01 00:00:00' AND '2022-09-30 00:00:00' --AND
	--Vencimento BETWEEN '2022-09-01 00:00:00' AND '2022-09-30 00:00:00'
order by
	--Nota_fiscal DESC
	Documento DESC
	
	
SELECT
	NF.Cliente_NF Cliente, 
	C.Razao_Nome_Cliente, 
	B.Empresa, 
	B.Documento, 
	B.Serie, 
	B.Parcela, 
	NF.Emissao_NF Emissao, 
	NP.Vencimento_Parcelas Vencimento, 
    Max(B.Data_Baixa) Maior_Data_Baixa, 
    NP.Banco_Parcelas Bco, 
    NP.Operacao_Parcelas Operacao,      
    IsNull(NP.Valor_Parcelas,0) Valor, 
    SUM(IsNull(B.Valor_Recebido,0)) Valor_Baixas,
    SUM(IsNull(B.Juros_Recebidos,0)) Soma_Juros, 
    SUM(IsNull(B.Desconto_Concedido,0)) Soma_Desconto            
FROM 
	Notas_Fiscais_Rec NF 
	INNER JOIN Notas_Fiscais_Parcelas NP ON (NF.Nr_Empresa_NF=NP.Empresa_Parcelas and NF.Nr_Documento_NF=NP.Documento_Parcelas and NF.Serie=NP.Serie)    
    INNER JOIN Rec_Baixas B ON (B.Empresa=NP.Empresa_Parcelas and B.Documento=NP.Documento_Parcelas and B.Serie=NP.Serie and B.Parcela=NP.Parcela_Parcelas)
    INNER JOIN Clientes_Principal C ON (C.Codigo_Cliente=NF.Cliente_NF)                        
GROUP BY 
	NF.Cliente_NF, 
	C.Razao_Nome_Cliente, 
	B.Empresa, 
	B.Documento, 
	B.Serie, 
	B.Parcela, 
	NF.Emissao_NF, 
	NP.Vencimento_Parcelas, 
	NP.Banco_Parcelas, 
	NP.Operacao_Parcelas, 
	NP.Valor_Parcelas    

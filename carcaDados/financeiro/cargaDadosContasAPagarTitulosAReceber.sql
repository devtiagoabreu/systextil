--CARGA DE CONTAS A PAGAR - TÍTULOS EM ABERTO - HOMOLOGADO

--CRIANDO TABELA DE TITULOS A PAGAR

DROP TABLE DBPromoda.dbo.RelTitAb_systextil; 
CREATE TABLE DBPromoda.dbo.RelTitAb_systextil (

	Fornec VARCHAR(255) Null,
	Fornecedor VARCHAR(255) Null,
	Vencimento VARCHAR(255) Null,
	Empresa VARCHAR(255) Null,
	Titulo VARCHAR(255) Null,
	Serie VARCHAR(255) Null,
	Parcela VARCHAR(255) Null,
	Emissao VARCHAR(255) Null,
	Valor VARCHAR(255) Null,
	Referente VARCHAR(255) Null,
	Tipo VARCHAR(255) Null,
	Data_Entrada VARCHAR(255) Null,
	Ch1 VARCHAR(255) Null,
	Ch2 VARCHAR(255) Null,
	Valor_Baixa VARCHAR(255) Null,
	Aviso VARCHAR(255) Null,
	Atraso VARCHAR(255) Null,
	VlBaixaT VARCHAR(255) Null,
	VlBaixaOutros VARCHAR(255) Null,
	VlBaixaFornec VARCHAR(255) Null, 
	Desc_Referencia VARCHAR(255) Null,
	DOperacao VARCHAR(255) Null

);

Create Table #Tp_RelTitAb_Emp (Codigo Char(02) Null)

Insert Into #Tp_RelTitAb_Emp Values ('01')

Insert Into #Tp_RelTitAb_Emp Values ('02')

select * from DBPromoda.dbo.RelTitAb_systextil

Insert Into DBPromoda.dbo.RelTitAb_systextil (
	Fornec,
	Fornecedor,
	Vencimento,
	Empresa,
	Titulo,
	Serie,
	Parcela,
	Emissao,
	Valor,
	Referente,
	Tipo,
	Data_Entrada,
	Ch1,
	Ch2,
	Valor_Baixa,
	Aviso,
	Atraso,
	VlBaixaT,
	VlBaixaOutros,
	VlBaixaFornec,
	Desc_Referencia,
	DOperacao
)
	Exec DBMicrodata.dbo.SP_Pag_RelTituloAb 
	'2050-12-31T00:00:00',
	'2022-09-26T00:00:00',
	'1990-01-01T00:00:00',
	'2030-09-30T00:00:00',
	'2050-12-31T00:00:00',
	'Order By 
	Fornecedor ,
	TP.Vencimento,
	TP.Empresa,
	TP.Parcela,
	Emissao,
	TP.Valor,
	TNF.Referente,
	TF.Tipo,
	TNF.Data_Entrada,
	Ch1,
	Ch2,
	Titulo','#Tp_RelTitAb_Emp','','','1900-01-01T00:00:00','1900-01-01T00:00:00','','','S', 'N', '', 'S', 'N';
	
DROP TABLE DBPromoda.dbo.SelTitAb_systextil;
CREATE TABLE DBPromoda.dbo.SelTitAb_systextil (
	Id_SisPag VARCHAR(255) Null,
	Empresa VARCHAR(255) Null,
	Documento VARCHAR(255) Null,
	Parcela VARCHAR(255) Null,
	Serie VARCHAR(255) Null,
	Emissao VARCHAR(255) Null,
	Vencimento VARCHAR(255) Null,
	Fornecedor VARCHAR(255) Null,
	Tipo_Fornec VARCHAR(255) Null,
	Total_Doc VARCHAR(255) Null,
	Valor_Parcela VARCHAR(255) Null,
	Valor_Baixas VARCHAR(255) Null,
	Valor_Saldo VARCHAR(255) Null,
	Dias VARCHAR(255) Null,
	CodigoBarra VARCHAR(255) Null
)

Insert Into DBPromoda.dbo.SelTitAb_systextil (
Id_SisPag,
Empresa,
Documento,
Parcela,
Serie,
Emissao,
Vencimento,
Fornecedor,
Tipo_Fornec,
Total_Doc,
Valor_Parcela,
Valor_Baixas,
Valor_Saldo,
Dias,
CodigoBarra 
)
SELECT 
	P.Id_SisPag,
	P.Empresa, 
	P.Documento, 
	P.Parcela, 
	P.Serie, 
	NF.Data_Emissao Emissao, 
	P.Vencimento Vencimento,
	NF.Fornecedor, 
	NF.Tipo_Fornec,
    --C.CGC_Cliente,
    --C.Razao_Nome_Cliente,
    ISNULL(NF.Vr_Total_Parcelas,0) Total_Doc, 
    ISNULL(P.Valor,0) Valor_Parcela, 
    SUM(ISNULL(B.Valor_Liquido,0)) Valor_Baixas, (ISNULL(P.Valor,0) - SUM(ISNULL(B.Valor_Liquido,0))) Valor_Saldo,
    DATEDIFF(dd, P.Vencimento, GETDATE()) Dias, 
    P.CodigoBarra 
FROM 
	(DBMicrodata.dbo.NFE_Parcelas P 
	LEFT JOIN DBMicrodata.dbo.Pag_Baixas B ON (B.Empresa=P.Empresa and B.Documento=P.Documento and B.Serie=P.Serie and B.Tipo_Fornec=P.Tipo_Fornec and B.Fornecedor=P.Fornecedor and B.Parcela=P.Parcela)) 
	INNER JOIN DBMicrodata.dbo.NF_Entradas NF ON (NF.Empresa=P.Empresa and NF.Documento=P.Documento and NF.Serie=P.Serie and NF.Tipo_Fornec=P.Tipo_Fornec and NF.Fornecedor=P.Fornecedor) 
	INNER JOIN DBMicrodata.dbo.Clientes_Principal C ON (C.Codigo=NF.Fornecedor) 
where
	P.Empresa in ('01','02') 	
GROUP BY 
	P.Empresa, 
	P.Documento, 
	P.Parcela, 
	P.Serie, 
	NF.Fornecedor, 
	NF.Tipo_Fornec,
	--C.CGC_Cliente,
    --C.Razao_Nome_Cliente, 
	P.Valor, 
	ISNULL(NF.Vr_Total_Parcelas,0),
    P.Vencimento, 
    NF.Data_Emissao,
    P.CodigoBarra, 
    P.Id_SisPag 
HAVING 
	SUM(ISNULL(B.Valor_Liquido,0)) < ISNULL(P.Valor,0)
ORDER BY
	P.Vencimento  asc



SELECT
	*
FROM
	DBPromoda.dbo.RelTitAb_systextil REL
	INNER JOIN DBPromoda.dbo.SelTitAb_systextil SEL ON 
		SUBSTRING(REL.Fornec,2,6) = SEL.Fornecedor AND
		REL.Empresa = SEL.Empresa AND 
		REL.Titulo = SEL.Documento AND 
		REL.Serie = SEL.Serie AND 
		REL.Parcela = SEL.Parcela
ORDER BY 
	REL.Empresa, 
	REL.Fornec, 
	REL.Titulo, 
	REL.Serie, 
	REL.Parcela		
		
		 
SELECT REL.Empresa, REL.Fornec, REL.Fornecedor, REL.Titulo, REL.Serie, REL.Parcela, REL.Valor,  * FROM DBPromoda.dbo.RelTitAb_systextil REL ORDER BY REL.Empresa, REL.Fornec, REL.Titulo, REL.Serie, REL.Parcela

SELECT REL.Empresa, REL.Fornecedor, REL.Documento, REL.Serie, REL.Parcela, REL.Valor_Parcela,  *  FROM DBPromoda.dbo.SelTitAb_systextil REL ORDER BY REL.Empresa, REL.Fornecedor, REL.Documento, REL.Serie, REL.Parcela

select * FROM DBPromoda.dbo.RelTitAb_systextil REL

select * FROM DBPromoda.dbo.SelTitAb_systextil SEL

-- CONTAS A PAGAR - TITULOS EM ABERTO
SELECT
	REL.Titulo AS NR_DUPLICATA,  
	REL.Parcela AS PARCELA,
	'' AS CGC_9, --CNPJ
	'' AS CGC_4, --CNPJ
	'' AS CGC_2, --CNPJ
	CASE REL.Empresa 
		WHEN '01' THEN '11'
		ELSE '32'
	END	AS TIPO_TITULO,
	'01' AS CODIGO_EMPRESA,
	REL.Titulo AS DOCUMENTO,
	REL.Serie AS SERIE,
	'0' AS SITUACAO, -- digitado
	FORMAT(CONVERT(DATETIME,REL.Emissao,103), 'dd/MM/yyyy') AS DATA_CONTRATO,
	FORMAT(CONVERT(DATETIME,REL.Vencimento,103), 'dd/MM/yyyy') AS DATA_VENCIMENTO,
	FORMAT(CONVERT(DATETIME,REL.Emissao,103), 'dd/MM/yyyy') AS DATA_DIGITACAO,
	FORMAT(CONVERT(DATETIME,REL.Vencimento,103), 'dd/MM/yyyy') AS DATA_TRANSACAO,
	REL.Valor AS VALOR_PARCELA,
	ISNULL(SEL.Valor_Saldo,'0') AS SALDO_TITULO,
	'01' AS TIPO_PAGAMENTO,
	'02' AS COD_END_COBRANCA,
	'001' AS COD_PORTADOR,
	'0' AS PREVISAO,
	'1000' AS CODIGO_DEPTO,
	'206' AS CODIGO_HISTORICO,
	'901' AS CODIGO_TRANSACAO,
	REL.Fornecedor AS EMITENTE_TITULO,
	REL.Referente + '| ' + REL.DOperacao AS ORIGEM_DEBITO,
	'04' AS POSICAO_TITULO,
	REL.Valor AS VALOR_MOEDA,
	'00' AS MOEDA_TITULO,
	'0' AS CODIGO_CONTABIL,
	REL.Titulo + '-' + REL.Parcela AS COMPL_HISTORICO,
	REL.Titulo AS NR_TITULO_BANCO,
	'0' AS NUM_CONTABIL,
	'0' AS VALOR_ISS,
	'0' AS VALOR_IRRF,
	'0' AS VALOR_DESC,
	'0' AS VALOR_JUROS,
	'0' AS VALOR_INSS,
	'9999' AS USUARIO_DIGITACAO,
	'' AS CODIGO_BARRAS
FROM
	DBPromoda.dbo.RelTitAb_systextil REL
	INNER JOIN DBPromoda.dbo.SelTitAb_systextil SEL ON 
		SUBSTRING(REL.Fornec,2,6) = SEL.Fornecedor AND
		REL.Empresa = SEL.Empresa AND 
		REL.Titulo = SEL.Documento AND 
		REL.Serie = SEL.Serie AND 
		REL.Parcela = SEL.Parcela
ORDER BY 
	REL.Empresa, 
	REL.Fornec, 
	REL.Titulo, 
	REL.Serie, 
	REL.Parcela	
	
	
	
SELECT
 CP.CGC_Cliente,
 *
FROM
	DBPromoda.dbo.vwCargaDadosContaAPagarTitulosAbertos AS VWTA
	INNER JOIN  DBMicrodata.dbo.CLIENTES_PRINCIPAL AS CP ON CP.Razao_Nome_Cliente = VWTA.EMITENTE_TITULO
	
	
SELECT * FROM DBMicrodata.dbo.CLIENTES_PRINCIPAL
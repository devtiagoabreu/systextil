USE [DBPromoda]
GO

/****** Object:  View [dbo].[vwCargaDadosContaAPagarTitulosAbertos]    Script Date: 10/04/2022 10:08:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE VIEW [dbo].[vwCargaDadosContaAPagarTitulosAbertos]
AS

SELECT
	SEL.FORNECEDOR,
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
		REL.Parcela = SEL.Parcela;

GO



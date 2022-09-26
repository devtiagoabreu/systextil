-- T�tulos a pagar - cpag_010

SELECT
	'' AS NR_DUPLICATA,
	'' AS PARCELA,
	'' AS CGC_9,
	'' AS CGC_4,
	'' AS CGC_2,
	'' AS TIPO_TITULO,
	'' AS CODIGO_EMPRESA,
	'' AS DOCUMENTO,
	'' AS SERIE,
	'' AS SITUACAO,
	'' AS DATA_CONTRATO,
	'' AS DATA_VENCIMENTO,
	'' AS DATA_DIGITACAO,
	'' AS DATA_TRANSACAO,
	'' AS VALOR_PARCELA,
	'' AS SALDO_TITULO,
	'' AS TIPO_PAGAMENTO,
	'' AS COD_END_COBRANCA,
	'' AS COD_PORTADOR,
	'' AS PREVISAO,
	'' AS CODIGO_DEPTO,
	'' AS CODIGO_HISTORICO,
	'' AS CODIGO_TRANSACAO,
	'' AS EMITENTE_TITULO,
	'' AS ORIGEM_DEBITO,
	'' AS POSICAO_TITULO,
	'' AS VALOR_MOEDA,
	'' AS MOEDA_TITULO,
	'' AS CODIGO_CONTABIL,
	'' AS COMPL_HISTORICO,
	'' AS NR_TITULO_BANCO,
	'' AS NUM_CONTABIL,
	'' AS VALOR_ISS,
	'' AS VALOR_IRRF,
	'' AS VALOR_DESC,
	'' AS VALOR_JUROS,
	'' AS VALOR_INSS,
	'' AS USUARIO_DIGITACAO,
	'' AS CODIGO_BARRAS




SELECT 
	P.Empresa, 
	P.Documento, 
	P.Parcela, 
	P.Serie, 
	NF.Data_Emissao Emissao, 
	P.Vencimento Vencimento, 
	NF.Fornecedor, 
	NF.Tipo_Fornec,
    ISNULL(NF.Vr_Total_Parcelas,0) Total_Doc, 
    ISNULL(P.Valor,0) Valor_Parcela, 
    SUM(ISNULL(B.Valor_Liquido,0)) Valor_Baixas, (ISNULL(P.Valor,0) - SUM(ISNULL(B.Valor_Liquido,0))) Valor_Saldo,
    DATEDIFF(dd, P.Vencimento, GETDATE()) Dias, 
    P.CodigoBarra, 
    P.Id_SisPag 
FROM 
	(DBMicrodata.dbo.NFE_Parcelas P 
	LEFT JOIN DBMicrodata.dbo.Pag_Baixas B ON (B.Empresa=P.Empresa and B.Documento=P.Documento and B.Serie=P.Serie and B.Tipo_Fornec=P.Tipo_Fornec and B.Fornecedor=P.Fornecedor and B.Parcela=P.Parcela)) 
	INNER JOIN DBMicrodata.dbo.NF_Entradas NF ON (NF.Empresa=P.Empresa and NF.Documento=P.Documento and NF.Serie=P.Serie and NF.Tipo_Fornec=P.Tipo_Fornec and NF.Fornecedor=P.Fornecedor) 
	--INNER JOIN DBMicrodata.dbo.Clientes_Principal C ON (C.Codigo=NF.Fornecedor) 
where
	P.Empresa in ('01','02')
GROUP BY 
	P.Empresa, 
	P.Documento, 
	P.Parcela, 
	P.Serie, 
	NF.Fornecedor, 
	NF.Tipo_Fornec, 
	P.Valor, 
	ISNULL(NF.Vr_Total_Parcelas,0),
    P.Vencimento, 
    NF.Data_Emissao,
    P.CodigoBarra, 
    P.Id_SisPag 
HAVING 
	SUM(ISNULL(B.Valor_Liquido,0)) < ISNULL(P.Valor,0)
order by
	P.Vencimento  asc

	
	
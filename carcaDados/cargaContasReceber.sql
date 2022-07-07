--tabela de contas a receber systextil: fatu_070 
--tabela de contas recebidas systextil: fatu_075 

--MAPEAMENTO REVERSO NA NOTA 025897
select * from Notas_Fiscais_Rec	
	
select * from Notas_Fiscais_Parcelas

select * from VW_Rec_Duplicata_Aberto ORDER BY Vencimento DESC

Select CL.Razao_Nome_Cliente,NF.Nr_Documento_NF,NF.Serie,NF.Emissao_NF,NF.Vr_Total_Doc_NF,NF.Cliente_NF,NF.Nr_Empresa_NF,CL.Codigo_Cliente
From Notas_Fiscais_Rec as NF, Clientes_Principal as CL
Where NF.Nr_Empresa_NF='01' and NF.Nr_Documento_NF Like '%025897%' and CL.Codigo_Cliente=NF.Cliente_NF
Order By NF.Nr_Documento_NF

Select * From Notas_Fiscais_Rec Where Nr_Empresa_NF='01' and Nr_Documento_NF like '025897' and Cliente_NF like '06.722.227/0001-27' and Serie like '1  55' Order By Nr_Documento_NF

Select * From Condicoes_Pagto_Parcelas Where Codigo_Pagto_Parcelas='3K' 

Select Codigo_Cliente,Razao_Nome_Cliente,Banco_Cliente,Operacao_Cliente From Clientes_Principal Where Codigo_Cliente='06.722.227/0001-27' Order By Razao_Nome_Cliente

Select *, Agencia_Parcelas+Dig_Age_Parcelas+Nr_Conta_Age_Parcelas+Dig_Conta_Age_Parcelas Nro_Agencia From Notas_Fiscais_Parcelas Where Empresa_Parcelas='01' and Documento_Parcelas='025897' and Serie='1  55' Order By Parcela_Parcelas

Select Max(Data_Baixa) as Maior_Baixa
From Rec_Baixas
Where Empresa='01' and Documento='025897' and Serie='1  55' and Parcela='01'

Select Tipo_Hist_Historicos as Tipo
From Rec_Baixas as RB Left Join Rec_Historicos as RH on(RB.Cod_Historico=RH.Cod_Historico_Historicos)
Where Empresa='01' and Documento='025897' and Serie='1  55' and Parcela='01'

Select Max(Data_Baixa) as Maior_Baixa
From Rec_Baixas
Where Empresa='01' and Documento='025897' and Serie='1  55' and Parcela='02'

Select Tipo_Hist_Historicos as Tipo
From Rec_Baixas as RB Left Join Rec_Historicos as RH on(RB.Cod_Historico=RH.Cod_Historico_Historicos)
Where Empresa='01' and Documento='025897' and Serie='1  55' and Parcela='02'

Select Max(Data_Baixa) as Maior_Baixa
From Rec_Baixas
Where Empresa='01' and Documento='025897' and Serie='1  55' and Parcela='03'

Select Tipo_Hist_Historicos as Tipo
From Rec_Baixas as RB Left Join Rec_Historicos as RH on(RB.Cod_Historico=RH.Cod_Historico_Historicos)
Where Empresa='01' and Documento='025897' and Serie='1  55' and Parcela='03'

Select Max(Data_Baixa) as Maior_Baixa
From Rec_Baixas
Where Empresa='01' and Documento='025897' and Serie='1  55' and Parcela='04'

Select Tipo_Hist_Historicos as Tipo
From Rec_Baixas as RB Left Join Rec_Historicos as RH on(RB.Cod_Historico=RH.Cod_Historico_Historicos)
Where Empresa='01' and Documento='025897' and Serie='1  55' and Parcela='04'

Select Nr_Age_Contas,Dig_Age_Contas,Nr_Conta_Contas,Dig_Conta_Contas,Nr_Bco_Contas, Nr_Age_Contas+Dig_Age_Contas+Nr_Conta_Contas+Dig_Conta_Contas Nro_Agencia From Contas_e_Agencias Where Nr_Bco_Contas='001' and (IsNull(Inativo,'N') <> 'S')

Select * From Notas_Fiscais_Vendedores_Parcelas Where Empresa_NF_Vendedores='01' and Doc_NF_Vendedores='025897' and Parcela_NF_Vendedores='01' and Serie='1  55' Order By Vendedor_NF_Vendedores
Select * From Notas_Fiscais_Vendedores_Parcelas Where Empresa_NF_Vendedores='01' and Doc_NF_Vendedores='025897' and Parcela_NF_Vendedores='03' and Serie='1  55' Order By Vendedor_NF_Vendedores


Select Count(*) Livre
From Fat_Param_ComLivre
Where Tipo = 'C'

Select B.*,(Case When H.Tipo_Hist_Historicos='6' Then 'J' Else 'B' End) Tp, (Select Top 1 U.Nome_Usuario From Usuarios U Where U.Cod_Usuario=B.Usuario_Baixa) Nome_Usuario From Rec_Baixas B INNER JOIN Rec_Historicos H ON (B.Cod_Historico=H.Cod_Historico_Historicos) Where B.Empresa='01' and B.Documento='025897' and Serie='1  55' and B.Parcela='01'

Select * From Rec_Transacao Where Empresa='01' and Documento='025897' and Serie='1  55' and Parcela='01'

Select O.idNotasFiscaisParcelasObs, O.Empresa, O.Documento, O.Serie, O.Parcela, O.DataHora, U.Nome_Usuario Usuario, O.Observacao From Notas_Fiscais_Parcelas_Obs O Left Join Usuarios U on (U.Cod_Usuario=O.Usuario) Where O.Empresa ='01' and O.Documento ='025897' and O.Serie ='1  55' and O.Parcela ='01' Order By O.idNotasFiscaisParcelasObs Desc

SELECT Valor_Parcelas - Sum(ISNull(Valor_Liquido,0)) As Vr_Aberto FROM Notas_Fiscais_Parcelas NFP LEFT JOIN (Rec_Baixas RB INNER JOIN Rec_Historicos H ON (RB.Cod_Historico=H.Cod_Historico_Historicos and H.Tipo_Hist_Historicos<>'6')) ON (NFP.Empresa_Parcelas=RB.Empresa AND NFP.Documento_Parcelas=RB.Documento and NFP.Serie=RB.Serie AND NFP.Parcela_Parcelas=RB.Parcela) Where NFP.Empresa_Parcelas ='01' AND NFP.Documento_Parcelas ='025897' and NFP.Serie='1  55' AND NFP.Parcela_Parcelas ='01' Group By Valor_Parcelas

Select ID_Empresa From Empresas where Codigo_Empresas = '01'

Select dbo.FNC_VlParamEmpSis('Usa_CC4Niveis_Rec',null,1,'100') valor

Select Isnull(Sum(Valor_Liquido),0) Recebido
From Rec_Baixas B INNER JOIN Rec_Historicos H ON (B.Cod_Historico=H.Cod_Historico_Historicos)
Where B.Empresa='01' and B.Documento='025897' and B.Serie='1  55' and B.Parcela='01' and H.Tipo_Hist_Historicos<>'6'




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
	INNER JOIN DBMicrodata.dbo.VW_Rec_Duplicata_Aberto DE ON DE.Empresa = DA.Empresa AND
	 DE.Documento = DA.Nota_Fiscal AND
	 DE.Serie = DA.Serie
WHERE
	Empresa = '01';	
	
	



GO



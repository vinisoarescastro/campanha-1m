-- =============================================================================
-- Objetivo   : Base de vendas elegíveis para a Campanha 5 Casas e 1 Milhão
--              Levanta todas as vendas ativas com dados de cliente, situação
--              financeira e aptidão para o sorteio.
-- Escopo     : Obras com prefixo IN ('65','67','68','69')
--              Empresas excluídas: 3, 9, 229, 204, 301, 302, 226
--              Obra excluída pontualmente: 243-69749
--              Recebimentos a partir de 2026-05-01, excluindo custas (Tipo 1)
-- Banco      : SQL Server (interno Brasil Terrenos)
-- Autor      : Área de Dados
-- Atualizado : 2026-06-17
-- =============================================================================

SELECT
    pc.Cidade,
    pc.Empresa_ven                                              [CodEmpresa],
    pc.Obra_Ven                                                 [CodObra],
    ps.Descricao_psc                                            [Produto],
    pc.Num_Ven                                                  [Venda],
	up.identificador_unid [Identificador],
    FORMAT(pc.Data_Ven, 'dd/MM/yyyy')                           [Dt.Venda],

    FORMAT(pc.ValorTot_Ven, 'C')                                [VlrVenda],
    UPPER(PesCli.Nome_pes)                                      [NomeCliente],
    PesCli.cpf_pes,
    LOWER(PesCli.Email_pes)                                     [EmailCliente],
    TelefoneFormatado,
	TipoTelefone,

    CASE 
        WHEN crConsolidado.StatusContasReceber = 'Inadimplente' THEN 'Inadimplente'
        ELSE 'Adimplente'
    END                                                         [StatuVenda],

    -- Quantidade por tipo de parcela
    crConsolidado.Qtd_P                                         [Qtd Parcelas],
    crConsolidado.Qtd_S                                         [Qtd Sinal],
    crConsolidado.Qtd_SA                                        [Qtd Sinal/Arras],
    crConsolidado.Qtd_SN                                        [Qtd Sinal Negoci],
    crConsolidado.Qtd_E                                         [Qtd Entrada],
    crConsolidado.Qtd_ER                                        [Qtd Ent.Reativacao],
    crConsolidado.Qtd_AM                                        [Qtd Amortizacao],
    crConsolidado.Qtd_FC                                        [Qtd Financ.CEF],
    crConsolidado.Qtd_B                                         [Qtd Balao],
    crConsolidado.Qtd_R                                         [Qtd Residuo],
    crConsolidado.Qtd_I                                         [Qtd Intermediacao],
    crConsolidado.Qtd_OP                                        [Qtd Operacao XPI],

    -- Valores gerais
    FORMAT(ISNULL(crConsolidado.ValorAReceber,     0), 'C')     [Valor a Receber],
    FORMAT(ISNULL(crConsolidado.ValorInadimplente, 0), 'C')     [Valor Inadimplência],
    FORMAT(ISNULL(recTotais.ValorRec,              0), 'C')     [Valor Recebido],
    FORMAT(recTotais.DataUltimoRecebimento, 'dd/MM/yyyy')       [Data Último Recebimento],
    FLOOR(ISNULL(recTotais.ValorRec, 0) / 100)                  [Cupons Gerados],

    --  Diagnóstico - era inadimplente no mês do pagamento?
    CASE
        WHEN inadimMesPag.EraInadimplenteMesPagamento = 1 THEN 'Sim'
        ELSE 'Não'
    END                                                         [Inadimplente no Mês Pago],
  --  Status final do sorteio (Apto / Não Apto)
    CASE
        WHEN ISNULL(recTotais.ValorRec, 0) = 0
            THEN 'NÃO APTO'
        WHEN inadimMesPag.EraInadimplenteMesPagamento = 1
            THEN 'NÃO APTO'
        ELSE 'APTO'
    END                                                         [Status Sorteio],

    --  Motivo do status do sorteio
    CASE
        WHEN ISNULL(recTotais.ValorRec, 0) = 0
            THEN 'SEM PAGAMENTO'
        WHEN inadimMesPag.EraInadimplenteMesPagamento = 1
            THEN 'INADIMPLENTE NO MÊS DO PAGAMENTO'
        ELSE 'PAGAMENTO EM DIA'
    END                                                         [Motivo]

FROM
(
    SELECT
        UPPER(o.cid_obr)    AS Cidade,
        v.Empresa_ven,
        v.Obra_Ven,
        v.Num_Ven,
        v.Data_Ven,
        ValorTot_Ven,
        v.Status_Ven,
        ValorTot_Ven        AS Faturamento,
        o.descr_obr,
        e.Desc_emp,
        v.Cliente_Ven
    FROM
    (
        SELECT
            Empresa_ven, Obra_ven, Num_Ven, Data_Ven, DataCad_Ven, Status_ven,
            Cliente_Ven,
            ValorTot_Ven + Acrescimo_Ven - Desconto_Ven AS ValorTot_Ven
        FROM Vendas WITH(NOLOCK)
        WHERE DataCessao_Ven IS NULL
          AND Status_Ven = 0

        UNION

        SELECT
            Empresa_vrec, Obra_VRec, Num_VRec, Data_VRec, DataCad_Vrec, Status_Vrec,
            Cliente_VRec,
            ValorTot_VRec + Acrescimo_VRec - Desconto_VRec AS ValorTot_VRec
        FROM VendasRecebidas WITH(NOLOCK)
        WHERE DataCessao_Vrec IS NULL
          AND Status_Vrec = 0
    ) AS v

    INNER JOIN Obras o WITH(NOLOCK)
        ON  o.Empresa_obr = v.Empresa_ven
        AND o.cod_obr     = v.Obra_Ven

    INNER JOIN Empresas e WITH(NOLOCK)
        ON  e.Codigo_emp  = o.Empresa_obr

    WHERE
        o.DataLancamento_obr IS NOT NULL
        AND LEFT(v.Obra_Ven, 2) IN ('65', '67', '68', '69')
        AND v.Empresa_ven NOT IN (3, 9, 229, 204, 301, 302, 226)
        AND NOT CONCAT(v.Empresa_Ven, '-', v.Obra_Ven) = '243-69749'

    GROUP BY
        o.cid_obr, v.Empresa_ven, v.Obra_Ven, v.Num_Ven,
        v.Data_Ven, ValorTot_Ven, v.Status_Ven,
        o.descr_obr, e.Desc_emp, v.Cliente_Ven

) AS pc

-- JOIN: Itens da venda
INNER JOIN
(
    SELECT * FROM ItensVenda     WITH(NOLOCK)
    UNION
    SELECT * FROM ItensRecebidas WITH(NOLOCK)
) AS itv
    ON  itv.Empresa_itv = pc.Empresa_ven
    AND itv.Obra_itv    = pc.Obra_Ven
    AND itv.NumVend_Itv = pc.Num_Ven

-- LEFT JOIN: Unidade/Personalização
LEFT JOIN
(
    SELECT Empresa_unid, Obra_unid, Prod_unid, NumPer_unid, identificador_unid
    FROM UnidadePer WITH(NOLOCK)
    WHERE Vendido_unid <> 10
) AS up
    ON  up.Empresa_unid = itv.Empresa_itv
    AND up.Obra_unid    = itv.Obra_itv
    AND up.Prod_unid    = itv.Produto_itv
    AND up.Numper_unid  = itv.CodPerson_itv

-- LEFT JOIN: Nome do Produto
LEFT JOIN PrdSrv AS ps WITH(NOLOCK)
    ON ps.NumProd_psc = up.Prod_unid

-- LEFT JOIN: Cliente
LEFT JOIN Pessoas AS PesCli WITH(NOLOCK)
    ON PesCli.cod_pes = pc.Cliente_Ven

-- LEFT JOIN: Telefone
LEFT JOIN
(
    SELECT
        classificado.pes_tel,
        classificado.NumeroTratado  AS TelefoneFormatado,
        classificado.TipoTel        AS TipoTelefone
    FROM
    (
        SELECT
            base.pes_tel,
            base.NumeroCompleto,
            base.FoneLimpo,
 
            -- Número tratado com regra do 9
            CASE
                -- Celular: 11 dígitos limpos, fone começa com 9
                WHEN LEN(base.NumeroCompleto) = 11
                 AND LEFT(base.FoneLimpo, 1) = '9'
                    THEN base.NumeroCompleto
 
                -- Celular antigo: 10 dígitos limpos, fone começa com 6,7,8,9 → insere 9
                WHEN LEN(base.NumeroCompleto) = 10
                 AND LEFT(base.FoneLimpo, 1) IN ('6','7','8','9')
                    THEN base.DddLimpo + '9' + base.FoneLimpo
 
                -- Fixo: 10 dígitos limpos, fone começa com 2,3,4,5
                WHEN LEN(base.NumeroCompleto) = 10
                 AND LEFT(base.FoneLimpo, 1) IN ('2','3','4','5')
                    THEN base.NumeroCompleto
 
                -- Indefinido: retorna o número limpo mesmo assim
                ELSE base.NumeroCompleto
            END AS NumeroTratado,
 
            -- Classificação do tipo
            CASE
                WHEN LEN(base.NumeroCompleto) = 11
                 AND LEFT(base.FoneLimpo, 1) = '9'
                    THEN 'Celular'
 
                WHEN LEN(base.NumeroCompleto) = 10
                 AND LEFT(base.FoneLimpo, 1) IN ('6','7','8','9')
                    THEN 'Celular (corrigido)'
 
                WHEN LEN(base.NumeroCompleto) = 10
                 AND LEFT(base.FoneLimpo, 1) IN ('2','3','4','5')
                    THEN 'Fixo'
 
                ELSE 'Indefinido'
            END AS TipoTel,
 
            -- Prioridade: Celular=1, Celular corrigido=2, Fixo=3, Indefinido=4
            ROW_NUMBER() OVER (
                PARTITION BY base.pes_tel
                ORDER BY
                    CASE
                        WHEN LEN(base.NumeroCompleto) = 11
                         AND LEFT(base.FoneLimpo, 1) = '9'
                            THEN 1
                        WHEN LEN(base.NumeroCompleto) = 10
                         AND LEFT(base.FoneLimpo, 1) IN ('6','7','8','9')
                            THEN 2
                        WHEN LEN(base.NumeroCompleto) = 10
                         AND LEFT(base.FoneLimpo, 1) IN ('2','3','4','5')
                            THEN 3
                        ELSE 4
                    END
            ) AS prioridade
 
        FROM
        (
            -- ----------------------------------------------------
            -- Limpeza única: remove hífen/espaço/parênteses e
            -- zeros à esquerda (DDD ou fone digitado com 0 extra)
            -- ----------------------------------------------------
            SELECT
                pt.pes_tel,
 
                -- DDD limpo, sem zero(s) à esquerda
                SUBSTRING(
                    REPLACE(REPLACE(REPLACE(REPLACE(
                        LTRIM(RTRIM(pt.ddd_tel)),
                    '-',''),' ',''),'(',''),')',''),
                    PATINDEX('%[1-9]%',
                        REPLACE(REPLACE(REPLACE(REPLACE(
                            LTRIM(RTRIM(pt.ddd_tel)),
                        '-',''),' ',''),'(',''),')','') + '1'),
                    LEN(REPLACE(REPLACE(REPLACE(REPLACE(
                        LTRIM(RTRIM(pt.ddd_tel)),
                    '-',''),' ',''),'(',''),')',''))
                ) AS DddLimpo,
 
                -- Fone limpo, sem zero(s) à esquerda
                SUBSTRING(
                    REPLACE(REPLACE(REPLACE(REPLACE(
                        LTRIM(RTRIM(pt.fone_tel)),
                    '-',''),' ',''),'(',''),')',''),
                    PATINDEX('%[1-9]%',
                        REPLACE(REPLACE(REPLACE(REPLACE(
                            LTRIM(RTRIM(pt.fone_tel)),
                        '-',''),' ',''),'(',''),')','') + '1'),
                    LEN(REPLACE(REPLACE(REPLACE(REPLACE(
                        LTRIM(RTRIM(pt.fone_tel)),
                    '-',''),' ',''),'(',''),')',''))
                ) AS FoneLimpo
 
            FROM PesTel AS pt WITH(NOLOCK)
        ) AS base0
        CROSS APPLY (SELECT base0.pes_tel, base0.DddLimpo, base0.FoneLimpo,
                             base0.DddLimpo + base0.FoneLimpo AS NumeroCompleto) AS base
 
    ) AS classificado
    WHERE classificado.prioridade = 1   -- pega apenas o melhor número por pessoa
 
) AS tel
    ON tel.pes_tel = pc.Cliente_Ven

-- LEFT JOIN: ContasReceber consolidado
LEFT JOIN
(
    SELECT
        cr.Empresa_prc,
        cr.Obra_prc,
        cr.NumVend_prc,
        SUM(IIF(cr.Tipo_Prc = 'P',  1, 0))  AS Qtd_P,
        SUM(IIF(cr.Tipo_Prc = 'S',  1, 0))  AS Qtd_S,
        SUM(IIF(cr.Tipo_Prc = 'SA', 1, 0))  AS Qtd_SA,
        SUM(IIF(cr.Tipo_Prc = 'SN', 1, 0))  AS Qtd_SN,
        SUM(IIF(cr.Tipo_Prc = 'E',  1, 0))  AS Qtd_E,
        SUM(IIF(cr.Tipo_Prc = 'ER', 1, 0))  AS Qtd_ER,
        SUM(IIF(cr.Tipo_Prc = 'AM', 1, 0))  AS Qtd_AM,
        SUM(IIF(cr.Tipo_Prc = 'FC', 1, 0))  AS Qtd_FC,
        SUM(IIF(cr.Tipo_Prc = 'B',  1, 0))  AS Qtd_B,
        SUM(IIF(cr.Tipo_Prc = 'R',  1, 0))  AS Qtd_R,
        SUM(IIF(cr.Tipo_Prc = 'I',  1, 0))  AS Qtd_I,
        SUM(IIF(cr.Tipo_Prc = 'OP', 1, 0))  AS Qtd_OP,
        SUM(crc.ValParcela_crc)                    AS ValorAReceber,
        MAX(CASE WHEN cr.Data_Prc < CAST(GETDATE() AS DATE)
                 THEN 'Inadimplente' END)    AS StatusContasReceber,
        DATEDIFF(DAY,
            MIN(CASE WHEN cr.Data_Prc < CAST(GETDATE() AS DATE)
                     THEN cr.Data_Prc END),
            CAST(GETDATE() AS DATE)
        )                                    AS DiasAtraso,
        SUM(CASE WHEN cr.Data_Prc < CAST(GETDATE() AS DATE)
                      AND crc.ValParcela_crc IS NOT NULL
                 THEN crc.ValParcela_crc
                 ELSE 0 END)                 AS ValorInadimplente
    FROM ContasReceber cr WITH(NOLOCK)
    LEFT JOIN ContasReceberCalc crc WITH(NOLOCK)
        ON  crc.Empresa_crc    = cr.Empresa_prc
        AND crc.Obra_crc       = cr.Obra_Prc
        AND crc.NumVend_crc    = cr.NumVend_prc
        AND crc.NumParc_crc    = cr.NumParc_Prc
        AND crc.NumParcGer_crc = cr.NumParcGer_Prc
        AND crc.Tipo_crc       = cr.Tipo_Prc
    WHERE cr.Tipo_Prc <> '1'
    GROUP BY cr.Empresa_prc, cr.Obra_prc, cr.NumVend_prc
) AS crConsolidado
    ON  crConsolidado.Empresa_prc = pc.Empresa_ven
    AND crConsolidado.Obra_prc    = pc.Obra_Ven
    AND crConsolidado.NumVend_prc = pc.Num_Ven

--  LEFT JOIN: Valor recebido desde 01/05/2026
LEFT JOIN
(
    SELECT
        r.Empresa_rec,
        r.Obra_rec,
        r.NumVend_rec,
        SUM((
              r.ValorConf_Rec
            + r.VlJurosParcConf_Rec
            + r.VlCorrecaoConf_Rec
            + r.VlAcresConf_Rec
            + r.VlTaxaBolConf_Rec
            + r.VlMultaConf_Rec
            + r.VlJurosConf_Rec
            + r.VlCorrecaoAtrConf_Rec
        ) - (
              r.VlDescontoConf_Rec
            + r.ValDescontoCustaConf_Rec
            + r.ValDescontoImpostoConf_Rec
            + r.ValDescontoCondicionalConf_rec
        ))                              AS ValorRec,
        MAX(r.Data_Rec)                 AS DataUltimoRecebimento
    FROM Recebidas r WITH(NOLOCK)
    WHERE CAST(r.Data_Rec AS DATE) >= '2026-05-01'
      AND r.Tipo_rec <> '1'
    GROUP BY r.Empresa_rec, r.Obra_rec, r.NumVend_rec
) AS recTotais
    ON  recTotais.Empresa_rec = pc.Empresa_ven
    AND recTotais.Obra_rec    = pc.Obra_Ven
    AND recTotais.NumVend_rec = pc.Num_Ven

--  LEFT JOIN: Inadimplência no mês do pagamento — separado para evitar erro de agregação
LEFT JOIN
(
    SELECT DISTINCT
        r.Empresa_rec,
        r.Obra_rec,
        r.NumVend_rec,
        1 AS EraInadimplenteMesPagamento
    FROM Recebidas r WITH(NOLOCK)
    INNER JOIN ContasReceber cr WITH(NOLOCK)
        ON  cr.Empresa_prc = r.Empresa_rec
        AND cr.Obra_Prc    = r.Obra_rec
        AND cr.NumVend_prc = r.NumVend_rec
        AND cr.Tipo_Prc   <> '1'
        -- havia parcela vencida antes do 1º dia do mês em que o pagamento ocorreu
        AND cr.Data_Prc    < DATEFROMPARTS(YEAR(r.Data_Rec), MONTH(r.Data_Rec), 1)
    WHERE CAST(r.Data_Rec AS DATE) >= '01/07/2026'
      AND r.Tipo_rec <> '1'
) AS inadimMesPag
    ON  inadimMesPag.Empresa_rec = pc.Empresa_ven
    AND inadimMesPag.Obra_rec    = pc.Obra_Ven
    AND inadimMesPag.NumVend_rec = pc.Num_Ven

WHERE pc.Status_Ven = 0 
ORDER BY pc.Cidade;
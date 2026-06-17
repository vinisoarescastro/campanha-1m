# Mapeamento de Campos — Campanha 5 Casas e 1 Milhão

> De-para entre os conceitos do regulamento de negócio e os campos/tabelas do banco de dados SQL Server.

---

## Conceitos do Regulamento × Campos do Banco

| Conceito (Negócio) | Tabela | Campo(s) | Observação |
|---|---|---|---|
| Venda ativa | `Vendas` | `Status_Ven = 0` | Status 0 = Normal |
| Venda quitada | `VendasRecebidas` | `Status_Vrec = 0` | Status 3 = Quitada — tabela espelho de `Vendas` |
| Venda com cessão de direito | `Vendas` / `VendasRecebidas` | `DataCessao_Ven IS NOT NULL` / `DataCessao_Vrec IS NOT NULL` | Excluir da base elegível |
| Venda cancelada | `Vendas` / `VendasRecebidas` | `Status_Ven <> 0` / `Status_Vrec <> 0` | Excluir da base elegível |
| Valor total do contrato | `Vendas` | `ValorTot_Ven + Acrescimo_Ven - Desconto_Ven` | Calculado, não armazenado diretamente |
| Empreendimento | `Obras` | `cod_obr`, `descr_obr`, `cid_obr` | JOIN via `Empresa_obr + cod_obr` |
| Empresa | `Empresas` | `Codigo_emp`, `Desc_emp` | JOIN via `Codigo_emp = Empresa_obr` |
| Cliente (titular) | `Pessoas` | `cod_pes`, `nome_pes`, `cpf_pes`, `Email_pes` | JOIN via `cod_pes = Cliente_Ven` |
| Telefone do cliente | `PesTel` | `pes_tel`, `ddd_tel`, `fone_tel` | JOIN via `pes_tel = Cliente_Ven` — múltiplos registros por pessoa |
| Produto (lote/unidade) | `PrdSrv` | `NumProd_psc`, `Descricao_psc` | JOIN via `UnidadePer → ItensVenda` |
| Recebimento no mês | `Recebidas` | `Data_Rec`, campos `*Conf_Rec` | Filtrar por período e excluir `ParcType_Rec = '1'` |
| Custas (exclusão) | `Recebidas` / `ContasReceber` | `ParcType_Rec = '1'` / `Tipo_Prc = '1'` | Excluir do cálculo de cupons |
| Valor efetivamente recebido | `Recebidas` | Ver DT-004 em `decisoes_tecnicas.md` | Soma de componentes confirmados menos descontos |
| Parcela inadimplente | `ContasReceber` | `Data_Prc < CAST(GETDATE() AS DATE)` | Parcela vencida sem recebimento |
| Cupons gerados | Calculado | `FLOOR(ValorRec / 100)` | 1 cupom por R$ 100 completos |

---

## Filtros de Escopo da Campanha

> Filtros aplicados na consulta `sql/exploracao/01_base_elegivel_campanha.sql`, confirmados para a campanha atual.

| Filtro | Campo | Valor | Observação |
|---|---|---|---|
| Prefixo de obra | `LEFT(Obra_Ven, 2)` | `IN ('65','67','68','69')` | Faixas de códigos dos empreendimentos elegíveis |
| Empresas excluídas | `Empresa_ven` | `NOT IN (3, 9, 229, 204, 301, 302, 226)` | Empresas fora do escopo da campanha |
| Obra excluída pontualmente | `CONCAT(Empresa_Ven, '-', Obra_Ven)` | `<> '243-69749'` | Exceção pontual de obra específica |
| Empreendimentos lançados | `DataLancamento_obr` | `IS NOT NULL` | Garante que apenas obras já lançadas participam |
| Período de recebimento | `CAST(r.Data_Rec AS DATE)` | `>= '2026-05-01'` | Data de corte dos recebimentos elegíveis |
| Exclusão de custas (recebimentos) | `r.ParcType_Rec` | `<> '1'` | Remove custas do cálculo de cupons |
| Exclusão de custas (contas a receber) | `cr.Tipo_Prc` | `<> '1'` | Remove custas da verificação de inadimplência |
| Venda ativa | `Status_Ven` / `Status_Vrec` | `= 0` | Exclui canceladas e alteradas |
| Sem cessão de direito | `DataCessao_Ven` / `DataCessao_Vrec` | `IS NULL` | Exclui contratos cedidos a terceiros |

---

## Joins Principais

```
Vendas / VendasRecebidas (UNION, alias: pc)
  └─► INNER JOIN Obras o          ON o.Empresa_obr = pc.Empresa_ven
                                  AND o.cod_obr     = pc.Obra_Ven
        └─► INNER JOIN Empresas e ON e.Codigo_emp   = o.Empresa_obr
  └─► INNER JOIN ItensVenda / ItensRecebidas (UNION, alias: itv)
                                     ON itv.Empresa_itv = pc.Empresa_ven
                                    AND itv.Obra_itv    = pc.Obra_Ven
                                    AND itv.NumVend_Itv = pc.Num_Ven
        └─► LEFT JOIN UnidadePer up  ON up.Empresa_unid = itv.Empresa_itv
                                    AND up.Obra_unid    = itv.Obra_itv
                                    AND up.Prod_unid    = itv.Produto_itv
                                    AND up.Numper_unid  = itv.CodPerson_itv
                                    WHERE Vendido_unid <> 10
              └─► LEFT JOIN PrdSrv ps ON ps.NumProd_psc = up.Prod_unid
  └─► LEFT JOIN Pessoas PesCli        ON PesCli.cod_pes = pc.Cliente_Ven
  └─► LEFT JOIN PesTel tel            ON tel.pes_tel    = pc.Cliente_Ven
        (pivotado: seq 1 → Telefone1, seq 2 → Telefone2 via ROW_NUMBER)
  └─► LEFT JOIN ContasReceber cr      ON Empresa + Obra + NumVend
        WHERE cr.Tipo_Prc <> '1'
        └─► LEFT JOIN ContasReceberCalc crc ON Empresa + Obra + NumVend
                                            + NumParc + NumParcGer + Tipo (5 campos)
  └─► LEFT JOIN Recebidas r (recTotais)     ON Empresa + Obra + NumVend
        WHERE Data_Rec >= '2026-05-01' AND ParcType_Rec <> '1'
  └─► LEFT JOIN Recebidas r + ContasReceber cr (inadimMesPag)
        ON Empresa + Obra + NumVend
        (detecta se havia parcela vencida antes do 1º dia do mês do pagamento)
```

## Colunas Retornadas

| Coluna | Origem | Lógica |
|---|---|---|
| `Cidade` | `Obras.cid_obr` | `UPPER(cid_obr)` |
| `CodEmpresa` | `Vendas.Empresa_ven` | Direto |
| `CodObra` | `Vendas.Obra_Ven` | Direto |
| `Produto` | `PrdSrv.Descricao_psc` | Via `UnidadePer → ItensVenda` |
| `Venda` | `Vendas.Num_Ven` | Direto |
| `Dt.Venda` | `Vendas.Data_Ven` | `FORMAT('dd/MM/yyyy')` |
| `VlrVenda` | Calculado | `ValorTot_Ven + Acrescimo_Ven - Desconto_Ven` |
| `NomeCliente` | `Pessoas.Nome_pes` | `UPPER(Nome_pes)` |
| `cpf_pes` | `Pessoas.cpf_pes` | Direto |
| `EmailCliente` | `Pessoas.Email_pes` | `LOWER(Email_pes)` |
| `ContatoCliente` | `PesTel` | `ISNULL(Telefone2, Telefone1)` — prioriza 2º telefone |
| `StatuVenda` | `ContasReceber` | `'Inadimplente'` se qualquer parcela vencida |
| `Qtd Parcelas … Qtd Operacao XPI` | `ContasReceber` | `SUM(IIF(Tipo_Prc = X, 1, 0))` por tipo |
| `Valor a Receber` | `ContasReceber.Valor_Prc` | `SUM(Valor_Prc)` |
| `Valor Inadimplência` | `ContasReceberCalc.ValParcelaAntec_crc` | Soma das parcelas vencidas com valor calculado |
| `Valor Recebido` | `Recebidas` | Soma líquida de todos os componentes confirmados menos descontos |
| `Data Último Recebimento` | `Recebidas.Data_Rec` | `MAX(Data_Rec)` |
| `Cupons Gerados` | Calculado | `FLOOR(ValorRec / 100)` |
| `Inadimplente no Mês Pago` | `inadimMesPag` | `'Sim'` se `EraInadimplenteMesPagamento = 1` |
| `Status Sorteio` | Calculado | `'APTO'` / `'Não Apto/Sem pagamento'` / `'Não Apto/Inadimplente no mês do pagamento'` |

---

*Atualizar este arquivo conforme novas tabelas ou campos forem identificados.*

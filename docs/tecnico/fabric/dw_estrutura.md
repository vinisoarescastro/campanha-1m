# Data Warehouse — Estrutura no Microsoft Fabric

> Documentação da infraestrutura de dados criada no Microsoft Fabric para suporte à Campanha 5 Casas e 1 Milhão.

---

## Visão Geral

| Item | Valor |
|---|---|
| Plataforma | Microsoft Fabric |
| Workspace | FB_Comercial |
| Artefato | `dw_campanha_1m` (Warehouse) |
| Criado em | 2026-06-18 |
| Responsável | Área de Dados |

---

## Arquitetura Adotada

A solução segue o padrão de **arquitetura medallion** simplificada:

```
Banco de Origem (SQL Server — BURITI-BD-02 / UAU)
        │
        ▼
  Dataflow Gen2  ──► Warehouse (dbo) ──► Power BI
  (query SQL)         bronze_*
```

- A camada **bronze** recebe o resultado bruto da query diretamente do banco de origem.
- Não há transformações aplicadas no Dataflow — o dado chega como a query retorna.
- O Power BI conecta diretamente ao Warehouse via SQL endpoint.

---

## Tabelas Existentes

| Schema | Tabela | Origem | Descrição |
|---|---|---|---|
| `dbo` | `bronze_query_base_elegivel_campanha` | `BURITI-BD-02 / UAU` | Base de vendas elegíveis com situação financeira e status de sorteio, resultado da query `sql/exploracao/01_base_elegivel_campanha.sql` |

---

## Conexão SQL

O Warehouse expõe um **SQL endpoint** que pode ser acessado via:

- Editor SQL nativo do Fabric
- SSMS / Azure Data Studio (usando a connection string do workspace)
- Power BI Desktop (modo DirectQuery ou Import)

---

## Observações Técnicas

- O Warehouse foi criado manualmente no workspace `FB_Comercial` via interface do Fabric.
- A ingestão é realizada via **Dataflow Gen2**, ver `df_bronze_vw_campanha_1m.md`.
- Foi tentada inicialmente a ingestão via **Copy Activity** (pipeline), porém com erros, ver `pipeline_copy.md`.
- As tabelas `bronze_*` são recriadas a cada execução do Dataflow (Full copy). Não há controle incremental neste momento.

---

## Próximos Passos Sugeridos

- [ ] Avaliar criação de camada `gold` com views consolidadas para consumo no Power BI
- [ ] Definir recorrência de atualização do Dataflow (agendamento)
- [ ] Avaliar controle incremental caso o volume de dados cresça significativamente
# Dataflow Gen2 — Ingestão Base Elegível Campanha

> Documentação da configuração do Dataflow Gen2 responsável por ingerir a base de vendas elegíveis do banco de origem para o Warehouse no Microsoft Fabric.

---

## Identificação

| Item | Valor |
|---|---|
| Artefato | Dataflow Gen2 |
| Workspace | FB_Comercial |
| Nome sugerido | `DF_Base_Elegivel_Campanha` |
| Criado em | 2026-06-18 |
| Responsável | Área de Dados |

---

## Configuração da Fonte

| Parâmetro | Valor |
|---|---|
| Tipo de conector | SQL Server database |
| Servidor | `BURITI-BD-02` |
| Banco de dados | `UAU` |
| Gateway | `[On-premises] GW_POWERBI_SERVER` |
| Autenticação | Windows (`dominio\usuario`) |
| Modo de leitura | Full copy |
| SQL Statement | Ver `sql/exploracao/01_base_elegivel_campanha.sql` |

> **Nota:** O campo *Command timeout in minutes* foi deixado em branco (usa o timeout padrão do sistema).

---

## Configuração do Destino

| Parâmetro | Valor |
|---|---|
| Tipo | Microsoft Fabric Warehouse |
| Workspace | FB_Comercial |
| Warehouse | `dw_campanha_1m` |
| Schema | `dbo` |
| Tabela | `bronze_query_base_elegivel_campanha` |
| Modo de escrita | New table (recria a cada execução) |

---

## Query Utilizada

A query configurada no campo *SQL Statement* do Dataflow é a mesma consulta oficial da campanha, mantida e versionada em:

```
sql/exploracao/01_base_elegivel_campanha.sql
```

Ela retorna as seguintes colunas principais:

| Coluna | Tipo | Descrição |
|---|---|---|
| `Cidade` | texto | Cidade do empreendimento |
| `CodEmpresa` | inteiro | Código da empresa |
| `CodObra` | texto | Código da obra |
| `Produto` | texto | Descrição do produto (lote/unidade) |
| `Venda` | inteiro | Número da venda |
| `Dt.Venda` | texto | Data da venda formatada |
| `VlrVenda` | texto | Valor total da venda formatado |
| `NomeCliente` | texto | Nome do cliente em maiúsculas |
| `cpf_pes` | texto | CPF do cliente |
| `EmailCliente` | texto | E-mail do cliente |
| `ContatoCliente` | texto | Telefone de contato |
| `StatuVenda` | texto | `Adimplente` ou `Inadimplente` |
| `Qtd Parcelas` … `Qtd Operacao XPI` | inteiro | Quantidade por tipo de parcela |
| `Valor a Receber` | texto | Saldo a receber formatado |
| `Valor Inadimplência` | texto | Valor em atraso formatado |
| `Valor Recebido` | texto | Total recebido no período formatado |
| `Data Último Recebimento` | texto | Data do último pagamento |
| `Cupons Gerados` | inteiro | `FLOOR(ValorRec / 100)` |
| `Inadimplente no Mês Pago` | texto | `Sim` ou `Não` |
| `Status Sorteio` | texto | `APTO`, `Não Apto/Sem pagamento` ou `Não Apto/Inadimplente no mês do pagamento` |

---

## Fluxo de Execução

```
1. Dataflow conecta ao BURITI-BD-02/UAU via GW_POWERBI_SERVER
2. Executa a query de 01_base_elegivel_campanha.sql
3. Retorna o resultado como tabela no Power Query
4. Carrega os dados na tabela dbo.bronze_query_base_elegivel_campanha do Warehouse
5. Recria a tabela a cada execução (Full copy)
```

---

## Agendamento

> A definir. O Dataflow pode ser agendado via opção *Schedule* no workspace do Fabric.

Recomendação: executar manualmente antes de cada sorteio, seguindo o checklist em `pipelines/pipeline_sorteio_mensal.md`.

---

## Observações

- A tabela de destino é **recriada a cada execução** — não há acumulação de histórico nessa tabela.
- O schema de colunas é inferido automaticamente pelo Dataflow a partir do resultado da query.
- A coluna `Status Sorteio` retorna textos longos (ex.: `'Não Apto/Inadimplente no mês do pagamento'`) — o Dataflow lida com isso sem truncamento, ao contrário da Copy Activity.
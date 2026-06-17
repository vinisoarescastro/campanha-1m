# sql/views

Views criadas no banco de dados SQL Server para centralizar lógicas reutilizadas em múltiplas consultas da campanha.

## Views Previstas

| Arquivo (a criar) | Descrição |
|---|---|
| `vw_vendas_ativas.sql` | UNION de `Vendas` + `VendasRecebidas` filtrando apenas contratos ativos e sem cessão |
| `vw_itens_venda.sql` | UNION de `ItensVenda` + `ItensRecebidas` |
| `vw_recebimentos_campanha.sql` | Recebimentos do período jul–dez/2025, excluindo custas (Tipo 1) |
| `vw_inadimplencia_atual.sql` | Situação atual de inadimplência por venda |

## Convenção de Nomenclatura

```
vw_<descricao>.sql
```

# sql/validacoes

Consultas de auditoria e testes de consistência, devem ser executadas antes de cada sorteio para garantir a integridade dos dados.

## Validações Previstas

| Arquivo (a criar) | Validação |
|---|---|
| `val_01_total_cupons_por_mes.sql` | Confere o volume total de cupons gerados contra expectativa de negócio |
| `val_02_clientes_sem_cupom.sql` | Identifica clientes com valor ≥ R$ 100 que não geraram cupons |
| `val_03_cupons_por_custas.sql` | Verifica se a exclusão de custas (Tipo 1) está sendo aplicada corretamente |
| `val_04_vendas_canceladas.sql` | Identifica vendas canceladas que possuem cupons gerados |
| `val_05_recebimentos_fora_periodo.sql` | Garante que apenas o período jul–dez/2025 está sendo considerado |
| `val_06_ganhadores_mensais.sql` | Confirma que ganhadores de casas estão excluídos dos sorteios subsequentes |
| `val_07_inadimplentes_vs_aptos.sql` | Separa corretamente participantes válidos dos bloqueados por inadimplência |

## Convenção de Nomenclatura

```
val_<nn>_<descricao>.sql
```

# Pipeline Operacional — Sorteio Mensal

> Checklist passo a passo para executar o fechamento de cada sorteio mensal da Campanha 5 Casas e 1 Milhão.
> Executar na ordem indicada. Marcar cada etapa com data e responsável ao concluir.

---

## Informações do Sorteio

| Campo | Valor |
|---|---|
| Mês de referência | _ex.: Julho/2025_ |
| Data de fechamento | _ex.: 31/07/2025_ |
| Data do sorteio | _ex.: 15/08/2025_ |
| Responsável pela execução | _nome_ |
| Revisado por | _nome_ |

---

## Etapa 1 — Preparação (D-3 antes do sorteio)

- [ ] Confirmar com a área de negócio se houve alguma alteração de regra desde o último sorteio
- [ ] Verificar se há novos ganhadores mensais a registrar em `data/reference/ganhadores_mensais.csv`
- [ ] Confirmar a lista de empreendimentos e empresas elegíveis (comparar com `data/reference/empreendimentos_elegiveis.csv`)
- [ ] Validar acesso ao banco de dados SQL Server

---

## Etapa 2 — Extração da Base (D-2)

- [ ] Executar `sql/exploracao/01_base_elegivel_campanha.sql` com o período correto
- [ ] Conferir contagem de linhas retornadas — registrar total de vendas na tabela de controle abaixo
- [ ] Exportar resultado para `data/raw/base_elegivel_<AAAAMM>.csv` (não versionar)

---

## Etapa 3 — Cálculo de Cupons (D-2)

- [ ] Executar script de cálculo de cupons (`sql/relatorios/rel_0X_cupons_sorteio_<mes><ano>.sql`)
- [ ] Conferir que recebimentos estão restritos ao mês de referência (`Data_Rec >= '...' AND Data_Rec < '...'`)
- [ ] Confirmar que custas (`ParcType_Rec = '1'`) foram excluídas
- [ ] Registrar total de cupons gerados na tabela de controle abaixo

---

## Etapa 4 — Validações de Auditoria (D-1)

Executar todas as queries de `sql/validacoes/` e registrar os resultados:

| Validação | Resultado Esperado | Resultado Obtido | OK? |
|---|---|---|---|
| `val_01_total_cupons_por_mes.sql` | Alinhado com estimativa de negócio | | ☐ |
| `val_02_clientes_sem_cupom.sql` | Zero clientes com ≥ R$100 sem cupom | | ☐ |
| `val_03_cupons_por_custas.sql` | Zero cupons gerados por custas | | ☐ |
| `val_04_vendas_canceladas.sql` | Zero vendas canceladas com cupons | | ☐ |
| `val_05_recebimentos_fora_periodo.sql` | Zero recebimentos fora de jul–dez/2025 | | ☐ |
| `val_06_ganhadores_mensais.sql` | Ganhadores anteriores ausentes da lista | | ☐ |
| `val_07_inadimplentes_vs_aptos.sql` | Segregação correta | | ☐ |

> Se qualquer validação falhar, **não avançar para a Etapa 5**. Investigar e corrigir antes.

---

## Etapa 5 — Geração da Lista Final (D-1)

- [ ] Executar relatório final com apenas clientes com `Status Sorteio = 'APTO'`
- [ ] Conferir que nenhum ganhador de sorteio anterior (de casas) está na lista
- [ ] Exportar lista final para `data/processed/lista_sorteio_<AAAAMM>.csv` (não versionar)
- [ ] Exportar resumo gerencial para `data/processed/resumo_sorteio_<AAAAMM>.xlsx` (não versionar)

---

## Etapa 6 — Revisão e Entrega (D)

- [ ] Segunda pessoa revisar a lista final (quatro olhos)
- [ ] Encaminhar lista para a área responsável pelo sorteio
- [ ] Documentar resultado em `docs/resultados/sorteio_<NN>_<mes><ano>.md`
- [ ] Registrar no `CHANGELOG.md`

---

## Etapa 7 — Pós-Sorteio

- [ ] Registrar nome e CPF do ganhador em `data/reference/ganhadores_mensais.csv`
- [ ] Verificar se o ganhador precisa ser excluído do próximo sorteio de casas
- [ ] Arquivar os arquivos de `data/raw/` e `data/processed/` deste sorteio em local seguro (fora do repositório)

---

## Tabela de Controle por Sorteio

| Sorteio | Mês Ref. | Total Vendas | Total Cupons | Clientes Aptos | Clientes Bloqueados | Executado por | Data |
|---|---|---|---|---|---|---|---|
| Sorteio 01 | Jul/2025 | | | | | | |
| Sorteio 02 | Ago/2025 | | | | | | |
| Sorteio 03 | Set/2025 | | | | | | |
| Sorteio 04 | Out/2025 | | | | | | |
| Sorteio 05 | Nov/2025 | | | | | | |
| Sorteio Final | Jul–Dez/2025 | | | | | | |

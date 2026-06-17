# Requisitos de Negócio — Campanha 5 Casas e 1 Milhão

> Registro das perguntas em aberto, decisões confirmadas e pontos de atenção levantados durante o desenvolvimento da análise.

---

## Decisões Confirmadas

| # | Decisão | Status |
|---|---|---|
| 1 | Fórmula de cupons: `FLOOR(total_recebido / 100)` — 1 cupom por R$ 100 completos | ✅ Confirmado |
| 2 | Período da campanha: julho a dezembro/2025 | ✅ Confirmado |
| 3 | Exclusão de custas: `ParcType_Rec = '1'` (Recebidas) e `Tipo_Prc = '1'` (ContasReceber) | ✅ Confirmado |
| 4 | Cliente inadimplente gera cupom, mas não participa do sorteio | ✅ Confirmado |
| 5 | Ganhador de casa é excluído dos sorteios mensais seguintes, mas mantém cupons para o sorteio final | ✅ Confirmado |
| 6 | Agrupamento por Empresa + Obra + Venda, CPF como chave do cliente | ✅ Confirmado |
| 7 | Sem transporte de sobras entre meses — cálculo fechado mensalmente | ✅ Confirmado |
| 8 | Empreendimentos elegíveis: obras cujo `LEFT(Obra_Ven, 2) IN ('65','67','68','69')` | ✅ Confirmado |
| 9 | Empresas excluídas: `Empresa_ven NOT IN (3, 9, 229, 204, 301, 302, 226)` | ✅ Confirmado |
| 10 | Obra excluída pontualmente: empresa `243`, obra `69749` | ✅ Confirmado |
| 11 | Apenas empreendimentos com `DataLancamento_obr IS NOT NULL` participam | ✅ Confirmado |
| 12 | Data de corte dos recebimentos elegíveis: `>= '2026-05-01'` | ✅ Confirmado |
| 13 | Vendas com cessão de direito (`DataCessao IS NOT NULL`) são excluídas integralmente | ✅ Confirmado |

---

## Perguntas em Aberto

| # | Pergunta | Impacto | Status |
|---|---|---|---|
| 1 | ~~Quais empreendimentos e empresas estão incluídos na campanha?~~ | — | ✅ Resolvido — ver Decisões #8, #9, #10 |
| 2 | ~~Qual é o campo/condição exata que identifica "custas" no banco?~~ | — | ✅ Resolvido — ver Decisão #3 |
| 3 | Como controlar a exclusão dos ganhadores mensais dos sorteios subsequentes? Há tabela nativa no sistema? | Médio — precisa de processo ou tabela auxiliar | ⏳ Pendente |
| 4 | Em vendas com mais de um comprador (sócios), o CPF de qual titular deve ser usado? | Médio — afeta unicidade de clientes | ⏳ Pendente |
| 5 | O cálculo de inadimplência usa `Data_Prc < hoje` — há regra de carência a considerar para este projeto? | Médio — afeta quem é bloqueado no sorteio | ⏳ Pendente |
| 6 | ~~Vendas com cessão de direito devem ser excluídas integralmente?~~ | — | ✅ Resolvido — ver Decisão #13 |

---

## Principais Perguntas de Negócio

1. Quais clientes possuem cupons e quantos cada um acumulou por mês?
2. Quantos cupons foram gerados no total e por mês da campanha?
3. Quais vendas/contratos geraram cupons e com base em quais recebimentos?
4. Quais clientes estão elegíveis para participar do sorteio (adimplentes) em cada mês?
5. Quais clientes têm cupons mas estão inadimplentes no fechamento do período?
6. Há clientes que deveriam ter cupom mas não têm (falhas de cálculo)?
7. Há cupons gerados incorretamente (com base em custas, datas fora do período, vendas canceladas)?
8. Qual o volume financeiro recebido por empreendimento e cidade por mês?
9. Quais clientes regularizaram inadimplência durante a campanha?
10. Ganhadores mensais estão corretamente excluídos dos sorteios seguintes de casas?

---

## Pontos de Atenção

- A **consulta `sql/exploracao/01_base_elegivel_campanha.sql`** é a consulta oficial da campanha atual, com todos os filtros de escopo já confirmados.
- A **tabela de cadastro de clientes** (CPF, nome, telefone) já está documentada no dicionário de dados (`Pessoas` e `PesTel`), mas os campos de join precisam ser validados em ambiente de produção.
- O controle de **ganhadores mensais** precisará de tabela ou processo específico, pois não há estrutura nativa para isso no sistema atual. Sugestão: manter em `data/reference/ganhadores_mensais.csv`.

---

*Atualizar este arquivo após cada reunião com a área de negócio.*

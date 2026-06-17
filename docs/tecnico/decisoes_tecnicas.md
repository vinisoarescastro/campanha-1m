# Decisões Técnicas — Campanha 5 Casas e 1 Milhão

> Registro das decisões de implementação tomadas durante o desenvolvimento das consultas SQL. Serve como auditoria técnica e evita retrabalho em revisões futuras.

---

## Formato

Cada decisão segue o padrão:

- **Contexto:** por que o problema surgiu
- **Decisão:** o que foi escolhido
- **Justificativa:** por que essa opção foi escolhida
- **Alternativas descartadas:** o que foi considerado e rejeitado
- **Status:** Confirmado / Pendente confirmação / Revisado

---

## DT-001 — UNION entre Vendas e VendasRecebidas

**Contexto:** O sistema separa contratos ativos (`Vendas`) de contratos quitados (`VendasRecebidas`, `Status = 3`). Clientes com contratos quitados durante a campanha ainda devem gerar cupons pelos pagamentos realizados.

**Decisão:** Usar `UNION` entre `Vendas` e `VendasRecebidas` na subquery base, aplicando os mesmos filtros de status e cessão em ambas.

**Justificativa:** Garante que clientes que quitaram o contrato no período jul–dez/2025 não sejam excluídos da base elegível.

**Alternativas descartadas:** Usar apenas `Vendas` excluiria contratos quitados durante a campanha.

**Status:** ✅ Confirmado (decisão técnica independente de negócio)

---

## DT-002 — Exclusão de Vendas com Cessão de Direito

**Contexto:** Uma venda com cessão de direito (`DataCessao IS NOT NULL`) representa uma transferência do contrato para outro comprador. O titular original não é mais o responsável financeiro.

**Decisão:** Excluir todas as vendas com `DataCessao_Ven IS NOT NULL` (Vendas) e `DataCessao_Vrec IS NOT NULL` (VendasRecebidas).

**Justificativa:** Evita que o cedente (ex-titular) gere cupons por pagamentos realizados pelo cessionário (novo titular).

**Alternativas descartadas:** Incluir a venda original e filtrar apenas os recebimentos pós-cessão — complexidade alta sem ganho proporcional.

**Status:** ✅ Confirmado (decisão técnica, aguarda validação de negócio para casos de borda)

---

## DT-003 — Exclusão de Custas pelo Campo ParcType_Rec / Tipo_Prc

**Contexto:** O regulamento exclui "custas" do cálculo de cupons. No banco, custas são identificadas pelo tipo da parcela.

**Decisão:** Filtrar `ParcType_Rec <> '1'` na tabela `Recebidas` e `Tipo_Prc <> '1'` na tabela `ContasReceber`.

**Justificativa:** Padrão identificado na consulta de referência técnica da campanha anterior. O valor `'1'` corresponde ao tipo "Custas" no sistema.

**Alternativas descartadas:** N/A.

**Status:** ⏳ Pendente confirmação com área de negócio (ver requisito aberto #2 em `docs/negocio/requisitos.md`)

---

## DT-004 — Cálculo do Valor Recebido Líquido

**Contexto:** O regulamento determina que o cupom é calculado sobre o valor **efetivamente recebido**, não o valor original da parcela. Descontos reduzem a base.

**Decisão:** Calcular o valor líquido como:

```sql
(ValorConf_Rec + VlJurosParcConf_Rec + VlCorrecaoConf_Rec + VlAcresConf_Rec
 + VlTaxaBolConf_Rec + VlMultaConf_Rec + VlJurosConf_Rec + VlCorrecaoAtrConf_Rec)
-
(VlDescontoConf_Rec + ValDescontoCustaConf_Rec + ValDescontoImpostoConf_Rec
 + ValDescontoCondicionalConf_rec)
```

**Justificativa:** Soma todos os componentes confirmados de entrada e subtrai todos os descontos confirmados, refletindo o montante real recebido.

**Alternativas descartadas:** Usar apenas `ValorConf_Rec` ignoraria juros, multas e correções, que segundo o regulamento também contam para a base de cupons.

**Status:** ✅ Confirmado

---

## DT-005 — Diagnóstico de Inadimplência no Mês do Pagamento

**Contexto:** O regulamento bloqueia clientes inadimplentes de participar do sorteio. A regra precisa ser avaliada **no mês em que o pagamento ocorreu**, não apenas no fechamento.

**Decisão:** Usar uma subquery separada (`inadimMesPag`) que verifica, para cada recebimento, se havia alguma parcela vencida antes do primeiro dia do mês daquele recebimento:

```sql
AND cr.Data_Prc < DATEFROMPARTS(YEAR(r.Data_Rec), MONTH(r.Data_Rec), 1)
```

**Justificativa:** Evitar erro de agregação ao misturar diagnóstico de inadimplência com cálculo de valores na mesma subquery. A separação em subquery distinta mantém a lógica clara e auditável.

**Alternativas descartadas:** Calcular tudo em uma única subquery — causava conflito de agregação entre `SUM()` e `DISTINCT`.

**Status:** ✅ Confirmado

---

## DT-006 — Uso de WITH(NOLOCK)

**Contexto:** As consultas leem tabelas transacionais do sistema ERP em produção.

**Decisão:** Usar `WITH(NOLOCK)` em todas as leituras.

**Justificativa:** Evita bloqueios de leitura em tabelas com alta movimentação transacional, reduzindo impacto nas operações do sistema.

**Alternativas descartadas:** Leitura sem hint — risco de timeout ou bloqueio em horário de pico.

**Status:** ✅ Confirmado (padrão do ambiente SQL Server da Brasil Terrenos)

---

*Adicionar nova entrada a cada decisão relevante tomada. Usar formato DT-NNN sequencial.*

# Changelog — Campanha 5 Casas e 1 Milhão

> Registro cronológico de marcos, entregas, decisões relevantes e problemas encontrados.
> Formato: `[Versão/Marco] — AAAA-MM-DD`

---

## [Estruturação Inicial] — 2026-06-17

### Adicionado
- `README.md` principal com objetivo, regras da campanha, abordagem técnica e próximos passos
- `docs/negocio/regulamento_campanha.md` — regulamento expandido da campanha
- `docs/negocio/requisitos.md` — perguntas em aberto, decisões confirmadas e pontos de atenção
- `docs/tecnico/dicionario_de_dados.md` — dicionário completo de 16 tabelas do sistema ERP
- `docs/tecnico/decisoes_tecnicas.md` — registro de 6 decisões técnicas tomadas (DT-001 a DT-006)
- `docs/tecnico/mapeamento_campos.md` — de-para entre conceitos de negócio e campos do banco
- `docs/resultados/` — pasta reservada para registros dos sorteios
- `sql/exploracao/01_base_elegivel_campanha.sql` — consulta de referência técnica (campanha anterior)
- `sql/exploracao/README.md`, `sql/validacoes/README.md`, `sql/relatorios/README.md`, `sql/views/README.md`
- `data/raw/`, `data/processed/`, `data/reference/` — estrutura de dados com `.gitkeep`
- `pipelines/pipeline_sorteio_mensal.md` — checklist operacional completo para cada sorteio
- `.gitignore` — proteção contra versionamento acidental de dados sensíveis

### Contexto
Repositório criado para suportar a análise de dados da Campanha 5 Casas e 1 Milhão (jul–dez/2025).
Estrutura inicial definida com base nas melhores práticas de projetos de dados analíticos.

---

## Próximos Marcos Esperados

| Marco | Descrição | Data Prevista |
|---|---|---|
| Base elegível v1 | Primeira versão da query de base elegível validada com área de negócio | A definir |
| Cálculo de cupons v1 | Script de cálculo de cupons testado e validado | A definir |
| Sorteio 01 | Fechamento e entrega da lista para o sorteio de agosto/2025 | 15/08/2025 |
| Sorteio 02 | Fechamento e entrega da lista para o sorteio de setembro/2025 | 15/09/2025 |
| Sorteio 03 | Fechamento e entrega da lista para o sorteio de outubro/2025 | 15/10/2025 |
| Sorteio 04 | Fechamento e entrega da lista para o sorteio de novembro/2025 | 15/11/2025 |
| Sorteio 05 | Fechamento e entrega da lista para o sorteio de dezembro/2025 | 15/12/2025 |
| Sorteio Final | Fechamento e entrega da lista para o sorteio de R$ 1 milhão | 15/01/2027 |

---

*Adicionar uma entrada a cada sorteio executado, decisão relevante tomada ou problema significativo encontrado.*

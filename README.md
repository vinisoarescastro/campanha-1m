# Campanha do Milhão — Análise de Dados

---

## Objetivo

Analisar, calcular, auditar e validar a geração de cupons da campanha promocional **"5 Casas e 1 Milhão"**, garantindo que todos os clientes elegíveis recebam os cupons corretos de acordo com as regras documentadas, e que os dados estejam íntegros para a realização dos sorteios mensais.

---

## Contexto da Campanha

A campanha **"5 Casas e 1 Milhão"** vigora de **julho a dezembro de 2025** e prevê:

- **5 sorteios mensais** (agosto a dezembro/2025), cada um premiando **1 casa mobiliada com carro na garagem**.
- **1 sorteio final** em **janeiro/2026** com prêmio de **R$ 1.000.000,00**.

**Geração de cupons:** os cupons são gerados com base no **valor total recebido por cliente no mês**, conforme tabela de faixas:

| Valor recebido no mês | Cupons gerados |
|---|:---:|
| R$ 100,00 a R$ 200,00 | 1 |
| R$ 200,01 a R$ 300,00 | 2 |
| R$ 300,01 a R$ 500,00 | 3 |
| R$ 500,01 a R$ 1.000,00 | 5 |
| R$ 1.000,01 a R$ 2.000,00 | 10 |
| R$ 2.000,01 a R$ 5.000,00 | 20 |
| Acima de R$ 5.000,00 | 50 |

**Regras principais:**

- Todo valor recebido conta (parcelas, antecipações, renegociações, juros e multas).
- Única exclusão: **custas** (Tipo Parcela 1).
- O cálculo é **fechado por mês** — sem transporte de sobras para o mês seguinte.
- O cliente inadimplente **gera cupom**, mas **só participa do sorteio se estiver em dia** no fechamento do período.
- Ganhador de uma das 5 casas: excluído dos sorteios de casas restantes, mas mantém todos os cupons para o **sorteio do R$ 1 milhão**.
- Agrupamento: **Empresa + Obra + Venda**, com **CPF como chave do cliente**.

---

## Documentos de Referência

| Documento | Descrição |
|---|---|
| [`docs/00_inicial/campanha_5_casas_1_milhao.md`](docs/00_inicial/campanha_5_casas_1_milhao.md) | Regulamento expandido da campanha — fonte oficial das regras de negócio |
| [`docs/00_inicial/dicionario_de_dados.md`](docs/00_inicial/dicionario_de_dados.md) | Dicionário das tabelas do sistema interno utilizadas na análise |

---

## Estrutura do Repositório

```text
.
├── docs/
│   └── 00_inicial/
│       ├── campanha_5_casas_1_milhao.docx   # Regulamento da campanha
│       └── dicionario_de_dados.md           # Dicionário de dados do sistema
├── sql/
│   ├── 00_referencias/     # Scripts exploratórios e mapeamento de dados
│   ├── 01_base_elegivel/   # Identificação de clientes e vendas participantes
│   ├── 02_calculo_cupons/  # Agregação de recebimentos e aplicação das faixas
│   ├── 03_validacoes/      # Auditorias, cruzamentos e testes de consistência
│   └── 04_relatorios/      # Consultas finais para os sorteios e visão gerencial
├── outputs/                # Arquivos gerados (listas de cupons, relatórios)
├── README.md
└── .gitignore
```

---

## Fontes de Dados

Todas as consultas utilizam o banco de dados SQL Server interno da empresa. As principais tabelas são:

| Tabela | Papel na análise |
|---|---|
| `Recebidas` | Fonte primária dos pagamentos recebidos — base do cálculo de cupons |
| `Vendas` | Contratos de venda ativos |
| `VendasRecebidas` | Espelho de vendas quitadas (status 3) |
| `ContasReceber` | Parcelas a receber — usada para verificar inadimplência |
| `Obras` | Dados dos empreendimentos (cidade, data de lançamento) |
| `VendasLogParc` | Log de parametrizações de parcelas das vendas |
| `VendRecLogParc` | Log de parametrizações de parcelas das vendas recebidas |

> A tabela de cadastro de clientes (CPF, nome, telefone) não está documentada no dicionário atual e precisa ser mapeada junto à área de negócio.

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

## Abordagem Técnica

A análise é construída de forma incremental, em sete etapas:

1. **Entendimento das regras da campanha** — leitura e formalização do regulamento em regras de negócio mensuráveis.
2. **Identificação das tabelas relevantes** — mapeamento das tabelas e campos do sistema que sustentam cada regra.
3. **Construção da base de clientes e vendas elegíveis** — filtrar contratos ativos, sem cancelamento e sem cessão, dentro do período da campanha.
4. **Aplicação das regras de geração de cupons** — agregar recebimentos por cliente/venda/mês, excluir custas e aplicar a tabela de faixas.
5. **Consolidação dos cupons por cliente** — acumular cupons ao longo dos meses e cruzar com status de inadimplência.
6. **Validação dos totais** — comparar totais de cupons, clientes e recebimentos com fontes alternativas.
7. **Auditoria de inconsistências** — identificar e documentar cupons potencialmente incorretos ou registros ausentes.

As consultas utilizam **CTEs (Common Table Expressions)** para organização e legibilidade, seguindo o padrão do SQL Server.

---

## Consultas SQL

| Arquivo | Descrição |
|---|---|
| `sql/00_referencias/` | Scripts exploratórios: contagem de registros, faixas de datas, tipos de parcelas |
| `sql/01_base_elegivel/` | Base de vendas e clientes participantes da campanha |
| `sql/02_calculo_cupons/` | Cálculo de cupons por cliente/venda/mês com aplicação das faixas |
| `sql/03_validacoes/` | Cruzamentos de auditoria e testes de consistência |
| `sql/04_relatorios/` | Relatórios finais para os sorteios e painéis gerenciais |

---

## Validações e Auditoria

As seguintes validações devem ser executadas antes de cada sorteio:

| Validação | Objetivo |
|---|---|
| Total de cupons por mês | Conferir volume gerado contra expectativa de negócio |
| Clientes elegíveis vs. inadimplentes | Separar participantes válidos dos bloqueados |
| Clientes sem cupom com valor ≥ R$100 | Identificar possíveis falhas na geração |
| Cupons com base em custas | Verificar se a exclusão está sendo aplicada corretamente |
| Vendas canceladas com cupons | Identificar registros inconsistentes |
| Recebimentos fora do período | Garantir que só o período jul–dez/2025 está sendo considerado |
| Ganhadores mensais | Confirmar exclusão correta dos sorteios subsequentes de casas |

---

## Pontos de Atenção

- **A consulta SQL de referência utilizada neste projeto** provém de uma campanha anterior com critérios distintos (planos específicos, filtros de obra e empresa, datas diferentes). Ela foi usada **apenas como referência técnica de estrutura**, padrões de join e nomenclatura de tabelas. Nenhuma regra, filtro ou critério daquela campanha deve ser assumido como válido para a Campanha do Milhão sem confirmação explícita.
- A **identificação de "custas"** para exclusão do cálculo de cupons ainda precisa ser confirmada com a área de negócio (campo exato e valor correspondente no banco).
- A **tabela de cadastro de clientes** (CPF, nome, telefone) não está documentada no dicionário de dados atual e precisa ser mapeada antes de finalizar a consulta.
- Os **empreendimentos e empresas elegíveis** para a campanha não foram explicitamente listados no regulamento. Este filtro precisa ser confirmado.
- O controle de **ganhadores mensais** (exclusão dos sorteios seguintes) precisará de tabela ou processo específico, pois não há estrutura nativa para isso no sistema atual.

---

## Próximos Passos

- [ ] Confirmar com a área de negócio as respostas às dúvidas listadas na análise técnica
- [ ] Mapear a tabela de cadastro de clientes (CPF, nome, telefone)
- [ ] Confirmar quais empreendimentos e empresas estão incluídos na campanha
- [ ] Confirmar o campo/condição que identifica "custas" no banco
- [ ] Executar scripts exploratórios (`sql/00_referencias/`) para validar o entendimento das tabelas
- [ ] Construir e testar a consulta da base elegível (`sql/01_base_elegivel/`)
- [ ] Implementar e validar o cálculo de cupons (`sql/02_calculo_cupons/`)
- [ ] Executar validações antes do primeiro sorteio (agosto/2025)
- [ ] Definir processo de controle de ganhadores mensais

---

*Repositório mantido pela área de dados. Dúvidas sobre as regras da campanha devem ser direcionadas à área de negócio responsável.*

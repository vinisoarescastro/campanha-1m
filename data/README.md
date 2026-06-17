# data

Arquivos de dados utilizados ou gerados durante a análise, exportações, amostras e insumos externos.

> **Atenção:** arquivos com dados de clientes (CPF, nome, telefone) **nunca devem ser versionados**. As pastas `raw/` e `processed/` estão no `.gitignore`. Verifique antes de executar `git add`.

## Subpastas

| Pasta | Conteúdo |
|---|---|
| `raw/` | Extrações brutas diretas do SQL Server — nunca modificar manualmente |
| `processed/` | Dados tratados e intermediários gerados pelos scripts |
| `reference/` | Tabelas de referência estáticas: lista de empreendimentos elegíveis, ganhadores mensais, de-para de empresas |

## O que pode ser versionado

Apenas a pasta `reference/` pode conter arquivos versionados, **desde que não contenham dados pessoais de clientes**.

Exemplos de arquivos seguros para versionar:
- `reference/empreendimentos_elegiveis.csv` — lista de obras participantes da campanha
- `reference/empresas_excluidas.csv` — empresas fora do escopo
- `reference/ganhadores_mensais.csv` — controle de exclusão nos sorteios subsequentes

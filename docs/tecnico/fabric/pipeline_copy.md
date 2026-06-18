# Copy Activity — Histórico de Tentativa e Erros

> Registro da tentativa de ingestão via Copy Activity (pipeline do Fabric) e dos erros encontrados.
> Mantido como histórico técnico para referência em revisões futuras.

---

## Contexto

Antes de optar pelo Dataflow Gen2, foi tentada a ingestão da base elegível via **Copy Activity** dentro de um pipeline do Microsoft Fabric. A tentativa foi abandonada após dois erros distintos, documentados abaixo.

---

## Configuração Tentada

| Parâmetro | Valor |
|---|---|
| Workspace | FB_Comercial |
| Artefato | Pipeline com Copy job |
| Copy job | `CopyJob_1` |
| Fonte | SQL Server — `BURITI-BD-02 / UAU` |
| Destino | Warehouse `dw_campanha_1m` — tabela `dbo.01_base_elegivel_campanha` |
| Modo | Full copy |

---

## Erro 1 — OAuth Token Expirado

**Quando ocorreu:** primeira tentativa de execução via botão *Run* no pipeline.

**Código do erro:**
```
DMTS_OAuthTokenRefreshFailedError
```

**Mensagem:**
```
Failed to refresh OAuth token.
AADSTS50173: The provided grant has expired due to it being revoked,
a fresh auth token is needed.
TokensValidFrom: 2026-04-23T10:53:35Z
```

**Causa:** a conexão salva (`311d3bfd-ce1d-4043-ab33-43aa530a79cf`) estava com o token OAuth vencido desde abril/2026, provavelmente em consequência de alteração de senha do usuário.

**Solução:**
1. Acessar **Settings → Manage connections and gateways**
2. Localizar a conexão pelo nome do servidor (`BURITI-BD-02`)
3. Editar e reinserir as credenciais atuais
4. Reexecutar o pipeline

---

## Erro 2 — Truncamento de VARCHAR

**Quando ocorreu:** após reautenticação, na segunda tentativa de execução.

**Código do erro:**
```
DWCopyCommandOperationFailed
```

**Mensagem:**
```
String or binary data would be truncated while reading column
of type 'VARCHAR(41)'. Column: 'Status Sorteio'.
Truncated value: 'Não Apto/Inadimplente no mês do pagamen'
```

**Causa:** o Fabric inferiu o tipo da coluna `Status Sorteio` como `VARCHAR(41)` com base nas primeiras linhas retornadas. O valor completo `'Não Apto/Inadimplente no mês do pagamento'` excede esse tamanho e foi truncado.

**Tentativa de solução:**
Foi tentado um `ALTER TABLE` para ampliar o tipo da coluna:
```sql
ALTER TABLE dbo.[01_base_elegivel_campanha]
ALTER COLUMN [Status Sorteio] VARCHAR(500)
```

O comando falhou porque a tabela não havia sido criada — o pipeline interrompe antes de criá-la quando encontra o erro de truncamento:
```
Msg 4902: Cannot find the object "dbo.01_base_elegivel_campanha"
because it does not exist or you do not have permissions.
```

**Decisão:** abandonar a Copy Activity para este caso de uso e migrar para **Dataflow Gen2**, que permite revisar e ajustar os tipos de colunas antes de carregar os dados, evitando o problema de inferência incorreta de schema.

---

## Lição Aprendida

A Copy Activity infere o schema da tabela de destino com base nas primeiras linhas retornadas pela query. Colunas com valores longos que aparecem apenas em linhas posteriores causam erro de truncamento sem possibilidade de ajuste dinâmico durante a carga.

Para queries que retornam colunas de texto com valores variáveis (como campos de status descritivos), o **Dataflow Gen2** é mais adequado por permitir revisão e ajuste explícito dos tipos antes da carga.

---

*Caso a Copy Activity seja retomada no futuro, criar a tabela de destino manualmente com tipos corretos antes de executar o pipeline, garantindo que o schema não seja inferido automaticamente.*
# Dicionário de Dados

> Documentação das tabelas e colunas do banco de dados.

---

## Índice

- [CategoriasPrecoProd](#categoriasprecoprod)
- [ContasReceber](#contasreceber)
- [ContasReceberCalc](#contasreceberCalc)
- [Empresas](#empresas)
- [ItensRecebidas](#itensrecebidas)
- [ItensVenda](#itensvenda)
- [Obras](#obras)
- [Pessoas](#pessoas)
- [PesTel](#pestel)
- [PrdSrv](#prdsrv)
- [Recebidas](#recebidas)
- [UnidadePer](#unidadeper)
- [Vendas](#vendas)
- [VendasLogParc](#vendaslogparc)
- [VendasRecebidas](#vendasrecebidas)
- [VendRecLogParc](#vendreclogparc)

---

## Legenda

| Campo | Descrição |
|-------|-----------|
| **Coluna** | Nome da coluna na tabela |
| **Chave** | Indica se a coluna faz parte da chave primária |
| **Tipo** | Tipo de dado da coluna |
| **Tamanho** | Tamanho em bytes do tipo |
| **Padrão** | Valor padrão da coluna |
| **Null** | `1` = Aceita NULL / `0` = Não aceita NULL |

---

## CategoriasPrecoProd

Armazena as categorias de preço por produto, com validade e rastreabilidade de quem inseriu o registro.

| Coluna | Chave | Tipo | Tamanho | Padrão | Null | Descrição |
|--------|:-----:|------|:-------:|:------:|:----:|-----------|
| NumProd_cpp | SIM | int | 4 | NULL | 0 | Código do produto |
| Codigo_cpp | SIM | varchar | 5 | NULL | 0 | Código da categoria de preço |
| Data_cpp | SIM | datetime | 8 | NULL | 0 | Data de início de validade do preço da categoria |
| Valor_cpp | NÃO | numeric | 9 | NULL | 0 | Preço da categoria |
| Login_cpp | NÃO | varchar | 8 | NULL | 0 | Usuário que inseriu o preço da categoria |
| Quando_cpp | NÃO | datetime | 8 | NULL | 0 | Data em que foi inserido o preço da categoria |
| Empresa_cpp | SIM | smallint | 2 | NULL | 0 | Código da empresa |

---

## ContasReceber

Registra as parcelas de recebimento das vendas, incluindo parâmetros de juros, correção, multa, amortização e cobrança bancária.

| Coluna | Chave | Tipo | Tamanho | Padrão | Null | Descrição |
|--------|:-----:|------|:-------:|:------:|:----:|-----------|
| NumParc_Prc | SIM | int | 4 | 0 | 0 | Número da parcela de recebimento |
| Tipo_Prc | SIM | varchar | 3 | NULL | 0 | Tipo da parcela: (E)ntrada, (P)arcela ou (Balão) |
| NumParcGer_Prc | SIM | int | 4 | 0 | 0 | Número da parcela de recebimento (geral / total de parcelas) |
| Empresa_prc | SIM | smallint | 2 | NULL | 0 | Código da empresa |
| Obra_Prc | SIM | varchar | 5 | NULL | 0 | Obra da venda |
| NumVend_prc | SIM | int | 4 | 0 | 0 | Número da venda |
| Data_Prc | NÃO | datetime | 8 | NULL | 1 | Data de recebimento |
| Valor_Prc | NÃO | numeric | 9 | 0 | 1 | Valor da parcela de recebimento |
| Status_Prc | NÃO | tinyint | 1 | 0 | 1 | Status da parcela: 0 = Normal, 1 = Recebimento |
| EmBanco_Prc | NÃO | tinyint | 1 | 0 | 1 | 0 = Não está em banco; 1 = Em banco |
| Origem_Prc | NÃO | int | 4 | 0 | 1 | Origem desta parcela |
| Cliente_Prc | NÃO | int | 4 | NULL | 1 | Código do cliente |
| DataPror_Prc | NÃO | datetime | 8 | NULL | 1 | Data para a qual foi prorrogada a parcela (se a parcela estiver atrasada) |
| JurosParc_Prc | NÃO | numeric | 9 | 0 | 1 | Percentual de juros do parcelamento |
| ComoParc_Prc | NÃO | varchar | 5 | NULL | 1 | Frequência de recebimento da parcela |
| IdxReaj_Prc | NÃO | varchar | 5 | NULL | 1 | Índice do recebimento |
| AmortParc_Prc | NÃO | tinyint | 1 | 0 | 1 | Sistema de amortização: (0) Gradiente; (1) Price; (2) SAC; (3) Simples |
| BegEndParc_Prc | NÃO | tinyint | 1 | 0 | 1 | Se é Begin ou End: (0) Begin; (1) End |
| DtIdxParc_Prc | NÃO | datetime | 8 | NULL | 1 | Data base de correção por índice da parcela |
| DtJurParc_Prc | NÃO | datetime | 8 | NULL | 1 | Data base de juros do parcelamento |
| Cap_Prc | NÃO | varchar | 30 | NULL | 1 | CAP da venda |
| TotParc_Prc | NÃO | smallint | 2 | 0 | 1 | Total de parcelas (por parâmetros) |
| DtParc_Prc | NÃO | datetime | 8 | NULL | 1 | Data de início da parcela |
| ValorResiduo_Prc | NÃO | numeric | 9 | 0 | 1 | Valor do resíduo gerado |
| GrupoIdx_Prc | NÃO | smallint | 2 | -1 | 0 | Grupo de indexação do plano indexador |
| GrupoParc_Prc | NÃO | smallint | 2 | NULL | 0 | Indica quais parcelas são do mesmo grupo (possuem os mesmos parâmetros) |
| StatusCbr_Prc | NÃO | varchar | 255 | ('') | 1 | Status de cobrança da parcela |
| CapCorrecaoAtr_Prc | NÃO | varchar | 30 | NULL | 0 | CAP de correção por atraso |
| CapJuros_Prc | NÃO | varchar | 30 | NULL | 0 | CAP de juros |
| CapCorrecao_Prc | NÃO | varchar | 30 | NULL | 0 | CAP de correção |
| CapMulta_Prc | NÃO | varchar | 30 | NULL | 0 | CAP de multa |
| CapJurosAtr_Prc | NÃO | varchar | 30 | NULL | 0 | CAP de juros por atraso |
| CapAcrescimo_Prc | NÃO | varchar | 30 | NULL | 0 | CAP de acréscimo |
| CapDesconto_Prc | NÃO | varchar | 30 | NULL | 0 | CAP de desconto |
| Anexos_Prc | NÃO | tinyint | 1 | NULL | 1 | Indica os tipos de anexos vinculados ao registro |
| CapDescontoAntec_Prc | NÃO | varchar | 30 | NULL | 0 | CAP do desconto por antecipação das parcelas a receber |
| CapTaxaBol_prc | NÃO | varchar | 30 | NULL | 1 | CAP da taxa de boleto |
| ValorTaxaBol_prc | NÃO | numeric | 9 | NULL | 0 | Valor da taxa do boleto |
| NumCtp_prc | NÃO | int | 4 | NULL | 1 | Identificador do tipo de custas |
| OrigemCusta_prc | NÃO | tinyint | 1 | NULL | 1 | 0 = Origem é da obra (locador/empreendedor); 1 = Origem é da administração |
| CobrarMulta_prc | NÃO | tinyint | 1 | NULL | 0 | Se pode cobrar multa por atraso: 0 = Não cobrar; 1 = Cobrar (default). Utilizado para parcelas do tipo custas |
| CobrarJurosAtr_prc | NÃO | tinyint | 1 | NULL | 0 | Se pode cobrar juros por atraso: 0 = Não cobrar; 1 = Cobrar (default). Utilizado para parcelas do tipo custas |
| CobrarTxAdm_prc | NÃO | tinyint | 1 | NULL | 0 | Se pode cobrar taxa de administração: 0 = Não cobrar (default); 1 = Cobrar. Utilizado para parcelas do tipo custas |
| CobrarImposto_prc | NÃO | tinyint | 1 | NULL | 0 | Se entrará no cálculo do imposto de renda: 0 = Não cobrar (default); 1 = Cobrar. Utilizado para parcelas do tipo custas |
| CobrarCorrecao_prc | NÃO | tinyint | 1 | NULL | 0 | Se pode cobrar correção da parcela: 0 = Não cobrar; 1 = Cobrar (default). Utilizado para parcelas do tipo custas |
| CobrarCPMF_prc | NÃO | tinyint | 1 | NULL | 0 | Se ao gerar o repasse para o locador irá descontar a % de CPMF: 0 = Não cobrar (default); 1 = Cobrar |
| RepassarLocador_prc | NÃO | tinyint | 1 | NULL | 0 | Se irá repassar o valor do lançamento para o locador: 0 = Não repassar (default); 1 = Repassar. Utilizado para parcelas do tipo custas |
| ValDescontoCusta_prc | NÃO | numeric | 9 | NULL | 0 | Valor de desconto atribuído via lançamento de custas (somente para contratos do tipo aluguel) |
| CapDescontoCusta_prc | NÃO | varchar | 30 | NULL | 0 | CAP de custa desconto |
| ValDescontoImposto_prc | NÃO | numeric | 9 | NULL | 0 | Valor de desconto atribuído via lançamento de imposto |
| TotParcGrupo_prc | NÃO | smallint | 2 | NULL | 0 | Total de parcelas do grupo |
| DataCad_Prc | NÃO | datetime | 8 | NULL | 0 | Data de cadastro da parcela em contas a receber |
| DtJurosComJuros_Prc | NÃO | tinyint | 1 | NULL | 0 | Se a parcela no mesmo mês/dia da data de início de juros terá juros calculados (em caso de parcela price) |
| Obs_Prc | NÃO | varchar | 4000 | NULL | 1 | Observação ao gerar uma custa |
| DataIniPeriodoAluguel_prc | NÃO | datetime | 8 | NULL | 1 | Data de início do período do aluguel; 30 dias após esta data vence o período |
| CapRepasse_Prc | NÃO | varchar | 30 | NULL | 0 | Código do CAP de repasse |
| NumeroBanco_prc | NÃO | smallint | 2 | NULL | 1 | Número do banco na tabela de bancos |
| ContaBanco_prc | NÃO | varchar | 20 | NULL | 1 | Número da conta corrente do banco |
| NumPcb_prc | NÃO | int | 4 | NULL | 1 | Número do padrão de cobrança |
| DataSegJuros_prc | NÃO | datetime | 8 | NULL | 1 | Data base da segunda taxa de juros do parcelamento |
| PorcSegJuros_prc | NÃO | numeric | 9 | NULL | 1 | Porcentagem da segunda taxa de juros a ser cobrada na parcela |
| CarenciaAtraso_prc | NÃO | smallint | 2 | NULL | 0 | Dias de carência para cobrança de juros por atraso e multa |
| CarenciaAtrasoCorrecao_prc | NÃO | smallint | 2 | NULL | 0 | Dias de carência para cobrança de correção por atraso |
| CobrarJurosProRata_prc | NÃO | smallint | 2 | NULL | 0 | Cobrar juros pró-rata |
| TipoSeguro_prc | NÃO | tinyint | 1 | NULL | 1 | Tipo do seguro: 0 = MIP (Morte e Invalidez Permanente); 1 = DFI (Danos Físicos ao Imóvel) |
| CobrarJurosProRataPrimeiroMes_prc | NÃO | bit | 1 | NULL | 0 | Calcular juros no primeiro mês como pró-rata: 0 = Não; 1 = Sim |
| CapDescontoCondicional_prc | NÃO | varchar | 30 | NULL | 1 | CAP responsável pelo valor do desconto condicional |

---

## Obras

Cadastro de obras (empreendimentos), contendo dados de localização, tipo, configurações de cobrança, parâmetros financeiros e informações de integração com sistemas externos.

| Coluna | Chave | Tipo | Tamanho | Padrão | Null | Descrição |
|--------|:-----:|------|:-------:|:------:|:----:|-----------|
| cod_obr | SIM | varchar | 5 | NULL | 0 | Código da obra |
| Fisc_obr | NÃO | varchar | 5 | NULL | 0 | Obra fiscal para despesas |
| descr_obr | NÃO | varchar | 255 | NULL | 0 | Descrição |
| ender_obr | NÃO | varchar | 100 | NULL | 1 | Endereço: rua, número, complemento |
| setor_obr | NÃO | varchar | 100 | NULL | 1 | Setor ou bairro onde a obra se localiza |
| cid_obr | NÃO | varchar | 50 | NULL | 1 | Nome da cidade |
| uf_obr | NÃO | varchar | 5 | NULL | 1 | Unidade da Federação |
| cep_obr | NÃO | varchar | 8 | NULL | 0 | Código de Endereçamento Postal |
| dtini_obr | NÃO | datetime | 8 | NULL | 0 | Data de início da obra |
| dtfim_obr | NÃO | datetime | 8 | NULL | 0 | Data de término da obra (ou previsão) |
| status_obr | NÃO | tinyint | 1 | 0 | 0 | Situação da obra: 0 = Andamento; 1 = Paralizada; 2 = Término Físico; 3 = Término Financeiro |
| fone_obr | NÃO | varchar | 20 | NULL | 1 | Número do telefone para contato com a obra |
| fax_obr | NÃO | varchar | 20 | NULL | 1 | Número do fax da obra |
| CodGrupo_obr | NÃO | varchar | 30 | NULL | 1 | Código do grupo de obra ao qual esta obra pertence |
| TipoObra_obr | NÃO | tinyint | 1 | 0 | 0 | Tipo de obra: 1 = Empreitada; 2 = Incorporação; 3 = Administração; 4 = Vendas; 5 = Interno |
| FiscRec_obr | NÃO | varchar | 5 | NULL | 0 | Obra fiscal para receitas |
| enderEntr_obr | NÃO | varchar | 100 | ('') | 1 | Endereço de entrega: rua, número, complemento |
| setorEntr_obr | NÃO | varchar | 100 | ('') | 1 | Setor ou bairro de entrega |
| cidEntr_obr | NÃO | varchar | 50 | ('') | 1 | Nome da cidade de entrega |
| ufEntr_obr | NÃO | varchar | 5 | NULL | 1 | Unidade da Federação de entrega |
| cepEntr_obr | NÃO | varchar | 8 | NULL | 0 | Código de Endereçamento Postal de entrega |
| TipoOC_obr | NÃO | tinyint | 1 | NULL | 1 | Tipo da Ordem de Compra padrão da obra: 0 = Padrão; 1 = Nova |
| EmpPaga_obr | NÃO | int | 4 | NULL | 1 | Código da empresa pagadora |
| EmpFatura_obr | NÃO | int | 4 | NULL | 1 | Código da empresa faturada |
| CodObrNet_obr | NÃO | varchar | 10 | NULL | 1 | Código da obra em Construcompras |
| CodCentroCustoNet_obr | NÃO | varchar | 10 | NULL | 1 | Código do centro de custo da obra em Construcompras |
| CodEnderEntregaNet_obr | NÃO | varchar | 10 | NULL | 1 | Código do endereço de entrega do pedido |
| CodRegiaoNet_obr | NÃO | varchar | 10 | NULL | 1 | Código da região de entrega em Construcompras |
| DataCad_obr | NÃO | datetime | 8 | NULL | 1 | Data de cadastro do registro |
| UsrCad_obr | NÃO | varchar | 8 | NULL | 1 | Usuário que fez o cadastro do registro |
| DataAlt_obr | NÃO | datetime | 8 | NULL | 1 | Data da última alteração no registro |
| UsrAlt_obr | NÃO | varchar | 8 | NULL | 1 | Usuário que fez a última alteração no registro |
| Anexos_obr | NÃO | tinyint | 1 | NULL | 1 | Tipos de anexos (Pendência, Comentário e Foto) armazenados como somatório |
| CarenciaAtraso_obr | NÃO | tinyint | 1 | NULL | 1 | Dias de carência no atraso |
| Multa_obr | NÃO | numeric | 9 | NULL | 1 | Porcentagem da multa a ser cobrada por atraso |
| Juros_obr | NÃO | numeric | 9 | NULL | 1 | Juros ao dia a ser cobrado por atraso |
| JurosContrato_obr | NÃO | tinyint | 1 | NULL | 0 | Verificar se deverá ser cobrado juros contratuais |
| CorrecaoAtr_obr | NÃO | tinyint | 1 | NULL | 0 | Verificar se deverá ser cobrada correção por atraso |
| TipoUtilFis_Obr | NÃO | tinyint | 1 | NULL | 0 | Tipo de utilização do Físico: 0 = Mês; 1 = Geral |
| TipoUtilFin_Obr | NÃO | tinyint | 1 | NULL | 0 | Tipo de utilização do Financeiro: 0 = Mês; 1 = Geral |
| FoneEntr_obr | NÃO | varchar | 20 | NULL | 1 | Telefone de contato com o endereço de entrega da obra |
| FaxEntr_obr | NÃO | varchar | 50 | NULL | 1 | Fax do endereço de entrega da obra |
| MesReplanejar_obr | NÃO | datetime | 8 | NULL | 1 | Mês de replanejamento |
| ContaPlc_obr | NÃO | varchar | 20 | NULL | 1 | Conta padrão da obra para o processamento fiscal |
| ContaBanco_obr | NÃO | varchar | 20 | NULL | 1 | Conta para recebimento |
| NumeroBanco_obr | NÃO | smallint | 2 | NULL | 1 | Banco para recebimento |
| Carteira_obr | NÃO | varchar | 5 | NULL | 1 | Carteira padrão |
| LotacaoFolha_obr | NÃO | varchar | 20 | NULL | 1 | Código da obra para geração do arquivo de exportação para folha |
| CEI_obr | NÃO | varchar | 20 | NULL | 1 | Número de registro CEI |
| NumCid_obr | NÃO | int | 4 | NULL | 1 | Código da cidade da obra |
| NumCidEntr_obr | NÃO | int | 4 | NULL | 1 | Código da cidade de entrega da obra |
| PorcTolEntrega_obr | NÃO | numeric | 5 | NULL | 1 | Porcentagem de tolerância no recebimento de mercadorias |
| ContaBancoPg_obr | NÃO | varchar | 20 | NULL | 1 | Conta para pagamento |
| NumeroBancoPg_obr | NÃO | smallint | 2 | NULL | 1 | Banco para pagamento |
| Empresa_obr | SIM | smallint | 2 | NULL | 0 | Código da empresa |
| NumeroBancoAdm_obr | NÃO | smallint | 2 | NULL | 1 | Banco default para cobrança bancária da administração |
| ContaBancoAdm_obr | NÃO | varchar | 20 | NULL | 1 | Conta corrente default para cobrança bancária da administração |
| CarteiraAdm_obr | NÃO | varchar | 5 | NULL | 1 | Carteira default para cobrança bancária da administração |
| ValidaFeriado_Obr | NÃO | tinyint | 1 | NULL | 0 | 1 = Valida feriados com endereço da obra; 0 = Valida com endereço da empresa |
| NumSet_obr | NÃO | smallint | 2 | NULL | 1 | Contador da tabela SetViabilidade |
| NumContEmpree_obr | NÃO | varchar | 40 | NULL | 1 | Número do controle de empreendimento |
| NumEmpree_obr | NÃO | varchar | 50 | NULL | 1 | Número do empreendimento |
| ReajusteAnual_obr | NÃO | tinyint | 1 | NULL | 0 | Reajuste anual |
| DataLancamento_obr | NÃO | datetime | 8 | NULL | 1 | Data de lançamento do empreendimento |
| NumCreci_obr | NÃO | int | 4 | NULL | 1 | Número do CRECI (Conselho Regional dos Corretores de Imóveis) |
| TipoCreci_obr | NÃO | varchar | 3 | NULL | 1 | Tipo do CRECI: CJ (Jurídico) ou C (Físico) |
| FimAnuncio_obr | NÃO | varchar | 150 | NULL | 1 | Texto livre inserido no final do anúncio ao imprimi-lo |
| DiaUtil_Obr | NÃO | bit | 1 | NULL | 0 | Indica se será usado dia útil no planejamento da obra pelo Gantt |
| EmpresaIntermediadora_Obr | NÃO | smallint | 2 | NULL | 1 | Código da empresa incorporadora para controle dos lançamentos de incorporação no DIMOB |
| EmpSet_obr | NÃO | smallint | 2 | NULL | 1 | Código da empresa do empreendimento |
| CustoDesembolso_Obr | NÃO | bit | 1 | NULL | 0 | Valida se custo e desembolso estão com valores diferentes no planejamento ao gravar o gestão |
| DDDFone_Obr | NÃO | varchar | 2 | NULL | 1 | DDD do telefone da obra |
| DDDFoneEntr_Obr | NÃO | varchar | 2 | NULL | 1 | DDD do telefone de entrega |
| DDDFax_Obr | NÃO | varchar | 2 | NULL | 1 | DDD do fax da obra |
| DDDFaxEnt_Obr | NÃO | varchar | 2 | NULL | 1 | DDD do fax de entrega |
| BoletoDetalhado_obr | NÃO | bit | 1 | NULL | 0 | Boleto detalhado |
| PorcTxAdm_Obr | NÃO | numeric | 9 | NULL | 1 | Porcentagem da taxa de administração |
| FecharMesAutomatico_obr | NÃO | bit | 1 | NULL | 0 | Fechar o mês automaticamente: 0 = Não; 1 = Sim |
| TipoCaucaoTxAdm_Obr | NÃO | bit | 1 | NULL | 1 | Tipo do caução: 0 = Sobre o total do período; 1 = Sobre a taxa de administração |
| CaucaoTxAdm_Obr | NÃO | numeric | 5 | NULL | 0 | Porcentagem de caução sobre os valores da nota |
| ImpostosTxAdm_Obr | NÃO | numeric | 5 | NULL | 0 | Porcentagem dos impostos sobre a taxa de administração por conta do contratante |
| NumPcbObra_obr | NÃO | int | 4 | NULL | 1 | Número do padrão de cobrança para recebimento da obra |
| NumPcbAdm_obr | NÃO | int | 4 | NULL | 1 | Número do padrão de cobrança para recebimento da administração |
| NumPcbAvulso_obr | NÃO | int | 4 | NULL | 1 | Número do padrão de cobrança para boleto avulso |
| AtInat_obr | NÃO | bit | 1 | NULL | 0 | Ativo / Inativo |
| TipoTxAdm_Obr | NÃO | bit | 1 | NULL | 1 | Tipo do relatório de administração: 0 = Data de emissão da NF; 1 = Data de pagamento |
| ApropriarCustoDtPgto_Obr | NÃO | bit | 1 | NULL | 0 | Apropriar custo pela data de pagamento |
| ProcessoPago_Obr | NÃO | bit | 1 | NULL | 0 | 0 = Não gera processo direto em contas pagas; 1 = Gera processo direto em contas pagas |
| NumeroBancoBI_obr | NÃO | smallint | 2 | NULL | 1 | Banco para o processo de pagamento direto em contas pagas |
| ContaBi_obr | NÃO | varchar | 20 | NULL | 1 | Conta corrente para o processo de pagamento direto em contas pagas |
| PorcTotPrecoUnit_Obr | NÃO | numeric | 5 | NULL | 1 | Percentual pelo qual o preço unitário será alterado |
| ApontSiAplic_obr | NÃO | bit | 1 | NULL | 0 | Controla se a aplicação de material da obra será por apontamento ou proporcional |
| ControlaEstornoPL_obr | NÃO | bit | 1 | NULL | 0 | Se irá controlar estorno de custo |
| FiscFolha_obr | NÃO | varchar | 5 | NULL | 0 | Obra contábil para folha de pagamento |
| ParcCustaAdm_obr | NÃO | bit | 1 | NULL | 1 | Parcela de custa administrativa |
| ConvenioBancoPg_obr | NÃO | varchar | 25 | NULL | 1 | Convênio bancário para pagamento |
| controlaValorLimite_obr | NÃO | bit | 1 | NULL | 0 | Indica se haverá controle do valor limite do planejamento da obra |
| PorcInadimp_obr | NÃO | numeric | 9 | NULL | 1 | Porcentagem de inadimplência |
| ControleSolicitacao_obr | NÃO | bit | 1 | NULL | 0 | Controle de solicitação |
| ObraTipoDepart_Obr | NÃO | bit | 1 | NULL | 0 | Indica se a obra é do tipo departamento |
| CodGrupoContabil_obr | NÃO | varchar | 30 | NULL | 1 | Campo contabilizado como grupo de obra |
| ControlaServExterno_obr | NÃO | tinyint | 1 | ((0)) | 0 | Controla serviços externos |
| MaxParcelamento_obr | NÃO | smallint | 2 | NULL | 1 | Quantidade máxima de parcelamento no recebimento por cartão |
| ModalidadesCartao_obr | NÃO | varchar | 5 | NULL | 1 | Modalidades permitidas no recebimento por cartão |
| fiscControleFin_obr | NÃO | varchar | 5 | NULL | 1 | Controle financeiro fiscal |
| CodPesObra_obr | NÃO | int | 4 | NULL | 1 | Código de pesquisa da obra |
| PorcTotPrecoUnitReducao_Obr | NÃO | numeric | 5 | NULL | 1 | Percentual de redução do preço unitário |

---

## PrdSrv

Cadastro de produtos e serviços utilizados nas obras e vendas.

| Coluna | Chave | Tipo | Tamanho | Padrão | Null | Descrição |
|--------|:-----:|------|:-------:|:------:|:----:|-----------|
| NumProd_psc | SIM | int | 4 | 0 | 0 | Número do produto |
| Descricao_psc | NÃO | varchar | 255 | NULL | 0 | Descrição do produto |
| Unidade_psc | NÃO | varchar | 5 | NULL | 0 | Unidade do produto |
| TabPer_psc | NÃO | varchar | 50 | NULL | 1 | Nome da tabela de personalização do produto |
| Status_psc | NÃO | tinyint | 1 | 0 | 1 | Controla a confirmação do registro: 0 = Pendente; 1 = Confirmado |
| UsrCad_psc | NÃO | varchar | 8 | NULL | 1 | Usuário que cadastrou o produto |
| AtInat_psc | NÃO | tinyint | 1 | 0 | 0 | 0 = Ativo; 1 = Inativo |
| Obs_psc | NÃO | varchar | 100 | NULL | 1 | Observação a respeito do produto |
| Anexos_psc | NÃO | tinyint | 1 | NULL | 1 | Tipos de anexos (Comentário, Pendência ou Foto) armazenados como somatório |
| NCM_psc | NÃO | varchar | 8 | NULL | 1 | Nomenclatura Comum do Mercosul |
| TipoUnidade_psc | NÃO | varchar | 2 | NULL | 1 | Tipo de unidade imobiliária vendida: 01 = Terreno para venda; 02 = Terreno de loteamento; 03 = Lote de desmembramento; 04 = Unidade de incorporação; 05 = Prédio construído/em construção; 06 = Outras |
| NumApi_psc | NÃO | smallint | 2 | NULL | 1 | Código da aplicação do produto |
| Atividade_psc | NÃO | tinyint | 1 | NULL | 0 | Atividade do produto |
| CEST_psc | NÃO | varchar | 7 | NULL | 1 | CEST — Código Especificador da Substituição Tributária |
| NumCsf_psc | NÃO | int | 4 | NULL | 1 | Código de serviço do produto |

---

## Recebidas

Registra os recebimentos das parcelas de venda, incluindo valores de correção, multa, juros, desconto, acréscimo, taxa de boleto e informações de cobrança bancária.

| Coluna | Chave | Tipo | Tamanho | Padrão | Null | Descrição |
|--------|:-----:|------|:-------:|:------:|:----:|-----------|
| Empresa_rec | SIM | smallint | 2 | NULL | 0 | Código da empresa |
| NumVend_Rec | SIM | int | 4 | 0 | 0 | Número da Venda |
| Obra_Rec | SIM | varchar | 5 | NULL | 0 | Obra da Venda |
| NumParc_Rec | SIM | int | 4 | 0 | 0 | Número da Parcela |
| ParcType_Rec | SIM | varchar | 5 | NULL | 0 | Tipo de dados da Parcela: D=Dinheiro, C=Cheque, E=Eletrônico, B=Bens |
| Tipo_Rec | SIM | varchar | 3 | NULL | 0 | Tipo da parcela: (E)ntrada, (P)arcela, (B)alao |
| NumParcGer_Rec | SIM | int | 4 | 0 | 0 | Número da Parcela de Recebimento (Geral Total de Parcelas) |
| NumReceb_Rec | NÃO | numeric | 9 | 0 | 1 | Numero do Recebimento |
| Data_Rec | NÃO | datetime | 8 | NULL | 1 | Data de Recebimento |
| PorcentVl_Rec | NÃO | numeric | 9 | 0 | 1 | Quantos em % equivale o cheque para esta parcela |
| Valor_Rec | NÃO | numeric | 9 | 0 | 1 | Valor da Parcela |
| ValorConf_Rec | NÃO | numeric | 9 | 0 | 1 | Valor da Parcela Confirmado |
| VlCorrecao_Rec | NÃO | numeric | 9 | 0 | 1 | Valor da Correção monetária por um Índice |
| VlCorrecaoConf_Rec | NÃO | numeric | 9 | 0 | 1 | Valor da Correção monetária por um Índice — Confirmado |
| VlMulta_Rec | NÃO | numeric | 9 | 0 | 1 | Valor da Multa por atraso no Recebimento |
| VlMultaConf_Rec | NÃO | numeric | 9 | 0 | 1 | Valor da Multa por atraso no Recebimento Confirmado |
| VlJurosParc_Rec | NÃO | numeric | 9 | 0 | 1 | Valor do juros da parcela |
| VlJurosParcConf_Rec | NÃO | numeric | 9 | 0 | 1 | Valor do juros da parcela Confirmado |
| VlJuros_Rec | NÃO | numeric | 9 | 0 | 1 | Valor de Juros por atraso no Recebimento |
| VlJurosConf_Rec | NÃO | numeric | 9 | 0 | 1 | Valor de Juros por atraso no Recebimento Confirmado |
| VlDesconto_Rec | NÃO | numeric | 9 | 0 | 1 | Valor de Descontos |
| VlDescontoConf_Rec | NÃO | numeric | 9 | 0 | 1 | Valor de Descontos Confirmado |
| VlAcresConf_Rec | NÃO | numeric | 9 | 0 | 1 | Valor do acrescimo Confirmado |
| VlAcres_Rec | NÃO | numeric | 9 | 0 | 1 | Valor do acrescimo |
| Status_Rec | NÃO | tinyint | 1 | 0 | 1 | Status do Recebimento: 0 = Recebida; 1 = Confirmada |
| User_Rec | NÃO | varchar | 8 | NULL | 1 | Usuário que Efetuou o Recebimento |
| UserDesc_Rec | NÃO | varchar | 8 | NULL | 1 | Usuário que Concedeu um Desconto |
| OrigParc_Rec | NÃO | int | 4 | 0 | 1 | Origem de Geração da Parcela no Recebimento |
| DataVenci_Rec | NÃO | datetime | 8 | NULL | 1 | Data de vencimento da parcela |
| Cliente_Rec | NÃO | int | 4 | 0 | 1 | Cod. do cliente |
| EParte_Rec | NÃO | tinyint | 1 | 0 | 0 | Se a parcela foi recebida, total ou parcial |
| JurosParc_Rec | NÃO | numeric | 9 | 0 | 1 | Percentual de Juros Parcelamento |
| ComoParc_Rec | NÃO | varchar | 5 | NULL | 1 | Freq. de recebimento da parcela |
| IdxReaj_Rec | NÃO | varchar | 5 | NULL | 1 | Indice do Recebimento |
| AmortParc_Rec | NÃO | tinyint | 1 | 0 | 1 | Sistema de Amortização: (0) Gradiente; (1) Price; (2) SAC; (3) Simples |
| BegEndParc_Rec | NÃO | tinyint | 1 | 0 | 1 | Se é Begin ou End: (0) Begin; (1) End |
| DtIdxParc_Rec | NÃO | datetime | 8 | NULL | 1 | Data Base de Correção por Índice da parcela |
| DtJurParc_Rec | NÃO | datetime | 8 | NULL | 1 | Data Base juros Parcelamento |
| Cap_Rec | NÃO | varchar | 30 | NULL | 1 | Cap da venda |
| TotParc_Rec | NÃO | smallint | 2 | 0 | 1 | Total de parcelas (por parametros) |
| DtParc_Rec | NÃO | datetime | 8 | NULL | 1 | Data Inicio da parcela |
| ValorResiduo_Rec | NÃO | numeric | 9 | 0 | 1 | Valor do resíduo gerado |
| GrupoIdx_Rec | NÃO | smallint | 2 | -1 | 0 | Grupo de indexação do plano indexador |
| GrupoParc_Rec | NÃO | smallint | 2 | 0 | 1 | Quais parcelas são do mesmo grupo, possuem os mesmo parâmetros |
| DtCalReaj_Rec | NÃO | datetime | 8 | NULL | 1 | Data que foi calculado o reajuste |
| VlrDescAdiant_Rec | NÃO | numeric | 9 | 0 | 0 | Utilizado guardar o valor do desconto por adiantamento da parcela |
| VlCorrecaoAtrConf_Rec | NÃO | numeric | 9 | NULL | 0 | NULL |
| VlCorrecaoAtr_Rec | NÃO | numeric | 9 | NULL | 0 | NULL |
| CapCorrecaoAtr_Rec | NÃO | varchar | 30 | NULL | 0 | NULL |
| CapJuros_Rec | NÃO | varchar | 30 | NULL | 0 | NULL |
| CapCorrecao_Rec | NÃO | varchar | 30 | NULL | 0 | NULL |
| CapMulta_Rec | NÃO | varchar | 30 | NULL | 0 | NULL |
| CapJurosAtr_Rec | NÃO | varchar | 30 | NULL | 0 | NULL |
| CapAcrescimo_Rec | NÃO | varchar | 30 | NULL | 0 | NULL |
| CapDesconto_Rec | NÃO | varchar | 30 | NULL | 0 | NULL |
| Anexos_Rec | NÃO | tinyint | 1 | NULL | 1 | Indicar os tipos de Anexos de um registro (Pendencia, Comentario ou foto) |
| CapDescontoAntec_Rec | NÃO | varchar | 30 | NULL | 0 | Armazenar o CAP do desconto por antecipação das parcelas recebidas |
| VlJurosParcEmb_Rec | NÃO | numeric | 9 | NULL | 0 | Juros a ser embutido no principal quando tiver aniversário de contrato |
| VlJurosParcEmbConf_Rec | NÃO | numeric | 9 | NULL | 0 | Juros confirmado a ser embutido no principal quando tiver aniversário de contrato |
| VlCorrecaoEmb_Rec | NÃO | numeric | 9 | NULL | 0 | Correção acumulada no período a ser embutida no principal quando tiver aniversário de contrato |
| VlCorrecaoEmbConf_Rec | NÃO | numeric | 9 | NULL | 0 | Correção confirmada acumulada no período a ser embutida no principal quando tiver aniversário de contrato |
| CapTaxaBol_Rec | NÃO | varchar | 30 | NULL | 1 | Cap da taxa de boleto |
| VlTaxaBol_Rec | NÃO | numeric | 9 | NULL | 0 | Valor da taxa de boleto cobrada |
| VlTaxaBolConf_Rec | NÃO | numeric | 9 | NULL | 0 | Valor da taxa de boleto cobrada Confirmada |
| NumCtp_Rec | NÃO | int | 4 | NULL | 1 | Identificador do tipo de custas |
| OrigemCusta_Rec | NÃO | tinyint | 1 | NULL | 1 | NULL |
| CobrarMulta_rec | NÃO | tinyint | 1 | NULL | 1 | Se pode cobrar multa/juros atraso da parcela (parcelas do tipo custas): 0 = Não cobrar; 1 = Cobrar (default) |
| CobrarJurosAtr_rec | NÃO | tinyint | 1 | NULL | 0 | Se pode cobrar juros por atraso da parcela (parcelas do tipo custas): 0 = Não cobrar; 1 = Cobrar (default) |
| CobrarTxAdm_rec | NÃO | tinyint | 1 | NULL | 0 | Se pode cobrar taxa de administração (parcelas do tipo custas): 0 = Não cobrar (default); 1 = Cobrar |
| CobrarImposto_rec | NÃO | tinyint | 1 | NULL | 0 | Se irá entrar no cálculo do imposto de renda (parcelas do tipo custas): 0 = Não cobrar (default); 1 = Cobrar |
| CobrarCorrecao_rec | NÃO | tinyint | 1 | NULL | 0 | Se pode cobrar correção da parcela (parcelas do tipo custas): 0 = Não cobrar; 1 = Cobrar (default) |
| CobrarCPMF_rec | NÃO | tinyint | 1 | NULL | 0 | Se ao gerar o repasse para o locador irá descontar a % de CPMF: 0 = Não cobrar (default); 1 = Cobrar |
| RepassarLocador_rec | NÃO | tinyint | 1 | NULL | 0 | Se irá repassar o valor do lançamento para o locador (parcelas do tipo custas): 0 = Não repassar (default); 1 = Repassar |
| ValDescontoCusta_rec | NÃO | numeric | 9 | NULL | 0 | Valor de desconto atribuído via lançamento de custas (somente para contratos do tipo aluguel) |
| ValDescontoCustaConf_rec | NÃO | numeric | 9 | NULL | 0 | Valor de desconto depositado atribuído via lançamento de custas (somente para contratos do tipo aluguel) |
| CapDescontoCusta_rec | NÃO | varchar | 30 | NULL | 0 | CAP de desconto de custa |
| ValDescontoImposto_rec | NÃO | numeric | 9 | NULL | 0 | Valor de desconto atribuído via lançamento de imposto |
| ValDescontoImpostoConf_rec | NÃO | numeric | 9 | NULL | 0 | Valor de desconto depositado atribuído via lançamento de imposto |
| TotParcGrupo_rec | NÃO | smallint | 2 | NULL | 0 | Total de parcelas do grupo (para exibição correta na nota promissória) |
| DataCad_Rec | NÃO | datetime | 8 | NULL | 0 | Data de cadastro da parcela em contas a receber |
| DtJurosComJuros_Rec | NÃO | tinyint | 1 | NULL | 0 | Se a parcela no mesmo mês/dia da data de início de juros terá juros calculados (parcela price, frequência Mensal/Anual/Diária) |
| Obs_rec | NÃO | varchar | 4000 | NULL | 1 | Observação de custa |
| DataIniPeriodoAluguel_rec | NÃO | datetime | 8 | NULL | 1 | Data de início do período do aluguel; 30 dias após vencerá o período |
| CapRepasse_Rec | NÃO | varchar | 30 | NULL | 0 | Código do CAP de repasse |
| NumeroBanco_rec | NÃO | smallint | 2 | NULL | 1 | Número do banco na tabela bancos |
| ContaBanco_rec | NÃO | varchar | 20 | NULL | 1 | Número da conta corrente do banco |
| NumPcb_rec | NÃO | int | 4 | NULL | 1 | Numero do padrão de cobrança |
| DataSegJuros_rec | NÃO | datetime | 8 | NULL | 1 | Data Base da segunda taxa de juros do Parcelamento |
| PorcSegJuros_rec | NÃO | numeric | 9 | NULL | 1 | Porcentagem da segunda taxa de juros que será cobrada na parcela |
| CarenciaAtraso_rec | NÃO | smallint | 2 | NULL | 0 | Dias de carência para cobrança de juros por atraso e multa |
| CarenciaAtrasoCorrecao_rec | NÃO | smallint | 2 | NULL | 0 | Dias de carência para cobrança de correção por atraso |
| CobrarJurosProRata_rec | NÃO | smallint | 2 | NULL | 0 | NULL |
| TipoSeguro_rec | NÃO | tinyint | 1 | NULL | 1 | Tipo do seguro: 0 = MIP (Morte e invalidez permanente do mutuário); 1 = DFI (Danos físicos ao imóvel) |
| ValorPrincipalPrice_rec | NÃO | numeric | 9 | NULL | 0 | Valor do principal real PRICE |
| ValorJurosPrice_rec | NÃO | numeric | 9 | NULL | 0 | Valor do juros real PRICE |
| CobrarJurosProRataPrimeiroMes_rec | NÃO | bit | 1 | NULL | 0 | Realizar o cálculo de juros no primeiro mês como pró-rata: 0 = Não; 1 = Sim |
| CapDescontoCondicional_rec | NÃO | varchar | 30 | NULL | 1 | CAP responsável pelo valor do desconto condicional |
| ValDescontoCondicional_rec | NÃO | numeric | 9 | NULL | 0 | Valor do desconto condicional da parcela recebida |
| ValDescontoCondicionalConf_rec | NÃO | numeric | 9 | NULL | 0 | Valor do desconto condicional da parcela recebida confirmado |

---

## UnidadePer

Armazena as unidades personalizadas por produto/obra, com dados de preço, frações ideais, localização no espelho de vendas e até 45 campos de personalização livres (C1–C45).

| Coluna | Chave | Tipo | Tamanho | Padrão | Null | Descrição |
|--------|:-----:|------|:-------:|:------:|:----:|-----------|
| Empresa_unid | SIM | smallint | 2 | NULL | 0 | Código da empresa |
| Prod_unid | SIM | int | 4 | NULL | 0 | Código do produto |
| NumPer_unid | SIM | int | 4 | NULL | 0 | Contador para definir a personalização |
| Obra_unid | NÃO | varchar | 5 | NULL | 1 | Código da obra |
| Qtde_unid | NÃO | numeric | 9 | NULL | 1 | Quantidade do produto personalizado |
| Vendido_unid | NÃO | tinyint | 1 | NULL | 0 | Status da personalização |
| Codigo_Unid | NÃO | varchar | 5 | NULL | 1 | Código da tabela de preço |
| PorcentPr_Unid | NÃO | numeric | 9 | NULL | 1 | Percentual da tabela de preço |
| C1_unid … C45_unid | NÃO | varchar | 175 | NULL | 1 | Campos C1 a C45: valores personalizados do produto |
| anexos_unid | NÃO | tinyint | 1 | NULL | 1 | Tipos de anexos (Comentário, Pendência e Foto) como somatório |
| Identificador_unid | NÃO | varchar | 30 | NULL | 1 | Identificador para a personalização |
| UsrCad_unid | NÃO | varchar | 8 | NULL | 0 | Login do usuário que cadastrou a unidade |
| DataCad_unid | NÃO | datetime | 8 | NULL | 0 | Data de cadastro da unidade |
| ValPreco_unid | NÃO | numeric | 9 | NULL | 1 | Preço da unidade (para unidades do tipo Aluguel) |
| FracaoIdeal_unid | NÃO | numeric | 9 | NULL | 1 | Fração ideal da unidade em relação ao grupo do empreendimento |
| NumObe_unid | NÃO | int | 4 | NULL | 1 | Número do bloco / etapa |
| ObjEspelhoTop_unid | NÃO | int | 4 | NULL | 1 | Posição Top do objeto no espelho de vendas |
| ObjEspelhoLeft_unid | NÃO | int | 4 | NULL | 1 | Posição Left do objeto no espelho de vendas |
| PorcentComissao_unid | NÃO | numeric | 9 | NULL | 1 | Percentual de comissão da unidade |
| CodTipProd_unid | NÃO | varchar | 30 | NULL | 1 | Código da tipologia do produto |
| NumCategStatus_unid | NÃO | int | 4 | NULL | 1 | Número da categoria de status de personalização |
| FracaoIdealDecimal_unid | NÃO | numeric | 9 | NULL | 1 | Fração ideal em formato decimal |
| DataEntregaChaves_unid | NÃO | datetime | 8 | NULL | 1 | Data de entrega das chaves |
| DataReconhecimentoReceitaMapa_unid | NÃO | datetime | 8 | NULL | 1 | Data de reconhecimento de receita no mapa |

---

## Vendas

Registra os contratos de venda (e aluguel/revenda), com parâmetros financeiros, de cobrança, correção, indexação, provisão contábil e informações fiscais.

| Coluna | Chave | Tipo | Tamanho | Padrão | Null | Descrição |
|--------|:-----:|------|:-------:|:------:|:----:|-----------|
| Empresa_ven | SIM | smallint | 2 | NULL | 0 | Código da empresa |
| Obra_Ven | SIM | varchar | 5 | NULL | 0 | Obra da venda |
| Num_Ven | SIM | int | 4 | 0 | 0 | Número da venda |
| Contrato_Ven | NÃO | int | 4 | 0 | 1 | Número do contrato (-1 = diferente de medição) |
| Vendedor_Ven | NÃO | int | 4 | 0 | 1 | Código do vendedor |
| Cliente_Ven | NÃO | int | 4 | 0 | 1 | Código do cliente |
| ValorTot_Ven | NÃO | numeric | 9 | 0 | 1 | Valor total da venda |
| Juros_Ven | NÃO | numeric | 9 | 0 | 1 | Percentual de juros por atraso |
| Multa_Ven | NÃO | numeric | 9 | 0 | 1 | Percentual de multa por atraso |
| Desconto_Ven | NÃO | numeric | 9 | 0 | 1 | Desconto por adiantamento |
| User_Ven | NÃO | varchar | 8 | NULL | 1 | Usuário que realizou a venda |
| IntExt_Ven | NÃO | varchar | 1 | NULL | 1 | Se a venda é externa ou interna |
| Data_Ven | NÃO | datetime | 8 | NULL | 1 | Data de venda |
| Status_Ven | NÃO | tinyint | 1 | 0 | 1 | Status: (0) Normal; (1) Cancelada; (2) Alterada |
| UserStatus_Ven | NÃO | varchar | 8 | NULL | 1 | Usuário que alterou o status |
| Acrescimo_Ven | NÃO | numeric | 9 | 0 | 1 | Valor do acréscimo na venda |
| PlanoIndexador_Ven | NÃO | tinyint | 1 | 0 | 1 | Se a venda possui plano indexador |
| JurContrato_ven | NÃO | tinyint | 1 | 0 | 1 | Se continua a cobrar juros contratuais em caso de atraso da parcela |
| Adiantamento_ven | NÃO | tinyint | 1 | 0 | 1 | Como será calculado o adiantamento: 0 = Pro-rata; 1 = Mensal |
| StatusEscritura_Ven | NÃO | varchar | 255 | NULL | 1 | Status da escritura |
| StatusCobranca_Ven | NÃO | varchar | 255 | NULL | 1 | Status de cobrança |
| VlrCorretagem_Ven | NÃO | numeric | 9 | 0 | 1 | Valor de corretagem |
| VlrLiberarCorretor_Ven | NÃO | numeric | 9 | 0 | 1 | Valor a liberar para o corretor |
| ReajusteAnual_Ven | NÃO | tinyint | 1 | 0 | 1 | Se será calculado reajuste anual |
| GerarResiduo_Ven | NÃO | tinyint | 1 | 0 | 1 | Se vai gerar resíduo |
| CarenciaAtraso_Ven | NÃO | smallint | 2 | 0 | 0 | Dias de carência para cobrança de juros e multa por atraso |
| RetroagirIdx_Ven | NÃO | smallint | 2 | 0 | 0 | Nº de meses que irá retroagir a data de reajuste |
| DataBaseResiduo_Ven | NÃO | datetime | 8 | NULL | 1 | Data base para gerar as parcelas de resíduo (12 meses após esta data) |
| CorrecaoAtr_Ven | NÃO | tinyint | 1 | NULL | 0 | Correção por atraso |
| CorrecaoProRata_Ven | NÃO | tinyint | 1 | NULL | 0 | Se o cálculo da correção será pró-rata |
| Anexos_ven | NÃO | tinyint | 1 | NULL | 1 | Tipos de anexos do registro (Pendência, Comentário ou Foto) |
| DataCessao_Ven | NÃO | datetime | 8 | NULL | 1 | Data em que foi efetuada a cessão de direito |
| DataCancel_Ven | NÃO | datetime | 8 | NULL | 1 | Data de cancelamento da venda |
| CodDvg_Ven | NÃO | smallint | 2 | NULL | 1 | Código de divulgação vinculado à venda |
| NumFin_Ven | NÃO | smallint | 2 | NULL | 1 | Código da finalidade vinculado à venda |
| AniversarioContr_Ven | NÃO | tinyint | 1 | NULL | 0 | Verificar se haverá aniversário de contrato |
| CobrarTaxaBol_Ven | NÃO | tinyint | 1 | NULL | 0 | Cobrar taxa de boleto |
| DataCad_Ven | NÃO | datetime | 8 | NULL | 0 | Data de cadastro da venda |
| AlmoxCentral_Ven | NÃO | tinyint | 1 | NULL | 0 | Identifica se a venda interna vem do almoxarifado central: 0 = Não; 1 = Sim |
| ObraFiscal_Ven | NÃO | varchar | 5 | NULL | 0 | Obra fiscal da venda |
| TipoVenda_Ven | NÃO | tinyint | 1 | NULL | 0 | Tipo de contrato: 0 = Venda; 1 = Aluguel; 2 = Revenda |
| DiaRepasse_Ven | NÃO | tinyint | 1 | NULL | 0 | Dia do mês para repasse do valor do aluguel |
| ValProvisaoCurto_Ven | NÃO | numeric | 9 | NULL | 0 | Valor para provisionamento de lançamentos de curto prazo |
| ValProvisaoLongo_Ven | NÃO | numeric | 9 | NULL | 0 | Valor para provisionamento de lançamentos de longo prazo |
| CapProvisaoCurto_Ven | NÃO | varchar | 30 | NULL | 1 | Código do CAP de provisão de curto prazo |
| CapProvisaoLongo_Ven | NÃO | varchar | 30 | NULL | 1 | Código do CAP de provisão de longo prazo |
| CarenciaAtrasoCorrecao_ven | NÃO | smallint | 2 | NULL | 0 | Carência para cobrar correção por atraso |
| AntecipaCorrecao_ven | NÃO | tinyint | 1 | NULL | 0 | Se a venda for de correção anual e o cliente antecipar a parcela, cobrar correção diária |
| CobrarJurosRecPosChave_ven | NÃO | tinyint | 1 | NULL | 0 | Cobrar juros em parcela com vencimento anterior ao início de juros, se recebida após essa data |
| DataIniContrato_Ven | NÃO | datetime | 8 | NULL | 1 | Data inicial do contrato de venda/aluguel |
| DataFimContrato_Ven | NÃO | datetime | 8 | NULL | 1 | Data final do contrato de venda/aluguel |
| TipoFianca_ven | NÃO | tinyint | 1 | NULL | 0 | Tipo de fiança: 0 = Sem fiança; 1 = Fiadores; 2 = Bancária; 3 = Caução; 4 = Seguro locatícia; 5 = Carta; 6 = Capitalização; 7 = Imóvel |
| Txt1Fianca_ven | NÃO | varchar | 150 | NULL | 1 | Texto livre definido para cada tipo de fiança (ex.: Autorizado, Cobrança) |
| Txt2Fianca_ven | NÃO | varchar | 150 | NULL | 1 | Texto livre definido para cada tipo de fiança (ex.: Banco, Cedente, Título nº) |
| Txt3Fianca_ven | NÃO | varchar | 150 | NULL | 1 | Texto livre definido para cada tipo de fiança (ex.: Agência, Contato, Cartório) |
| DataFianca_ven | NÃO | datetime | 8 | NULL | 1 | Data (vencimento, pagamento, depósito etc.) da fiança |
| ValFianca_ven | NÃO | numeric | 9 | NULL | 1 | Valor da fiança |
| NomeSegIncendio_ven | NÃO | varchar | 150 | NULL | 1 | Nome da seguradora do seguro incêndio |
| ApoliceSegIncendio_ven | NÃO | varchar | 50 | NULL | 1 | Nº da apólice do seguro contra incêndio |
| ValSegIncendio_ven | NÃO | numeric | 9 | NULL | 1 | Valor da apólice do seguro contra incêndio |
| DataVencSegIncendio_ven | NÃO | datetime | 8 | NULL | 1 | Data de vencimento do seguro |
| MultaFracionada_ven | NÃO | bit | 1 | NULL | 0 | Multa fracionada diariamente (1% ao dia até o total): 0 = Não fracionada (default); 1 = Fracionada |
| AntecipaJurosLinear_ven | NÃO | bit | 1 | NULL | 0 | Antecipar juros de forma linear |
| ValDescontoImposto_ven | NÃO | numeric | 9 | NULL | 0 | Valor de desconto atribuído via lançamento de imposto |
| PeriodoMesReajuste_ven | NÃO | smallint | 2 | NULL | 1 | Frequência em meses da correção: 12 = anual; 6 = semestral; etc. |
| HistLanc_ven | NÃO | varchar | 500 | NULL | 1 | Histórico do lançamento |
| HistLancRec_ven | NÃO | varchar | 500 | NULL | 1 | Histórico do lançamento de recebimento |
| HistLancJurosCorrecao_ven | NÃO | varchar | 500 | NULL | 1 | Histórico do lançamento de juros/correção |
| ZerarCorrecaoNegativa_ven | NÃO | bit | 1 | NULL | 0 | Zerar correção negativa |
| JuroAtrasoMensal_ven | NÃO | bit | 1 | NULL | 0 | Juros por atraso mensal |
| CorrecaoCrescente_ven | NÃO | bit | 1 | NULL | 0 | A correção nunca será menor que a do mês anterior: 0 = Não (default); 1 = Sim |
| SPEDPisCofins_ven | NÃO | bit | 1 | NULL | 0 | Se a venda será enviada para o SPED PIS/COFINS: 0 = Não; 1 = Sim |
| CorrecaoAtrasoPerson_ven | NÃO | bit | 1 | NULL | 0 | Cobrar correção dos dias de atraso do último mês de pagamento de forma personalizada |
| ContratoCEF_ven | NÃO | varchar | 20 | NULL | 1 | Número do contrato de financiamento associativo da Caixa Econômica Federal |
| Atividade_ven | NÃO | tinyint | 1 | NULL | 0 | Atividade da venda |
| ValProvisaoCurtoBaixa_ven | NÃO | numeric | 9 | NULL | 0 | Valor de curto prazo a ser baixado na contabilidade (para vendas canceladas) |
| ValProvisaoLongoBaixa_ven | NÃO | numeric | 9 | NULL | 0 | Valor de longo prazo a ser baixado na contabilidade (para vendas canceladas) |
| ValProvisaoCurtoCessao_ven | NÃO | numeric | 9 | NULL | 0 | Valor de provisão de curto prazo para vendas geradas por cessão de direito |
| ValProvisaoLongoCessao_ven | NÃO | numeric | 9 | NULL | 0 | Valor de provisão de longo prazo para vendas geradas por cessão de direito |
| CapProvisaoCurtoBaixa_ven | NÃO | varchar | 30 | NULL | 1 | Código do CAP de baixa de provisão de curto prazo |
| CapProvisaoLongoBaixa_ven | NÃO | varchar | 30 | NULL | 1 | Código do CAP de baixa de provisão de longo prazo |
| HistLancBaixaProvisao_ven | NÃO | varchar | 500 | NULL | 1 | Histórico utilizado no processamento contábil de distrato e cessão de direitos |
| Validador_ven | NÃO | numeric | 13 | NULL | 0 | Validador interno do registro |
| JurosAnual_ven | NÃO | tinyint | 1 | NULL | 0 | Define se os juros serão ou não mensais |
| PeriodoMesJuros_ven | NÃO | smallint | 2 | NULL | 0 | Período dos juros não mensais |
| ValPrestServico_ven | NÃO | numeric | 9 | NULL | 0 | Valor de prestação de serviço (para vendas do tipo Revenda) |
| AnteciparCorrecaoProxPer_ven | NÃO | bit | 1 | NULL | 0 | Calcular correção por antecipação apenas no próximo aniversário de contrato: 0 = Não; 1 = Sim |
| RET_ven | NÃO | bit | 1 | NULL | 0 | Define se o contrato é RET (Regime Especial de Tributação): 0 = Não; 1 = Sim |
| NumRet_ven | NÃO | smallint | 2 | NULL | 1 | Contador da tabela TabRet |
| NumCsf_ven | NÃO | int | 4 | NULL | 1 | Código de serviço da venda |
| UtilizarDescUltimaParc_ven | NÃO | bit | 1 | NULL | 1 | Se incidirá desconto na última parcela conforme campanha do tipo 1 (desconto total da última parcela) |

---

## VendasLogParc

Log de parametrizações de parcelas associadas às vendas.

| Coluna | Chave | Tipo | Tamanho | Padrão | Null | Descrição |
|--------|:-----:|------|:-------:|:------:|:----:|-----------|
| Empresa_vlp | SIM | smallint | 2 | NULL | 0 | Código da empresa |
| NumVen_Vlp | SIM | int | 4 | 0 | 0 | Número da venda |
| Obra_Vlp | SIM | varchar | 5 | NULL | 0 | Obra da venda |
| NumParam_Vlp | SIM | smallint | 2 | 0 | 0 | Número de parametrizações |
| Tipo_Vlp | NÃO | varchar | 3 | NULL | 1 | Tipo da parcela: (E)ntrada, (P)arcela ou (Balão) |
| NumParc_Vlp | NÃO | int | 4 | 0 | 1 | Número total de parcelas |
| Valor_Vlp | NÃO | numeric | 9 | 0 | 1 | Valor das parcelas |
| Juros_Vlp | NÃO | numeric | 9 | 0 | 1 | Juros da parcela |
| Como_Vlp | NÃO | varchar | 5 | NULL | 1 | Frequência de recebimento da parcela |
| IdxReaj_Vlp | NÃO | varchar | 5 | NULL | 1 | Índice do recebimento |
| Amort_Vlp | NÃO | tinyint | 1 | 0 | 1 | Sistema de amortização: (0) Gradiente; (1) Price; (2) SAC |
| BeginEnd_Vlp | NÃO | tinyint | 1 | 0 | 1 | Se é Begin ou End: (0) Begin; (1) End |
| DtParc_Vlp | NÃO | datetime | 8 | NULL | 1 | Data da 1ª parcela |
| DtJuros_Vlp | NÃO | datetime | 8 | NULL | 1 | Data do 1º juros |
| DtReaj_Vlp | NÃO | datetime | 8 | NULL | 1 | Data do 1º reajuste |
| DtJurosComJuros_vlp | NÃO | tinyint | 1 | NULL | 0 | Se a parcela no mesmo mês/dia da data de início de juros terá juros calculados (parcela price) |
| DataSegJuros_vlp | NÃO | datetime | 8 | NULL | 1 | Data base da segunda taxa de juros do parcelamento |
| PorcSegJuros_vlp | NÃO | numeric | 9 | NULL | 1 | Porcentagem da segunda taxa de juros a ser cobrada na parcela |
| CarenciaAtraso_vlp | NÃO | smallint | 2 | NULL | 0 | Dias de carência para cobrança de juros por atraso e multa |
| CarenciaAtrasoCorrecao_vlp | NÃO | smallint | 2 | NULL | 0 | Dias de carência para cobrança de correção por atraso |
| CobrarJurosProRata_vlp | NÃO | smallint | 2 | NULL | 0 | Cobrar juros pró-rata |
| CobrarJurosProRataPrimeiroMes_Vlp | NÃO | bit | 1 | NULL | 0 | Calcular juros no primeiro mês como pró-rata: 0 = Não; 1 = Sim |

---

## VendasRecebidas

Espelho da tabela Vendas com dados das vendas que foram recebidas/quitadas, acrescentando o status (3) Quitada.

| Coluna | Chave | Tipo | Tamanho | Padrão | Null | Descrição |
|--------|:-----:|------|:-------:|:------:|:----:|-----------|
| Empresa_vrec | SIM | smallint | 2 | NULL | 0 | Código da empresa |
| Num_VRec | SIM | int | 4 | 0 | 0 | Número da venda |
| Obra_VRec | SIM | varchar | 5 | NULL | 0 | Obra da venda |
| Contrato_VRec | NÃO | int | 4 | 0 | 1 | Número do contrato (-1 = diferente de medição) |
| Vendedor_VRec | NÃO | int | 4 | 0 | 1 | Código do vendedor |
| Cliente_VRec | NÃO | int | 4 | 0 | 1 | Código do cliente |
| ValorTot_VRec | NÃO | numeric | 9 | 0 | 1 | Valor total da venda |
| Juros_VRec | NÃO | numeric | 9 | 0 | 1 | Percentual de juros por atraso |
| Multa_VRec | NÃO | numeric | 9 | 0 | 1 | Percentual de multa por atraso |
| Desconto_VRec | NÃO | numeric | 9 | 0 | 1 | Desconto por adiantamento |
| User_VRec | NÃO | varchar | 8 | NULL | 1 | Usuário que realizou a venda |
| IntExt_VRec | NÃO | varchar | 1 | NULL | 1 | Se a venda é externa ou interna |
| Data_VRec | NÃO | datetime | 8 | NULL | 1 | Data de venda |
| Status_VRec | NÃO | tinyint | 1 | 0 | 1 | Status: (0) Normal; (1) Cancelada; (2) Alterada; (3) Quitada |
| UserStatus_VRec | NÃO | varchar | 8 | NULL | 1 | Usuário que alterou o status |
| Acrescimo_VRec | NÃO | numeric | 9 | 0 | 1 | Valor do acréscimo na venda |
| PlanoIndexador_VRec | NÃO | tinyint | 1 | 0 | 1 | Se a venda possui plano indexador |
| JurContrato_VRec | NÃO | tinyint | 1 | 0 | 1 | Se continua a cobrar juros contratuais em caso de atraso da parcela |
| Adiantamento_VRec | NÃO | tinyint | 1 | 0 | 1 | Como será calculado o adiantamento: 0 = Pro-rata; 1 = Mensal |
| StatusEscritura_VRec | NÃO | varchar | 255 | NULL | 1 | Status da escritura |
| StatusCobranca_VRec | NÃO | varchar | 255 | NULL | 1 | Status de cobrança |
| VlrCorretagem_VRec | NÃO | numeric | 9 | 0 | 1 | Valor de corretagem |
| VlrLiberarCorretor_VRec | NÃO | numeric | 9 | 0 | 1 | Valor a liberar para o corretor |
| ReajusteAnual_VRec | NÃO | tinyint | 1 | 0 | 1 | Se será calculado reajuste anual |
| GerarResiduo_VRec | NÃO | tinyint | 1 | 0 | 1 | Se vai gerar resíduo |
| CarenciaAtraso_VRec | NÃO | smallint | 2 | 0 | 0 | Dias de carência para cobrança de juros e multa por atraso |
| RetroagirIdx_VRec | NÃO | smallint | 2 | 0 | 0 | Nº de meses que irá retroagir a data de reajuste |
| DataBaseResiduo_Vrec | NÃO | datetime | 8 | NULL | 1 | Data base para gerar as parcelas de resíduo (12 meses após esta data) |
| CorrecaoAtr_VRec | NÃO | tinyint | 1 | NULL | 0 | Correção por atraso |
| CorrecaoProRata_VRec | NÃO | tinyint | 1 | NULL | 0 | Se o cálculo da correção será pró-rata |
| Anexos_Vrec | NÃO | tinyint | 1 | NULL | 1 | Tipos de anexos do registro (Pendência, Comentário ou Foto) |
| DataCessao_Vrec | NÃO | datetime | 8 | NULL | 1 | Data da cessão de direito |
| DataCancel_Vrec | NÃO | datetime | 8 | NULL | 1 | Data de cancelamento da venda |
| CodDvg_Vrec | NÃO | smallint | 2 | NULL | 1 | Código de divulgação vinculado à venda recebida |
| NumFin_Vrec | NÃO | smallint | 2 | NULL | 1 | Código da finalidade vinculado à venda recebida |
| AniversarioContr_Vrec | NÃO | tinyint | 1 | NULL | 0 | Se haverá aniversário de contrato |
| CobrarTaxaBol_Vrec | NÃO | tinyint | 1 | NULL | 0 | 0 = Não cobrar taxa; 1 = Cobrar taxa |
| DataCad_Vrec | NÃO | datetime | 8 | NULL | 0 | Data de cadastro da venda |
| AlmoxCentral_Vrec | NÃO | tinyint | 1 | NULL | 0 | Se a venda vem do almoxarifado central: 0 = Não; 1 = Sim |
| ObraFiscal_Vrec | NÃO | varchar | 5 | NULL | 0 | Obra fiscal da venda |
| TipoVenda_VRec | NÃO | tinyint | 1 | NULL | 0 | Tipo de contrato: 0 = Venda; 1 = Aluguel; 2 = Revenda |
| DiaRepasse_VRec | NÃO | tinyint | 1 | NULL | 0 | Dia do mês para repasse do valor do aluguel |
| ValProvisaoCurto_Vrec | NÃO | numeric | 9 | NULL | 0 | Valor para provisionamento de lançamentos de curto prazo |
| ValProvisaoLongo_VRec | NÃO | numeric | 9 | NULL | 0 | Valor para provisionamento de lançamentos de longo prazo |
| CapProvisaoCurto_Vrec | NÃO | varchar | 30 | NULL | 1 | Código do CAP de provisão de curto prazo |
| CapProvisaoLongo_Vrec | NÃO | varchar | 30 | NULL | 1 | Código do CAP de provisão de longo prazo |
| CarenciaAtrasoCorrecao_Vrec | NÃO | smallint | 2 | NULL | 0 | Carência para cobrar correção por atraso |
| AntecipaCorrecao_Vrec | NÃO | tinyint | 1 | NULL | 0 | Se a venda for de correção anual e o cliente antecipar a parcela, cobrar correção diária |
| CobrarJurosRecPosChave_Vrec | NÃO | tinyint | 1 | NULL | 0 | Cobrar juros em parcela com vencimento anterior ao início de juros, se recebida após essa data |
| DataIniContrato_Vrec | NÃO | datetime | 8 | NULL | 1 | Data inicial do contrato de venda/aluguel |
| DataFimContrato_Vrec | NÃO | datetime | 8 | NULL | 1 | Data final do contrato de venda/aluguel |
| TipoFianca_vrec | NÃO | tinyint | 1 | NULL | 0 | Tipo de fiança: 0 = Sem fiança; 1 = Fiadores; 2 = Bancária; 3 = Caução; 4 = Seguro locatícia; 5 = Carta; 6 = Capitalização; 7 = Imóvel |
| Txt1Fianca_vrec | NÃO | varchar | 150 | NULL | 1 | Texto livre definido para cada tipo de fiança (ex.: Autorizado, Cobrança) |
| Txt2Fianca_vrec | NÃO | varchar | 150 | NULL | 1 | Texto livre definido para cada tipo de fiança (ex.: Banco, Cedente, Título nº) |
| Txt3Fianca_vrec | NÃO | varchar | 150 | NULL | 1 | Texto livre definido para cada tipo de fiança (ex.: Agência, Contato, Cartório) |
| DataFianca_vrec | NÃO | datetime | 8 | NULL | 1 | Data (vencimento, pagamento, depósito etc.) da fiança |
| ValFianca_vrec | NÃO | numeric | 9 | NULL | 1 | Valor da fiança |
| NomeSegIncendio_vrec | NÃO | varchar | 150 | NULL | 1 | Nome da seguradora do seguro incêndio |
| ApoliceSegIncendio_vrec | NÃO | varchar | 50 | NULL | 1 | Nº da apólice do seguro contra incêndio |
| ValSegIncendio_vrec | NÃO | numeric | 9 | NULL | 1 | Valor da apólice do seguro contra incêndio |
| DataVencSegIncendio_vrec | NÃO | datetime | 8 | NULL | 1 | Data de vencimento do seguro |
| MultaFracionada_Vrec | NÃO | bit | 1 | NULL | 0 | Multa fracionada diariamente (1% ao dia até o total): 0 = Não fracionada (default); 1 = Fracionada |
| AntecipaJurosLinear_vrec | NÃO | bit | 1 | NULL | 0 | Antecipar juros de forma linear |
| ValDescontoImposto_vrec | NÃO | numeric | 9 | NULL | 0 | Valor de desconto atribuído via lançamento de imposto |
| PeriodoMesReajuste_vrec | NÃO | smallint | 2 | NULL | 1 | Frequência em meses da correção: 12 = anual; 6 = semestral; etc. |
| HistLanc_vrec | NÃO | varchar | 500 | NULL | 1 | Histórico do lançamento |
| HistLancRec_vrec | NÃO | varchar | 500 | NULL | 1 | Histórico do lançamento de recebimento |
| HistLancJurosCorrecao_vrec | NÃO | varchar | 500 | NULL | 1 | Histórico do lançamento de juros/correção |
| ZerarCorrecaoNegativa_vrec | NÃO | bit | 1 | NULL | 0 | Zerar correção negativa |
| JuroAtrasoMensal_vrec | NÃO | bit | 1 | NULL | 0 | Juros por atraso mensal |
| CorrecaoCrescente_VRec | NÃO | bit | 1 | NULL | 0 | A correção nunca será menor que a do mês anterior: 0 = Não (default); 1 = Sim |
| SPEDPisCofins_vrec | NÃO | bit | 1 | NULL | 0 | Se a venda será enviada para o SPED PIS/COFINS: 0 = Não; 1 = Sim |
| CorrecaoAtrasoPerson_vrec | NÃO | bit | 1 | NULL | 0 | Cobrar correção dos dias de atraso do último mês de pagamento de forma personalizada |
| ContratoCEF_vrec | NÃO | varchar | 20 | NULL | 1 | Número do contrato de financiamento associativo da Caixa Econômica Federal |
| Atividade_vrec | NÃO | tinyint | 1 | NULL | 0 | Atividade da venda |
| ValProvisaoCurtoBaixa_vrec | NÃO | numeric | 9 | NULL | 0 | Valor de curto prazo a ser baixado na contabilidade (para vendas canceladas) |
| ValProvisaoLongoBaixa_vrec | NÃO | numeric | 9 | NULL | 0 | Valor de longo prazo a ser baixado na contabilidade (para vendas canceladas) |
| ValProvisaoCurtoCessao_vrec | NÃO | numeric | 9 | NULL | 0 | Valor de provisão de curto prazo para vendas geradas por cessão de direito |
| ValProvisaoLongoCessao_vrec | NÃO | numeric | 9 | NULL | 0 | Valor de provisão de longo prazo para vendas geradas por cessão de direito |
| CapProvisaoCurtoBaixa_vrec | NÃO | varchar | 30 | NULL | 1 | Código do CAP de baixa de provisão de curto prazo |
| CapProvisaoLongoBaixa_vrec | NÃO | varchar | 30 | NULL | 1 | Código do CAP de baixa de provisão de longo prazo |
| HistLancBaixaProvisao_vrec | NÃO | varchar | 500 | NULL | 1 | Histórico utilizado no processamento contábil de distrato e cessão de direitos |
| Validador_vrec | NÃO | numeric | 13 | NULL | 0 | Validador interno do registro |
| JurosAnual_vrec | NÃO | tinyint | 1 | NULL | 0 | Define se os juros serão ou não mensais |
| PeriodoMesJuros_vrec | NÃO | smallint | 2 | NULL | 0 | Período dos juros não mensais |
| ValPrestServico_vrec | NÃO | numeric | 9 | NULL | 0 | Valor de prestação de serviço (para vendas do tipo Revenda) |
| AnteciparCorrecaoProxPer_vrec | NÃO | bit | 1 | NULL | 0 | Calcular correção por antecipação apenas no próximo aniversário de contrato: 0 = Não; 1 = Sim |
| RET_vrec | NÃO | bit | 1 | NULL | 0 | Define se o contrato é RET (Regime Especial de Tributação): 0 = Não; 1 = Sim |
| NumRet_vrec | NÃO | smallint | 2 | NULL | 1 | Contador da tabela TabRet |
| NumCsf_vrec | NÃO | int | 4 | NULL | 1 | Código de serviço da venda |
| UtilizarDescUltimaParc_vrec | NÃO | bit | 1 | NULL | 1 | Se incidirá desconto na última parcela conforme campanha do tipo 1 (desconto total da última parcela) |

---

## VendRecLogParc

Log de parametrizações de parcelas associadas às vendas recebidas.

| Coluna | Chave | Tipo | Tamanho | Padrão | Null | Descrição |
|--------|:-----:|------|:-------:|:------:|:----:|-----------|
| Empresa_vrl | SIM | smallint | 2 | NULL | 0 | Código da empresa |
| NumVen_Vrl | SIM | int | 4 | 0 | 0 | Número da venda |
| Obra_Vrl | SIM | varchar | 5 | NULL | 0 | Obra da venda |
| NumParam_Vrl | SIM | smallint | 2 | 0 | 0 | Número de parametrizações |
| Tipo_Vrl | NÃO | varchar | 3 | NULL | 1 | Tipo da parcela: (E)ntrada, (P)arcela ou (Balão) |
| NumParc_Vrl | NÃO | int | 4 | 0 | 1 | Número total de parcelas |
| Valor_Vrl | NÃO | numeric | 9 | 0 | 1 | Valor das parcelas |
| Juros_Vrl | NÃO | numeric | 9 | 0 | 1 | Juros da parcela |
| Como_Vrl | NÃO | varchar | 5 | NULL | 1 | Frequência de recebimento da parcela |
| IdxReaj_Vrl | NÃO | varchar | 5 | NULL | 1 | Índice do recebimento |
| Amort_Vrl | NÃO | tinyint | 1 | 0 | 1 | Sistema de amortização: (0) Gradiente; (1) Price; (2) SAC |
| BeginEnd_Vrl | NÃO | tinyint | 1 | 0 | 1 | Se é Begin ou End: (0) Begin; (1) End |
| DtParc_Vrl | NÃO | datetime | 8 | NULL | 1 | Data da 1ª parcela |
| DtJuros_Vrl | NÃO | datetime | 8 | NULL | 1 | Data do 1º juros |
| DtReaj_Vrl | NÃO | datetime | 8 | NULL | 1 | Data do 1º reajuste |
| DtJurosComJuros_Vrl | NÃO | tinyint | 1 | NULL | 0 | Se a parcela no mesmo mês/dia da data de início de juros terá juros calculados (parcela price) |
| DataSegJuros_vrl | NÃO | datetime | 8 | NULL | 1 | Data base da segunda taxa de juros do parcelamento |
| PorcSegJuros_vrl | NÃO | numeric | 9 | NULL | 1 | Porcentagem da segunda taxa de juros a ser cobrada na parcela |
| CarenciaAtraso_vrl | NÃO | smallint | 2 | NULL | 0 | Dias de carência para cobrança de juros por atraso e multa |
| CarenciaAtrasoCorrecao_vrl | NÃO | smallint | 2 | NULL | 0 | Dias de carência para cobrança de correção por atraso |
| CobrarJurosProRata_vrl | NÃO | smallint | 2 | NULL | 0 | Cobrar juros pró-rata |
| CobrarJurosProRataPrimeiroMes_vrl | NÃO | bit | 1 | NULL | 0 | Calcular juros no primeiro mês como pró-rata: 0 = Não; 1 = Sim |

---

## ContasReceberCalc

Armazena os valores calculados das parcelas a receber, incluindo principal, juros, correção, multa, taxa de boleto e valores antecipados.

| Coluna | Chave | Tipo | Tamanho | Padrão | Null | Descrição |
|--------|:-----:|------|:-------:|:------:|:----:|-----------|
| Empresa_crc | NÃO | smallint | 2 | NULL | 0 | Código da empresa |
| Obra_crc | NÃO | varchar | 5 | NULL | 0 | Código da obra |
| NumVend_crc | NÃO | int | 4 | NULL | 0 | Número da venda |
| NumParc_crc | NÃO | int | 4 | NULL | 0 | Número da parcela |
| Tipo_crc | NÃO | varchar | 3 | NULL | 0 | Tipo da parcela |
| NumParcGer_crc | NÃO | int | 4 | NULL | 0 | Número geral da parcela |
| DataCalc_crc | NÃO | datetime | 8 | NULL | 0 | Data do cálculo |
| ValParcela_crc | NÃO | numeric | 9 | NULL | 0 | Valor da parcela calculada |
| ValPrincipal_crc | NÃO | numeric | 9 | NULL | 0 | Valor do principal |
| ValPrincipalPrice_crc | NÃO | numeric | 9 | NULL | 0 | Valor do principal (Price) |
| ValJurosComp_crc | NÃO | numeric | 9 | NULL | 0 | Valor dos juros compostos |
| ValJurosCompPrice_crc | NÃO | numeric | 9 | NULL | 0 | Valor dos juros compostos (Price) |
| ValCorrecao_crc | NÃO | numeric | 9 | NULL | 0 | Valor da correção monetária |
| ValJuroAtraso_crc | NÃO | numeric | 9 | NULL | 0 | Valor dos juros por atraso |
| ValMultaAtraso_crc | NÃO | numeric | 9 | NULL | 0 | Valor da multa por atraso |
| ValCorrecaoAtraso_crc | NÃO | numeric | 9 | NULL | 0 | Valor da correção por atraso |
| ValDescontoCusta_crc | NÃO | numeric | 9 | NULL | 0 | Valor do desconto de custas |
| ValDescontoImposto_crc | NÃO | numeric | 9 | NULL | 0 | Valor do desconto de imposto |
| ValTaxaBol_crc | NÃO | numeric | 9 | NULL | 0 | Valor da taxa de boleto |
| ValParcelaAntec_crc | NÃO | numeric | 9 | NULL | 1 | Valor da parcela com antecipação |
| ValJurosCompAntec_crc | NÃO | numeric | 9 | NULL | 1 | Valor dos juros compostos antecipados |
| ValJurosCompPriceAntec_crc | NÃO | numeric | 9 | NULL | 1 | Valor dos juros compostos Price antecipados |
| ValCorrecaoAntec_crc | NÃO | numeric | 9 | NULL | 1 | Valor da correção antecipada |
| CapJuros_crc | NÃO | varchar | 30 | NULL | 1 | CAP de juros |
| CapCorrecao_crc | NÃO | varchar | 30 | NULL | 1 | CAP de correção |
| Cap_crc | NÃO | varchar | 30 | NULL | 1 | CAP da venda |
| ValDescontoAVPPorFaixa_crc | NÃO | numeric | 9 | NULL | 0 | Valor do desconto AVP por faixa |

---

## Empresas

Cadastro das empresas do grupo, com dados de identificação fiscal, endereço, contato e configurações de integração.

| Coluna | Chave | Tipo | Tamanho | Padrão | Null | Descrição |
|--------|:-----:|------|:-------:|:------:|:----:|-----------|
| Codigo_emp | SIM | smallint | 2 | NULL | 0 | Código da empresa |
| Desc_emp | NÃO | varchar | 150 | NULL | 1 | Descrição da empresa |
| CGC_emp | NÃO | varchar | 14 | NULL | 0 | CGC da empresa |
| IE_emp | NÃO | varchar | 20 | NULL | 0 | Inscrição estadual da empresa |
| Endereco_emp | NÃO | varchar | 100 | NULL | 1 | Endereço da sede da empresa |
| Setor_emp | NÃO | varchar | 100 | NULL | 1 | Setor da sede da empresa |
| Cidade_emp | NÃO | varchar | 50 | NULL | 1 | Cidade da sede da empresa |
| UF_emp | NÃO | varchar | 5 | NULL | 1 | Estado da sede da empresa |
| CEP_emp | NÃO | varchar | 8 | NULL | 0 | CEP da sede da empresa |
| Fone_emp | NÃO | varchar | 20 | NULL | 1 | Telefone da empresa |
| Fax_emp | NÃO | varchar | 20 | NULL | 1 | Fax da empresa |
| RedIcms_emp | NÃO | numeric | 9 | 0 | 0 | Valor da redução do ICMS |
| IpiIsenta_emp | NÃO | tinyint | 1 | 0 | 0 | Se a empresa é isenta do pagamento do IPI |
| AtInat_emp | NÃO | tinyint | 1 | 0 | 0 | 0 = Ativo; 1 = Inativo |
| CodEmPresaNet_emp | NÃO | varchar | 10 | NULL | 1 | Código da empresa no site Construcompras |
| Anexos_Emp | NÃO | tinyint | 1 | NULL | 1 | Tipos de anexos do registro (Foto, Comentário e Pendência) armazenados como somatório |
| InscrMunic_emp | NÃO | varchar | 30 | NULL | 1 | Inscrição municipal da empresa |
| EmpresaFolha_emp | NÃO | varchar | 10 | NULL | 1 | Código de DePara da empresa para geração de arquivo de folha |
| NumCid_emp | NÃO | int | 4 | NULL | 1 | Código da cidade |
| email_emp | NÃO | varchar | 50 | NULL | 1 | Endereço de e-mail |
| TipoInsc_emp | NÃO | tinyint | 1 | NULL | 0 | 1 = CNPJ; 2 = CEI (pessoas físicas) |
| NumEnd_emp | NÃO | varchar | 20 | NULL | 1 | Número do endereço |
| OptSimples_emp | NÃO | tinyint | 1 | NULL | 1 | Se a empresa é optante pelo Simples e qual a opção |
| QtdeSocio_Emp | NÃO | tinyint | 1 | NULL | 1 | Quantidade de sócios |
| DDDFone_Emp | NÃO | varchar | 2 | NULL | 1 | DDD do telefone |
| DDDFax_Emp | NÃO | varchar | 2 | NULL | 1 | DDD do fax |
| IncetivadorCultural_emp | NÃO | bit | 1 | NULL | 1 | Se é incentivador cultural |
| CodIdxCorrPat_Emp | NÃO | varchar | 5 | NULL | 1 | Código do índice de correção patrimonial |
| CodIdxIndPat_Emp | NÃO | varchar | 5 | NULL | 1 | Código do índice de indexação patrimonial |
| DataSimples_emp | NÃO | datetime | 8 | NULL | 1 | Data de adesão ao Simples |
| InsNIRE_emp | NÃO | varchar | 11 | NULL | 1 | Número de inscrição no registro de empresas |
| InsSuframa_emp | NÃO | varchar | 9 | NULL | 1 | Número de inscrição no SUFRAMA |
| NumBrr_emp | NÃO | int | 4 | NULL | 1 | Código do bairro |
| NumLogr_emp | NÃO | int | 4 | NULL | 1 | Código do logradouro |
| NumCd_emp | NÃO | int | 4 | NULL | 1 | Contador da tabela CampanhaDesconto |
| CodPesEmpresa_emp | NÃO | int | 4 | NULL | 1 | Código da pessoa vinculada à empresa |
| CodGrupo_emp | NÃO | varchar | 30 | NULL | 1 | Código do grupo da empresa |

---

## ItensRecebidas

Itens das vendas recebidas/quitadas, espelho de ItensVenda para contratos migrados para VendasRecebidas.

| Coluna | Chave | Tipo | Tamanho | Padrão | Null | Descrição |
|--------|:-----:|------|:-------:|:------:|:----:|-----------|
| Empresa_itr | SIM | smallint | 2 | NULL | 0 | Código da empresa |
| NumVend_Itr | SIM | int | 4 | 0 | 0 | Número da venda |
| Obra_Itr | SIM | varchar | 5 | NULL | 0 | Obra da venda |
| Produto_Itr | SIM | int | 4 | 0 | 0 | Produto da venda |
| CodPerson_Itr | SIM | int | 4 | 0 | 0 | Código de personalização |
| PrecoProc_Itr | NÃO | numeric | 9 | 0 | 1 | Preço do produto |
| Qtde_Itr | NÃO | numeric | 9 | 0 | 1 | Quantidade do produto |
| Contrato_Itr | NÃO | int | 4 | 0 | 1 | Contrato do produto escolhido |
| Item_Itr | NÃO | varchar | 50 | NULL | 1 | Item do produto (vem do PlanProd) |
| ValComissaoDir_itr | NÃO | numeric | 9 | NULL | 0 | Valor da comissão paga diretamente |
| PorcentComissao_itr | NÃO | numeric | 9 | NULL | 0 | Percentual de comissão no produto |
| PorcentItem_itr | NÃO | numeric | 9 | NULL | 0 | Percentual do item |
| UnicoItemDimob_itr | NÃO | tinyint | 1 | NULL | 0 | Se é único item para o DIMOB |

---

## ItensVenda

Itens das vendas ativas, relacionando produto e personalização a cada contrato de venda.

| Coluna | Chave | Tipo | Tamanho | Padrão | Null | Descrição |
|--------|:-----:|------|:-------:|:------:|:----:|-----------|
| Empresa_itv | SIM | smallint | 2 | NULL | 0 | Código da empresa |
| NumVend_Itv | SIM | int | 4 | 0 | 0 | Número da venda |
| Obra_Itv | SIM | varchar | 5 | NULL | 0 | Obra da venda |
| Produto_Itv | SIM | int | 4 | 0 | 0 | Produto da venda |
| CodPerson_Itv | SIM | int | 4 | 0 | 0 | Código de personalização |
| PrecoProc_Itv | NÃO | numeric | 9 | 0 | 1 | Preço do produto |
| Qtde_Itv | NÃO | numeric | 9 | 0 | 1 | Quantidade do produto |
| Contrato_Itv | NÃO | int | 4 | 0 | 1 | Contrato do produto escolhido |
| Item_Itv | NÃO | varchar | 50 | NULL | 1 | Item do produto (vem do PlanProd) |
| ValComissaoDir_Itv | NÃO | numeric | 9 | NULL | 0 | Valor da comissão paga diretamente |
| PorcentComissao_itv | NÃO | numeric | 9 | NULL | 0 | Percentual de comissão no produto |
| PorcentItem_itv | NÃO | numeric | 9 | NULL | 0 | Percentual do item |
| UnicoItemDimob_itv | NÃO | tinyint | 1 | NULL | 0 | Se é único item para o DIMOB |

---

## Pessoas

Cadastro de pessoas físicas e jurídicas (clientes, fornecedores, funcionários), com dados de identificação, contato e acesso ao portal.

| Coluna | Chave | Tipo | Tamanho | Padrão | Null | Descrição |
|--------|:-----:|------|:-------:|:------:|:----:|-----------|
| cod_pes | SIM | int | 4 | NULL | 0 | Código da pessoa |
| nome_pes | NÃO | varchar | 150 | NULL | 1 | Nome / Razão Social |
| tipo_pes | NÃO | tinyint | 1 | 0 | 1 | 0 = Física; 1 = Jurídica |
| cpf_pes | NÃO | varchar | 14 | NULL | 1 | Número do CPF ou CGC |
| dtcad_pes | NÃO | datetime | 8 | NULL | 1 | Data do cadastro |
| dtnasc_pes | NÃO | datetime | 8 | NULL | 1 | Data de nascimento / fundação |
| IntExt_pes | NÃO | tinyint | 1 | 0 | 1 | 1 = Interno; 2 = Externo |
| UsrCad_pes | NÃO | varchar | 8 | NULL | 1 | Login do usuário que cadastrou |
| UsrAlt_pes | NÃO | varchar | 8 | NULL | 1 | Login do usuário da última alteração |
| Status_pes | NÃO | tinyint | 1 | 0 | 1 | 1 = Temporário; 2 = Confirmado |
| Tratamento_pes | NÃO | varchar | 50 | NULL | 1 | Forma de tratamento (Sr., Sra., Ilmo. etc.) |
| Email_pes | NÃO | varchar | 400 | NULL | 1 | E-mail da pessoa / empresa |
| EndWWW_pes | NÃO | varchar | 255 | NULL | 1 | Site da pessoa / empresa |
| Matricula_Pes | NÃO | varchar | 15 | NULL | 1 | Matrícula do funcionário na folha de pagamento (único) |
| AtInat_pes | NÃO | tinyint | 1 | 0 | 0 | 0 = Ativo; 1 = Inativo |
| DataAlt_pes | NÃO | datetime | 8 | NULL | 1 | Data da última alteração |
| NomeFant_Pes | NÃO | varchar | 150 | NULL | 1 | Nome fantasia |
| Anexos_pes | NÃO | tinyint | 1 | NULL | 1 | Tipos de anexos do registro (Pendência, Comentário ou Foto) |
| InscrMunic_pes | NÃO | varchar | 30 | NULL | 1 | Número da inscrição municipal |
| inscrest_pes | NÃO | varchar | 30 | NULL | 1 | Número da inscrição estadual |
| Login_pes | NÃO | varchar | 30 | NULL | 1 | Login para acesso à área de clientes no portal |
| Senha_pes | NÃO | varchar | 15 | NULL | 1 | Senha para acesso à área de clientes no portal |
| CNAE_pes | NÃO | varchar | 8 | NULL | 1 | Código CNAE da atividade econômica |
| DataCadPortal_pes | NÃO | datetime | 8 | NULL | 1 | Data de cadastro no portal |
| CadastradoPrefeituraGyn_pes | NÃO | bit | 1 | NULL | 0 | 0 = Não cadastrado; 1 = Cadastrado na prefeitura de Goiânia |
| HabilitadoRiscoSacado_pes | NÃO | bit | 1 | NULL | 0 | 0 = Não habilitado; 1 = Habilitado para risco sacado |
| CEI_Pes | NÃO | varchar | 12 | NULL | 1 | Número de inscrição CEI (pessoa física ou jurídica) |
| IntegradoEDI_pes | NÃO | int | 4 | NULL | 1 | Integração EDI |
| QualificaoSped_pes | NÃO | varchar | 5 | NULL | 1 | Qualificação no SPED |
| siglaobr_pes | NÃO | varchar | 5 | NULL | 1 | Sigla da obra vinculada |
| siglaEmp_pes | NÃO | smallint | 2 | NULL | 1 | Sigla da empresa vinculada |
| BloqueioLgpd_Pes | NÃO | tinyint | 1 | NULL | 1 | Bloqueio por solicitação LGPD |

---

## PesTel

Telefones das pessoas cadastradas, com suporte a múltiplos registros por pessoa (residencial, comercial, celular etc.).

| Coluna | Chave | Tipo | Tamanho | Padrão | Null | Descrição |
|--------|:-----:|------|:-------:|:------:|:----:|-----------|
| pes_tel | SIM | int | 4 | NULL | 0 | Código da pessoa |
| fone_tel | SIM | varchar | 11 | NULL | 0 | Número do telefone |
| ddd_tel | SIM | varchar | 4 | NULL | 0 | DDD do telefone |
| ram_tel | NÃO | varchar | 50 | NULL | 1 | Número do ramal |
| tipo_tel | NÃO | tinyint | 1 | 0 | 1 | Tipo: 0 = Residencial; 1 = Comercial; 2 = Celular; 3 = Recado; 4 = Fax; 5 = Bip; 6 = Telex; 7 = Outro; 8 = Fone/Fax |

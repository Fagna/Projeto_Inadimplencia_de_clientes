# Inadimplência de clientes de cartão de crédito

Esse projeto utilizou a base de dados encontrada no kaggle que pode ser acessada pelo [link.](https://www.kaggle.com/datasets/gabrieloliveirasan/inadimplncia-de-clientes-de-carto-de-crdito?resource=download) Para mais detalhes sobre os dados acesse o [Machine Learning Repository.](https://archive.ics.uci.edu/ml/datasets/default+of+credit+card+clients)

A variável alvo é Status de pagamento (1: Inadimplente, 0: Adimplente), as demais variáveis previsoras, são: limite de crédito, estado civil, escolaridade, sexo, idade e informações sobre histórico de faturas e pagamentos nos últimos 6 meses, como, valor da fatura, valor pago e status do pagamento.

**Objetivos:** Avaliar se os atributos: limite de crédito, estado civil, escolaridade, sexo, idade (categorias foram criadas para as variáveis limite de crédito e idade) possuem associação com a inadimplência de clientes. Em caso de positivo determinar o grau de associação. Obter um modelo de previsão utilizando algoritmos de aprendizado de máquina.

Testes de hipóteses foram realizados e outras medidas estatísticas foram obtidas. Em seguida, foi obtido um modelo de aprendizado de máquina, considerando técnicas de subamstragem e o princípio da parcimônia. 

Resumo das etapas realizadas:

1º Tratamento de inconsistências nos dados;

2º Análise exploratória;

3º Testes de hipóteses para todas as variáveis categóricas: O teste qui-quadrado para avaliar a existência de dependencia entres as variáveis preditivas e a variável predita. Exemplo: Existe associação entre o nível de escolaridade de cliente e a inadimplência? A resposta para essa pergunta foi "sim". Para medir o grau de associação ou dependência foi utilizada a razão de chances ou *odds ratio*;

4º Modelagem: Uso de algoritmos de Machine Learning para obtenção de um modelo capaz de classificar o status de pagamento do cliente no próximo mês (1 = Inadimplente, 0 = Adimplente). 

**Resultados:**

- A partir dos teste estatísticos (teste qui-quadrado e razão de chances), observou-se que uma tendência maior de inadimplência entre cliente do sexo masculino, escolaridade ensino médio, categoria de crédito silver (menor faixa de limite de crédito), estado civil casado ou não especificado e faixa etária dos 20 à 29 anos e a partir dos 40 anos.

- O modelo obtido por meio de técnicas de machine learning, teve capacidade de distinguir entre as duas classes, adimplente e inadimplente, em 71%, com probabilidade de 0.78 de acerto da classe positiva. Em se tratando da tomada de decisão, deve-se tomar maior cuidado com a taxa de *falsos negativos* cometidos pelo modelo, ou seja, é mais preocupante a situação em que o modelo prevê que o cliente **vai pagar** quando na verdade **não vai pagar**, do que prevê que o clente **não vai pagar** quando na verdade **vai pagar**. Lembre, **vai pagar (adimplente) é nossa classe negativa**, e **não vai pagar (inadimplente) é nossa classe positiva**. Nesta situação, o modelo que obteve maior probabilidade de acerto da classe positiva e maior poder discriminante cometeu uma taxa de 0.37 (37%) de falsos negativos. Para mais detalhes acesse o notebook [Análise exploratória e modelo](https://github.com/Fagna/Projeto_Inadimplencia_de_clientes/blob/main/Analise-explorat%C3%B3ria-e-modelo%20.ipynb).

Ferramentas utilizadas: Rstudio, Jupyter notebook e Power BI.

Links:

- [Visual em Power BI](https://app.powerbi.com/view?r=eyJrIjoiMzNlYTA0YmUtMDRiOC00NWU4LWE0MDAtMGIxYjc5ZDdjNDEyIiwidCI6ImVmODAxNDBiLTE1MGQtNDY0Yy04ZGY4LTUwZGNjMmMyMzk2YyJ9): Um visual básico em Power BI que mostra uma visão geral da base de dados e uma Storytelling.

- [Análise complementar em R](https://rpubs.com/fagna/1040245): A Linguagem de programação R é sem dúvidas uma das melhores para testes estatísticos. Portanto, mesmo fazendo a análise completa no Python, utilizei essa ferramenta que dispõe de várias biblitecas para realizar o teste de qui-quadrado e a razão de chances.

Tabela com resultado final da análise, os resultados são referente o modelo mais simples (parcimonioso) usando a técnica de subamostragem das observações da classe majoritária.

|                    | Accuracy | Precision | Recall | AUC probability | AUC predict |
|--------------------|----------|-----------|--------|-----------------|-------------|
| Random Forest      | 0.76     | 0.46      | 0.60   | 0.77            | 0.70        |
| Regressão Logística| 0.69     | 0.38      | 0.65   | 0.73            | 0.67        |
| XGBoost            | 0.76     | 0.46      | 0.62   | 0.77            | 0.70        |
| LightGBM           | 0.76     | 0.47      | 0.62   | 0.78            | 0.71        |
| CatBoost           | 0.77     | 0.48      | 0.62   | 0.78            | 0.71        |
| Rede Neural        | 0.73     | 0.43      | 0.64   | 0.77            | 0.70        |




 

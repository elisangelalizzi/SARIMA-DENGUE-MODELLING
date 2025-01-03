# Modelagem SARIMA (Seasonal Autoregressive Integrated Moving Average) para dados mensais de dengue em Londrina-PR com predição out of sample
## Publicação: Time series models for the description and forecasting of incident cases of dengue: a case study in Londrina- Paraná
Acesso em : https://ojs.revistacontribuciones.com/ojs/index.php/clcs/article/view/13834

Artigo estruturado com passo a passo da modelagem SARIMA indutiva em estudos epidemiológicos para arbovirose.
O modelo SARIMA (Seasonal Autoregressive Integrated Moving Average) é uma extensão do modelo ARIMA (Autoregressive Integrated Moving Average) que inclui componentes sazonais. A notação do modelo SARIMA é geralmente expressa como (p, d, q)(P, D, Q)s, onde cada letra representa um parâmetro específico. 
Explicação de cada componente:

1. AR (p): Autoregressive Order
   - Significado: Refere-se à ordem da parte autoregressiva, que captura a relação entre a observação atual e suas observações anteriores ao longo do tempo.
   - Aplicação: Útil quando padrões anteriores na série temporal influenciam os padrões futuros.

2. I (d): Integrated Order
   - Significado: Refere-se à ordem de diferenciação necessária para tornar a série temporal estacionária (ou seja, remover tendências).
   - Aplicação: Necessário quando a série temporal possui tendências ou padrões não estacionários.

3. MA (q): Moving Average Order
   - Significado: Refere-se à ordem da parte de média móvel, que modela a relação entre a observação atual e os erros residuais das observações anteriores.
   - Aplicação: Útil para capturar padrões de dependência nos erros residuais ao longo do tempo.

4. Sazonal AR (P): Seasonal Autoregressive Order
   - Significado: Refere-se à ordem da parte autoregressiva sazonal, que captura a relação entre a observação atual e suas observações anteriores na mesma estação sazonal.
   - Aplicação: Importante quando existem padrões sazonais que se repetem ao longo do tempo.

5. Sazonal I (D): Seasonal Integrated Order
   - Significado: Refere-se à ordem de diferenciação sazonal, que é a quantidade de diferenças sazonais necessárias para tornar a série sazonal estacionária.
   - Aplicação: Necessário quando há sazonalidade na série temporal que não é estacionária.

6. Sazonal MA (Q): Seasonal Moving Average Order
   - Significado: Refere-se à ordem da parte de média móvel sazonal, que modela a relação entre a observação atual e os erros residuais sazonais das observações anteriores.
   - Aplicação: Útil para modelar padrões sazonais na variância dos erros residuais.

7. s: Comprimento do Período Sazonal
   - Significado: Indica o número de observações em uma temporada completa.
   - Aplicação: Determina a periodicidade dos padrões sazonais na série temporal.


Passo a passo como estimar um modelo SARIMA com sazonalidade de 12 meses para uma série temporal de casos de dengue mensais da cidade de Londrina- PR e fazer uma previsão para um ano fora da amostra. Vamos utilizar o ACF e PACF para identificar os componentes AR, I, MA e sazonal, ou seja método indutivo de inserção dos componentes, considerando o estudo de uma arbovirose.
Os parâmetros do modelo com base na análise dos gráficos ACF e PACF, e também experimente otimizar os hiperparâmetros para melhorar o desempenho do modelo, se necessário. 


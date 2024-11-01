
#install.packages("tseries")
#install.packages("astsa")
#install.packages("forecast")



####################################################
########## Passo 1: Preparação dos Dados ##########  
dengue=c(39, 421, 777, 1592, 2414, 1783, 628, 413, 671, 481, 490, 845, 
1170, 4480, 4880, 4353, 3006, 794, 261, 305, 245, 344, 734, 683, 
643, 677, 540, 372, 313, 264, 154, 148, 182, 351, 519, 439, 484, 
451, 355, 303, 374, 124, 160, 154, 120, 267, 221, 350, 628, 884, 
2105, 3333, 2748, 2888, 1854, 576, 480, 608, 504, 581, 1129, 
6200, 16941, 17488, 6214, 2493, 700, 351, 455, 512, 576, 890, 
818, 1717, 2207, 3852, 5704, 4003, 995, 578, 1498, 1426, 1375, 
1239, 896, 1318, 904, 1055, 2552, 3295, 1181, 1164, 658, 645, 
927, 826, 848, 1405, 2796, 6644)

######## FORMATO de série temporal ############
denguets <- ts(dengue, frequency=12, start=c(2015,1))


  

##############################################################################
############# Passo 2: Análise Descritiva #############
summary(denguets) #### Resumo das informações
denguets ### visualização




########## Visualizando a série temporal
plot(denguets, type="l",col="blue",lwd=1.2, main='Casos confirmados de dengue em Londrina',ylab='Número de Casos', xlab='Série Mensal')


###########
#####Decomposição da série em componentes: observado, tendência, sazonalidade e aleatório
componentes_dengue<- decompose(denguets) ### decomposição
plot(componentes_dengue) ### grafico dos componentes da serie
componentes_dengue #### imprime os valores decompostos



##############################################################################
### Passo 3: Análise de Componentes
Use ACF e PACF para identificar os componentes AR, I, MA e sazonal.


par(mfrow=c(1,2))
acf(denguets, main='Autocorrelação Série')
pacf(denguets, main='Autocorrelação Parcial Série')





#############################################################################
############################ Diferenciação ##################################
########################### COMPONENTE INTEGRADO ############################


dado=denguets ### renomeando

dado2<-diff(dado,1)

plot.ts(dado2, main='Série Transformada com a 1a. Diferença', ylab='Série diferenciada', xlab='Série Mensal',xaxt="n")
axis(1,at=c(1,13,25,37,49,61,73,85,97),labels=c("2015","2016","2017","2018","2019","2020","2021","2022","2023"))


par(mfrow=c(1,2))
acf(dado2, main='ACF Série Diferenciada')
pacf(dado2,main='PACF Série Diferenciada')



######################## Diferenciações sazonais##############################


dado3<-diff(dado,12)

plot.ts(dado3, main='Série Transformada 12a. Diferença', col='blue', ylab='SÈrie diferenciada', xlab='Série Mensal(2015-2023)',xaxt="n")
axis(1,at=c(1,13,25,37,49,61,73,85,97),labels=c("2015","2016","2017","2018","2019","2020","2021","2022","2023"))


par(mfrow=c(1,2))
acf(dado3, main='ACF SÈrie Transformada e Diferenciada d=12', col='red')
pacf(dado3, main='PACF sÈrie Transformada e Diferenciada d=12', col='red')


###########################################################################
### Passo 4: Identificação dos Parâmetros
Com base nos gráficos ACF e PACF, identifique os termos AR, I, MA e sazonal.
###########################################################################



###########################################################################
### Passo 5: Estimação do Modelo SARIMA ###################################


##########Trabalhar com a serie diferenciada ########
##################### ARIMA(p,1,Q) ##################

############### Modelo 1 ################
mt1<-arima(dado, order = c(2,1,2),seasonal = list(order = c(1, 1, 1), period = 12), include.mean=TRUE)
mt1
rest1<-mt1$res
fitt1<-(dado-rest1)
tsdiag(mt1)

par(mfrow=c(1,2))
hist(rest1, main='Histograma Reséduos')
qqnorm(rest1, main='Normal Probability',ylim=c(-2,2),xlim=c(-2,2))
#lines(c(-2,2),c(-2,2))

par(mfrow=c(1,2))
acf(rest1, main='Autocorrelação resíduos')
pacf(rest1, main= 'Autocorrelação parcial resíduos')

matplot((cbind(dado,fitt1)),type='l',col=c(1,2), lty=c(1,1),main='Ajuste do modelo', ylab='Série Original e Preditos', xlab='Série Mensal')




############### Modelo 2################
mt2<-arima(dado, order = c(2,1,2),seasonal = list(order = c(2, 1, 2), period = 12), include.mean=TRUE)
mt2
rest2<-mt2$res
fitt2<-(dado-rest2)
tsdiag(mt2)

par(mfrow=c(1,2))
hist(rest2, main='Histograma Reséduos')
qqnorm(rest2, main='Normal Probability',ylim=c(-2,2),xlim=c(-2,2))
#lines(c(-2,2),c(-2,2))

par(mfrow=c(1,2))
acf(rest2, main='Autocorrelação resíduos')
pacf(rest2, main= 'Autocorrelação parcial resíduos')

matplot((cbind(dado,fitt2)),type='l',col=c(1,2), lty=c(1,1),main='Ajuste do modelo', ylab='Série Original e Preditos', xlab='Série Mensal')


###########################################################################
### Passo 6: Avaliação do Modelo
Métricas de ajuste entre os modelos, uso do critério de Akaike, quanto menor o valor desta métrica, melhor o ajuste do modelo aos dados.


mt1$aic
mt2$aic





###########################################################################
#### Passo 6:  Predição out of sample ##########################
## SARIMA(2,1,2)(1, 1, 1)s = 12

predict(mt1,n.ahead=6)

a<-as.numeric(predict(mt1,n.ahead=6)$pred)
b<-as.numeric(predict(mt1,n.ahead=6)$se)







######################### Grafico com predição################################;
par(mfrow=c(2,1))

matplot((cbind(dado,fitt1)),type='l',col=c(1,2), lty=c(1,1),main='Ajuste do modelo', ylab='Série Original e Preditos', xlab='Série Mensal')



plot(ts(c(dado,a), frequency=12, start=c(2015,1)),main='Predição com valores observados',ylab='Série', xlab='Série Mensal')
abline(v=2023+3/12,lty=2)
text(2023+4/12,14000,"out of sample")
#lines(ano,li, col=2)
#lines(ano,ls, col=2)
obs110 = scan()
7291.267 4919.224 2334.942 1508.070 1429.813 1506.887

ano<-c(2023+4/12,2023+5/12,2023+6/12,2023+7/12,2023+8/12,2023+9/12)#2023+10/12,2023+11/12)
points(ano, obs110, pch='*',cex=2,col="blue")








###########################################################################
###########################################################################
########### Alternativa método automático [ auto ajuste] #################
library(forecast)

modelo_sarima <- auto.arima(dado, seasonal=TRUE, stepwise=FALSE, approximation=FALSE)
modelo_sarima
tsdiag(modelo_sarima)


##Performance
modelo_sarima$aic
mt1$aic
mt2$aic


###### Previsão out of sample
previsao <- forecast(modelo_sarima, h = 12)

###### Visualize a previsão
plot(previsao, main='Previsão ARIMA para Casos de Dengue')
lines(teste$data, teste$casos_dengue, col='red', lty=2)
legend("topright", legend=c("Observado", "Previsão"), col=c("red", "blue"), lty=2:1)



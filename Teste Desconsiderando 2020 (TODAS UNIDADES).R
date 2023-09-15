library(forecast)
library(ggplot2)
library(seasonal)
library(seasonalview)
library(urca)


dados = read.csv('desconsiderando 2020 matriculas.csv', header = FALSE)
print(dados)

frequency(dados)

matriculas= ts(dados, start = c(2019,1), end = c(2021,4), frequency = 12)

summary(matriculas)

autoplot(matriculas)

hist(matriculas)

boxplot(matriculas)

dec = decompose(matriculas)
print(dec)
autoplot(dec$trend)

autoplot(window(dec$trend, start=c(2020,4)))

ggseasonplot(matriculas)

estacionaridade = ur.kpss(matriculas)
print(estacionaridade)

#teste de estacionaridade = The value of the test statistic is:  0.1687 

ndiffs(matriculas) #confirmação com 0 diferenciações

tsdisplay(matriculas) #Autocorrelação teste = ta show de bola


#começando modelagem prediticia 

modelo = auto.arima(matriculas, trace = T, stepwise = F, approximation = F)

#melhor modelo encontrado auto arima  Best model:(0,1,0)(0,1,0)[12] 

print(modelo)

#indices de desempenho modelo AIC=288.41   AICc=288.72   BIC=289.12

checkresiduals(modelo)
shapiro.test(modelo$residuals)

var(modelo$residuals)
mean(modelo$residuals)

previsao = forecast(modelo,h=12)
autoplot(previsao)

print(previsao)

#divindo em treino e teste

#Hold out

matriculastreino = ts(dados,start = c(2019,1), end = c(2020,12), frequency = 12)
matriculasteste = ts(dados,start = c(2021,1), end = c(2021,4), frequency = 12)

modeloarima = auto.arima(matriculastreino, trace= T, stepwise = F, approximation = F)

#melhor modelo TREINO Best model:ARIMA(1,0,0)    

preverarima= forecast(modeloarima,h=12)
autoplot(preverarima)
print(preverarima)

#comparando modelos

plot(matriculas)
lines(preverarima$mean,col="blue")




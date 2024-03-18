library(dplyr)
ls()
print(despesas_ceaps_2021)
# Filtrando as linhas onde a coluna "NOME_SENADOR" é igual a "RODRIGO PACHECO"
DF_filtrado <- despesas_ceaps_2021[despesas_ceaps_2021$NOME_SENADOR == "RODRIGO PACHECO", ]

# Filtrando as linhas onde a coluna "DOCUMENTO" contém a palavra "AZUL"
DF_filtrado <- DF_filtrado[grepl("AZUL", DF_filtrado$DOCUMENTO, ignore.case = TRUE), ]

# Somando todos os valores da coluna "VALOR_REEMBOLSADO" no data frame filtrado
soma_valores <- sum(DF_filtrado$VALOR_REEMBOLSADO)

# Exibindo o data frame filtrado
print(DF_filtrado)

# Exibindo a soma total dos valores na coluna "VALOR_REEMBOLSADO"
print(soma_valores)


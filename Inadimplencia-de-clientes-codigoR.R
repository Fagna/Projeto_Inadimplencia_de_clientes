library(readxl)

setwd("~/Carreira em Data science/Projetos Kaggle")
df = read_excel('credit.xlsx')
df

#Renomeando colunas

colnames(df) <- c('ID Cliente', 'Limite_Credito', 'Sexo', 'Escolaridade', 'Est_Civil', 
                  'Idade', 'Status_Set', 'Status_Ago', 'Status_Jul', 
                  'Status_Jun', 'Status_Mai', 'Status_Abr', 'Valor_Set',
                  'Valor_Ago', 'Valor_Jul', 'Valor_Jun', 'Valor_Mai',
                  'Valor_Abr', 'Pag_Set', 'Pag_Ago', 'Pag_Jul', 
                  'Pag_Jun', 'Pag_Mai', 'Pag_Abr', 'Status Pagamento')


#Tratando valores inconsistentes

df$Est_Civil[df$Est_Civil == 0] <- 3

df$Escolaridade[df$Escolaridade > 4] <- 4
df$Escolaridade[df$Escolaridade == 0] <- 4


#Renomeando as variáveis 

df$`Status Pagamento` <- ifelse(df$`Status Pagamento`== 1, "Inadimplente","Adimplente")
df$Sexo <- ifelse(df$Sexo == 1, "Masculino", "Feminino")
df$Escolaridade <- ifelse(df$Escolaridade == 1, "Pós-graduação", 
                          ifelse(df$Escolaridade == 2, "Graduação",
                                 ifelse(df$Escolaridade == 3, "Ensino médio", "Outros")))
df$Est_Civil <- ifelse(df$Est_Civil == 1, "Casado",
                       ifelse(df$Est_Civil == 2, "Solteiro", "Outros"))


#Criando uma nova variável a partir da variável cartão de crédito
categorias_credito <- function(valor) {
  if (valor < 50000) {
    return('Silver')
  } else if (valor < 250000) {
    return('Gold')
  } else if (valor < 500000) {
    return('Platinum')
  } else {
    return('Black')
  }
}

df$Categorias_credito <- sapply(df$Limite_Credito, categorias_credito)

mapeamento <- c('Silver' = 1, 'Gold' = 2, 'Platinum' = 3, 'Black' = 4)

#Criando uma nova variável a partir da variável idade

faixa_etaria <- function(valor) {
  if (valor < 30) {
    return('De 20 à 29 anos')
  } else if (valor < 40) {
    return('De 30 à 39 anos')
  } else if (valor < 50) {
    return('De 40 à 49 anos')
  } else if (valor < 60) {
    return('De 50 à 59 anos')
  } else {
    return('A partir de 60 anos')
  }
}

df$faixa_etaria <- sapply(df$Idade, faixa_etaria)

mapeamento <- c('De 20 à 29 anos' = 1, 'De 30 à 39 anos' = 2, 
                'De 40 à 49 anos' = 3, 'De 50 à 59 anos' = 4,
                'A partir de 60 anos' = 5)


#Transformando as variáveis em factor 

df$`Status Pagamento` <- as.factor(df$`Status Pagamento`)
df$Sexo <- as.factor(df$Sexo)
df$Escolaridade <- as.factor(df$Escolaridade)
df$Est_Civil <- as.factor(df$Est_Civil)
df$Categorias_credito <- as.factor(df$Categorias_credito)
df$faixa_etaria <- as.factor(df$faixa_etaria)

str(df)

#Teste qui-quadrado

library(gmodels)

#Sexo
sexo = CrossTable(df$Sexo,df$`Status Pagamento`,prop.r=TRUE, 
           prop.c=FALSE,chisq = TRUE, prop.chisq=F,
           fisher=FALSE)


#Escolaridade
Esc = CrossTable(df$Escolaridade,df$`Status Pagamento`,prop.r=TRUE, 
           prop.c=FALSE,chisq = TRUE, prop.chisq=F,
           fisher=FALSE)


#Estado Civil
Est = CrossTable(df$Est_Civil,df$`Status Pagamento`,prop.r=TRUE, 
           prop.c=FALSE,chisq = TRUE, prop.chisq=F,
           fisher=FALSE)


#Categoria cartão de credito
Cat = CrossTable(df$Categorias_credito,df$`Status Pagamento`,prop.r=TRUE, 
           prop.c=FALSE,chisq = TRUE, prop.chisq=F,
           fisher=FALSE)


#Faixa etária
Fax = CrossTable(df$faixa_etaria,df$`Status Pagamento`,prop.r=TRUE, 
                 prop.c=FALSE,chisq = TRUE, prop.chisq=F,
                 fisher=FALSE)


#Faixa etária
Age = CrossTable(df$faixa_idade,df$`Status Pagamento`,prop.r=TRUE, 
                 prop.c=FALSE,chisq = TRUE, prop.chisq=F,
                 fisher=FALSE)



# Razão de chances

library(epitools)

X <- matrix(data = c(14349, 9015, 3763, 2873), 
            nrow = 2, ncol = 2)

X

# Nomeando as linhas e colunas

dimnames(X) <- list("Sexo" = c("Feminino", "Masculino"),
                    "Status de pagamento ?" = c("Adimplente", "Inadimplente"))

X


oddsratio(X, method = "wald")

# OBS: Usar rev = "r" para inverter s? as linhas.
# OBS: Usar rev = "c" para inverter s? as colunas.
# OBS: Usar rev = "both" para inverter as linhas e colunas.

##########################################################################

X <- matrix(data = c(3680,10700,435,8549,1237,3330,33,2036), 
            nrow = 4, ncol = 2)

X

# Nomeando as linhas e colunas

dimnames(X) <- list("Escolaridade" = c("Ensino médio", "Graduação","Outros", "Pós-graduação"),
                    "Status de pagamento" = c("Adimplente", "Inadimplente"))

X

oddsratio(X, method = "wald", rev = 'r')

##########################################################################

X <- matrix(data = c(10453,288,12623,3206,89,3341), 
            nrow = 3, ncol = 2)

X

# Nomeando as linhas e colunas

dimnames(X) <- list("Estado Civil" = c("Casado", "Outros","Solteiro"),
                    "Status de pagamento " = c("Adimplente", "Inadimplente"))

X

oddsratio(X, method = "wald")

##########################################################################

X <- matrix(data = c(824,14529,5255,2756,104,4093,884,1555), 
            nrow = 4, ncol = 2)

X

# Nomeando as linhas e colunas

dimnames(X) <- list("Categoria Credito" = c("Black", "Gold", "Platinum", "Silver"),
                    "Status de pagamento " = c("Adimplente", "Inadimplente"))

X

oddsratio(X, method = "wald")


##########################################################################

X <- matrix(data = c(8962,4979,1759,243,7421,2276,1485,582,96,2197), 
            nrow = 5, ncol = 2)

X

# Nomeando as linhas e colunas

dimnames(X) <- list("Faixa etária" = c('De 30 à 39 anos',
                                       'De 40 à 49 anos',
                                       'De 50 à 59 anos',
                                       'A partir de 60 anos',
                                       'De 20 à 29 anos'),
                    "Status de pagamento" = c("Adimplente", "Inadimplente"))

X

oddsratio(X, method = "wald")

#Razão de Chances usando a tabela de contigencia obtidas no teste qui-quadrado

# sexo
oddsratio(sexo$t, method = "wald")

# escolaridade 
oddsratio(Esc$t, method = "wald", rev = "r")

# estado civil
oddsratio(Est$t, method = "wald")

# limite de crédito
oddsratio(Cat$t, method = "wald")

# faixa etária
oddsratio(Age$t, method = "wald", rev = "r")

# não permite a escolha da variável de referencia.




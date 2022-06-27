data2=read.table("clipboard",header=TRUE,sep="|")
library(ggplot2)
ggplot(data2, aes(x=Entidad, y=Monto)) +  geom_boxplot(fill='red')
ggplot(data2, aes(x=Edad, y=Monto)) +  geom_boxplot(fill='red')
ggplot(data2, aes(x=Genero, y=Monto)) +  geom_boxplot(fill='red')
ggplot(data2, aes(x=Modalidad, y=Monto)) +  geom_boxplot(fill='red')
ggplot(data2, aes(x=Ingreso, y=Monto)) +  geom_boxplot(fill='red')

count1=table(data2$Ingreso,data2$Edad)
mosaicplot(count1, xlab='Ingreso', ylab='Edad',main='Ingreso por Edad', col='orange')

ggplot(data2, aes(x=Ingreso, y=Monto, shape=Genero, color=Genero)) + geom_point()
ggplot(data2, aes(x=Entidad, y=Monto, shape=Modalidad, color=Modalidad)) + geom_point()
ggplot(data2, aes(x=Ingreso, y=Monto, shape=Edad, color=Edad)) + geom_point()

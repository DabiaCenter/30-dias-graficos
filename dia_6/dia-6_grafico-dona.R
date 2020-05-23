#cargar librerias
library(readr)
library(ggplot2)
library(dplyr)

#cargar datos 
setwd("C:/Users/Cristal Rivera P/Documents/DABIA")
trabajo_data <- read_csv("General/work_data.csv")
View(trabajo_data)


# Grafico de Dona
donut <- ggplot(trabajo_data, aes(x=2, y=porcentaje,fill=trabajo)) +
  geom_col(color="black") +
  geom_text(aes(label=paste0(round(porcentaje*100,2),"%")),position = position_stack(vjust = 0.5),size=4)+
  theme(panel.background = element_blank(),
        axis.line = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        axis.title=element_blank(),
        plot.title = element_text(hjust=0,size=18,vjust = 0))+
  ggtitle("Porcentaje promedio de trabajo para un científico de datos")+
  scale_fill_brewer(palette="Accent") +
  coord_polar(theta="y",start=1) +
  xlim(c(0.5, 2.5)) 


#imprimir grafico 
donut
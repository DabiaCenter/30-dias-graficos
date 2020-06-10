library(readr)
library(ggplot2)
library(dplyr)
library(ggthemes)

#cargar la base de datos 
area_polar <- read_csv("dia_30/area_polar.csv")
names(area_polar)[ncol(area_polar)] <- "dia"
View(area_polar)

#acomodar datos 
area_polar <- area_polar[,c(1,2,ncol(area_polar))] %>% 
  group_by(provincia) %>% 
  summarise(suma=sum(dia))
area_polar <- na.omit(area_polar) 
area_polar

#grafico
ggplot(area_polar, aes(x = provincia, y = suma ,fill = provincia )) + 
  geom_bar(width = 0.85, stat="identity") +
  coord_polar(theta = "x") + 
  scale_fill_brewer(palette = "Accent") +
  xlab("Provincia") +
  ylab("Casos Covid 19")+
  theme_tufte()+
  theme(panel.grid.major = element_line(colour = "grey60", size =0.1 ),
        
        plot.title = element_text(hjust=0,size=11,vjust = 0))+
  ggtitle("Casos Covid19 al 10 de Junio de cada provincia en Costa Rica")

  
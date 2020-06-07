#Librerias
library(tidyverse)
library(gganimate)
library(gifski)
library(wesanderson)

#cargar datos
felicidad <- readr::read_csv("https://raw.githubusercontent.com/cienciadedatos/datos-de-miercoles/master/datos/2019/2019-08-07/felicidad.csv")

#Preparacion de datos

datos <- felicidad %>%
  filter(pais %in% c("Costa Rica","Estados Unidos","Francia","India"))

#graficar

grafico <- ggplot(datos, aes(x = anio ,y = escalera_vida , col = pais )) + 
  geom_line() + 
  geom_point() +
  scale_color_manual(name = "País",values = wes_palette(n=4, name="Cavalcanti1")) + 
  labs(title = "Comparación del puntaje de felicidad entre países",
       y= "Puntaje de Felicidad",
       x = "año") +
  scale_x_continuous(breaks = seq(2005,2018,1)) +
  scale_y_continuous(breaks = seq(1,10,1)) + 
  theme_light() + 
  theme(axis.text.x = element_text(angle = 50, hjust = 1,size = 10)) + 
  transition_reveal(anio)
  

animate(grafico, duration = 5, fps = 20, width = 500, height = 500, renderer = gifski_renderer())
anim_save("dia_27.gif")
  

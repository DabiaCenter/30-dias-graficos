#librerias
library(tidyverse)
library(readr)
library(wesanderson)

#Cargar datos
pokemon <-read_csv("https://raw.githubusercontent.com/cienciadedatos/datos-de-miercoles/master/datos/2019/2019-07-10/pokemon.csv")

#Grafico
grafico <- ggplot(pokemon,aes(x = velocidad,y = ataque ,color = es_legendario)) + 
  geom_point(alpha=0.7) +
  labs(title = "Relación entre la velocidad y el daño en ataque normal de los Pokemones",
       x = "Velocidad",
       y = "Daño en ataques normales") +
  scale_color_manual(values = wes_palette(n = 2, name = "Royal1"),name = "Legendario", labels = c("Sí","No")) +
  theme_classic()

#mostrar grafico

grafico


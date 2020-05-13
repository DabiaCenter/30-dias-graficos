# dependencias

if(!require("pacman")) install.packages("pacman")
p_load("ggplot2")
p_load("dplyr")
p_load("forcats")
p_load("gameofthrones")
p_load("tvthemes")
p_load("extrafont")

import_cinzel() 
loadfonts()

# cargando datos
tiempo_pantalla <- readr::read_csv("https://raw.githubusercontent.com/cienciadedatos/datos-de-miercoles/master/datos/2019/2019-04-17/tiempo_pantalla.csv")

# graficando

jdt_grafico <- tiempo_pantalla %>% 
  mutate(nombre = fct_reorder(nombre, minutos_pantalla, .desc = TRUE)) %>% 
  head(7) %>% 
  ggplot(aes(x = nombre, y = minutos_pantalla, fill = nombre, col = "red")) + 
  geom_col() +
  labs(title = "Top 7 según tiempo en pantalla en Juego de Tronos",
       y = "Minutos", x = "") + 
  scale_fill_westeros() +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 50, hjust = 1, size = 14),
        legend.position = "none") +
  theme(text = element_text(family = "Cinzel", size = 16))

# mostrando grafico

jdt_grafico 

  

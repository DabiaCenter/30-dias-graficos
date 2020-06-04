library(readr)
library(sunburstR)
library(dplyr)
library(htmltools)

## Clasificación NFL Divisiones 2019
proyeccion_solar <- read_csv("dia_23/proyeccion_solar.csv", 
                             col_types = cols(Puntos_total = col_number()))

 
#View(proyeccion_solar)

data <- proyeccion_solar %>%
  mutate(path = paste(AFC, Equipos, sep="-")) %>% 
  dplyr::select(path, Puntos_total)

#View(data)


#visualizar grafico
p <- sunburst(data, legend= list(w=150,h=20)) 
p



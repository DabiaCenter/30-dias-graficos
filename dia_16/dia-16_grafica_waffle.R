library(waffle)
library(dplyr)
library(RColorBrewer)

covid <- data.frame(
  "Provincia" = c("San José", "Alajuela", "Heredia", "Cartago", "Limón", "Guanacaste", "Puntarenas"),
  "Casos" = c(450, 210, 94, 65, 16, 63, 46)
)

covid <- covid %>%
  mutate(Porcentaje = round(Casos/sum(Casos)*100)) %>%
  arrange(desc(Porcentaje)) 

covid2 <- covid$Porcentaje
names(covid2) <- covid$Provincia

waffle(covid2, rows = 8, 
       title = "Proporción de casos por Covid-19 en Costa Rica 
al 27/5/2020 por provincia", 
       colors = c("#FF0000", "#FFA500", "#F3DC00", "#28EF00", "#000ADD", "#00D4C4","#8C00D4")
       )


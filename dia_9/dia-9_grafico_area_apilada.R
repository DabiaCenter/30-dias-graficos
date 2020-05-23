#librerias
library(tidyverse)
library(RColorBrewer)

#importar datos
h1n1 <- readr::read_csv("https://raw.githubusercontent.com/cienciadedatos/datos-de-miercoles/master/datos/2020/2020-03-11/h1n1.csv")

#graficar

grafico <- h1n1 %>%
  filter(pais %in% c("Guatemala","Belice","Honduras","El Salvador","Nicaragua","Costa Rica","Panamá")) %>%
  group_by(fecha_actualizacion, pais) %>%
  summarise(n = sum(casos)) %>%
  mutate(percentage = n / sum(n)) %>%
  ggplot(aes(x = fecha_actualizacion, y = percentage, fill = pais)) + 
  geom_area(alpha = 0.6, size = 1 , colour = "black") +
  scale_fill_brewer(name = "País", palette = "Dark2") +
  labs(title = "Porcentaje de casos de H1N1 en 2009 en Centroamérica",
       y = "Porcentaje de casos",
       x = "Fecha") +
  theme_minimal()

#Mostrar grafico

grafico

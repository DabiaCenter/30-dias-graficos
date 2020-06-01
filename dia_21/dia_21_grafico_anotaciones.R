#Librerias
library(tidyverse)

#Cargar Datos
imdb <- readr::read_csv("https://raw.githubusercontent.com/cienciadedatos/datos-de-miercoles/master/datos/2020/2020-02-19/ranking_imdb.csv")

#filtrar datos
datos<-imdb %>%
  filter(direccion == "Stanley Kubrick" ) %>%
  na.omit() %>%
  arrange(desc(ganancias))%>%
  head(n=6)

#graficar
datos %>%
  mutate(titulo = fct_reorder(titulo, ganancias, .desc = TRUE)) %>%
  ggplot(aes(x = titulo , y = ganancias)) + 
  geom_col(fill = c("indianred3")) + 
  geom_text(aes(label = factor(puntaje), x = titulo, y = ganancias), position = position_dodge(width = 0.8), vjust = -0.6) +
  labs(y = "Ganancias en millones de dolares", 
       x = "Película", 
       title = "Comparación del puntaje de las películas de Stanley Kubrick con más ganancias") + 
  theme_classic()+
  theme(axis.text.x = element_text(angle = 50, hjust = 1, size = 10),
        legend.position = "none")

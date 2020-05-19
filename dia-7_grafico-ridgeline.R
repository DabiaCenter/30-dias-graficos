# dependencias

if(!require("pacman")) install.packages("pacman")
p_load("ggplot2")
p_load("dplyr")
p_load("ggridges")
p_load('forcats')
p_load("ggthemes")

# cargando los datos 
co2_ingreso <- readr::read_csv("https://raw.githubusercontent.com/cienciadedatos/datos-de-miercoles/master/datos/2019/2019-08-21/co2_ingreso.csv")

# graficando 

grafico_dia_7 <- co2_ingreso %>% 
  mutate(grupo = fct_reorder(grupo, emision_co2, .desc = TRUE)) %>% 
  ggplot(aes(x = emision_co2, y = grupo, fill = grupo)) +
  geom_density_ridges() +
  theme_economist() +
  theme(legend.position = "none") +
  scale_fill_economist() +
  labs(y = "", 
       x = "Toneladas métricas per cápita",
         title = "Distribucion de la emision de CO2",
       subtitle = "países agrupados según la clasificación del Banco Mundial")

grafico_dia_7

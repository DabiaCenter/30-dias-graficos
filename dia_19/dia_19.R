# Dependencias 

if(!require("pacman")) install.packages("pacman")
p_load("tidyverse")
p_load("RColorBrewer")

datos_f <- read.csv("https://pjcrdatosabiertos.blob.core.windows.net/datosabiertos/PJCROD_FEMICIDIOS_V1/PJCROD_FEMICIDIOS_V1.csv", 
                    header = FALSE,
                    col.names = c("periodo",
                    "CodTipoFemicidio",
                    "DesTipoFemicidio",	
                    "Cantidad"))

# Corrigiendo datos desactualizados 

datos_f$Cantidad[datos_f$CodTipoFemicidio == 1 & datos_f$periodo == 2018] = 18

datos_f$Cantidad[datos_f$CodTipoFemicidio == 2 & datos_f$periodo == 2018] = 8

datos_f$Cantidad[datos_f$CodTipoFemicidio == 1 & datos_f$periodo == 2019] = 9

datos_f$Cantidad[datos_f$CodTipoFemicidio == 2 & datos_f$periodo == 2019] = 5


# Agregando y valor para numeros 

datos_f <- datos_f %>% 
  mutate(label_y = if_else(CodTipoFemicidio == 1, 22, -22))
datos_f

# Graficando 

grafico_18 <- datos_f %>% 
  ggplot(aes(x = periodo,
             y = Cantidad,
             group = DesTipoFemicidio,
             fill = DesTipoFemicidio)) + 
  stat_steamgraph() + 
  scale_x_continuous(breaks = seq(2007, 2019, 1)) +
  geom_text(aes(label = Cantidad, y = label_y, col = DesTipoFemicidio),
            size = 5, show.legend = FALSE) + 
  scale_fill_brewer(palette = "Set2") +
  scale_color_brewer(palette = "Set2") +
  theme_light() + 
  theme(axis.text.y = element_blank(),
        axis.text.x = element_text(size = 15),
        panel.grid = element_blank()) +
  labs(y = "Proporción",
       fill = "Clasificación", 
       x = "Año",
       title = "Femicidios registrados en Costa Rica según tipo",
       subtitle = "del 2007 al 2019") 

grafico_18

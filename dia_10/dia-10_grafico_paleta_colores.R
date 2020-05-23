library(ggplot2)
library(readr)
library(dplyr)
library(RColorBrewer)

resultados_cmff <- readr::read_csv("https://raw.githubusercontent.com/cienciadedatos/datos-de-miercoles/master/datos/2019/2019-07-17/resultados_cmff.csv")

resultados_cmff <- resultados_cmff %>%
  select(equipo, ronda, resultado) %>%
  rename(Equipo = equipo) %>%
  filter(ronda == "Semifinales")

ggplot(resultados_cmff, aes(x = resultado, fill = Equipo)) + 
  geom_bar() + 
  scale_fill_brewer(palette = "Paired") +
  labs(title = "Cantidad encuentros en la semifinal de Copa Mundial de la FIFA Femenina") +
  xlab("Resultado final del partido") +
  ylab("Cantidad de encuentros") +
  theme_minimal() +
  theme(text = element_text(family = "sans", size =12),
        axis.title.x = element_text(vjust = 10, hjust = 2),
        plot.title = element_text(face="bold", size = 11))
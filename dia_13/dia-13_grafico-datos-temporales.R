# dependencias


if(!require("pacman")) install.packages("pacman")
p_load("ggplot2")
p_load("dplyr")
p_load("lubridate")
p_load("stringr")
p_load("ggthemes")

datos <- read.csv("dia_13/casos_cr.csv")

## haciendo primera letra mayuscula 

mayus <- function(x) {
  substr(x, 1, 1) <- toupper(substr(x, 1, 1))
  x
}

# preparando datos

datos_reducidos <- datos %>% 
  select(Fecha, Casos) %>% 
  mutate(dia = wday(Fecha, label = TRUE)) %>% 
  mutate(dia = mayus(str_sub(dia,start = 1, end = 3))) %>% 
  mutate(mes = month(Fecha, label = TRUE)) %>% 
  mutate(mes = mayus(str_sub(mes,start = 1, end = 3))) %>% 
  mutate(semana = stringi::stri_datetime_fields(as.POSIXct(datos_reducidos$Fecha))$WeekOfMonth)

datos_reducidos$dia %>% unique()

datos_reducidos$dia <- factor(datos_reducidos$dia, levels = c("Lun", 
                                                              "Mar",
                                                              "Mié",
                                                              "Jue",
                                                              "Vie", 
                                                              "Sáb",
                                                              "Dom"))
datos_reducidos$mes <- factor(datos_reducidos$mes, levels = c("Mar",
                                                              "Abr",
                                                              "May"))
datos_reducidos <- datos_reducidos %>% 
  mutate(dia_num = day(Fecha))
# graficando 

grafico_dia_13 <- datos_reducidos %>% 
  ggplot(aes(x = semana, y = dia, fill = Casos)) + 
  facet_grid(~mes, scales = "free") + 
  geom_tile(colour = "white") + 
  scale_fill_gradient(low="white", high="black") + 
  labs(x = "", y = "", 
       title = "Casos confirmados de Covid-19 en Costa Rica", 
       subtitle =  "del 6 de marzo al 23 de abril de 2020") +
  theme_economist_white() +
  theme(axis.text.x = element_blank(),
        axis.ticks.x = element_blank())

grafico_dia_13 + 
  geom_text(aes(label = dia_num), col = "#1DA99D") + 
  scale_color_discrete(guide = "none")
         
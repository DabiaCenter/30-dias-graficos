# Librerias requeridas ---------------------------
library(rwhatsapp)
library(lubridate)
library(tidyverse)
library(tidytext)
library(kableExtra)
library(RColorBrewer)
library(knitr)
library(plotly)
library(dplyr)

# Cargar datos ---------------------------

# Obtener txt con datos exportados de chat de WA
miChat <- rwa_read(file.choose())

# Preparacion de datos: se eliminan mensajes de la aplicacion y se da formato fecha al tiempo
miChat <- miChat %>% 
  mutate(day = date(time)) %>% 
  filter(!is.na(author))

# Generar grafico ---------------------------

# Tabla de referencias: dias y horas de toda una semana
referencia <- data.frame(fecha = seq(from = as.POSIXct("2020-04-06 00:00"), 
                                     to = as.POSIXct("2020-04-12 23:00"), 
                                     by = "hour"))
referencia <- referencia %>% mutate(
  
  day = as.Date(as.character(fecha)),
  hour = hour(fecha),
  wday.name = weekdays(fecha)
  
) %>%
  select(day,hour, wday.name)


# Tabla de datos: MENSAJES POR HORA DEL DÍA
diasyhoras <- miChat %>%
  select(time, day) %>% 
  mutate( hour = hour(time),
          wday.name = weekdays(day)) %>%
  group_by(day,hour,wday.name) %>%
  summarize(conteo = n()) %>%
  ungroup() 

# Combinar la tabla de referencia con la tabla con los datos
df <- left_join(referencia, diasyhoras, by = c("day", "hour", "wday.name")) %>%
  mutate(conteo = ifelse(is.na(conteo),
                         0,
                         conteo))

colnames(df) <- c("fecha", "hora", "dia", "mensajes")

#Grafico en plotly
fig <- plot_ly(df, x = ~fecha, y = ~hora, z = ~mensajes, type = "contour", contours = list(showlabels = TRUE))

fig <- fig %>% colorbar(title = "Cantidad \n de mensajes")

fig


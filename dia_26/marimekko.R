
# Dependencias ------------------------------------------------------------

library(readr)
library(ggplot2)
library(dplyr)
library(reshape2)


# Carga de los datos ------------------------------------------------------

#Antes de cargar los datos, hay que setear el directorio de trabajo
datos <- read_csv("MoviesOnStreamingPlatforms_updated.csv")
# Fuente: https://www.kaggle.com/ruchi798/movies-on-netflix-prime-video-hulu-and-disney/data

glimpse(datos)

head(datos)

# Procesamiento de los datos ----------------------------------------------

datos_procesados <- datos %>% 
  group_by(Age) %>% 
  summarize(Netflix = sum(Netflix),
            Hulu = sum(Hulu),
            PrimeVideo = sum(`Prime Video`),
            DisneyPlus = sum(`Disney+`)) %>% 
  rename(Edad = Age) %>% 
  mutate(TotalXEdad = Netflix + Hulu + PrimeVideo + DisneyPlus,
         xmax = cumsum(TotalXEdad),
         xmin = xmax - TotalXEdad,
         Edad = ifelse(is.na(Edad), 
                       "Sin clasificar", 
                       Edad
         )
  )

datos_procesados$TotalXEdad <-NULL

datos_procesados$Edad[datos_procesados$Edad == "all"] <- "Todo público"

datos_procesados <- melt(datos_procesados, id.vars = c("Edad", "xmin", "xmax"))

datos_finales <- datos_procesados %>%
  group_by(Edad) %>%
  mutate(ymax = cumsum(value/sum(value)),
         ymin = ymax - value/sum(value)
         )

edades <- datos_finales$Edad[1:6]

contador <- 0

for (i in edades) {
  contador <- contador + 1
  df <- datos_finales %>% 
    select(Edad, value) %>% 
    filter(Edad == i) %>% 
    mutate(porcentaje = value/sum(value)) %>% 
    ungroup() %>% 
    select(value, porcentaje)
  
  if (contador == 1) {
    salvar = df
  } else {
    salvar <- rbind(salvar, df)
  }
  
}

datos_finales <- datos_finales %>%
  inner_join(salvar, by = "value")


# Graficar ----------------------------------------------------------------

xtext <- with(datos_finales, xmin + (xmax - xmin)/2)
ytext <- with(datos_finales, ymin + (ymax - ymin)/2)

ggplot(datos_finales, aes(ymin = ymin, 
                          ymax = ymax,
                          xmin = xmin, 
                          xmax = xmax, 
                          fill = variable)) +
  geom_rect(colour = "white") +
  geom_text(aes(x = xtext, 
                y = ytext,
                label = ifelse(porcentaje > 0.05, 
                               paste(round(100*porcentaje, 1), "%", sep=""),
                               ""
                               )
                ), 
            size = 3) +
  geom_text(aes(x = xtext, 
                y = 1.1,
                label = Edad
                ), 
            size = 4) +
  coord_flip() +
  theme(legend.position = "bottom") +
  scale_y_continuous(limits = c(0, 1.15)) + 
  labs(title = "Películas por clasificación de edad y servicio de streaming",
       x = "Cantidad de películas",
       y = "Porcentaje de películas") 




# Dependencias ---------------------------------------

if(!require("pacman")) install.packages("pacman")
p_load("dplyr")
p_load("echarts4r")

# Carga/procesar datos ---------------------------

datos <- read.csv("dia_20/covid19_cantones_cr.csv") %>% 
  select(provincia, canton, X31.5.2020) %>% 
  arrange(desc(X31.5.2020)) %>% 
  head(10) %>% 
  select(provincia, canton) %>% 
  rename(padre = provincia, hijo = canton) %>% 
  mutate(hijo = as.character(hijo), padre = as.character(padre)) %>% 
  mutate(hijo = ifelse(padre == hijo, "CANTON CENTRAL", hijo))

provincias <- data.frame(padre = rep("COSTA RICA", 4), 
                         hijo = c("SAN JOSE", "HEREDIA", "CARTAGO", "ALAJUELA"))

datos <- rbind(datos, provincias)

# Grafico --------------------------------------

datos %>% 
  e_charts() %>% 
  e_tree(padre, hijo) %>% 
  e_title("Grafico de red: Top 10 de cantones con más enfermos de COVID19")

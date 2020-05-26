library(dplyr)
library(echarts4r)

datos <- read.csv("covid19_cantones_cr.csv")

datos %>% 
  rename(confirmados = X25.5.2020) %>% 
  arrange(desc(confirmados)) %>% 
  head(10) %>% 
  e_charts() %>% 
  e_treemap(parent = provincia, child = canton, value = confirmados) %>% 
  e_title("Top 10: Cantones con más casos de Covid-19", "Datos de Costa Rica al 25 de mayo") %>%
  e_theme("infographic")

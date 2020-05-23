library(dplyr)
library(echarts4r)
library(lubridate)

datos <- read.csv("ARG.csv") #Datos obtenidos de http://www.football-data.co.uk/argentina.php

datos %>%
  filter(Home %in% c("Boca Juniors", "Independiente", "Racing Club", "River Plate", "San Lorenzo")) %>%
  select(Home, Date, HG) %>%
  arrange(Home) %>%
  mutate(Date = as.Date(Date, format = "%d/%m/%Y")) %>%
  mutate(Year = as.character(year(Date))) %>%
  group_by(Home, Year) %>%
  summarize(HG = sum(HG)) %>%
  e_chart(Year) %>%
  e_line(HG) %>%
  e_title("Cantidad de goles en casa de los 5 grandes del futbol argentino") %>%
  e_legend(right = 0) %>%
  e_y_axis(splitNumber = 10, max = 40) 
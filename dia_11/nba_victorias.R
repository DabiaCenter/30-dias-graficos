library(readr)
library(ggplot2)
library(tidyr)

nba <- read_csv("data_nba.csv")
nba <- gather(nba, temporada, victorias, 2:6)

ggplot(nba, aes(temporada, equipo, fill= victorias)) + 
  geom_tile() +
  scale_fill_gradient(low="lightblue", high="darkblue") +
  labs(title = "Victorias por equipos de NBA en las últimas 5 temporadas") +
  xlab("Temporada") +
  ylab("Equipo") +
  theme_minimal() +
  theme(text = element_text(family = "sans", size =12),
        plot.title = element_text(face="bold", size = 11, hjust = 1))
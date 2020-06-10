library(ggrepel)
library(tidyverse)

goat <- read_csv("goat.csv")

ggplot(goat, aes(x = Reward, y = Value, group = Name, colour = Name)) +
  geom_line(size = 1) +
  geom_point(size = 3) +
  labs(
    title = "Comparación entre tres de los mejores jugadores de la NBA de la historia, datos hasta 2020",
    x = "",
    y = "Cantidad"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 12),
        axis.text.y = element_text(size = 12),
        axis.title.y = element_text(size = 12),
        legend.title = element_blank(),
        legend.text = element_text(size = 12)) +
  scale_y_continuous(limits = c(0,12), breaks = seq(0, 12, by = 1))
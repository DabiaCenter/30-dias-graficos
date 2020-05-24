library(ggplot2)
library(readr)
library(dplyr)

smash <- read_csv("smash_bros.csv")

ggplot(smash, aes(x = reorder(personaje, uso), y = uso, col = puesto, fill = puesto)) +
  geom_segment(aes(xend = personaje, yend = 0), size = 2, show.legend = F) +
  geom_point(size = 5, show.legend = F) +
  scale_fill_manual(values = c("#EE150E", "#18D00D", "#6D27A7", "#5E5F57", "#1CE2E8",
                               "#FF9B02", "#C28220", "#000FFF", "#000000", "#F9F905",
                               "#1C3A83", "#EEEE99")) +
  scale_color_manual(values = c("#EE150E", "#18D00D", "#6D27A7", "#5E5F57", "#1CE2E8",
                                "#FF9B02", "#C28220", "#000FFF", "#000000", "#F9F905",
                                "#1C3A83", "#EEEE99")) +
  coord_flip() +
  labs(title = "Top 12 personajes m?s usados de SuperSmash Ultimate en torneos") +
  xlab("") +
  ylab("Cantidad de usos") +
  theme(text = element_text(family = "sans", size =12),
        plot.title = element_text(face="bold", size = 13, hjust = 0.4),
        panel.background = element_rect(fill = "white",
                                        colour = "black",
                                        size = 0.5, linetype = "solid")) 
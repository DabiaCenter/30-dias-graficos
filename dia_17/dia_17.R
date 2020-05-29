library(jsonlite)
library(dplyr)
got <- jsonlite::fromJSON("https://raw.githubusercontent.com/jeffreylancaster/game-of-thrones/master/data/characters.json") %>%
  as.data.frame()

got <- got %>% select(1,5,9)

colnames(got) <- c("Nombre", "Casa", "asesinado_por")

got <- got %>% filter(Casa %in% c("Targaryen", "Stark", "Greyjoy", "Lannister",
                                  "Baratheon")) %>% head(n = 50)

genero <- c("H", "H", "H", "H", "M", "H", "H", "H", "H", "H",
            "M", "D", "H", "H", "H", "L", "L", "H", "H", "H",
            "L", "H", "M", "H", "H", "M", "L", "H", "D", "H",
            "M", "M", "H", "H", "H", "H", "M", "M", "L", "M",
            "H", "L", "H", "H", "H", "H", "D", "H", "H", "M")

got$genero <- genero

got[31,3] <- "Dead"

got <- got %>% mutate(
  Genero = ifelse(genero == "H", "Hombre",
                  ifelse(genero == "M", "Mujer",
                         ifelse(genero == "D", "Dragon",
                                "Lobo"))),
  Muerto = ifelse(asesinado_por == "NULL", "No",
                         "Si")
) %>%
  select(Casa, Genero, Muerto)

got$Casa <- unlist(got$Casa)

library(ggalluvial)

got %>%
  group_by(Casa, Genero, Muerto) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  ggplot(aes(axis1 = reorder(Casa, -n), axis2 = reorder(Genero,n), axis3 = reorder(Muerto,-n),y = n)) +
  scale_x_discrete(limits = c("", "", ""), expand = c(.1, .05)) +
  geom_stratum(aes(fill = Casa), color="black") +
  geom_alluvium(aes(fill = Casa)) + geom_text(stat = "stratum", infer.label = TRUE) +
  theme_minimal() +
  labs(title ="Día 17: Diagrama de Sankey",
       subtitle= "Personajes de Game of Thrones") +
  ylab("") +
  theme(plot.background = element_rect(fill = "white", color=NA), 
        panel.border = element_blank(),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        axis.text  = element_blank(),
        axis.ticks = element_blank(),
        legend.position = "none")

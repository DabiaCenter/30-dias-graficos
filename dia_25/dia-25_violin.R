
# Dependencias ------------------------------------------------------------
if(!require("pacman")) install.packages("pacman")
p_load(tidyverse)
p_load(here)
p_load(forcats)


# Obteniendo y limpiando la data ------------------------------------------

# data <- read_csv("dia_25/Medium_Clean.csv")


# # Preparando los datos --------------------------------------------------

data_redu <- data %>% 
  select(Title, Claps, contains("Tag"))

data_redu_2 <- data_redu %>% 
  pivot_longer(-c("Title", "Claps"), names_to = "Tag", values_to = "ind") %>% 
  filter(ind ==1)

unique(data_redu_2$Tag)

data_redu_3 <- data_redu_2 %>% 
  filter(Tag %in% c("Tag_ai", 
                    "Tag_data-science",
                    "Tag_data",
                    "Tag_artificial-intelligence",
                    "Tag_deep-learning",
                    "Tag_machine-learning"
       )) 

             
data_redu_3 <- data_redu_3 %>% 
  mutate(Tag = ifelse(Tag == "Tag_artificial-intelligence",
                      "Tag_ai", Tag)) %>% 
  mutate(Tag = toupper(str_sub(Tag,start = 5)),
         Tag = fct_reorder(Tag, Claps, .desc = T))


# Graficando --------------------------------------------------------------


grafico <- data_redu_3 %>% 
  filter(Claps !=0, Claps > 5000) %>% 
  ggplot(aes(x = Tag, y = Claps,fill = Tag)) +
  geom_violin(show.legend = FALSE) + 
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 0),
        panel.grid = element_blank(),
  ) + 
  geom_jitter(alpha = 0.3 ,width = 0.2, show.legend = FALSE) +
  labs(title = "Variación de la cantidad de Claps según tema relacionado con datos",
       subtitle = "en publicaciones en Medium con más de 5000 claps") +
  expand_limits(y = 5000)
grafico
        
        
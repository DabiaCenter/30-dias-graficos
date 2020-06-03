library(tidyverse)
library(tidytext)
library(echarts4r)
library(RColorBrewer)
library(wordcloud)
library(stopwords)

potter <- read.csv("HarryPotter3.csv", sep = ";")
potter <- data.frame(potter)
colnames(potter) <- c("character", "sentence")
potter$character <- as.character(potter$character)
potter$sentence <- as.character(potter$sentence)

potter_tokens <- potter %>%
  unnest_tokens(word, sentence) %>%
  count(word) %>%
  arrange(desc(n))

important_words <- bind_rows(
  stop_words,
  tibble(
    word = stopwords::stopwords("es", "stopwords-iso"),
    lexicon = "custom"
  )
)

union <- potter_tokens %>%
  anti_join(important_words) %>%
  arrange(desc(n))

union %>%
  e_color_range(n, color, colors = c("#FF0000", "#FFA500", "#F3DC00", "#28EF00", "#000ADD", "#00D4C4","#8C00D4")) %>%
  e_charts() %>%
  e_cloud(word, n, color, shape = "triangle") %>%
  e_title("¿Cuáles son las palabras más usadas en el guión de Harry Potter y el prisionero de Azkaban?")
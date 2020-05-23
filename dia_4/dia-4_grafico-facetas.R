#librerias
library(tidyverse)
library(spotifyr)
library(wesanderson)

#Acceso a spotifyr
#id <- id_personal

#secret <- secret_personal

Sys.setenv(SPOTIFY_CLIENT_ID = id)

Sys.setenv(SPOTIFY_CLIENT_SECRET = secret)

access_token <- get_spotify_access_token()

#Extraccion de datos

discografia<-get_playlist_audio_features(playlist_uris ="5IkfrmTiMPib9YUYshcz5N")

#generar grafico

discografia %>%
  filter(track.album.name == c("The Getaway","I'm with You","By the Way","Stadium Arcadium","Californication")) %>%
  ggplot(aes(x = track.popularity ,fill = track.album.name)) +
  geom_density() +
  facet_grid(track.album.name~.) + 
  scale_fill_manual(name = "Album",values = wes_palette(n=5, name="Rushmore1")) +
  labs(title = "Comparación en la popularidad de las canciones entre los últimos 5 albumes de RHCP" ,
       y = "",
       x = "Popularidad"
  ) + 
  theme_classic()


#librerias
library(tidyverse)
library(spotifyr)
library(rpart)
library(rpart.plot)

#Acceso a spotifyr
#id <- id_personal

#secret <- secret_personal

Sys.setenv(SPOTIFY_CLIENT_ID = id)

Sys.setenv(SPOTIFY_CLIENT_SECRET = secret)

access_token <- get_spotify_access_token()

#Extraccion de datos

bad_bunny<-get_playlist_audio_features(playlist_uris ="37i9dQZF1DX2apWzyECwyZ")

#limpieza de datos
datos <- bad_bunny %>%
  select(c("danceability","energy","key","loudness","speechiness","acousticness","liveness","valence","tempo","track.popularity"))


#contruccion del modelo

modelo <- rpart(track.popularity ~ danceability + energy + key + loudness + speechiness + acousticness + liveness + valence + tempo, 
                method = "anova", 
                data = datos)

#graficar

rpart.plot(modelo, type = 3 ,clip.right.labs = FALSE, extra = 0 , 
           main = "Árbol de regresión para estimar la popularidad en canciones de Bad bunny", 
           box.palette = c("indianred3"))

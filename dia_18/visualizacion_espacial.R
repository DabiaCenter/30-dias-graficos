#cargar librerias
library(ggplot2)
library(dplyr)
require(maps)
require(viridis)


#importacion del mapa del mundo 
mapa_mundi <- map_data("world")
p <- ggplot(mapa_mundi,aes(x=long, y=lat,group= group)) +
  geom_polygon(fill="lightgray", colour="white")

#10 paises más poblados
paises <- c(
  "China", "India", "United States","Indonesia","Pakistan","Nigeria",
  "Brazil","Russia","Mexico","Japan")

#acomodo de data frame
mapa_paises <- map_data("world", region = paises)
region.lab.data <- mapa_paises %>%
  group_by(region) %>%
  summarise(long = mean(long), lat = mean(lat))

#gráfico
ggplot(mapa_paises, aes(x = long, y = lat)) +
  geom_polygon(aes( group = group, fill = region))+
  geom_text(aes(label = region), data = region.lab.data,  size = 3, hjust = 0.5)+
  scale_fill_viridis_d()+
  #theme_void()+
  theme(legend.position = "none") + 
  xlab("Longitud") +
  ylab("Latitud")+
  theme(panel.background = element_blank(),
        
        plot.title = element_text(hjust=0,size=18,vjust = 0))+
  ggtitle("Los 10 países más poblados del mundo")
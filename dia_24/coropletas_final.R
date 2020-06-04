#cargar librerias
library(readr)
library(ggplot2)
library(maptools)
library(mapdata)
library(rgdal)
library(gapminder)
library(scales)



mundo <- readOGR(dsn="C:/Users/Cristal Rivera P/Documents/DABIA/General/World_Countries",layer = "World_Countries")
#plot(mundo)

gapminder_data <- gapminder 
names(gapminder_data)[1] <- "COUNTRY"
names(gapminder_data)[4] <- "Esperanza_de_Vida"

np_dist <- fortify(mundo, region = "COUNTRY")


ggplot() +
  geom_map(data =  gapminder_data, aes(map_id = COUNTRY, fill = Esperanza_de_Vida),map=np_dist) +
  expand_limits(x = np_dist$long, y = np_dist$lat)+
  scale_fill_gradient2(low = muted("red"), 
                       mid = "cornsilk3", midpoint = 50, high = muted("blue"), limits = c(0,90))+
  theme(panel.background = element_blank(),
        
        plot.title = element_text(hjust=0,size=15,vjust = 0))+
  ggtitle("Esperanza de vida de diferentes países del año 1950 al 2007")

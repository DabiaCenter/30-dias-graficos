library(circlize)
library(readxl)

finales_costarica <- read_xlsx("finales_costarica.xlsx")

colores <- c("#FEFF35", "#4920FF", "#FFA500",
             "#FF2929", "#35F7FF", "#C5296F", 
             "#B75597", "#F3DC00", "#28EF00", 
             "#000ADD", "#00D4C4", "#8C00D4",
             "#5EB755", "#5F55B7", "#FF0000",
             "#B75555", "#27B57B")

chordDiagram(finales_costarica, 
             grid.col = colores,
             annotationTrack = "grid",
             preAllocateTracks = 1,
             transparency = 0.5)
             circos.trackPlotRegion(
               track.index = 1,
               panel.fun = function(x, y){
                 xlim = get.cell.meta.data("xlim")
                 ylim = get.cell.meta.data("ylim")
                 sector.name = get.cell.meta.data("sector.index")
                 circos.text(mean(xlim), ylim[1] + .1,
                             cex = 1,
                             facing = "clockwise",
                             sector.name,
                             niceFacing = TRUE, adj = c(0, 0.5))
               },
               bg.border = NA
             )
             title("Campeones y subcampeones de la Primera División de Costa Rica")
             text(x = 0, y = 1.035, "La línea que sale de un equipo hacia otro significa que ese equipo le ganó la final al otro", cex = 0.7)
             circos.clear()
             
             
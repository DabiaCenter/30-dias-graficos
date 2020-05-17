#Librería

library(arcdiagram)
library(randomcoloR)


#Definición del conjunto de pares de vértices adyacentes

relaciones <- rbind(cbind(1:14, 1:14),
                    c(1,2), c(1,4), c(1,5), c(1,6), c(1,8), c(1,10), c(1,11), c(1,13), c(1,14),
                    c(2,1), c(2,4), c(2,5), c(2,6), c(2,8), c(2,10), c(2,11), c(2,13), c(2,14),
                    c(3,4), c(3,8), c(3,10), c(3,11), c(3,13), c(3,14),
                    c(4,1), c(4,2), c(4,3), c(4,5), c(4,6), c(4,8), c(4,10), c(4,11), c(4,13), c(4,14),
                    c(5,1), c(5,2), c(5,4), c(5,6), c(5,7), c(5,8), c(5,10), c(5,11),
                    c(6,1), c(6,2), c(6,4), c(6,5), c(6,7), c(6,8), c(6,10), c(6,11),
                    c(7,5), c(7,6),
                    c(8,1), c(8,2), c(8,3), c(8,4), c(8,5), c(8,6), c(8,9), c(8,10), c(8,11), c(8,13), c(8,14),
                    c(9,8), c(9,10), c(9,11), c(9,13), c(9,14),
                    c(10,3), c(10,4), c(10,5), c(10,6), c(10,8), c(10,9), c(10,11), c(10,13), c(10,14),
                    c(11,3), c(11,4), c(11,5), c(11,6), c(11,8), c(11,9), c(11,10), c(11,12), c(11,13), c(11,14),
                    c(12,11), c(12,14),
                    c(13,1), c(13,2), c(13,3), c(13,4), c(13,8), c(13,9), c(13,10), c(13,11), c(13,14),
                    c(14,1), c(14,2), c(14,3), c(14,4), c(14,8), c(14,9), c(14,10), c(14,11), c(14,12), c(14,13)
)

# Etiquetación de vértices

nombres_personajes = c("Rey Ameba", "Reina Moho",
                        "Shriek", "Princesa Tusla", "Príncipe Collows", "Carl", "Príncipe Dingus",
                        "Maw Titter", "Billy Bob Estrella", "Sluggo", "Herb Estrella", "Margie Estrella",
                        "Gary el Caracol", "Patricio Estrella")

# Diagrama de arco

arcplot(relaciones, labels = nombres_personajes, col.arcs = randomColor(length(edgelist), hue = "pink"),
        main = "Relación familiar de la familia de Patricio Estrella y Gary", cex.labels = 0.6,
        sub = "Las relaciones hecha solo toman en cuenta tatarabuelos, bisbabuelos, abuelos, tios abuelos, papás e hijos",
        font.sub=3, cex.sub=0.7, horizontal = FALSE)



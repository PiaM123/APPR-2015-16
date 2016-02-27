# 3. faza: Izdelava zemljevida

source("lib/uvozi.zemljevid.r", encoding = "UTF-8")
library(ggplot2)
library(dplyr)

# Uvozimo zemljevid.
zemljevid <- uvozi.zemljevid("http://biogeo.ucdavis.edu/data/gadm2.8/shp/SVN_adm_shp.zip",
                             "SVN_adm1", encoding = "UTF-8")

# Preuredimo podatke, da jih bomo lahko izrisali na zemljevid.

pretvori.zemljevid <- function(zemljevid) {
  fo <- fortify(zemljevid)
  data <- zemljevid@data
  data$id <- as.character(0:(nrow(data)-1))
  return(inner_join(fo, data, by="id"))
}


slo <- pretvori.zemljevid(zemljevid)

ZemljevidIzobrazba <- ggplot() + geom_polygon(data = IzobrazbaRegije %>%
                          filter(Izobrazba == "Visoka") %>%
                          right_join(slo, by = c("Regija" = "NAME_1")),
                        aes(x = long, y = lat, group = group,
                            fill = Delež)) + ggtitle("Delež visoko izobraženih v posamezni regiji") + 
                      scale_fill_continuous(low = "#3f0000", high = "#ff0030")
                        

print(ZemljevidIzobrazba)

#Dodamo imena regij





                                          

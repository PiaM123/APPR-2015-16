# 3. faza: Izdelava zemljevida

source("lib/uvozi.zemljevid.r", encoding = "UTF-8")
library(ggplot2)
library(dplyr)

# Uvozimo zemljevid.
zemljevid <- uvozi.zemljevid("http://biogeo.ucdavis.edu/data/gadm2.8/shp/SVN_adm_shp.zip",
                             "SVN_adm1", encoding = "UTF-8")

slo <- pretvori.zemljevid(zemljevid)
ggplot() + geom_polygon(data = IzobrazbaRegije %>%
                          filter(Izobrazba == "Visoka") %>%
                          right_join(slo, by = c("Regija" = "NAME_1")),
                        aes(x = long, y = lat, group = group,
                            fill = Stevilo.oseb))
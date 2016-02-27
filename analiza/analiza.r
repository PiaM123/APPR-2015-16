# 4. faza: Analiza podatkov

library(mgcv) 

#Vse skupaj 

VseSkupaj <- ggplot(PlacaPoLetih, aes(x = Leto, y = Plača, color = Izobrazba, shape = Spol)) +
  geom_point() + geom_smooth(method = "lm", fullrange = TRUE) + xlim(2008, 2016) 
print(VseSkupaj)

# Ločimo po spolu in izobrazbi
ŽenskeVisoka <- PlacaPoLetih %>% filter(Spol == "Ženske") %>% 
  filter(Izobrazba == "Visoka")
grafŽV <- ggplot(ŽenskeVisoka, aes(x = Leto, y = Plača) ) + geom_point() + 
  geom_smooth(method = "lm", fullrange = TRUE) + xlim(2008, 2016)

grafŽV1 <- lowess(ŽenskeVisoka$Leto, ŽenskeVisoka$Plača)
grafŽV1 <- grafŽV + geom_line(data=as.data.frame(grafŽV1), aes(x=x, y=y), color="deeppink")

print(grafŽV1)

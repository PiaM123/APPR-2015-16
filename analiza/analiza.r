# 4. faza: Analiza podatkov

# Ločimo po spolu in izobrazbi
ŽenskeVisoka <- PlacaPoLetih %>% filter(Spol == "Ženske") %>% 
  filter(Izobrazba == "Visoka")
grafŽV <- ggplot(ŽenskeVisoka, aes(x = Leto, y = Plača) ) + geom_point() + 
  geom_smooth(method = "lm", fullrange = TRUE) + xlim(2008, 2016)
print(grafŽV)

grafŽV1 <- lowess(ŽenskeVisoka$Leto, ŽenskeVisoka$Plača)
grafŽV1 <- grafŽV + geom_line(data=as.data.frame(grafŽV1), aes(x=x, y=y), color="deeppink")
print(grafŽV1)

grafŽV2 <- loess(data = ŽenskeVisoka, Plača ~ Leto)
grafŽV2 <- grafŽV + geom_smooth(method = "loess")
print(grafŽV)

grafŽV3 <- gam(data = ŽenskeVisoka, Plača ~ s(Leto))
grafŽV3 <- fragŽV + geom_smooth(method = "gam", formula = y ~ s(x))
print(grafŽV3)
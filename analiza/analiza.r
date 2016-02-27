# 4. faza: Analiza podatkov

# Ločimo po spolu in izobrazbi
ŽenskeVisoka <- PlacaPoLetih %>% filter(Spol == "Ženske") %>% 
  filter(Izobrazba == "Visoka")
grafŽV <- ggplot(ŽenskeVisoka, aes(x = Leto, y = Plača) ) + geom_point() + 
  geom_smooth(method = "lm", fullrange = TRUE) + xlim(2008, 2016)
print(grafŽV)

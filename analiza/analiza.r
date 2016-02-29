# 4. faza: Analiza podatkov

library(mgcv) 

#Vse skupaj 

VseSkupaj <- ggplot(PlacaPoLetih, aes(x = Leto, y = Plača, color = Izobrazba, shape = Spol)) +
  geom_point() + geom_smooth(method = "lm", fullrange = TRUE) + xlim(2008, 2016) +
  labs(title = "Linearni model za moške in ženske z vsemi tremi stopnjami izobrazbe")
print(VseSkupaj)

# Ločimo po spolu in izobrazbi (Ženske visoka izobraza)
ŽenskeVisoka <- PlacaPoLetih %>% filter(Spol == "Ženske") %>% 
  filter(Izobrazba == "Visoka")
grafŽV <- ggplot(ŽenskeVisoka, aes(x = Leto, y = Plača) ) + geom_point() + 
  geom_smooth(method = "lm", fullrange = TRUE) + xlim(2008, 2016) +
  labs(title = " Linearni model za ženske z visoko izobrazbo")

grafŽV1 <- lowess(ŽenskeVisoka$Leto, ŽenskeVisoka$Plača)
grafŽV1 <- grafŽV + geom_line(data=as.data.frame(grafŽV1), aes(x=x, y=y), color="deeppink")

print(grafŽV1)

#Naredimo enako še za moške z visoko izobrazbo
MoškiVisoka <- PlacaPoLetih %>% filter(Spol == "Moški") %>% 
  filter(Izobrazba == "Visoka")
grafMV <- ggplot(MoškiVisoka, aes(x = Leto, y = Plača) ) + geom_point() + 
  geom_smooth(method = "lm", fullrange = TRUE) + xlim(2008, 2016) +
  labs(title = "Linearni model za moške z visoko izobrazbo")

grafMV1 <- lowess(MoškiVisoka$Leto, MoškiVisoka$Plača)
grafMV1 <- grafMV + geom_line(data=as.data.frame(grafMV1), aes(x=x, y=y), color="green")

print(grafMV1)

#Naredimo še kvadratni model (Ženske nizka izobrazba)
ŽenskeOsnovna <- PlacaPoLetih %>% filter(Spol == "Ženske") %>% 
  filter(Izobrazba == "Osnovna")
grafŽO <- ggplot(ŽenskeOsnovna, aes(x = Leto, y = Plača) ) + geom_point() + 
  geom_smooth(method = "lm", fullrange = TRUE, formula = y ~ x + I(x^2) ) + xlim(2008, 2016) +
  labs(title = "Kvadratni model za ženske z  osnovnošolsko izobrazbo")

grafŽO1 <- lowess(ŽenskeOsnovna$Leto, ŽenskeOsnovna$Plača)
grafŽO1 <- grafŽO + geom_line(data=as.data.frame(grafŽO1), aes(x=x, y=y), color="deeppink")

print(grafŽO1)

#Naredimo še kvadratni model za moške z osnovno izobrazbo

MoškiOsnovna <- PlacaPoLetih %>% filter(Spol == "Moški") %>% 
  filter(Izobrazba == "Osnovna")
grafMO <- ggplot(MoškiOsnovna, aes(x = Leto, y = Plača) ) + geom_point() + 
  geom_smooth(method = "lm", fullrange = TRUE, formula = y ~ x + I(x^2) ) + xlim(2008, 2016) +
  labs(title = "Kvadratni model za moške z osnovnošolko izobrazbo")

grafMO1 <- lowess(MoškiOsnovna$Leto, MoškiOsnovna$Plača)
grafMO1 <- grafMO + geom_line(data=as.data.frame(grafMO1), aes(x=x, y=y), color="green")

print(grafMO1)

#napoved za povprečno plačo žensk z visoko izobrazbo

lin <- lm(data = ŽenskeVisoka, Plača ~ Leto)
lin
NŽV <- predict(lin, data.frame(Leto = seq(2014, 2020, 1)))

# napoved za povprečno plačo moških z visoko izobrazbo

lim <- lm(data = MoškiVisoka, Plača ~ Leto)
lim
NMV <- predict(lim, data.frame(Leto = seq(2014, 2020, 1)))

#napoved za povprečno plačo žensk z osnovno izobrazbo
lin1 <- lm(data = ŽenskeOsnovna, Plača ~ Leto)
lin1
NŽO <- predict(lin1, data.frame(Leto = seq(2014, 2020, 1)))

#napoved za povprečno plačo moških z osnovno izobrazbo
lim1 <- lm(data = MoškiOsnovna, Plača ~ Leto)
lim1
NMO <- predict(lim1, data.frame(Leto = seq(2014, 2020, 1)))

#naredimo novo tabelo v katero damo te podatke

tabela = data.frame(NŽV, NMV, NŽO, NMO)
rownames(tabela) <- c("2014", "2015", "2016", "2017", "2018", "2019", "2020")
colnames(tabela) <- c("Ženske visoka", "Moški visoka", "Ženske osnovna", "Moški osnovna")



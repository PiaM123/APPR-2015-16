# 2. faza: Uvoz podatkov

# Funkcija, ki uvozi podatke iz datoteke druzine.csv
# Zapišimo podatke v razpredelnico druzine.
# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.


# IZOBRAZBA MOŠKIH V NEMČIJI

#Uvozimo podatke 
uvozi.IzobrazbaMoskiNemcija <- function() {
  return(read.table("podatki/IzobrazbaMoskiNemcija.csv", sep = ",", skip = 1, as.is = TRUE,
                    row.names = NULL,
                    col.names = 1:23,
                    fileEncoding = "Windows-1250"))
}

MoskiNemcija <- uvozi.IzobrazbaMoskiNemcija()

#Izbrišemo stolpce, ki jih ne potrebujemo
MoskiNemcija <- MoskiNemcija[,-1:-5]
MoskiNemcija <- MoskiNemcija[,-2:-4]
MoskiNemcija <- MoskiNemcija[,-3:-5]
MoskiNemcija <- MoskiNemcija[,-4:-9]
MoskiNemcija <- MoskiNemcija[,-5:-6]

#Dodamo imena stolpcev
colnames(MoskiNemcija) = c("Starost", "Stopnja.izobrazbe", "Leto", "Stevilo.oseb")

#Popravimo imena, da so v slovenščini
MoskiNemcija[1,2] <- "Osnovna"
MoskiNemcija[3,2] <- "Osnovna"
MoskiNemcija[7,2] <- "Osnovna"
MoskiNemcija[12,2] <- "Osnovna"
MoskiNemcija[2,2] <- "Srednja"
MoskiNemcija[4,2] <- "Srednja"
MoskiNemcija[8,2] <- "Srednja"
MoskiNemcija[10,2] <- "Srednja"
MoskiNemcija[5,2] <- "Visoka"
MoskiNemcija[6,2] <- "Visoka"
MoskiNemcija[9,2] <- "Visoka"
MoskiNemcija[11,2] <- "Visoka"

MoskiNemcija[1,1] <- "20-24 let"
MoskiNemcija[2,1] <- "20-24 let"
MoskiNemcija[6,1] <- "20-24 let"
MoskiNemcija[3,1] <- "30-34 let"
MoskiNemcija[10,1] <- "30-34 let"
MoskiNemcija[11,1] <- "30-34 let"
MoskiNemcija[4,1] <- "35-39 let"
MoskiNemcija[5,1] <- "35-39 let"
MoskiNemcija[12,1] <- "35-39 let"
MoskiNemcija[7,1] <- "25-29 let"
MoskiNemcija[8,1] <- "25-29 let"
MoskiNemcija[9,1] <- "25-29 let"




# IZOBRAZBA ŽENSK V NEMČIJI

#Uvozimo podatke
uvozi.IzobrazbaZenskeNemcija <- function() {
  return(read.table("podatki/IzobrazbaZenskeNemcija.csv", sep = ",", skip=1, as.is = TRUE,
                    row.names = NULL,
                    col.names = 1:23,
                    fileEncoding = "Windows-1250"))
}

ZenskeNemcija <- uvozi.IzobrazbaZenskeNemcija()

#Odstranimo nepotrebne stolpce
ZenskeNemcija <- ZenskeNemcija[,-1:-5]
ZenskeNemcija <- ZenskeNemcija[,-2:-4]
ZenskeNemcija <- ZenskeNemcija[,-3:-5]
ZenskeNemcija <- ZenskeNemcija[,-4:-9]
ZenskeNemcija <- ZenskeNemcija[,-5:-6]

#Dodamo imena stolpcev
colnames(ZenskeNemcija) = c("Starost", "Stopnja.izobrazbe", "Leto", "Stevilo.oseb")

#Popravimo imena, da bodo v slovenščini
ZenskeNemcija[1,2] <- "Osnovna"
ZenskeNemcija[4,2] <- "Osnovna"
ZenskeNemcija[8,2] <- "Osnovna"
ZenskeNemcija[11,2] <- "Osnovna"
ZenskeNemcija[2,2] <- "Srednja"
ZenskeNemcija[3,2] <- "Srednja"
ZenskeNemcija[5,2] <- "Srednja"
ZenskeNemcija[9,2] <- "Srednja"
ZenskeNemcija[6,2] <- "Visoka"
ZenskeNemcija[7,2] <- "Visoka"
ZenskeNemcija[10,2] <- "Visoka"
ZenskeNemcija[12,2] <- "Visoka"

ZenskeNemcija[1,1] <- "20-24 let"
ZenskeNemcija[2,1] <- "20-24 let"
ZenskeNemcija[7,1] <- "20-24 let"
ZenskeNemcija[3,1] <- "30-34 let"
ZenskeNemcija[12,1] <- "30-34 let"
ZenskeNemcija[11,1] <- "25-29 let"
ZenskeNemcija[4,1] <- "35-39 let"
ZenskeNemcija[5,1] <- "35-39 let"
ZenskeNemcija[6,1] <- "35-39 let"
ZenskeNemcija[10,1] <- "25-29 let"
ZenskeNemcija[8,1] <- "30-34 let"
ZenskeNemcija[9,1] <- "25-29 let"


#IZOBRAZBA ŽENSK V SLOVENIJI

#Uvozimo podatke
library(XML)
Sys.setlocale("LC_TIME", "C")

stripByPath <- function(x, path) {
  unlist(xpathApply(x, path,
                    function(y) gsub("^\\s*(.*?)\\s*$", "\\1",
                                     gsub("\\[[^]]*\\]", "",
                                          xmlValue(y)))))
}

uvozi.IzobrazbaZenskeSlovenija <- function() {
  url.IzobrazbaZenskeSlovenija <- "podatki/IzobrazbaZenskeSlovenija.htm"
  doc.IzobrazbaZenskeSlovenija <- htmlTreeParse(url.IzobrazbaZenskeSlovenija, useInternalNodes=TRUE, encoding="Windows-1250")
  tabele <- getNodeSet(doc.IzobrazbaZenskeSlovenija, "//table")
  vrstice <- getNodeSet(tabele[[1]], "./tr")
  seznam <- lapply(vrstice[4:8], stripByPath, "./td")
  seznam <- lapply(seznam, function(x) x[1:3])
  matrika <- matrix(unlist(seznam), nrow=length(seznam), byrow=TRUE)
  matrika <- apply(matrika[-nrow(matrika),], 2, as.numeric)
  colnames(matrika) <- gsub("\n", " ", stripByPath(vrstice[[3]], ".//th"))[2:4]
  return(
    data.frame("Število oseb z osnovnoŠolsko izobrazbo" = matrika[,1], "Število oseb s srednješolsko izobrazbo" = matrika[,2], "Število oseb z visokošolsko izobrazbo" = matrika[,3], row.names=1:4)
  )
}

ZenskeSlovenija <- uvozi.IzobrazbaZenskeSlovenija()

#Dodamo imena stolpcev
colnames(ZenskeSlovenija) = c("Število žensk z osnovnošolsko izobrazbo", "Število žensk s srednješolsko izobrazbo", "Število žensk z visokošolsko izobrazbo")

ZenskeSlovenija <- data.frame(Starost = c("20-24 let", "25-29 let", "30-34 let", "35-39 let"),
                              ZenskeSlovenija)



#IZOBRAZBA MOŠKIH V SLOVENIJI

#Uvozimo podatke
library(XML)
Sys.setlocale("LC_TIME", "C")

stripByPath <- function(x, path) {
  unlist(xpathApply(x, path,
                    function(y) gsub("^\\s*(.*?)\\s*$", "\\1",
                                     gsub("\\[[^]]*\\]", "",
                                          xmlValue(y)))))
}

uvozi.IzobrazbaMoskiSlovenija <- function() {
  url.IzobrazbaMoskiSlovenija <- "podatki/IzobrazbaMoskiSlovenija.htm"
  doc.IzobrazbaMoskiSlovenija <- htmlTreeParse(url.IzobrazbaMoskiSlovenija, useInternalNodes=TRUE, encoding="Windows-1250")
  tabele <- getNodeSet(doc.IzobrazbaMoskiSlovenija, "//table")
  vrstice <- getNodeSet(tabele[[1]], "./tr")
  seznam <- lapply(vrstice[4:8], stripByPath, "./td")
  seznam <- lapply(seznam, function(x) x[1:3])
  matrika <- matrix(unlist(seznam), nrow=length(seznam), byrow=TRUE)
  matrika <- apply(matrika[-nrow(matrika),], 2, as.numeric)
  colnames(matrika) <- gsub("\n", " ", stripByPath(vrstice[[3]], ".//th"))[2:4]
  return(
    data.frame("Število oseb z osnovnošolsko izobrazbo" = matrika[,1], "Število oseb s srednješolsko izobrazbo" = matrika[,2], "Število oseb z visokošolsko izobrazbo" = matrika[,3], row.names=1:4)
  )
}
MoskiSlovenija <- uvozi.IzobrazbaMoskiSlovenija()

#Dodamo imena stolpcev
colnames(MoskiSlovenija) = c("Število moških z osnovnošolsko izobrazbo", "Število moških s srednješolsko izobrazbo", "Število moških z visokošolsko izobrazbo")

MoskiSlovenija <- data.frame(Starost = c("20-24 let", "25-29 let", "30-34 let", "35-39"),
                             MoskiSlovenija)

#Izobrazbo v Sloveniji damo v obliko tidy data  
IzobrazbaSlovenija <- data.frame(Spol = c(rep("ženski", 12), rep("moški", 12)),
                                 Starost = c("20-24 let", "25-29 let", "30-34 let", "35-39 let"),
                                 Leto = 2013,
                                 Stopnja.izobrazbe = c("Osnovna",
                                                       "Srednja",
                                                       "Visoka") %>%
                                   matrix(ncol = 4, nrow = 3) %>% t() %>% as.vector(),
                                 Stevilo.oseb = c(ZenskeSlovenija[-1] %>% as.matrix() %>% as.vector(),
                                                  MoskiSlovenija[-1] %>% as.matrix() %>% as.vector()))

#DELOVNA AKTIVNOST IN POVPREČNE BRUTO PLAČE V SLOVENIJI

#Uvozimo podatke za povprečne bruto plače in delovno aktivnost  
uvozi.PlaceAktivnostSlovenija <- function() {
  return(read.csv2("podatki/PlaceAktivnostSlovenija.csv", sep = ";", skip = 0,
                   row.names = NULL,
                   fileEncoding = "Windows-1250"))
}


PlaceAktivnostSlovenija <- uvozi.PlaceAktivnostSlovenija()

#Uvozimo podatke za zemljevid - izobrazba v Sloveniji po regijah
uvozi.IzobrazbaRegije <- function() {
  return(read.table("podatki/IzobrazbaPoRegijah.csv", sep = ";", skip = 0, 
                    row.names = NULL,
                    fileEncoding = "Windows-1250"))
}

IzobrazbaRegije <- uvozi.IzobrazbaRegije()

colnames(IzobrazbaRegije) <- c("Regija", "Stevilo.oseb", "Izobrazba")

#Seštejemo število prebivalcev v določeni regiji
Pomurska <- sum(IzobrazbaRegije[1:3,2])
Podravska <- sum(IzobrazbaRegije[4:6,2])
Koroška <- sum(IzobrazbaRegije[7:9,2])
Savinjska <- sum(IzobrazbaRegije[10:12,2])
Zasavska <- sum(IzobrazbaRegije[13:15,2])
Spodnjeposavska <- sum(IzobrazbaRegije[16:18,2])
JugovzhodnaSlovenija <- sum(IzobrazbaRegije[19:21,2])
Osredjeslovenska <- sum(IzobrazbaRegije[22:24,2])
Gorenjska <- sum(IzobrazbaRegije[25:27,2])
NotranjoKraška <- sum(IzobrazbaRegije[28:30,2])
Goriška <- sum(IzobrazbaRegije[31:33,2])
ObalnoKraška <- sum(IzobrazbaRegije[34:36,2])

#Naredimo nov stolpec
IzobrazbaRegije["Delež"] <- NA

#Vstavimo deleže
IzobrazbaRegije[1:3,4] <- IzobrazbaRegije[1:3,2]/Pomurska
IzobrazbaRegije[4:6,4] <- IzobrazbaRegije[4:6,2]/Podravska
IzobrazbaRegije[7:9,4] <- IzobrazbaRegije[7:9,2]/Koroška
IzobrazbaRegije[10:12,4] <- IzobrazbaRegije[10:12,2]/Savinjska
IzobrazbaRegije[13:15,4] <- IzobrazbaRegije[13:15,2]/Zasavska
IzobrazbaRegije[16:18,4] <- IzobrazbaRegije[16:18,2]/Spodnjeposavska
IzobrazbaRegije[19:21,4] <- IzobrazbaRegije[19:21,2]/JugovzhodnaSlovenija
IzobrazbaRegije[22:24,4] <- IzobrazbaRegije[22:24,2]/Osredjeslovenska
IzobrazbaRegije[25:27,4] <- IzobrazbaRegije[25:27,2]/Gorenjska
IzobrazbaRegije[28:30,4] <- IzobrazbaRegije[28:30,2]/NotranjoKraška
IzobrazbaRegije[31:33,4] <- IzobrazbaRegije[31:33,2]/Goriška
IzobrazbaRegije[34:36,4] <- IzobrazbaRegije[34:36,2]/ObalnoKraška

# POVPREČNE MESEČNE BRUTO PLAČE PO LETIH GLEDE NA SPOL IN IZOBRAZBO
# to tabelo uvozimo zaradi 4. faze

uvozi.PlacaPoLetih<- function() {
  return(read.table("podatki/PlacaPoLetih.csv", sep = ";", skip = 1, as.is = TRUE,
                    row.names = NULL,
                    fileEncoding = "Windows-1250"))
}

PlacaPoLetih <- uvozi.PlacaPoLetih()

#Spremenimo imena stolpcev
colnames(PlacaPoLetih) <- c("Leto", "Spol", "Izobrazba", "Plača")
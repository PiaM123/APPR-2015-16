# 2. faza: Uvoz podatkov

# Funkcija, ki uvozi podatke iz datoteke druzine.csv
# Zapišimo podatke v razpredelnico druzine.
# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.


# MOŠKI NEMČIJA IZOBRAZBA
uvozi.IzobrazbaMoskiNemcija <- function() {
  return(read.table("podatki/IzobrazbaMoskiNemcija.csv", sep = ",", skip = 1, as.is = TRUE,
                    row.names = NULL,
                    col.names = 1:23,
                    fileEncoding = "Windows-1250"))
}

MoskiNemcija <- uvozi.IzobrazbaMoskiNemcija()

MoskiNemcija <- MoskiNemcija[,-1:-5]
MoskiNemcija <- MoskiNemcija[,-2:-4]
MoskiNemcija <- MoskiNemcija[,-3:-5]
MoskiNemcija <- MoskiNemcija[,-4:-9]
MoskiNemcija <- MoskiNemcija[,-5:-6]

colnames(MoskiNemcija) = c("Starost", "Stopnja izobrazbe", "Leto", "Stevilo oseb")

MoskiNemcija[1,2] <- "Osnovnosolka izobrazba"
MoskiNemcija[3,2] <- "Osnovnosolka izobrazba"
MoskiNemcija[7,2] <- "Osnovnosolka izobrazba"
MoskiNemcija[12,2] <- "Osnovnosolka izobrazba"
MoskiNemcija[2,2] <- "Srednjesolska izobrazba"
MoskiNemcija[4,2] <- "Srednjesolska izobrazba"
MoskiNemcija[8,2] <- "Srednjesolska izobrazba"
MoskiNemcija[10,2] <- "Srednjesolska izobrazba"
MoskiNemcija[5,2] <- "Visokosolska izobrazba"
MoskiNemcija[6,2] <- "Visokosolska izobrazba"
MoskiNemcija[9,2] <- "Visokosolska izobrazba"
MoskiNemcija[11,2] <- "Visokosolska izobrazba"

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




# ŽENSKE NEMČIJA IZOBRAZBA
uvozi.IzobrazbaZenskeNemcija <- function() {
  return(read.table("podatki/IzobrazbaZenskeNemcija.csv", sep = ",", skip=1, as.is = TRUE,
                    row.names = NULL,
                    col.names = 1:23,
                    fileEncoding = "Windows-1250"))
}

ZenskeNemcija <- uvozi.IzobrazbaZenskeNemcija()

ZenskeNemcija <- ZenskeNemcija[,-1:-5]
ZenskeNemcija <- ZenskeNemcija[,-2:-4]
ZenskeNemcija <- ZenskeNemcija[,-3:-5]
ZenskeNemcija <- ZenskeNemcija[,-4:-9]
ZenskeNemcija <- ZenskeNemcija[,-5:-6]

colnames(ZenskeNemcija) = c("Starost", "Stopnja izobrazbe", "Leto", "Stevilo oseb")


ZenskeNemcija[1,2] <- "Osnovnosolka izobrazba"
ZenskeNemcija[4,2] <- "Osnovnosolka izobrazba"
ZenskeNemcija[8,2] <- "Osnovnosolka izobrazba"
ZenskeNemcija[11,2] <- "Osnovnosolka izobrazba"
ZenskeNemcija[2,2] <- "Srednjesolska izobrazba"
ZenskeNemcija[3,2] <- "Srednjesolska izobrazba"
ZenskeNemcija[5,2] <- "Srednjesolska izobrazba"
ZenskeNemcija[9,2] <- "Srednjesolska izobrazba"
ZenskeNemcija[6,2] <- "Visokosolska izobrazba"
ZenskeNemcija[7,2] <- "Srednjesolska izobrazba"
ZenskeNemcija[10,2] <- "Visokosolska izobrazba"
ZenskeNemcija[12,2] <- "Srednjesolska izobrazba"

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


# ŽENSKE SLOVENIJA IZOBRAZBA

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
    data.frame("Stevilo oseb z osnovnosolsko izobrazbo" = matrika[,1], "Stevilo oseb s srednjesolsko izobrazbo" = matrika[,2], "Stevilo oseb z visokosolsko izobrazbo" = matrika[,3], row.names=1:4)
  )
}

ZenskeSlovenija <- uvozi.IzobrazbaZenskeSlovenija()

colnames(ZenskeSlovenija) = c("Stevilo zensk z osnovnosolsko izobrazbo", "Stevilo zensk s srednjesolsko izobrazbo", "Stevilo zensk z visokosolsko izobrazbo")

ZenskeSlovenija <- data.frame(Starost = c("20-24 let", "25-29 let", "30-34 let", "35-39 let"),
                             ZenskeSlovenija)

# MOŠKI SLOVENIJA IZOBRAZBA

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
    data.frame("Stevilo oseb z osnovnosolsko izobrazbo" = matrika[,1], "Stevilo oseb s srednjesolsko izobrazbo" = matrika[,2], "Stevilo oseb z visokosolsko izobrazbo" = matrika[,3], row.names=1:4)
  )
}
  MoskiSlovenija <- uvozi.IzobrazbaMoskiSlovenija()
  
  colnames(MoskiSlovenija) = c("Število moskih z osnovnosolsko izobrazbo", "Stevilo moskih s srednjesolsko izobrazbo", "Stevilo moskih z visokosolsko izobrazbo")
  
  MoskiSlovenija <- data.frame(Starost = c("20-24 let", "25-29 let", "30-34 let", "35-39"),
                                MoskiSlovenija)

  
  #DELOVNA AKTIVNOST IN POVPREČNE BRUTO PLAČE V SLOVENIJI
  
  uvozi.PlaceAktivnostSlovenija <- function() {
    return(read.csv2("podatki/PlaceAktivnostSlovenija.csv", sep = ";", skip = 0, as.is = TRUE,
                      row.names = NULL,
                      fileEncoding = "Windows-1250"))
  }
  
  
  PlaceAktivnostSlovenija <- uvozi.PlaceAktivnostSlovenija()
  

  
  
# 2. faza: Uvoz podatkov

# Funkcija, ki uvozi podatke iz datoteke druzine.csv
# Zapišimo podatke v razpredelnico druzine.
# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.


# MOŠKI NEMČIJA
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




# ŽENSKE NEMČIJA
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


# ŽENSKE SLOVENIJA

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

ZenskeSlovenija <- data.frame(starost = c("20-24 let", "25-29 let", "30-34 let", "35-39 let"),
                             ZenskeSlovenija)
# MOŠKI SLOVENIJA

library(XML)
Sys.setlocale("LC_TIME", "C")

stripByPath <- function(x, path) {
  unlist(xpathApply(x, path,
                    function(y) gsub("^\\s*(.*?)\\s*$", "\\1",
                                     gsub("\\[[^]]*\\]", "",
                                          xmlValue(y)))))
}

uvozi.IzobrazbaMoskiSlovenija <- function() {
  url.IzobrazbaMoskiSlovenija <- "podatki/IzobrazbaZenskeSlovenija.htm"
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
  
  colnames(MoskiSlovenija) = c("Stevilo moskih z osnovnosolsko izobrazbo", "Stevilo moskih s srednjesolsko izobrazbo", "Stevilo moskih z visokosolsko izobrazbo")
  
  ZenskeSlovenija <- data.frame(starost = c("20-24 let", "25-29 let", "30-34 let", "35-39 let"),
                                ZenskeSlovenija)
  
  #Graf za izobrazbo moških v Sloveniji
  
  grafMS <- ggplot2(MoskiSlovenija, aes(x = starost, y = Stevilo.moskih.z.visokosolsko.izobrazbo,)) +
    geom_bar(stat = "identity") + theme_minimal() + aes(fill=starost) +
    labs(title="Število moških z visokošolsko izobrazbo v Sloveniji", y="Število")
  print(grafMS)
  
  #Graf za izobrazbo žensk v Sloveniji.
  
  grafZS <- ggplot2(ZenskeSlovenija, aes(x = starost, y = Stevilo.zensk.z.visokosolsko.izobrazbo,)) +
    geom_bar(stat = "identity") + theme_minimal() + aes(fill=starost) + 
    labs(title="Število žensk v Sloveniji z visokošolsko izobrazbo", y="Število")
  print(grafZS)
  
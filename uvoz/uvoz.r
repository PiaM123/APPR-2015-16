# 2. faza: Uvoz podatkov

require(dplyr)
require(rvest)
require(gsubfn)


# Funkcija, ki uvozi podatke iz datoteke druzine.csv
# Zapišimo podatke v razpredelnico druzine.
#druzine <- uvozi.druzine()

#obcine <- uvozi.obcine()

stran <- file("podatki/05G2010S.htm") %>% read_html(encoding = "Windows-1250")
tabela <- stran %>% html_nodes(xpath ="//table[1]") %>% .[[1]] %>% html_table(fill=TRUE)

SLO.2011 <- data.frame(apply(tabela[4:14, 5:14], 2, as.numeric))
row.names(SLO.2011) <- tabela[4:14, 1]
names(SLO.2011) <- tabela[2, 5:14]
Encoding(names(SLO.2011)) <- "UTF-8"

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
  colnames(matrika) <- gsub("\n", " ", stripByPath(vrstice[[3]], ".//th"))[2:4]
  return(
    data.frame("Stevilo oseb z osnovnosolsko izobrazbo" = matrika[,1], "Stevilo oseb s srednjesolsko izobrazbo" = matrika[,2], "Stevilo oseb z visokosolsko izobrazbo" = matrika[,3], row.names=1:5)
  )
}


ZenskeSlovenija <- uvozi.IzobrazbaZenskeSlovenija()

rownames(ZenskeSlovenija) = c("20-24 let", "25-29 let", "30-34 let", "35-39 let", "nič")

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
  url.IzobrazbaMoskiSlovenija <- "podatki/IzobrazbaMoskiSlovenija.htm"
  doc.IzobrazbaMoskiSlovenija <- htmlTreeParse(url.IzobrazbaMoskiSlovenija, useInternalNodes=TRUE, encoding="Windows-1250")
  tabele <- getNodeSet(doc.IzobrazbaMoskiSlovenija, "//table")
  vrstice <- getNodeSet(tabele[[1]], "./tr")
  seznam <- lapply(vrstice[4:8], stripByPath, "./td")
  seznam <- lapply(seznam, function(x) x[1:3])
  matrika <- matrix(unlist(seznam), nrow=length(seznam), byrow=TRUE)
  colnames(matrika) <- gsub("\n", " ", stripByPath(vrstice[[3]], ".//th"))[2:4]
  return(
    data.frame("Stevilo oseb z osnovnosolsko izobrazbo" = matrika[,1], "Stevilo oseb s srednjesolsko izobrazbo" = matrika[,2], "Stevilo oseb z visokosolsko izobrazbo" = matrika[,3], row.names=1:5)
  )
}


MoskiSlovenija <- uvozi.IzobrazbaMoskiSlovenija()

rownames(MoskiSlovenija) = c("20-24 let", "25-29 let", "30-34 let", "35-39 let", "nič")

# 2. faza: Uvoz podatkov

require(dplyr)
require(rvest)
require(gsubfn)


# Funkcija, ki uvozi podatke iz datoteke druzine.csv
# Zapišimo podatke v razpredelnico druzine.
# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.


# Uvozimo podatke za izobrazbo moških v Nemčiji.
uvozi.IzobrazbaMoskiNemcija <- function() {
  return(read.table("podatki/IzobrazbaMoskiNemcija.csv", sep = ",", as.is = TRUE,
                      row.names = NULL,
                      col.names = 1:23,
                      fileEncoding = "Windows-1250"))
}

MoskiNemcija <- uvozi.IzobrazbaMoskiNemcija()


# Uvozimo podatke za izobrazbo žensk v Nečiji. 
uvozi.IzobrazbaZenskeNemcija <- function() {
  return(read.table("podatki/IzobrazbaZenskeNemcija.csv", sep = ",", as.is = TRUE,
                    row.names = NULL,
                    col.names = 1:23,
                    fileEncoding = "Windows-1250"))
}


# Uvozimo podatke za izobrazbo moških v Sloveniji.


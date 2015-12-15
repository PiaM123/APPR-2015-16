# Obdelava, uvoz in čiščenje podatkov.

Tukaj bomo imeli program, ki bo obdelal, uvozil in očistil podatke (druga faza
projekta).

require(dplyr)
require(rvest)
require(gsubfn

uvozi.IzobrazbaZenskeNemcija <- function() {
  return(read.csv("podatki/IzobrazbaZenskeNemcija.csv", sep = ",", as.is = TRUE,
                      fileEncoding = "Windows-1250"))
}

uvozi.IzobrazbaMoskiNemcija <- function() {
  return(read.csv("podatki/IzobrazbaMoskiNemcija.csv", sep = ",", as.is = TRUE,
                      fileEncoding = "Windows-1250"))
}


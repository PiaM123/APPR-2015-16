# 2. faza: Uvoz podatkov

require(dplyr)
require(rvest)
require(gsubfn)


# Funkcija, ki uvozi podatke iz datoteke druzine.csv
uvozi.druzine <- function() {
  return(read.csv2("podatki/druzine.csv", sep = ";", as.is = TRUE,
                      row.names = 1,
                      col.names = c("obcina", "en", "dva", "tri", "stiri"),
                      fileEncoding = "Windows-1250"))
}

# Zapišimo podatke v razpredelnico druzine.
#druzine <- uvozi.druzine()

#obcine <- uvozi.obcine()

stran <- file("podatki/05G2010S.htm") %>% read_html(encoding = "Windows-1250")
tabela <- stran %>% html_nodes(xpath ="//table[1]") %>% .[[1]] %>% html_table(fill=TRUE)

SLO.2011 <- data.frame(apply(tabela[4:14, 5:14], 2, as.numeric))
row.names(SLO.2011) <- tabela[4:14, 1]
names(SLO.2011) <- tabela[2, 5:14]
Encoding(names(SLO.2011)) <- "UTF-8"

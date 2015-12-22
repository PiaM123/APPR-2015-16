library(knitr)

# Uvozimo funkcije za delo z datotekami XML.
source("lib/xml.r", encoding = "UTF-8")

require(dplyr)
require(rvest)
require(gsubfn)
library(XML)
library(ggplot2)

# Uvozimo funkcije za pobiranje in uvoz zemljevida..
source("lib/uvozi.zemljevid.r", encoding = "UTF-8")

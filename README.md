# Analiza podatkov s programom R, 2015/16

Avtor: Pia Modrijan 

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2015/16.

## Tematika

Za svojo temo sem si izbrala analizo izobraženosti prebivalcev Slovenije. 

Podatke bom črpala iz STATISTIČNEGA URADA REPUBLIKE SLOVENIJE (STAT):
http://pxweb.stat.si/pxweb/Dialog/varval.asp?ma=05G2010S&ti=&path=../Database/Dem_soc/05_prebivalstvo/20_soc_ekon_preb/01_05G20_izobrazba/&lang=2
Tu so podatki na voljo v oblikah html, csv, txt, xls,..

Zanimale me bodo osnovnošolska, srednješolska ter višješolska oziroma visokošolska izobrazba. Te podatke bom analizirala v letih 2012, 2013 in 2014.

Moj cilj je predstaviti kako se stopnja izobrazbe moških in žensk spreminja glede na regije, katera stopnja izobrazbe je najbolj pogosta, ter v kateri regiji je stopnja izobrazbe največja in v kateri najmanjša. Naredila bom tudi primerjavo med moškimi in ženskami po izobrazbah, torej katerih je več pri posamezni stopnji izobrazbe.

## Program

Glavni program in poročilo se nahajata v datoteki `projekt.Rmd`. Ko ga prevedemo,
se izvedejo programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`. Podatkovni
viri so v mapi `podatki/`. Zemljevidi v obliki SHP, ki jih program pobere, se
shranijo v mapo `../zemljevidi/` (torej izven mape projekta).

## Spletni vmesnik

Spletni vmesnik se nahaja v datotekah v mapi `shiny/`. Poženemo ga tako, da v
RStudiu odpremo datoteko `server.R` ali `ui.R` ter kliknemo na gumb *Run App*.
Alternativno ga lahko poženemo tudi tako, da poženemo program `shiny.r`.

## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti sledeče pakete za R:

* `knitr` - za izdelovanje poročila
* `rmarkdown` - za prevajanje poročila v obliki RMarkdown
* `shiny` - za prikaz spletnega vmesnika
* `DT` - za prikaz interaktivne tabele
* `maptools` - za uvoz zemljevidov
* `sp` - za delo z zemljevidi
* `digest` - za zgoščevalne funkcije (uporabljajo se za shranjevanje zemljevidov)
* `httr` - za pobiranje spletnih strani
* `XML` - za branje spletnih strani
* `extrafont` - za pravilen prikaz šumnikov (neobvezno)

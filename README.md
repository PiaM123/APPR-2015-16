# Analiza podatkov s programom R, 2015/16

Avtor: Pia Modrijan 

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2015/16.

## Tematika

Za svojo tematiko sem izbrala analizo 100 najboljših filmov.
Podatke bom črpala iz spletne strani IMDB:
http://www.imdb.com/list/ls055592025/

Filme bom med seboj primerjala po:
1.letu nastanka
2.oceni
3.zvrsti
4.številu nominacij
5.številu nagrad
6.državah, kjer je bil posnet film

Uporabila bom nominacije oziroma nagrade, ki so jih podelile organizacije/akademije The Oscars, BAFTA in THE Golden Globe Award.

S projektom bom ugotovila, v katerem obdobju so po večini nastali filmi, ki so med najbolj priljubljenimi, katera zvrst filmov je najbol priljubljena, ter v katerih državah so bili posneti najbolj priljubljeni filmi.

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

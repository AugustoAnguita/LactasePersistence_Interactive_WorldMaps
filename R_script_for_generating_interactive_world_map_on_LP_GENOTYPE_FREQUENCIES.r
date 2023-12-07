###### OPTION 1

# Bd <- read.csv2("/home/augusto/Descargas/MAP_LACTOSE/DATABASES/FINAL_TO_MAP/FINAL_FINAL/DB_ALLELES_WHOLE.csv", header=TRUE, sep=";", stringsAsFactors=F, dec=",", na.strings=c(""," ","NaN","NA"))
Bd = read.csv2("./www/INPUT_DATABASE_for_generating_interactive_world_map_on_LP_GENOTYPE_FREQUENCIES.csv", 
               header=TRUE, sep=";", stringsAsFactors=F, dec=",", na.strings=c(""," ","NaN","NA"))
#Datos input en formato wide
Bd <- Bd[,2:9]
Bd


CapStr <- function(y) {
  c <- strsplit(y, " ")[[1]]
  paste(toupper(substring(c, 1,1)), substring(c, 2),
      sep="", collapse=" ")
}


Bd$Country <- tolower(Bd$Country)
Bd$Country <- sapply(Bd$Country, CapStr)
Bd$Country

Bd <- Bd[which(Bd$Frequency.of.LP.alleles != 0),]

#Bd <- Bd[which(Bd$SNP %in% c("")),]


#Bd <- Bd[which(Bd$SNP %in% c("-13495 C>T rs4954490","-13907 C>G rs41525747","-13910 C>T rs4988235","-13915 T>G rs41380347","-14009 T>G ss820486563","-14010 G>C rs145946881")),]
table(Bd$SNP)
Bd <- Bd[which(Bd$SNP %in% c("-13907 C>G rs41525747","-13910 C>T rs4988235","-13915 T>G rs41380347","-14009 T>G ss820486563","-13495 C>T rs4954490","-14010 G>C rs145946881 ")),]


table(Bd$SNP)



# Library
library(rgdal)
library(maptools)
library(htmlwidgets)
library(leaflet)

# load example data (Fiji Earthquakes) + keep only 100 first lines

quakes <-  Bd

#quakes$LATITUDE <- jitter(quakes$LATITUDE, factor = 0.0001)
#quakes$LONGITUDE <- jitter(quakes$LONGITUDE, factor = 0.0001)

quakes

# Create a color palette with handmade bins.
mybins <- seq(0, 1, by=0.1)
mypalette <- colorBin( palette="Blues", domain=quakes$Frequency.of.LP.alleles, na.color="transparent", bins=mybins)

quakes$SNP <- as.factor(quakes$SNP)
quakes$SNP <- factor(quakes$SNP, levels(quakes$SNP)[c(5,2,1,4,3,6)])
#3,4,1,2,5
mypalette <- colorFactor( palette="Set3", domain=quakes$SNP, na.color="transparent")



# Prepare the text for the tooltip:
mytext <- paste(
   "Country: ", quakes$Country, "<br/>", 
   "Population: ", quakes$Population, "<br/>",
   "N: ", quakes$N, "<br/>",
   "Frequency of LP-associated allele: ",quakes$Frequency.of.LP.alleles, "<br/>",
   "SNP",quakes$SNP, "<br/>", 
   "Reference: ", quakes$Reference, sep="") %>%
  lapply(htmltools::HTML)

# %>%
#  addProviderTiles("Esri.WorldImagery")

# Final Map
m <- leaflet(quakes) %>% 
  addTiles()  %>%
  addCircleMarkers(~Longitude, ~Latitude, 
    fillColor = ~mypalette(SNP), fillOpacity =0.7, color="black", radius=7, stroke=TRUE,weight=1,clusterOptions =
               markerClusterOptions(freezeAtZoom=3,spiderfyDistanceMultiplier=1.4,maxClusterRadius=50,iconCreateFunction =
                                      JS("                       function(cluster) {                                             return new L.DivIcon({                                               html: '<div style=\"background-color:rgba(77,77,77,0.7)\"><span>' + cluster.getChildCount() + '</div><span>',                                               className: 'marker-cluster'                                             });                                       }")),label = mytext,
    labelOptions = labelOptions( style = list("font-weight" = "normal", padding = "3px 8px"), textsize = "13px", direction = "auto")
  ) %>%
  addLegend( pal=mypalette, values=~SNP, opacity=0.9, title = "LP-associated SNP", position = "bottomright" )

m 
# library(htmlwidgets)
# 
# saveWidget(m, file=paste0( "/home/augusto/Descargas/MAP_LACTOSE/OUTPUT_MAPS/MAP2.html"))

#########ELEGIDO
















# Prepare the text for the tooltip:
mytext <- paste(
   "Country: ", quakes$Country, "<br/>", 
   "Population: ", quakes$Population, "<br/>",
   "N: ", quakes$N, "<br/>",
   "Frequency of LP-associated alleles: ",quakes$Frequency.of.LP.alleles, "<br/>",
   "SNP",quakes$SNP, "<br/>", 
   "Reference: ", quakes$Reference, sep="") %>%
  lapply(htmltools::HTML)

# %>%
#  addProviderTiles("Esri.WorldImagery")

# Final Map
m <- leaflet(quakes) %>% 
  addTiles()  %>%
  addCircleMarkers(~Longitude, ~Latitude, 
    fillColor = ~mypalette(SNP), fillOpacity =0.7, color="black", radius=7, stroke=TRUE,weight=1,label = mytext,
    labelOptions = labelOptions( style = list("font-weight" = "normal", padding = "3px 8px"), textsize = "13px", direction = "auto")
  ) %>%
  addLegend( pal=mypalette, values=~SNP, opacity=0.9, title = "LP-associated SNP", position = "bottomright" )

m 
# library(htmlwidgets)
# 
# saveWidget(m, file=paste0( "/home/augusto/Descargas/MAP_LACTOSE/OUTPUT_MAPS/backgroundMap_Five_Alleles_Option2.html"))

# saveRDS(m, "./www/genotype_frequencies.RDS")





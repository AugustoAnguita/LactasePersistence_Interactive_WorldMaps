###### OPTION 1

Bd <- read.csv2("/home/augusto/Descargas/MAP_LACTOSE/DATABASES/FINAL_TO_MAP/FINAL_FINAL/DB_LPFREQ_vfiltered.csv", header=TRUE, sep=";", stringsAsFactors=F, dec=",", na.strings=c(""," ","NaN","NA"))
#Datos input en formato wide
Bd <- Bd[,2:8]
Bd


CapStr <- function(y) {
  c <- strsplit(y, " ")[[1]]
  paste(toupper(substring(c, 1,1)), substring(c, 2),
      sep="", collapse=" ")
}


Bd$Country <- tolower(Bd$Country)
Bd$Country <- sapply(Bd$Country, CapStr)
Bd$Country


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
mypalette <- colorBin( palette="RdBu", domain=quakes$Frequency_of_digestors, na.color="transparent", bins=mybins)

# Prepare the text for the tooltip:
mytext <- paste(
   "Country: ", quakes$Country, "<br/>", 
   "Population: ", quakes$Population, "<br/>",
   "Frequency of lactose digestors: ", quakes$Frequency_of_digestors, "<br/>", 
   "N: ", quakes$N, "<br/>", 
   "Reference: ", quakes$Reference, sep="") %>%
  lapply(htmltools::HTML)

# %>%
#  addProviderTiles("Esri.WorldImagery")

# Final Map
m <- leaflet(quakes) %>% 
  addTiles()  %>%
  addCircleMarkers(~longitude, ~latitude, 
    fillColor = ~mypalette(Frequency_of_digestors), fillOpacity = 0.7, color="black", radius=7, stroke=TRUE,weight=1,clusterOptions =
               markerClusterOptions(freezeAtZoom=3,spiderfyDistanceMultiplier=1.4,maxClusterRadius=50,iconCreateFunction =
                                      JS("                       function(cluster) {                                             return new L.DivIcon({                                               html: '<div style=\"background-color:rgba(77,77,77,0.7)\"><span>' + cluster.getChildCount() + '</div><span>',                                               className: 'marker-cluster'                                             });                                       }")),
    label = mytext,
    labelOptions = labelOptions( style = list("font-weight" = "normal", padding = "3px 8px"), textsize = "13px", direction = "auto")
  ) %>%
  addLegend( pal=mypalette, values=~Frequency_of_digestors, opacity=0.9, title = "Frequency of lactose digestors", position = "bottomright" )

m 
library(htmlwidgets)

saveWidget(m, file=paste0( "/home/augusto/Descargas/MAP_LACTOSE/OUTPUT_MAPS/LP_Phen_Freq_OptionFrozenClusters_A.html"))

#########ELEGIDO














# Prepare the text for the tooltip:
# Prepare the text for the tooltip:
mytext <- paste(
   "Country: ", quakes$Country, "<br/>", 
   "Population: ", quakes$Population, "<br/>",
   "Frequency of digestors: ", quakes$Frequency_of_digestors, "<br/>", 
   "N: ", quakes$N, "<br/>", 
   "Reference: ", quakes$Reference, sep="") %>%
  lapply(htmltools::HTML)

# %>%
#  addProviderTiles("Esri.WorldImagery")

# Final Map
m <- leaflet(quakes) %>% 
  addTiles()  %>%
  addCircleMarkers(~longitude, ~latitude, 
    fillColor = ~mypalette(Frequency_of_digestors), fillOpacity = 0.7, color="black", radius=7, stroke=TRUE,weight=1,clusterOptions =
               markerClusterOptions(spiderfyDistanceMultiplier=1.4,maxClusterRadius=50,iconCreateFunction =
                                      JS("                       function(cluster) {                                             return new L.DivIcon({                                               html: '<div style=\"background-color:rgba(77,77,77,0.7)\"><span>' + cluster.getChildCount() + '</div><span>',                                               className: 'marker-cluster'                                             });                                       }")),
    label = mytext,
    labelOptions = labelOptions( style = list("font-weight" = "normal", padding = "3px 8px"), textsize = "13px", direction = "auto")
  ) %>%
  addLegend( pal=mypalette, values=~Frequency_of_digestors, opacity=0.9, title = "Frequency of digestors", position = "bottomright" )

m 
library(htmlwidgets)

saveWidget(m, file=paste0( "/home/augusto/Descargas/MAP_LACTOSE/OUTPUT_MAPS/LP_Phen_Freq_OptionClusters.html"))

















# Create a color palette with handmade bins.
mybins <- seq(0, 1, by=0.1)
mypalette <- colorBin( palette="RdBu", domain=quakes$Frequency_of_digestors, na.color="transparent", bins=mybins)

# Prepare the text for the tooltip:
# Prepare the text for the tooltip:
mytext <- paste(
   "Country: ", quakes$Country, "<br/>", 
   "Population: ", quakes$Population, "<br/>",
   "Frequency of digestors: ", quakes$Frequency_of_digestors, "<br/>", 
   "N: ", quakes$N, "<br/>", 
   "Reference: ", quakes$Reference, sep="") %>%
  lapply(htmltools::HTML)

# %>%
#  addProviderTiles("Esri.WorldImagery")

# Final Map
m <- leaflet(quakes) %>% 
  addTiles()  %>%
  addCircleMarkers(~longitude, ~latitude, 
    fillColor = ~mypalette(Frequency_of_digestors), fillOpacity = 0.7, color="black", radius=7, stroke=TRUE,weight=1,clusterOptions =
               markerClusterOptions(freezeAtZoom=18,spiderfyDistanceMultiplier=1.5,maxClusterRadius=50,iconCreateFunction =
                                      JS("                       function(cluster) {                                             return new L.DivIcon({                                               html: '<div style=\"background-color:rgba(77,77,77,0.7)\"><span>' + cluster.getChildCount() + '</div><span>',                                               className: 'marker-cluster'                                             });                                       }")),
    label = mytext,
    labelOptions = labelOptions( style = list("font-weight" = "normal", padding = "3px 8px"), textsize = "13px", direction = "auto")
  ) %>%
  addLegend( pal=mypalette, values=~Frequency_of_digestors, opacity=0.9, title = "Frequency of digestors", position = "bottomright" )

m 
library(htmlwidgets)

saveWidget(m, file=paste0( "/home/augusto/Descargas/MAP_LACTOSE/OUTPUT_MAPS/LP_Phen_Freq_OptionFrozenClusters_B.html"))








##MEANS by country

d <- quakes[which(!is.na(quakes$N)),]

ds <- aggregate(d[, c(3:4,6)], list(d$Country), mean)
names(ds)[1] <- "Country"
ds
da <- aggregate(d[, c(5)], list(d$Country), sum)
names(da)[1] <- "Country"
names(da)[2] <- "N"
da

quakes <- cbind(ds,da[,2])
names(quakes)[5] <- "N"

# Create a color palette with handmade bins.
mybins <- seq(0, 1, by=0.1)
mypalette <- colorBin( palette="RdBu", domain=quakes$Frequency_of_digestors, na.color="transparent", bins=mybins)

# Prepare the text for the tooltip:
mytext <- paste(
   "Country: ", quakes$Country, "<br/>",
   "Frequency of digestors (Country mean): ", round(quakes$Frequency_of_digestors,2), "<br/>", 
   "N: ", quakes$N, sep="") %>%
  lapply(htmltools::HTML)

# %>%
#  addProviderTiles("Esri.WorldImagery")

# Final Map
m <- leaflet(quakes) %>% 
  addTiles()  %>%
  addCircleMarkers(~longitude, ~latitude, 
    fillColor = ~mypalette(Frequency_of_digestors), fillOpacity = 0.7, color="black", radius=7, stroke=TRUE,weight=1,clusterOptions =
               markerClusterOptions(freezeAtZoom=18,spiderfyDistanceMultiplier=1.5,maxClusterRadius=50,iconCreateFunction =
                                      JS("                       function(cluster) {                                             return new L.DivIcon({                                               html: '<div style=\"background-color:rgba(77,77,77,0.7)\"><span>' + cluster.getChildCount() + '</div><span>',                                               className: 'marker-cluster'                                             });                                       }")),
    label = mytext,
    labelOptions = labelOptions( style = list("font-weight" = "normal", padding = "3px 8px"), textsize = "13px", direction = "auto")
  ) %>%
  addLegend( pal=mypalette, values=~Frequency_of_digestors, opacity=0.9, title = "Frequency of digestors", position = "bottomright" )

m 
library(htmlwidgets)

saveWidget(m, file=paste0( "/home/augusto/Descargas/MAP_LACTOSE/OUTPUT_MAPS/LP_Phen_Freq_OptionStatic.html"))





































































###### OPTION 2 NATURAL

Bd <- read.csv2("/home/augusto/Descargas/MAP_LACTOSE/DATABASES/FINAL_TO_MAP/FINAL_FINAL/DB_LPFREQ_vfiltered.csv", header=TRUE, sep=";", stringsAsFactors=F, dec=",", na.strings=c(""," ","NaN","NA"))
#Datos input en formato wide
Bd <- Bd[,2:8]
Bd


CapStr <- function(y) {
  c <- strsplit(y, " ")[[1]]
  paste(toupper(substring(c, 1,1)), substring(c, 2),
      sep="", collapse=" ")
}


Bd$Country <- tolower(Bd$Country)
Bd$Country <- sapply(Bd$Country, CapStr)
Bd$Country


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
mypalette <- colorBin( palette="RdBu", domain=quakes$mag, na.color="transparent", bins=mybins)

# Prepare the text for the tooltip:
mytext <- paste(
   "Country: ", quakes$Country, "<br/>", 
   "Population: ", quakes$Population, "<br/>", 
   "N: ", quakes$N, "<br/>", 
   "Reference: ", quakes$Reference, sep="") %>%
  lapply(htmltools::HTML)


# Final Map
m <- leaflet(quakes) %>% 
  addTiles()  %>%
  addProviderTiles("Esri.WorldImagery") %>%
 addCircleMarkers(~longitude, ~latitude, 
    fillColor = ~mypalette(Frequency_of_digestors), fillOpacity = 0.7, color="black", radius=7, stroke=TRUE,weight=1,clusterOptions =
               markerClusterOptions(freezeAtZoom=18,spiderfyDistanceMultiplier=1.5,maxClusterRadius=50,iconCreateFunction =
                                      JS("                       function(cluster) {                                             return new L.DivIcon({                                               html: '<div style=\"background-color:rgba(77,77,77,0.7)\"><span>' + cluster.getChildCount() + '</div><span>',                                               className: 'marker-cluster'                                             });                                       }")),
    label = mytext,
    labelOptions = labelOptions( style = list("font-weight" = "normal", padding = "3px 8px"), textsize = "13px", direction = "auto")
  ) %>%
  addLegend( pal=mypalette, values=~Frequency_of_digestors, opacity=0.9, title = "Frequency of digestors", position = "bottomright" )

m 
library(htmlwidgets)


saveWidget(m, file=paste0( "/home/augusto/Descargas/MAP_LACTOSE/OUTPUT_MAPS/backgroundMapBasic_Option2.html"))

 



source('./r_files/flatten_HTML.r')

############### Library Declarations ###############
library(leaflet)
library(readxl)
####################################################

################### Actual code ####################
dataset <-  read_excel("C:/Users/Wu Yin/Projects/India Customer Analysis/201801-05_customer_with_coordinates.xlsx")
dataset <- unique(dataset)


labels <- paste0("Locality: ", dataset$locality,                        
                 ",  Center: ", dataset$center)%>% lapply(htmltools::HTML) 

p=leaflet(dataset) %>%
  setView(lng=77.17, lat=28.62, zoom=8) %>%
  addTiles() %>%
  addProviderTiles("CartoDB.Positron", group="Light map") %>%
  addProviderTiles("Esri.NatGeoWorldMap", group= "Green map") %>%
  addScaleBar %>%
  addMarkers(~longitude, ~latitude,
             label = labels,  
             clusterOptions = markerClusterOptions()) %>%
  addLayersControl(baseGroups = c("Green map", "Light map"), options = layersControlOptions(collapsed = FALSE))

####################################################

############# Create and save widget ###############
internalSaveWidget(p, 'out.html')
####################################################

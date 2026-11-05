############################################################
# INTEGRATION DONNEES SATELLITE (PLUIE + TEMPERATURE)
############################################################

library(httr)
library(jsonlite)
library(dplyr)
library(leaflet)
library(shiny)

# Exemple API météo (Open-Meteo - gratuit)
get_weather <- function(lat, lon){
  
  url <- paste0(
    "https://api.open-meteo.com/v1/forecast?",
    "latitude=", lat,
    "&longitude=", lon,
    "&current_weather=true",
    "&hourly=precipitation,temperature_2m"
  )
  
  res <- GET(url)
  data <- fromJSON(content(res, "text"))
  
  return(data)
}

# Exemple récupération Goma
weather <- get_weather(-1.6788, 29.2228)

print(weather$current_weather)

# ==============================
# SHINY CARTE AVEC PLUIE
# ==============================
ui <- fluidPage(
  titlePanel("Carte Climat + Epidemie"),
  leafletOutput("map")
)

server <- function(input, output){
  
  output$map <- renderLeaflet({
    
    leaflet() %>%
      addTiles() %>%
      setView(lng = 29.22, lat = -1.67, zoom = 7) %>%
      
      addCircleMarkers(
        lng = 29.22,
        lat = -1.67,
        radius = weather$current_weather$temperature,
        color = "blue",
        popup = paste(
          "Temp:", weather$current_weather$temperature,
          "Pluie:", weather$hourly$precipitation[1]
        )
      )
  })
}

shinyApp(ui, server)

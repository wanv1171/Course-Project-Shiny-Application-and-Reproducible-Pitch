library(shiny)
library(magrittr)
library(leaflet)

shinyServer(function(input, output) {
  shotData <- read.csv("ready_la_crime.csv", sep=",")
  
  plotData <- reactive({
    hour <- input$hourSlider 
    if (hour == 24) {
      plotData <- shotData
    }
    else {
      plotData <- shotData[shotData$Hour == hour,]
    }
    
    return(plotData)
  })
  
  gunIcon <- makeIcon(
    iconUrl = "gun.png",
    iconWidth = 32, 
    iconHeight = 32,
    iconAnchorX = 16,
    iconAnchorY = 16
  )
  
  output$plot1 <- renderLeaflet(
    leaflet() %>% 
    addTiles() %>%
    addMarkers(data = plotData(),
               lng = ~Longitude, 
               lat = ~Latitude, 
               clusterOptions = markerClusterOptions(),
               popup = paste("Police Record Number: ", plotData()$DR.Number, "<br>",
                             "Date Occured: ", plotData()$Date.Occurred, "<br>",
                             "Time Occured: ", plotData()$Time.Occurred, "<br>",
                             "Weapons Involved: ", plotData()$Weapon.Description, "<br>",
                             "Case Status: ", plotData()$Status.Description, "<br>",
                             "Address: ", plotData()$Address, "<br>",
                             "Cross Street: ", plotData()$Cross.Street, "<br>"
               ))
  
    )
})
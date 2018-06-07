library(shiny)
library(leaflet)

shinyUI(fluidPage(
  titlePanel("LA Shooting Map"),
  sidebarLayout(
    sidebarPanel(
      h1("Slide to Select Hour"),
      h3("Select 24 for all hours"),
      sliderInput("hourSlider","Hour", 0, 24, 0)
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("LA Shootings Map",leafletOutput("plot1", width=800, height=800)),
        tabPanel("About",includeMarkdown("README.MD"))
      )
    )
  )
))
library(shiny)
library(shinythemes)
library(tidyverse)
library(DT)
players <- read_csv(here::here("FantasyPros_2018_Draft_Overall_Rankings.csv"))

ui <- fluidPage(
  theme = shinytheme("spacelab"),
  navbarPage(title = "Fantasy Football Rankings",
             tabPanel("Overall Rankings",
                      sidebarPanel(
                        width = 2,
                        numericInput("position", label = "New Rank", value = NA, min = 1, max = 300),
                        actionButton("move", label = "Move Player")
                        ),
                      mainPanel(dataTableOutput("overall_table"))
             )
  )
)

server <- function(input, output, session) {
  
  new_row <- reactive({input$tableId_rows_selected})
  
  overall <- reactive({
    players
    })
  
  output$overall_table <- renderDataTable({
    overall()
    }, 
    selection = "single")
  
  observeEvent(input$move, {
    players[[new_row]]
  })
  
}

shinyApp(ui, server)

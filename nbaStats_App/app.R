

library(shiny)
library(readr)
library(tidyverse)
library(dplyr)
library(rsconnect)
nbaStats

ui <- fluidPage(sliderInput(inputId = "g", 
                           label = "Games Played", min = 41, max = 1278, value =c(41, 1278)),
            selectInput(inputId = "Pos", label = "Position", choices = list(`Point Guard` ="PG", 
                                                                         `Shooting Guard` = "SG",
                                                                         `Small Forward` = "SF",
                                                                         `Power Forward` = "PF",
                                                                         Center = "C")), 
            submitButton(text = "Create Plot"),
            plotOutput(outputId = "graph"))

server <- function(input, output) {
   output$graph <- renderPlot({
      nbaStats %>% 
         filter(Pos == input$Pos,) %>% 

  ggplot(aes(x = g, y = PTS))+
       geom_point()+
       geom_smooth()+
       labs(y = "Points per Game", x = "Total Games Played")+
       scale_x_continuous(limits = input$g) 
})}


shinyApp(ui = ui, server = server)





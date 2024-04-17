library(shiny)
library(tidyverse)
ui <- fluidPage(
  titlePanel("Demographic Insights for Targeted Advertising"),
  fluidRow(
    column(width = 12,
           wellPanel(
             selectInput("country", "Select Country:", 
                         choices = c("United-States", "Canada", "Mexico", "Germany", "Philippines"))
           )
    )
  ),
  
  fluidRow(
    column(width = 6,
           radioButtons("continuous_variable", "Variable:", 
                        choices = c("Age" = "age", "Hours per week" = "hours_per_week"))
    ),
    column(width = 6,
           radioButtons("graph_type", "Graph Type:", 
                        choices = c("Histogram" = "histogram", "Boxplot" = "boxplot"))
    )
  ),
  
  fluidRow(
    column(width = 12,
           plotOutput("p1")
    )
  ),
  fluidRow(
    column(width = 6,
           radioButtons("categorical_variable", "Variable:", 
                        choices = c("Education" = "education", "Workclass" = "workclass", "Sex" = "sex"))
    ),
    column(width = 3,
           checkboxInput("is_stacked", "Stacked Bar Charts", value = TRUE)
    ),
    column(width = 3,
           plotOutput("p2")
    )
  )
)
server <- function(input, output) {}
shinyApp(ui = ui, server = server)

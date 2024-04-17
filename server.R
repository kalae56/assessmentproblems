# Load libraries
library(shiny)
library(tidyverse)

# Read in data
adult <- read_csv("adult.csv")
# Convert column names to lowercase for convenience 
names(adult) <- tolower(names(adult))

# Define server logic
shinyServer(function(input, output) {
  
  df_country <- reactive({
    adult %>% filter(native_country == input$country)
  })
  
  output$p1 <- renderPlot({
    data <- df_country()
    if (input$graph_type == "histogram") {
      ggplot(data, aes_string(x = input$continuous_variable)) +
        geom_histogram() +
        facet_wrap(~prediction)
    } else {
      ggplot(data, aes_string(x = input$continuous_variable)) +
        geom_boxplot() +
        coord_flip() +
        facet_wrap(~prediction)
    }
  })
  
  output$p2 <- renderPlot({
    data <- df_country()
    p <- ggplot(data, aes_string(x = input$categorical_variable, fill = 'prediction'))
    
    if (input$is_stacked) {
      p + geom_bar(stat = "count", position = "stack") +
        labs(x = input$categorical_variable, y = "Count") +
        theme_minimal()
    } else {
      p + geom_bar(stat = "count", position = "dodge") +
        labs(x = input$categorical_variable, y = "Count") +
        facet_wrap(~prediction) +
        theme_minimal()
    }
  })
})
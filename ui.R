library(shiny)

# Define UI for application
shinyUI(fluidPage(
        
        # App title
        titlePanel("Classification Prediction of Species of Iris Flowers "),
        
        # Sidebar layout
        sidebarLayout(
                
                # Sidebar panel
                sidebarPanel(
                        sliderInput("petal_length", "Petal Length:", min = 0, max = 7, value = 3),
                        sliderInput("petal_width", "Petal Width:", min = 0, max = 3, value = 1),
                        actionButton("predict_button", "Predict")
                ),
                
                # Main panel
                mainPanel(
                        plotOutput("scatter_plot"),
                        verbatimTextOutput("predicted_species"),
                        tableOutput("classification_table")
                )
        )
))

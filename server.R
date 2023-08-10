library(shiny)
library(randomForest)  # For random forest model

# Load the iris dataset
data(iris)

# Convert species to a factor
iris$Species <- as.factor(iris$Species)

# Train a random forest model on the iris dataset
model <- randomForest(Species ~ Petal.Length + Petal.Width, data = iris)

# Define server logic
shinyServer(function(input, output) {
        
        # Calculate and render predictions
        predicted_species <- eventReactive(input$predict_button, {
                new_data <- data.frame(
                        Petal.Length = input$petal_length,
                        Petal.Width = input$petal_width
                )
                
                predicted_value <- predict(model, newdata = new_data)
                
                return(predicted_value)
        })
        
        # Scatter plot of selected predictors
        output$scatter_plot <- renderPlot({
                plot(iris$Petal.Length, iris$Petal.Width, pch = 19, col = iris$Species,
                     xlab = "Petal Length", ylab = "Petal Width",
                     main = "Iris Petal Length and Width Scatter Plot")
                points(input$petal_length, input$petal_width, pch = 19, col = "purple")
                legend("topright", legend = levels(iris$Species), col = 1:3, pch = 19)
        })
        
        # Display predicted species
        output$predicted_species <- renderPrint({
                paste("Predicted Iris Species:", as.character(predicted_species()))
        })
        
        # Classification table
        output$classification_table <- renderTable({
                classification_results <- data.frame(
                        Species = levels(iris$Species),
                        Occurrence = table(predicted_species())
                )
                classification_results
        })
})

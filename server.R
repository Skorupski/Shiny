library(shiny)
library(ggplot2)
library(plotly)

shinyServer(function(input, output) {
    getX <- reactive({
        x <- rexp(input$number * input$samples, input$lambda)
        dim(x) <- c(input$number, input$samples)
        x <- apply(x, 1, mean)
        x
    })
    
    getLambda <- reactive({
        input$lambda
    })
    
    getSamples <- reactive({
        input$samples
    })
    
    output$mean <- renderText({
        paste("Expected mean:", round(1 / getLambda(), 3), "/ Calculated mean:", round(mean(getX()), 3))
    })
    
    output$std <- renderText({
        paste("Expected standard deviation:", round((1 / getLambda()) / sqrt(getSamples()), 3), "/ Calculated standard deviation:", round(sd(getX()), 3))
    })
    
    output$shapiro <- renderText({
        paste("Shapiro-Wilk normality test", shapiro.test(getX())$p)
    })
    
    output$plot1 <- renderPlotly({
        x <- getX()
        
        g <- ggplot() + geom_histogram(aes(x), color = "blue", bins = 100)
        g <- g + xlab("Value") + ylab("Count") 
        
        ggplotly(g)
    })
    
    output$plot2 <- renderPlotly({
        x <- getX()
        lambda <- getLambda()
        samples <- getSamples()
        
        den <- density(x)
        df <- rbind(
            data.frame(x = den$x, y = den$y, Distribution = "Obtained"), 
            data.frame(x = den$x, y = dnorm(den$x, m = 1 / lambda, 
                sd = (1 / lambda) / sqrt(samples)), Distribution = "Expected")
        )
        
        g <- ggplot(data = df, aes(x = x, y = y, color = Distribution, fill = Distribution))
        g <- g + geom_area(alpha = 0.25, position = "identity")
        g <- g + xlab("Value") + ylab("Density") 
        
        ggplotly(g)
    })
})

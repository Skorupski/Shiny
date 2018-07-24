library(shiny)
library(plotly)

shinyUI(fluidPage(
    titlePanel("The use of the Central Limit Theorem with the exponential distribution"),
    sidebarLayout(
        sidebarPanel(
            numericInput("lambda", "Lambda", value = 0.2, min = 0.1, max = 10, step = 0.1),
            numericInput("number", "Number of elements", value = 1000, min = 10, max = 100000),
            numericInput("samples", "Sample size", value = 1, min = 1, max = 100000),
            submitButton("Validate")
    ),
    mainPanel(
        h2("Results"),
        textOutput("mean"),
        textOutput("std"),
        textOutput("shapiro"),
        h2("Charts"),
        tabsetPanel(
            tabPanel("Histogram", plotlyOutput("plot1")), 
            tabPanel("Distribution", plotlyOutput("plot2"))
        ),
        h2("Documentation"),
        "In one of the previous projects we were supposed to prove that the CLT theorem can be used with the exponential distribution,
        i.e. when we consider averaged values, their distribution should be approximately normal. Although it looked convincing,
        it did not pass the Shapiro-Wilk normality test, and therefore, the H0 hypothesis (the distribution is normal) had to be rejected. 
        This application was designed to prove that the CLT theorem is correct, however, much more values are needed.",
        h3("Input parameters"),
        "The user can specify lambda (needed for the exponential distribution), the number of averaged values and the number of random 
        exponential values they are composed of. To refresh the results the 'validate' button should be pressed. Note, that the total
        number of generated values is 'number of elements' times 'sample size'. To see the pure exponential distribution, 'sample size'
        should be set to one.",
        h3("Results"),
        "On the right side, one can see the mean value and the standard deviation. The expected values were calculated using the input parameters
        (and assuming that the resulting distribution is normal). The calculated values are based on the generated data. Finally, the p-value
        for the normality test is presented. Providing that it is larger than 0.05, the distribution can be considered normal.
        Additionally, there are two charts. The first one is the histogram. The second one is the distribution plot which compares
        the calculated distribution to the theoretical (normal) distribution."
    )
  )
))

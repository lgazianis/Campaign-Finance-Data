#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)

# Define UI for application that draws a histogram
ui <- fluidPage( theme = shinytheme("cyborg"),
    navbarPage(
        "Campaign Finance Data",
        tabPanel("Data Analysis",
                 titlePanel("Campaign Finance Data"),
                 p("Analysis of PAC and interest group data"),
                 sidebarLayout(
                     sidebarPanel(
                         sliderInput("bin",
                                     "Number of bins:",
                                     min = 50,
                                     max = 100,
                                     value = 75),
                         selectInput(inputId = "state",
                                    label = "State: ",
                                    choices = c("MA", "CT", "NY", "CA", "TX"),
                                    selected = "NY")
                     ),
                     mainPanel(
                         plotOutput("distPlot")
                     )
                 )
        ),
        tabPanel("About",
                 titlePanel("Campaign Finance Data"),
                 br(),
                 h4("Introduction"),
                 p("This is where I will describe my data set and project."),
                 br(),
                 h4("About Me"),
                 p("I am a freshman at Harvard interested in data science."),
                 br(),
                 p("The source code on Github can be found ", 
                   a("here.", 
                     href = "https://github.com/lgazianis/Campaign-Finance-Data.git"))
                 
        )
        
        
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        binsthing <- seq(min(x), max(x), length.out = input$bin + 1)
        
        # draw the histogram with the specified number of bins
        hist(x, breaks = binsthing, col = 'darkgray', border = 'white')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)

library(DT)
library(shiny)
shinyUI(fluidPage(tabsetPanel(
    
    tabPanel("Row Data",
             h2("The mtcars data"),
             dataTableOutput("mytable")
    ),
    
    tabPanel("Boxplot",   
        titlePanel("mtcars data"),
            sidebarLayout(
                sidebarPanel(
                    textInput("title","Plot Title:",value = "Miles per Gallons vs. Transmission"),
            
                    selectInput("x", "Choose an x var:",
                        c("Transmission" = "am","Motor Type"="vs",
                        "Cylinders" = "cyl","Gears" = "gear",
                        "Carburator"="carb")
                    ),
            
                    selectInput("y", "Choose an y var:",
                        c("Miles per Gallons" = "mpg","Displacement"="disp",
                        "Hourse power" = "hp","Rear/Ratio" = "drat",
                        "1/4 mile time"="qsec","Weight"="wt")
                    ),
            
                    checkboxInput("show_xlab", "Show/Hide X Axis Label", value = TRUE),
                    checkboxInput("show_ylab", "Show/Hide Y Axis Label", value = TRUE),
                    checkboxInput("test", "points", value = TRUE)
                    #submitButton("Submit")
                ),
                
                mainPanel(
                    h3(textOutput("text")),
                    plotOutput("plot"),
                    h4("Anova"),
                    verbatimTextOutput('aovSummary'),
                    h4("multiple t-test"),
                    verbatimTextOutput('testSummary')
                )
            )
    ),
     
    tabPanel("Model Plot",
        titlePanel("mtcars data"),
            sidebarLayout(
                sidebarPanel(
                    textInput("title2","Plot Title:",value = "Miles per Gallons vs.Weight "),
                     
                    selectInput("x2", "Choose an x var:",
                        c("Weight"="wt","Displacement"="disp",
                        "Hourse power" = "hp","Rear/Ratio" = "drat",
                        "1/4 mile time"="qsec","Miles/Gallons" = "mpg")),
                     
                    selectInput("y2", "Choose an y var:",
                        c("Miles per Gallons" = "mpg","Weight"="wt",
                        "Displacement"="disp","Hourse power" = "hp",
                        "Rear/Ratio" = "drat","1/4 mile time"="qsec")),
                     
                    checkboxInput("show_xlab2", "Show/Hide X Axis Label", value = TRUE),
                    checkboxInput("show_ylab2", "Show/Hide Y Axis Label", value = TRUE),
                    numericInput("min_val", "Enter Slider Minimum Value", 1),
                    numericInput("max_val", "Enter Slider Maximum Value", 6),
                    #display dynamic UI
                    uiOutput("slider"),
                    #submitButton("Submit")
                    h3("Automatic trasmisson:"),
                    textOutput("pred1"),
                    h3("Manual Trasmission:"),
                    textOutput("pred2")
                ),
             
                mainPanel(
                    h3(textOutput("text2")),
                    plotOutput("plot2"),
                    h4("Liner Model:"),
                    verbatimTextOutput("test")
                )
            )
    ),
    
    tabPanel("Model Residue",
             fluidPage(
                h3(textOutput("text3")),
                plotOutput("plot3")
            )
    ),
    
    tabPanel("Help",
             fluidPage(
                 h3("Help Page"),
                 h4("This App show in a different tab mtcar data set:"),
                 h4(""),
                 h4("Raw Data:"),
                 h6("It is just to have an inspection of the data"),
                 h4(""),
                 h4("Boxplot:"),
                 h6("plot numeric data vs. factor data and perforn basic statistic"),
                 h4(""),
                 h4("Model Plot:"),
                 h6("Perform linear model with interaction with trasmission factor (am)"),
                 h6("it is possible to perform interactive predictions"),
                 h4(""),
                 h4("Model Residue:"),
                 h6("Show the Residue")
             )
    )
  
)))
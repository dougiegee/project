
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Capability Modeler"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("SD",
                  "Standard Deviation:",
                  min = 0,
                  max = 50,
                  value = .5),
      numericInput(inputId="mu", value=0, label = "Enter Process Mean"),
      numericInput(inputId="lsl", value=-2, label = "Enter LSL"),
      numericInput(inputId="usl", value=2, label = "Enter USL")
      
    ),

    # Show a plot of the generated distribution
    mainPanel(
#       p('Lower Spec'),
#       textOutput('lsl'),
#       p('Upper Spec'),
#       textOutput('usl'),
      plotOutput("Capaplot")

      
      
    )
  )
))


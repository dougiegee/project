
# Data Products Final Project
# 
# This project calculates capability indices given
#    - SD :  Standard Deviation
#    - mu :  Mean
#    - lsl : Lower specification limit (lowest value for an acceptable item)
#    - usl : Upper specification limit (highest value for an acceptable item)
#
#  This app would be useful in a Six Sigma training environment to show users how these 
#   commonly used metric behave based on the distribution of the data and the 
#    allowable variation
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Capability Modeler"),
  
  # Some helper text using MathJax to describe the equations
  withMathJax(),
  helpText('Capability statistics Cp and Cpk are used in manufacturing to show the relationship between the variation of
                a process (distribution) and the allowed variation'),
  helpText('The formulas for these statistics are:'),
  helpText('\\(Cp=\\frac{USL-LSL}{6S}\\)'),
  helpText('\\(Cpk=\\min\\left[\\left(\\frac{\\bar{x}-LSL}{6S}\\right),\\left(\\frac{USL-\\bar{x}}{6S}\\right)\\right]\\)'),
  helpText('Notice that the \\(Cpk\\) value is penalized when the mean is not exactly centered between the spec limits.'),
  
  # Sidebar with a slider input for standard deviation, and mean, and numeric inputs for mean and specs
  sidebarLayout(
    sidebarPanel(
      sliderInput("SD",
                  "Standard Deviation:",
                  min = .0001,
                  max = 5,
                  value = 1),
      sliderInput("mu",
                  "Mean:",
                  min = -30,
                  max = 30,
                  step = 0.5,
                  value = 0),
  
      numericInput(inputId="lsl", value=-3, label = "Enter Lower Specification (LSL)"),
      numericInput(inputId="usl", value=3, label = "Enter Upper Specification (USL)")
      
    ),

    # Show a plot of the generated distribution and spec limits
    mainPanel(

       plotOutput("Capaplot")

      
      
    )
  )
))



# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Capability Modeler"),
  withMathJax(),
  helpText('Capability statistics Cp and Cpk are used in manufacturing to show the relationship between the variation of
                a process (distribution) and the allowed variation'),
  helpText('The formulas for these statistics are:'),
  helpText('\\(Cp=\\frac{USL-LSL}{6S}\\)'),
  helpText('\\(Cpk=\\min\\left[\\left(\\frac{\\bar{x}-LSL}{6S}\\right),\\left(\\frac{USL-\\bar{x}}{6S}\\right)\\right]\\)'),
  helpText('Notice that the \\(Cpk\\) value is penalized when the mean is not exactly centered between the spec limits.'),
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("SD",
                  "Standard Deviation:",
                  min = .01,
                  max = 5,
                  value = 1),
      numericInput(inputId="mu", value=0, label = "Enter Mean"),
      numericInput(inputId="lsl", value=-2, label = "Enter Lower Specification (LSL)"),
      numericInput(inputId="usl", value=2, label = "Enter Upper Specification (USL)")
      
    ),

    # Show a plot of the generated distribution
    mainPanel(

       plotOutput("Capaplot")

      
      
    )
  )
))


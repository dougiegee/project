
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {

  output$Capaplot <- renderPlot({

    
    # capa graph
    
   # lsl<-80
   # usl<-140

    # determine plot scale
    
    probs<-seq(0.01, .99, .01)
    quants<-qnorm(probs, input$mu, input$SD)
     
    ifelse(quants[1] < input$lsl, x.lower<-quants[1]-.5*input$SD, x.lower<-input$lsl - 0.5*input$SD) 
    ifelse(quants[99] >input$usl, x.upper<-quants[99]+.5*input$SD, x.upper<-input$usl + 0.5*input$SD) 
    yfit<-dnorm(quants, mean=input$mu, sd=input$SD) 
    
    Cp<-round((input$usl-input$lsl)/(6*input$SD),2)
    Cp.positionx <- (x.lower + .05*(x.upper-x.lower))
    Cp.positiony<- yfit[40]
    plot(quants, yfit, type="l", col="blue", lwd=5, xlim=c(x.lower,x.upper))
    text(Cp.positionx, Cp.positiony, paste("Cp = ", Cp))
    lines(c(input$lsl, input$lsl), c(0, .4), col="red",lwd=3)
    lines(c(input$usl, input$usl), c(0, .4), col="red",lwd=3)
    

  })

    output$lsl<-renderText({input$lsl})
    output$usl<-renderText({input$usl})
  
})

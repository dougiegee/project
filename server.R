


library(shiny)

shinyServer(function(input, output) {

  output$Capaplot <- renderPlot({

    
    # distrbution plot

    # generate the x-variable for the distribution plot
    probs<-seq(0.00135, .99865, .0001)
    quants<-qnorm(probs, input$mu, input$SD)
   
    # determine the x-scale based on the spec limits or the normal curve 
    # with .5*standard Deviation buffer
    ifelse(quants[1] < input$lsl, x.lower<-quants[1]-.5*input$SD, x.lower<-input$lsl - 0.5*input$SD) 
    ifelse(quants[length(probs)] >input$usl, x.upper<-quants[length(probs)]+.5*input$SD, x.upper<-input$usl + 0.5*input$SD) 
    
    
    # y-values for the distribution curve
    yfit<-dnorm(quants, mean=input$mu, sd=input$SD) 
    
   
    # Calculation of Capbility Metric Cp and Cpk
    Cp<-round((input$usl-input$lsl)/(6*input$SD),2)
    Cpk<-round(min((input$m-input$lsl)/(3*input$SD), (input$usl-input$mu)/(3*input$SD)),2)
    
    
    #plot distribution with specs
    plot(quants, yfit, type="l", col="blue", lwd=5, xlim=c(x.lower,x.upper), , xlab="Process Variable", ylab="")
    lines(c(input$lsl, input$lsl), c(0, .4), col="red",lwd=3)
    lines(c(input$usl, input$usl), c(0, .4), col="red",lwd=3)
    title(main=(paste("Cp=", Cp, "  Cpk=", Cpk)))
    

  })

    output$lsl<-renderText({input$lsl})
    output$usl<-renderText({input$usl})
  
})

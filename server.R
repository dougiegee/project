


library(shiny)

shinyServer(function(input, output) {

  output$Capaplot <- renderPlot({

    
    # distrbution plot 
    # generate the x-variable for the Normal Density plot (-3 to +3 standard dev)
    probs<-pnorm(seq(-3, 3, by=.05))
    quants<-qnorm(probs, input$mu, input$SD)
   
    # determine the x-scale conditionally, based on the spec limits or the normal curve 
    #  0.5*standard Deviation buffer on the min and max of x-scale
    # lower value for x scale
    ifelse(quants[1] < input$lsl, x.lower<-quants[1]-.5*input$SD, x.lower<-input$lsl - 0.5*input$SD) 
    # upper value for x scale
    ifelse(quants[length(probs)] >input$usl, x.upper<-quants[length(probs)]+.5*input$SD, x.upper<-input$usl + 0.5*input$SD) 
    
    
    # y-values to plot the Normal density curve
    yfit<-dnorm(quants, mean=input$mu, sd=input$SD) 
    
   
    # Calculation of Capbility Metric Cp and Cpk
    Cp<-round((input$usl-input$lsl)/(6*input$SD),2)
    Cpk<-round(min((input$m-input$lsl)/(3*input$SD), (input$usl-input$mu)/(3*input$SD)),2)
    
    
    #plot Normal Density Curve with Specification Limits 
    plot(quants, yfit, type="l", col="blue", lwd=5, xlim=c(x.lower,x.upper), xlab="Process Variable", ylab="")
    lines(c(input$lsl, input$lsl), c(0, 40), col="red",lwd=3)
    text(input$lsl-.25*input$SD, dnorm(input$mu, mean=input$mu, sd=input$SD), "LSL")
    lines(c(input$usl, input$usl), c(0, 40), col="red",lwd=3)
    text(input$usl-.25*input$SD, dnorm(input$mu, mean=input$mu, sd=input$SD), "USL")
    title(main=(paste("Cp=", Cp, "  Cpk=", Cpk)))
    

  })

    output$lsl<-renderText({input$lsl})
    output$usl<-renderText({input$usl})
  
})

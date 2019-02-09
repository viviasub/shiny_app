library(shiny)
library(datasets)
library(DT)
data(mtcars)

cars<-mtcars

for (i in c(2,8,9,10,11)) {
        cars[,i]<-as.factor(cars[,i])
}
cars$am<-factor(cars$am,labels = c("auto","manual"))
cars$vs<-factor(cars$vs,labels = c("V-shape","linear"))
#cars_clean<-cars[!row.names(cars)=="Maserati Bora",]
options(shiny.deprecation.messages=FALSE)

shinyServer(function(input, output) {
    
    output$mytable = renderDataTable({cars})
    
    output$text <- renderText({input$title})
  
    output$plot<-renderPlot({
        xlab <- ifelse(input$show_xlab, input$x, "")
        ylab <- ifelse(input$show_ylab, input$y, "")
        colore<-ifelse(input$test,"red","white")
        size<-ifelse(input$test,1,0)
        x<-cars[,input$x]
        y<-cars[,input$y]
         
        boxplot(y~x,pch=16,xlab = xlab, ylab = ylab)
        points(x,y,col=colore,cex=size)
    })
  
    output$aovSummary = reactivePrint(function() {
        x<-cars[,input$x]
        y<-cars[,input$y]
        res.aov<-aov(y~x)
        summary.aov(res.aov)
    })
  
    output$testSummary = reactivePrint(function() {
        x<-cars[,input$x]
        y<-cars[,input$y]
        pairwise.t.test(y,x,p.adj="bonf")
    })
  
    output$text2 <- renderText({input$title2})
    
    output$slider <- renderUI({
        sliderInput("inSlider", "Slider", min=input$min_val, max=input$max_val, value=5)
    })
  
    output$plot2<-renderPlot({
        xlab <- ifelse(input$show_xlab2, input$x2, "")
        ylab <- ifelse(input$show_ylab2, input$y2, "")
        x<-cars[,input$x2]
        y<-cars[,input$y2]
        am<-cars[,9]
    
        model<-lm(y ~x*am) #wt +wt:am
         
        plot(y~x,pch=16,xlab = xlab, ylab = ylab,col=am,xlim=c(min(x),max(x)),ylim=c(0,max(y)))
        legend(x = min(x),y=min(y)-2,legend = levels(cars$am),pch = 21,col = c(1,2))
        intercept_manual<-model$coefficients[1]+model$coefficients[3]
        slope_manual<-model$coefficients[2]+model$coefficients[4]
        abline(intercept_manual,slope_manual, lwd = 2,col="red")
        
        intercept_auto<-model$coefficients[1]
        slope_auto<-model$coefficients[2]
        abline(intercept_auto,slope_auto, lwd = 2)
        
        pred_auto <- reactive({
            Input <- input$inSlider
            predict(model, newdata = data.frame(x = Input,am="auto"))
        })
        
        pred_manual <- reactive({
            Input <- input$inSlider
            predict(model, newdata = data.frame(x = Input,am="manual"))
        })
        
        
        
        points(input$inSlider, pred_auto(), col = "black", pch = 16, cex = 2)
        points(input$inSlider, pred_manual(), col = "red", pch = 16, cex = 2)
        
        output$pred1 <- renderText({pred_auto()})
        
        output$pred2 <- renderText({pred_manual()})
        
    })
    
    output$pred2 <- renderText({
        pred_manual()
    })
    
    output$test <- renderPrint({
        x<-cars[,input$x2]
        y<-cars[,input$y2]
        am<-cars[,9]
        model<-lm(y ~x*am) #hp + wt +wt:am
        summary(model)})
    
    output$text3 <- renderText({input$title2})
    
    output$plot3<-renderPlot({
        xlab <- ifelse(input$show_xlab, input$x2, "")
        ylab <- ifelse(input$show_ylab, input$y2, "")
        colore<-ifelse(input$test,"red","white")
        size<-ifelse(input$test,1,0)
        x<-cars[,input$x2]
        y<-cars[,input$y2]
        am<-cars[,9]
        model<-lm(y ~x*am)
        
        par(mfrow=c(2,2))
        plot(model)
       
    })
          
})
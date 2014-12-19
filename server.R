library(shiny)

train<-lm(mpg~cyl+disp+wt,data=mtcars)
predmpg<-function(cyl,disp,wt){
        predict(train,newdata=as.data.frame(as.matrix(cbind(cyl,disp,wt))))
}

shinyServer(function(input, output, session){
        output$inputValue <- renderPrint({input$cyl})
        output$inputValue2 <- renderPrint({input$disp})
        output$inputValue3 <- renderPrint({input$wt})
        output$prediction <- renderPrint({predmpg(input$cyl,input$disp,input$wt)})
        
})
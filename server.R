originalData <- read.csv('FullData.csv')
names(originalData)[13] <- 'Preferred_Foot'

shinyServer( function (input, output, session){
  
 observe({
   updateSliderInput(session, inputId = 'range', label = paste(input$trait, 'range:'),
                     min = min(originalData[,input$trait]), max = max(originalData[,input$trait]),
                     value = c(min, max) )
 })
  
  output$plot <- renderPlot({
    
    df <- originalData
    trait <- input$trait
    
    
    if (input$nationality != 'All') 
      df <- df[df$Nationality==input$nationality & df[[trait]]>=input$range[1] & df[[trait]]<=input$range[2],]
    else
      df <- df[df[[trait]]>=input$range[1] & df[[trait]]<=input$range[2],]
    
    if(length(input$foot)==1)
      switch(input$foot[1],
             'Left' = df <- df[df$Preferred_Foot=='Left',],
             'Right' = df <- df[df$Preferred_Foot=='Right',])
   
    traitMax <- max( df[[trait]] )

    if(nrow(df)!=0)

    hist(x = df[,trait],
         breaks = seq(min(df[,trait]),max(df[,trait]),l=input$bins+1),
         xlab = trait, ylab = paste(input$nationality,' Players'), density = 65,
         main =  paste0('The player with the highest ', trait, ' in this range is ',head(df[ df[[trait]] == traitMax  ,'Name']  ,n=1 )),
         col= 1:input$bins,
         labels = T 
         )

  #  abline(v = mean(df[,trait]), lwd = 3, lty = 4)
    
    
  })
  
  output$text <- renderText({
    df <- originalData
    trait <- input$trait
    
    if (input$nationality != 'All') 
      df <- df[df$Nationality==input$nationality & df[[trait]]>=input$range[1] & df[[trait]]<=input$range[2],]
    else
      df <- df[df[[trait]]>=input$range[1] & df[[trait]]<=input$range[2],]
    
    if(length(input$foot)==1)
      switch(input$foot[1],
             'Left' = df <- df[df$Preferred_Foot=='Left',],
             'Right' = df <- df[df$Preferred_Foot=='Right',])
  
    if(nrow(df)!=0)
    paste0(trait, ' -->  Mean: ', 
          round(mean(df[,trait]),digits = 2) ,
          ' Min: ',min(df[,trait]), ' Max:  ', max(df[,trait]),
          ' Total Players: ',nrow(df))
  })
 
})
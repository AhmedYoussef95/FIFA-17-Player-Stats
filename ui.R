originalData <- read.csv('FullData.csv')
names(originalData)[13] <- 'Preferred_Foot'
remove <- c('Name','National_Kit','Club_Kit','Nationality','National_Position','Club','Height','Weight','Club_Position','Club_Joining','Contract_Expiry','Preferred_Foot','Birth_Date','Preffered_Position','Work_Rate')
traits <- names(originalData)[!names(originalData) %in% remove]

shinyUI( fluidPage(
  titlePanel('FIFA Players'),
  sidebarLayout(
    sidebarPanel(
      helpText('FIFA 17 Player Stats'), hr(),
      selectInput('trait','Trait:',choices = traits,selected = 'Rating'),
      textInput('nationality','Nationality:', value = 'All'),
      sliderInput('range','Overall ratings range:', min = 45, max=94, value=c(45,94)),
      numericInput('bins','Number of bins:',value = 5,min = 2),
      checkboxGroupInput('foot','Preferred foot:',choices = c('Left','Right'),selected = c('Left','Right'))
    ),
   
    mainPanel(
      
      plotOutput('plot',height = 500),
      textOutput('text')
    )
  )
  
))
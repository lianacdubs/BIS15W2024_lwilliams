library("tidyverse")
library(shiny)

homerange <- read_csv("data/Tamburelloetal_HomeRangeDatabase.csv")

ui <- fluidPage(
  
  selectInput("x", "Select Fill Variable", choices = c("trophic.guild", "thermoregulation"), 
              selected = "trophic.guild"),
  
  
  plotOutput("plot", width="500px", height="400px") #prof didn't include size
)

server <- function(input, output) {
  
  output$plot <- renderPlot({ #make a plot 
    
    ggplot(data = homerange, aes_string(x="locomotion", fill=input$x))+  #the reactive part is the fill part. 
      geom_bar(position = "dodge", alpha=0.8, color="black")+
      labs(x=NULL, fill="Fill Variable")+
      theme_light(base_size = 18)
    
    
    
  }) #this closes rendered function
  
} #this closes server function

shinyApp(ui, server)

library(shiny)
library(DT)
library(tidyverse)
library(ggplot2)

server = function(input, output) {}


library(leaflet)
library(dplyr)
library(tidyverse)
library(readr)
library(ggplot2)
library(plotly)


##Calling Packages and Data Tables

Ultimate_with_averages <- read_csv("Ultimate_with_averages.csv")
Ultimate_averages_by_month_longlat <- read_csv("Ultimate_averages_by_month_longlat.csv")
Ultimate_Table <- read_csv("Ultimate_Table.csv")

server = function(input, output) {}

#Rendering the interactive map

server = function(input, output, session) {
  output$`Average Ticket Price by City` <- renderLeaflet({
    Color <- function(Ultimate_with_averages) { 
      sapply(Ultimate_with_averages$Average_Min_Price, 
             function(Average_Min_Price) {
               if (Average_Min_Price <= 30)       {"green"} 
               else if (Average_Min_Price <= 60)  {"blue"}
               else if (Average_Min_Price <= 90)  {"orange"} 
               else if (Average_Min_Price <= 120) {"red"} 
               else {"black"}})}
    
    icons <- awesomeIcons( icon = 'ticket-outline', library = 'ion', markerColor = Color(Ultimate_with_averages))
    leaflet(Ultimate_with_averages) %>%
      addTiles() %>%
      setView(lng = -98, lat = 40, zoom = 4)%>%
      addAwesomeMarkers(~Longitude,
                        ~Latitude, 
                        icon=icons, 
                        popup = ~paste("<p><b>", Ultimate_with_averages$City, "</b></p>",
                                       "<p>", "Average Ticket Price:", 
                                       prefix = "$",
                                       format(Ultimate_with_averages$Average_Min_Price, digits = 4), "</p>"), 
                        label = ~as.character(City)) %>%
      addLegend(position ="bottomright", 
                colors = c("#00CD00", "#00B2EE", "#FFA500", "#CD2626", "#000000"),
                opacity = 1,
                labels = c("<$30", "$30-60", "$60-90", "$90-120", "$120<"),
                title = "Average Prices", 
                labFormat = labelFormat(prefix = "$")
      )
    
  })
  
  
  #Rendering the filtered map
  
    output$`Average Ticket Price by City and Month` <- renderLeaflet({
      Color <- function(Ultimate_averages_by_month_longlat) { 
        sapply(Ultimate_averages_by_month_longlat$Average_Min_Price, 
               function(Average_Min_Price) {
                 if (Average_Min_Price <= 30)       {"green"} 
                 else if (Average_Min_Price <= 60)  {"blue"}
                 else if (Average_Min_Price <= 90)  {"orange"} 
                 else if (Average_Min_Price <= 120) {"red"} 
                 else {"black"}})}
      
    icons <- awesomeIcons( icon = 'ticket-outline', library = 'ion', markerColor = Color(Ultimate_averages_by_month_longlat))
    Ultimate_averages_by_month_longlat %>%
      filter(Month == input$Selector)%>%
    leaflet() %>%
      addTiles() %>%
      setView(lng = -98, lat = 40, zoom = 4)%>%
      addAwesomeMarkers(~Longitude,
                        ~Latitude, 
                        icon=icons, 
                        popup = ~paste("<p><b>", City, "</b></p>",
                                       "<p>", "Average Ticket Price:", 
                                       prefix = "$",
                                       format(Average_Min_Price, digits = 4), "</p>"), 
                        label = ~as.character(City)) %>%
      addLegend(position ="bottomright", 
                colors = c("#00CD00", "#00B2EE", "#FFA500", "#CD2626", "#000000"),
                opacity = 1,
                labels = c("<$30", "$30-60", "$60-90", "$90-120", "$120<"),
                title = "Average Prices", 
                labFormat = labelFormat(prefix = "$")
      )
  })
<<<<<<< HEAD
  output$Ultimate_Table_Plot <- renderPlot({ggplot(Ultimate_Table, aes( `Cost of Living Index`, `Minimum Ticket Price`, color = City)) + geom_point() + ylim(0, 275)
  })
  
  output$Ultimate_Table_Info <- renderTable({
    brushedPoints(Ultimate_Table, input$selected_cities)
  })

=======
  
  #Rendering the Raw Data 
  
output$myTable = DT::renderDataTable({
  Ultimate_Table
})
output$venueData = DT::renderDataTable({
  Book3
})
>>>>>>> 522b7cd5aabeaaa262f07986d2a5f269407b0915
}


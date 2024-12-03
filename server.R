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
Book3 <- read_csv("Book3.csv")
Venue_Map_ULTIMATE <- read.csv("Venue_Map_ULTIMATE.csv")

server = function(input, output) {}

#Rendering the interactive map

server = function(input, output, session) {
  output$`Average Ticket Price by City` <- renderLeaflet({
    
    Ultimate_with_averages %>%
      
      leaflet() %>%
      
       addTiles() %>%
       setView(lng = -98, lat = 40, zoom = 4) %>%
       addAwesomeMarkers(~Longitude,
                         ~Latitude, 
                         popup = ~paste("<p><b>", City, "</b></p>",
                                       "<p>", "Average Minimum Ticket Price:", 
                                       prefix = "$",
                                       format(Average_Min_Price, digits = 4), "</p>"), 
                         icon = awesomeIcons(
                          icon = 'ticket',
                          iconColor = "black",
                          library = 'ion',
                          markerColor = ~Color),
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
  

    Ultimate_averages_by_month_longlat %>%
        
      filter(Month == input$Selector) %>%

      leaflet() %>% 
        
         addTiles() %>%
         setView(lng = -98, lat = 40, zoom = 4) %>%
         addAwesomeMarkers(~Longitude,
                           ~Latitude, 
                            popup = ~paste("<p><b>", City, "</b></p>",
                                           "<p>", "Average Minimum Ticket Price:", 
                                             prefix = "$",
                                             format(Average_Min_Price, digits = 4), "</p>"), 
                           icon = awesomeIcons(
                             icon = 'ticket',
                             iconColor = "black",
                             library = 'ion',
                             markerColor = ~Color),
                           label = ~as.character(City)) %>%
      
        addLegend(position ="bottomright", 
                colors = c("#00CD00", "#00B2EE", "#FFA500", "#CD2626", "#000000"),
                opacity = 1,
                labels = c("<$30", "$30-60", "$60-90", "$90-120", "$120<"),
                title = "Average Prices", 
                labFormat = labelFormat(prefix = "$"))
  })
    

  
  #Rendering the interactive table
  
  output$Ultimate_Table_Plot <- renderPlot({
    ggplot(Ultimate_Table, aes( `Cost of Living Index`, `Minimum Ticket Price`, color = City)) + geom_point(show.legend = NULL) + ylim(0, 275)
  })
  
  output$Ultimate_Table_Info <- renderTable({
    brushedPoints(Ultimate_Table, input$selected_cities)
  })

  
  #Rendering the Raw Data 
  output$venueData = DT::renderDataTable({
    Book3})
#Rendering Venue Map


output$VenueMap <- renderLeaflet({
  leaflet(data = Venue_Map_ULTIMATE) %>%
    addTiles() %>%
    addMarkers(popup = ~Venue, label = ~Average_Price)
})

filtered_data <- reactive({
  req(input$artist_search)  # Ensure input is not empty
  
  artist_name <- input$artist_search
  
  
  result <- Ultimate_Table %>%
    filter(grepl(artist_name, Artist, ignore.case = TRUE)) %>%
    select(Artist, Venue, City, `Minimum Ticket Price`)  # Only show City and Minimum Ticket Cost
  
  return(result)
})


output$artist_info <- renderTable({
  req(input$search_button)  
  filtered_data()      
})

}




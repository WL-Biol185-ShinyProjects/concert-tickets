##Calling Packages

server = function(input, output) {}

library(shiny)
library(DT)
library(tidyverse)
library(ggplot2)
library(leaflet)
library(dplyr)
library(tidyverse)
library(readr)
library(ggplot2)

#Calling Data Tables

Ultimate_with_averages <- read_csv("Ultimate_with_averages.csv")
Ultimate_averages_by_month_longlat <- read_csv("Ultimate_averages_by_month_longlat.csv")
Ultimate_Table <- read_csv("Ultimate_Table.csv")
Book3 <- read_csv("Book3.csv")
Venue_Map_ULTIMATE <- read.csv("Venue_Map_ULTIMATE.csv")
COL_MTP <- read.csv("COL_MTP.csv")

server = function(input, output) {}


#Rendering the interactive "Average Ticket Price By City" map

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
  
  
#Rendering the interactive and filtered "Average Ticket Price by Month and City" map

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
                colors = c("#00CD00", 
                           "#00B2EE", 
                           "#FFA500", 
                           "#CD2626", 
                           "#000000"),
                opacity = 1,
                labels = c("<$30", 
                           "$30-60", 
                           "$60-90",
                           "$90-120", 
                           "$120<"),
                title = "Average Prices", 
                labFormat = labelFormat(prefix = "$"))
  })
    

  
#Rendering the interactive and brushed table
  
  output$Ultimate_Table_Plot <- renderPlot({
    ggplot(Book3,
           aes( `Cost of Living Index`, 
                `Minimum Ticket Price`, 
                color = City)) + geom_point(show.legend = NULL) + ylim(0, 275)
  })
  
  output$Ultimate_Table_Info <- renderTable({
    brushedPoints(Book3, 
                  input$selected_cities)
  })

  
#Rendering the Raw Data Table
  
  output$venueData = DT::renderDataTable({
    Book3})
  
#Rendering the interactive Venue Map

output$VenueMap <- renderLeaflet({
  
  Venue_Map_ULTIMATE %>%
    
  leaflet() %>%
    
    addTiles() %>%
    
    addAwesomeMarkers(~Longitude,
                      ~Latitude, 
                      popup = ~paste("<p><b>", Venue, "</b></p>",
                                     "<p>", "Average Minimum Ticket Price:", 
                                     prefix = "$",
                                     format(Average_Price, digits = 4), "</p>"), 
                      icon = awesomeIcons(
                        icon = 'ticket',
                        iconColor = "black",
                        library = 'ion',
                        markerColor = (~Color))) %>%
    
  addLegend(position ="bottomright", 
            colors = c("#00CD00", 
                       "#00B2EE", 
                       "#FFA500", 
                       "#CD2626", 
                       "#000000"),
            opacity = 1,
            labels = c("<$30", 
                       "$30-60", 
                       "$60-90",
                       "$90-120", 
                       "$120<"),
            title = "Average Prices", 
            labFormat = labelFormat(prefix = "$"))
})

#Rendering the Search Bar Feature

filtered_data <- reactive({
  req(input$artist_search)  # Ensure input is not empty
  
  artist_name <- input$artist_search
  
  result <- Book3 %>%
    
    filter(grepl(artist_name,
                 Artist, 
                 ignore.case = TRUE)) %>%
    
    select(Artist, 
           Venue, City, 
           `Minimum Ticket Price`)  # Only show City and Minimum Ticket Cost
  
  return(result)
})


output$artist_info <- renderTable({
  req(input$search_button)  
  filtered_data()      
})

#Rendering download buttons
##Raw data download

  output$Cumulative_Data <- downloadHandler(
    filename = function() {
      "Concert_Ticket_Data_2016"
    },
    content = function(file) {
      write.csv(Book3, file)
    }
  )

##Search bar download button
  
  output$Artist_Search <- downloadHandler(
    filename = function() {
      "Artist_Search_Results.csv"
    },
    content = function(file) {
      data_to_download <- filtered_data()
      
      if (nrow(data_to_download) == 0) {
        showNotification("Please search an artist's name...", type = "error")
        return(NULL) 
      }  else {
        write.csv(data_to_download, file, row.names = FALSE)
      }
    }
  )
  
##Brushed graph download button
  
  output$Download_Brushed <- downloadHandler(
    filename = function() {
      paste("Selected_Graph_Data_", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      brushed_data <- brushedPoints(Book3, input$selected_cities)
      if (nrow(brushed_data) == 0) {
        showNotification("Please brush over the graph...", type = "error")
        return(NULL) 
      } 
      write.csv(brushed_data, file, row.names = FALSE)
    }
  )
}


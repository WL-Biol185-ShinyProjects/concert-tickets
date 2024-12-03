#Building the Site

##Calling packages
library(shiny)
library(shinythemes)
library (dplyr)
library (leaflet)
library(ggplot2)
library(plotly)
library(tidyverse)

##Creating the Navigation Bar

navbarPage(theme = shinytheme("flatly"),
  "Concert Tickets USA",
           tabPanel("Welcome",
                    h1 ("Welcome to Concert Tickets USA"),
                    mainPanel(h3("Concert Tickets USA is your virtual guide to concert tickets. Our site displays connections between ticket prices, artistis, locations, and more! Concerts are pricey. 
                       Concert Tickets USA shows you these prices, allowing you to to predict ticket prices in the future!")),
                    img(src = "Ticket2.png")),
            tabPanel("About",
                    h4("About the Creators:"),
                    sidebarPanel(HTML("We are four college students at Washington and Lee University in Lexington Virginia. For full time students, concerts can be a fun night out after an exhausting week. 
                    But as college students, we have to find a way to save money... while also having fun! Our website, Concert Tickets USA, comes from our love of concerts and music, but also our need to be
                    cost efficient."),
                   br(), br(),
                   HTML("Julia Luzzio: Julia Luzzio is a biology major and a music minor. She is pre-veterinary and in her freetime enjoys reading, horseback riding, and coding!"),
                   br(), br(),
                   HTML("Liz Blakely: Liz Blakely is a biology and religion major. She is pursuing a career in health policy. In her free time, she enjoys spending time with friends, reading, and going on hikes."),
                   br(), br(),
                   HTML("Marcie Bernard: Marcie Bernard is a biology and environmental major on the pre-veterinary track. In her free time, she walks dogs, spends time outdoors, and cooking."),
                   br(), br(),
                   HTML("Zach Ricciardelli: Zach Ricciardelli is a neuroscience major and a classics and philosophy minor on the pre-med track. In his free time, he enjoys hanging out with friends, hiking, and watching football."))),
           tabPanel("Artist Search Bar",
                    fluidPage(
                      titlePanel("Artist Ticket Information"),
                      
                      sidebarLayout(
                        sidebarPanel(
                          textInput("artist_search", "Search Artist:", value = ""),
                          actionButton("search_button", "Search")
                        ),
                        
                        mainPanel(
                          tableOutput("artist_info")
                        ),
                        
                      ),
                      img(src = "guitar.png")
                    )
                    
                    ),
  
  #Adding Interactive Maps
  
           navbarMenu("Maps",
                    tabPanel("United States Average Ticket Price",
                             h1("United States Average Ticket Price (2016)"),
                             leafletOutput ("Average Ticket Price by City"),
                             ),
                    tabPanel("United States Monthly Average Ticket Price",
                            h1("United States Monthly Average Ticket Price (2016)"),
                            fluidPage(
                              selectInput(inputId = "Selector",
                                          label = "Select Month",
                                          choices = c("Please Select:",
                                                      "January",
                                                      "February",
                                                      "March",
                                                      "April",
                                                      "May",
                                                      "June",
                                                      "July",
                                                      "August",
                                                      "September",
                                                      "October",
                                                      "November",
                                                      "December" ),
                                          selected = "January"),
                              leafletOutput ("Average Ticket Price by City and Month"))),
                    tabPanel("Venue Prices Map",
                             leafletOutput ("VenueMap"))),
  
  #Stationary PNG of Bar Graph
          navbarMenu("Graphical Cost Comparisons",
           tabPanel("Ticket Vendor Cost Comparisons",
                    h1("Concert Ticket Vendor Graphical Cost Comparisons"),
                    sidebarPanel(HTML("This figure allows the buyer to understand which ticket vendor will
                                      sell the most affordable concert tickets. Our data finds Wantickets to
                                      be the most cost effective ticket vendor, and we recommend avoiding Live Nation.
                                      While these are subject to change, the graphical representation should
                                      help advise you to check as many vendors as possible and compare prices for
                                      cost efficiency.
                                      ")),            
                    img(src = "Ticket_Vendor_Comparison.png")),
            tabPanel("City Cost of Living vs. Minimum Ticket Price Graph",
                  fluidPage(
                      plotOutput("Ultimate_Table_Plot", brush = "selected_cities"),
                      tableOutput("Ultimate_Table_Info")
                    ),
                  mainPanel(HTML("This graph outlines the comparison between the cost of living index and 
                                 minimum average ticket price city by city. For your convenience, the 
                                 graph is colored city by city, allowing visualization of the contrast between
                                 cities. With this tool, you can find cities with the most affordable ticket 
                                 prices. Hold and brush over the graph to compare other factors of each data point,
                                 including venues and other features."))
                  )),
           navbarMenu("Raw Data",
                    tabPanel("Cumulative Raw Data",
                             h1("Raw Dataset Used For All Features With Search Bar"),
                             DT::dataTableOutput("venueData"))))

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

navbarPage(theme = shinytheme("cerulean"),
  "Concert Tickets USA",
           tabPanel("Welcome",
                    h1 ("Welcome to Concert Tickets USA"),
                    mainPanel(h3("Concert Tickets USA is your virtual guide to concert tickets. Our site displays connections between ticket prices, artistis, locations, and more! Concerts are pricey. 
                       Concert Tickets USA shows you these prices, allowing you to to predict ticket prices in the future!"),
                              br(),
                              h4("Our convenient features allow you to make the most educated decisions about your ticket purchase.
                                 Use our artist search bar to view your favorite performer's past concerts and prices. View our interactive
                                  maps to find optimum minimum ticket price by city, month, and venue. Our venur graph compares ticket vendors,
                                 to inform you of the most cost efficient place to purchase your tickets from. Our interactive cost of living and minimum
                                  ticket price graph help you view specific data about your home town. Finally, our entire dataset is at your 
                                 fingertips to search with our convenient data search bar."),
                              br(),
                              br()),
                    img(src = "musicconcert.png")),
            tabPanel("About",
                    h1("About the Creators:"),
                    h3("We are four college students at Washington and Lee University in Lexington Virginia. For full time students, concerts can be a fun night out after an exhausting week. 
                    But as college students, we have to find a way to save money... while also having fun! Our website, Concert Tickets USA, comes from our love of concerts and music, but also our need to be
                    cost efficient."),
                   br(), br(),
                   sidebarPanel(HTML("Zach Ricciardelli: Zach Ricciardelli is a neuroscience major and a classics and philosophy minor on the pre-med track. In his free time, he enjoys hanging out with friends, hiking, and watching football."),
                   br(), br(),
                   HTML("Marcie Bernard: Marcie Bernard is a biology and environmental major on the pre-veterinary track. In her free time, she enjoys walking dogs, hiking and spending time outdoors, and cooking."),
                   br(), br(),
                   HTML("Liz Blakely: Liz Blakely is a biology and religion major. She is pursuing a career in health policy. In her free time, she enjoys spending time with friends, reading, and going on hikes."),
                   br(), br(),
                   HTML("Julia Luzzio: Julia Luzzio is a biology major and a music minor. She is pre-veterinary and in her freetime enjoys reading, horseback riding, and coding!")),
                   br(), br(),
                   img(src = "grouppic.png", width = "60%", height = "60%")),
           tabPanel("Artist Search Bar",
                    fluidPage(
                      titlePanel("Artist Ticket Information"),
                      br(),
                      h4("Search the name of your favorite performer and discover which cities they commonly perform at, what venues they attend in said city, 
                         and the average minimum ticket price a consumer can find for one of their concerts."),
                      br(),
                      
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
                             h1("United States Average Ticket Price by City (2016)"),
                             leafletOutput ("Average Ticket Price by City"),
                             h4("The provided map allows the viewer to check the minimum average ticket price in a city of their choosing. Whether it is 
                                your hometown or across the country, prospective ticket buyers can check where the most afforable concerts are being held.")
                             ),
                    tabPanel("United States Monthly Average Ticket Price",
                            h1("United States Monthly Average Ticket Price by City (2016)"),
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
                    tabPanel("Concert Ticket Prices of Big City Venues",
                             h1("Zoom in on any Major City to compare the concert ticket prices of different venues within each city!"), 
                             br(),
                             leafletOutput ("VenueMap"),
                             br(),
                             h4("Click on popup to see name of Venue, and holding over should give you the price in American Dollars"))),

  
  #Stationary PNG of Bar Graph
          navbarMenu("Graphical Cost Comparisons",
           tabPanel("Ticket Vendor Cost Comparisons",
                    h1("Concert Ticket Vendor Graphical Cost Comparisons"),
                    sidebarPanel(h3("Understand What You Are Paying For..."),
                                 br(),
                                 br(),
                    HTML("This figure allows the buyer to understand which ticket vendor will
                                      sell the most affordable concert tickets. Our data finds Wantickets to
                                      be the most cost effective ticket vendor, and we recommend avoiding Live Nation.
                                      While these are subject to change, the graphical representation should
                                      help advise you to check as many vendors as possible and compare prices for
                                      cost efficiency.
                                      ")),            
                    img(src = "Ticket_Vendor_Comparison.png")),
            tabPanel("City Cost of Living vs. Minimum Ticket Price Graph",
                     h1("Cost of Living and Ticket Price Relationship"),
                  fluidPage(
                      plotOutput("Ultimate_Table_Plot", brush = "selected_cities"),
                      tableOutput("Ultimate_Table_Info")
                    ),
                  mainPanel(h3("Travel to Get the Best Deal!"),
                            br(),
                  HTML("This graph outlines the comparison between the cost of living index and 
                                 minimum average ticket price city by city. For your convenience, the 
                                 graph is colored city by city, allowing visualization of the contrast between
                                 cities. With this tool, you can find cities with the most affordable ticket 
                                 prices. Hold and brush over the graph to compare other factors of each data point,
                                 including venues and other features."))
                  )),
           navbarMenu("Raw Data",
                    tabPanel("Cumulative Raw Data",
                             h1("Raw Dataset Used For All Features With Search Bar"),
                             h3("Search through our full dataset with a search bar specialized for 
                                your convenience..."),
                             DT::dataTableOutput("venueData"))))

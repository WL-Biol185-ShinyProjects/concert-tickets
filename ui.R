#Building the Site

##Calling packages
library(shiny)
library(shinythemes)
library (dplyr)
library (leaflet)
library(ggplot2)
library(tidyverse)

##Creating the Navigation Bar

navbarPage(theme = shinytheme("cerulean"),
  "Concert Tickets USA",
           tabPanel("Welcome",
                    h1 ("Welcome to Concert Tickets USA"),
                    mainPanel(h3("Concert Tickets USA is your virtual guide to concert tickets. Our site displays connections between ticket prices, artistis, locations, and more! Concerts are pricey. 
                       Concert Tickets USA shows you these prices, allowing you to to predict ticket prices in the future!"),
                              br(),
                              h4("Our features allow you to make the most educated decisions about your concert ticket purchases.
                                 Use our artist search bar to view your favorite performer's past concerts and prices. View our interactive price
                                  maps to reveal ticket price information by city, month, and venue. Our vendor graph compares ticket vendors
                                 to help you choose where to buy your tickets. Our interactive cost of living and
                                  ticket price graph allows you to view specific data about your hometown or other city. Finally, the dataset we used to build all of these features is at your 
                                 fingertips to sift through and explore with a convenient search bar."),
                              br(),
                              br()),
                    img(src = "musicconcert.png")),
            tabPanel("About",
                    h1("About the Creators:"),
                    h3("We are four college students at Washington and Lee University in Lexington Virginia. For full time students, concerts can be a fun night out after an exhausting week. 
                    But as college students, we have to find a way to save money... while also having fun! Our website, Concert Tickets USA, comes from our love of concerts and music, but also our need to be
                    cost efficient."),
                   br(), br(),
                   sidebarPanel(h4("Zach Ricciardelli: Zach Ricciardelli is a neuroscience major and a classics and philosophy minor on the pre-med track. In his free time, he enjoys hanging out with friends, hiking, and watching football."),
                   br(), br(),
                   h4("Marcie Bernard: Marcie Bernard is a biology and environmental major on the pre-veterinary track. In her free time, she enjoys walking dogs, hiking and spending time outdoors, and cooking."),
                   br(), br(),
                   h4("Liz Blakely: Liz Blakely is a biology and religion major. She is pursuing a career in health policy. In her free time, she enjoys spending time with friends, reading, and going on hikes."),
                   br(), br(),
                   h4("Julia Luzzio: Julia Luzzio is a biology major and a music minor. She is pre-veterinary and in her freetime enjoys reading, horseback riding, and coding!")),
                   
                   img(src = "grouppic.png", width = "50%", height = "50%")),
           tabPanel("Artist Search Bar",
                    fluidPage(
                      titlePanel("Artist Ticket Information"),
                      br(),
                      h4("Search the name of your favorite performer and discover where they commonly perform as well as the average minimum ticket price you could find for one of their concerts."),
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
                      img(src = "guitar.png", width = "33%", height = "33%")
                    )
                    
                    ),
  
  #Adding Interactive Maps
  
           navbarMenu("Maps",
                    tabPanel("United States Average Ticket Price",
                             h1("United States Average Ticket Price by City (2016)"),
                             leafletOutput ("Average Ticket Price by City"),
                             h4("This map allows you to check the minimum average ticket price in any city. Whether it is 
                                your hometown or all the way across the country, take a look at where the most afforable concerts are being held!")
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
                              leafletOutput ("Average Ticket Price by City and Month"),
                              h4("This map allows you to check the minimum average ticket price in any city during whichever month you select. Just choose a month and 
                                 look at when and where the most afforable concerts are being held!"))
                              ),
                    tabPanel("Concert Ticket Prices of Big City Venues",
                             h1("Zoom in on any major American city to compare the concert ticket prices of different venues within each one!"), 
                             br(),
                             leafletOutput ("VenueMap"),
                             br(),
                             h4("Click on a marker to see the name of the venue it represents. Hover over it to view its average minimum ticket price."))),

  
  #Stationary PNG of Bar Graph
          navbarMenu("Graphical Cost Comparisons",
           tabPanel("Ticket Vendor Cost Comparisons",
                    h1("Concert Ticket Vendor Graphical Cost Comparisons"),
                    sidebarPanel(h3("Understand What You Are Paying For..."),
                                 br(),
                                 br(),
                    HTML("This figure shows you which ticket vendor
                                      typically sells the most affordable concert tickets. Our data finds Wantickets to
                                      be the most cost effective ticket vendor, and Live Nation to be the most expensive.
                                      While these are subject to change and we reccomend checking multiple websites before purchasing tickets, this graph 
                                      can help to visualize the general trend.
                                      ")),            
                    img(src = "Ticket_Vendor_Comparison.png")),
            tabPanel("City Cost of Living vs. Minimum Ticket Price Graph",
                     h1("Cost of Living vs. Ticket Price"),
                  fluidPage(
                      plotOutput("Ultimate_Table_Plot", brush = "selected_cities"),
                      tableOutput("Ultimate_Table_Info")
                    ),
                  mainPanel(h3("Is There a Relationship?"),
                            br(),
                  HTML("This graph shows the relationship of the cost of living index score for each city and 
                                 that city's respective average minimum ticket price. It is colored by city to make each point
                                 more easily discernible. Hold and brush over the graph to reveal 
                                 the cities along with all the data for each concert. As you can see, the cities with cost of living index scores
                                 below 100 do tend to have the lowest ticket prices. Outside of these cities, however, the majority of minimum 
                                 ticket prices fall between $30 and $150 with a relatively even distribution. This data tells us that outside of the cities
                                 with the lowest cost of living scores, venue or performing artist likely has more of an impact on ticket price than the
                                 cost of living."))
                  )),
           navbarMenu("Raw Data",
                    tabPanel("Cumulative Raw Data",
                             h1("Raw Dataset Used For All Features With Search Bar"),
                             h3("Use the search bar below to browse our entire set of 2016 concert data, which we used to construct all 
                             the graphs, maps, and stats you see on this site. Just start typing the name
                             of any artist, venue, city, state, or month to discover more!"),
                             fluidPage(
                               downloadButton("Cumulative_Data", "Download")
                             ),
                             DT::dataTableOutput("venueData"))))

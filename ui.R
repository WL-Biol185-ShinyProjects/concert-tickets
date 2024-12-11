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
  
  #Welcome Tab
           tabPanel("Welcome",
                    h1 ("Welcome to Concert Tickets USA"),
                    mainPanel(h3("Concert Tickets USA is your virtual guide to concert tickets! Our site displays connections between ticket prices, artists, locations, and more. Concerts are pricey. 
                       Concert Tickets USA presents these prices, allowing you to financially plan while still having fun."),
                              br(),
                              h4("Our features allow you to make educated decisions about your concert ticket purchases.
                                 Use our artist search bar to view your favorite performer's past concerts and prices. View our interactive price
                                  maps to reveal ticket price information by city, month, and venue. Our vendor graph compares ticket vendors
                                 to help you choose where to buy your tickets. Our interactive cost of living and
                                  ticket price graph allows you to view specific data about your hometown or other city. See our recommendations for finding the best deal and relevent articles to stay up to date in the latest of ticket price news. Finally, 
                                  the dataset we used to build all of these features is at your 
                                 fingertips to sift through and explore with a convenient search bar."),
                              br(),
                              br()),
                    img(src = "musicconcert.png")),
  
  #About Us tab
            tabPanel("About",
                    h1("About the Creators:"),
                    h3("We are four college students at Washington and Lee University in Lexington Virginia. For full time academics, concerts can be a fun night out after an exhausting week. 
                    But as college students, we have to find a way to save money... while also having a blast! Our app, Concert Tickets USA, arose from our hope to enjoy live music while being cost efficient and avoiding ridiculously high price tags."),
                   br(), br(),
                   sidebarPanel(h4("Zach Ricciardelli: Zach Ricciardelli is a neuroscience major and a classics and philosophy minor on the pre-med track. In his free time, he enjoys hanging out with friends, hiking, and watching football."),
                   br(), br(),
                   h4("Marcie Bernard: Marcie Bernard is a biology and environmental major on the pre-veterinary track. In her free time, she enjoys walking dogs, hiking and spending time outdoors, and cooking."),
                   br(), br(),
                   h4("Liz Blakely: Liz Blakely is a biology and religion major. She is pursuing a career in health policy. In her free time, she enjoys spending time with friends, reading, and going on hikes."),
                   br(), br(),
                   h4("Julia Luzzio: Julia Luzzio is a biology major and a music minor. She is pre-veterinary and in her freetime enjoys reading, horseback riding, and coding!")),
                   img(src = "grouppic.png", width = "50%", height = "50%")),
  
  #Search Bar Tab
           tabPanel("Artist Search Bar",
                    fluidPage(
                      titlePanel("Artist Ticket Information"),
                      br(),
                      h4("Type the name of your favorite performer in the search bar to display their past concert data and minimum ticket prices. After searching your chosen performer, easily download your search results using the provided button."),
                      br(),
                      fluidPage(
                        downloadButton("Artist_Search", "Download")
                        ),
                      br(),
                      sidebarLayout(
                        sidebarPanel(
                          textInput("artist_search", "Search Artist:", value = ""),
                          actionButton("search_button", "Search")),
                        mainPanel(
                          tableOutput("artist_info")),
                        ),
                      img(src = "guitar.png", width = "33%", height = "33%")
                    )
                    ),
  
  #Adding Interactive Maps
           navbarMenu("Maps",
                    tabPanel("United States Average Ticket Price",
                             h1("United States Average Ticket Price by City (2016)"),
                             leafletOutput ("Average Ticket Price by City"),
                             br(),
                             h4("This map allows you to check the minimum average ticket price in any city. Whether it is 
                                your hometown or a city all the way across the country, take a look at where the most afforable concerts are being held.")
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
                                          selected = "January"),     # Ensuring filter for map starts on January
                              leafletOutput ("Average Ticket Price by City and Month"),
                              br(),
                              h4("This map allows you to check the minimum average ticket price in any city by month. Simply select a month from the dropdown and 
                                 view when and where the most afforable concerts are being held."))
                              ),
                    tabPanel("Concert Ticket Prices of Big City Venues",
                             h1("Zoom in on any of the major American cities marked on the map to compare the average minimum concert ticket prices of different venues within the city of your choice."), 
                             br(),
                             leafletOutput ("VenueMap"),
                             br(),
                             h4("Select a popup on the map to view a concert venue and the average minimum ticket price at that venue.")
                             )
                    ),

  
  #Stationary PNG of Bar Graph
          navbarMenu("Graphical Cost Comparisons",
           tabPanel("Ticket Vendor Cost Comparisons",
                    h1("Concert Ticket Vendor Graphical Cost Comparisons"),
                    sidebarPanel(h3("Understand What You Are Paying For..."),
                                 br(),
                                 br(),
                    HTML("This figure shows you how concert ticket prices from different vendors
                                      compete with each other. Our data finds Wantickets to
                                      be the most cost effective ticket vendor and Live Nation to be the most expensive.
                                      This graph, like the others on this site, is based solely on the 2016 data we have, so we recommend 
                                      checking multiple websites before purchasing any tickets.
                                      ")
                    ),            
                    img(src = "Ticket_Vendor_Comparison.png")
                    ),
           
      #Interactive Graph
            tabPanel("City Cost of Living vs. Minimum Ticket Price Graph",
                     h1("Cost of Living and Ticket Price Relationship"),
                  fluidPage(
                      plotOutput("Ultimate_Table_Plot", brush = "selected_cities"),
                      tableOutput("Ultimate_Table_Info"),
                      downloadButton("Download_Brushed", "Download"),
                    ),
                  mainPanel(h3("Minimum Average Ticket Price vs. Cost of Living Per City"),
                            br(),
                  HTML("This graph presents a comparison between the cost of living index for each city and 
                                 its respective minimum average ticket price. The 
                                 graph is colored by city to make each point easily discernible. With this tool, you can look at how the cost of living in cities affects the 
                                 ticket prices there. Hold and brush over the graph to reveal the cities and other important data
                                 including artist, concert venue, ticket vendor, and more. After brushing over your chosen data points, easily download the resulting data 
                       by clicking the provided button."))
                  )
      ),
  
  #Recommendations Tab
           tabPanel("Our Recommendations",
                   h1("Recommended Concerts (Based on Affordability Concluded From This Data)"),
                   h2("So what factor matters most?"),
                   HTML("We ran the analytics for you, and we believe that overall,
                      the performing artist and ticket vendor are the most important factors in determining the price
                      of concert tickets. The concert venue and genre of the music also seem to play a significant role in ticket price. Other 
                      factors such as seat choice may also affect the price of a ticket. Although it was not included in the data we had access to, 
                      keep your seat selection in mind when deciding whether a concerts is affordable or not."), 
                   h3("Recommended Ticket Vendors"),
                   HTML("See our graph on Ticket Vendor Cost Comparisons for a graphical analysis of the most and 
                      least expensive ticket vendors from our data. Additionally, we have linked articles in the `Relevant Articles` 
                      tab diving into recent controversies over ticket vendor agencies like Ticketmaster. Linked here are our top three recommendations for ticket vendors!"),
                   img(src = "Live.nation.png", width = "20%", height = "20%", style="float:right"),
                   br(),
                   a(href = "https://www.livenation.com", 
                          "Livenation", target = "_blank"),
                   br(),
                   a(href = "https://www.ticketweb.com", 
                     "TicketWeb", target = "_blank"),
                   br(),
                   a(href = "https://www.etix.com/ticket/", 
                     "Etix", target = "_blank"),
                   h3("Recommended Artists"),
                   HTML("By nature, more popular artists are likely going to be more expensive to see in concert than 
                      smaller name bands and artists. So, if you're not stuck on any particular artist, trying to 
                      save some money, and just down for some live music, we recommend going to see a lesser-known local band or
                      a B-list artist."), 
                      HTML("Consider the following artists, all who's tickets tend to fall below $50:"),
                   h5("Anne-Marie"), 
                   h5("Bad Wolves"),
                   h5("Bazzi"), 
                   img(src = "stickfigure.jpg", width = "20%", height = "20%", style="float:right"),
                   h5("Brett Young"), 
                   h5("Corey Smith"), 
                   h5("Childish Gambino"), 
                   h5("Charlie Puth"), 
                   h5("Foster the People"), 
                   h5("G-Eazy"), 
                   h5("Godsmack"), 
                   h5("HoundMouth"),
                   h5("Kane Brown"),
                   h5("MercyMe"),
                   h5("Portugal the Man"),
                   h5("Rich the Kid"), 
                   h5("Shinedown"),
                   h5("Stick Figure"),
                   h5("Waka Flaka Flame"),
                   HTML("Of the big names, we recommend artist like the following, all with ticket prices as low as $40-95:"),
                   img(src = "Beyonce.jpg", width = "20%", height = "20%", style="float:right"),
                   h5("Bad Bunny"),
                   h5("Beyonce"),
                   h5("Bruno Mars"),
                   h5("Camilla Cabello"),
                   h5("Cardi B"),
                   h5("Drake"),
                   h5("Chris Stapelton"),
                   h5("Coldplay"),
                   h5("Dan + Shay"),
                   h5("Dua Lipa"),
                   h5("Ed Sheeran"),
                   h5("Florida Georgia Line"),
                   h5("Halsey"),
                   h5("Imagine Dragons"), 
                   h5("Leon Bridges"), 
                   h5("Lil Uzi"), 
                   img(src = "thomas.rhett.jpeg", width = "20%", height = "20%", style="float:right"),
                   h5("Luke Bryan"), 
                   h5("Lynrd Skynrd"), 
                   h5("Maroon 5"), 
                   h5("Nial Horan"), 
                   h5("P!NK"), 
                   h5("Panic at the Disco"), 
                   h5("Post Malone"), 
                   h5("Rihanna"), 
                   h5("Sam Smith"), 
                   h5("Selena Gomez"), 
                   h5("Chainsmokers"), 
                   h5("Thomas Rhett"), 
                   h5("Justin Timberlake"), 
                   h5("Kendrick Lamar"), 
                   h5("Kenny Chesney"), 
                   HTML("If you're trying to save money, we recommend avoiding the following popular artists whose prices are all above $100. Of course, if you love the artist the ticket is worth the price!"),
                   img(src = "JB.jpg", width = "20%", height = "20%", style="float:right"),
                   h5("Billy Joel"), 
                   h5("Bruce Springsteen"),
                   h5("Adele"), 
                   h5("Justin Bieber"), 
                   h5("Taylor Swift"), 
                   h5("Twenty One Pilots"), 
                   br(),
                   br(),
                   br(),
                   h4("Overall, the minimum price of tickets for country and rap artists tends to be cheaper than pop artists. Additionally, venue is an important factor in certain Artist's ticket prices, with more famous venues as well as more intimate venues typically yielding a higher price tag."),
           ),

  #Relevant Articles tab                
  tabPanel("Relevant Articles", 
           h1("Relevant Articles"),

           sidebarLayout(
             sidebarPanel(
               a(href = "https://www.pbs.org/newshour/arts/heres-a-running-list-of-clashes-between-ticketmaster-fans-and-artists", 
                 "Clashes Between Ticketmaster, Fans and Artists", target = "_blank")
               ),
             mainPanel(
               h3("Check out these articles!"),
               p("In the sidebar, you will find links to several articles discussing 
                 some problems with certain ticket vendors such as overpriced concert tickets in recent years!")
             )
           ),
           sidebarLayout(
             sidebarPanel(
               a(href = "https://www.vox.com/the-goods/23569504/ticketmaster-monopoly-live-nation-taylor-swift-antitrust-clyde-lawrence", 
                 "Ticketmaster Monopoly?", target = "_blank")
             ),
             mainPanel()
             ),
           br(),
           sidebarLayout(
             sidebarPanel(
               a(href = "https://www.bbc.com/news/articles/c2kdxlv8x05o", 
                 "Why do concert tickets cost as much as a game console?", target = "_blank")
             ),
             mainPanel()
           ),
           br(),
           sidebarLayout(
             sidebarPanel(
               a(href = "https://www.nbcnews.com/business/consumer/concert-ticket-sales-why-are-artists-canceling-shows-tours-prices-rcna154558", 
                 "Why artists are cancelling shows", target = "_blank")
             ),
             mainPanel()
           ),
           br(),
  sidebarLayout(
    sidebarPanel(
      a(href = "https://truthonthemarket.com/2024/05/24/live-nation-breakup-are-mergers-really-to-blame-for-ticketmasters-problems/", 
        "Live Nation Mergers", target = "_blank")
    ),
    mainPanel()
  )
           
),
           
#Raw Data Tab

                    tabPanel("Cumulative Raw Data",
                             h1("Raw Dataset Used For All Features With Search Bar"),
                             h3("Search through our full dataset with a search bar specialized for 
                                your convenience. Easily download the full dataset using the provided button."),
                             fluidPage(
                               downloadButton("Cumulative_Data", "Download")
                             ),
                             DT::dataTableOutput("venueData")))

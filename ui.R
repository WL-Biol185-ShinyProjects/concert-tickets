##building the site

library(shiny)
library(shinythemes)
library (dplyr)
library (leaflet)
library(ggplot2)
library(plotly)

navbarPage(theme = shinytheme("flatly"),
  "Concert Tickets USA",
           tabPanel("Welcome",
                    h1 ("Welcome to Concert Tickets USA"),
                    h3("Concert Tickets USA is your virtual guide to concert ticket understanding. Our site displays connections between ticket prices, artistis, locations, venues, and more!"),
                   br(), br(),
                    h4("About the Creators:"),
                    HTML("We are four college students at Washington and Lee University in Lexington Virginia. For full time students, concerts can be a fun night out after and exhausting week. 
                         However, concerts are pricey. Concert Tickets USA allows us to predict ticket prices based on a multitude of factors, and financially plan for that cost."),
                   br(), br(),
                   HTML("Julia Luzzio: Julia Luzzio is a biology major and a music minor. She is pre-veterinary and in her freetime enjoys reading, horseback riding, and coding!"),
                   br(), br(),
                   HTML("Liz Blakely: Liz Blakely is a biology and religion major. She is pursuing a career in health policy. In her free time, she enjoys spending time with friend, reading, and going on hikes."),
                   br(), br(),
                   HTML("Marcie Bernard: Marcie Bernard is a biology and environmental major on the pre-veterinary track. In her free time, she walks dogs, spends time outdoors, and cooking."),
                   br(), br(),
                   HTML("Zach Ricciardelli: Zach Ricciardelli is a neuroscience major and a classics and philosophy minor on the pre-med track. In his free time, he enjoys hanging out with friends, hiking, and watching football.")),
           tabPanel("Overall Search Bar"),
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
                                          selected = "Please Select:"),
                              leafletOutput ("Average Ticket Price by City and Month")),
                            textOutput("Please Select Month"))),
           tabPanel("Graphical Cost Comparisons",
                    h1("Concert Ticket Graphical Cost Comparisons"),
                    HTML("Ticket Vendor Comparison Graph")),            
           navbarMenu("Raw Data",
                    tabPanel("Cumulative Ticket Data",
                             h1("Cumulative Ticket Sale Data in the United States")),
                    tabPanel("Cost of Living Data",
                             h1("Raw Dataset of Cost of Living in United States Cities"))))

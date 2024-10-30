library(shiny)
library(shinythemes)
navbarPage(theme = shinytheme("flatly"),
  "Concert Tickets USA",
           tabPanel("Welcome",
                    h1 ("Welcome to Concert Tickets USA"),
                    h3("Concert Tickets USA is your virtual guide to concert ticket understanding. Our site displays connections between ticket prices, artistis, locations, venues, and more!"),
                    h4("About the Creators:"),
                    HTML("We are four college students at Washington and Lee University in Lexington Virginia. For full time students, concerts can be a fun night out after and exhausting week. 
                         However, concerts are pricey. Concert Tickets USA allows us to predict ticket prices based on a multitude of factors, and financially plan for that cost.")),
           tabPanel("Maps",
                    h1("Ticket Price, Artist, and Venue Map Data")),
           tabPanel("Graphical Cost Comparisons",
                    h1("Concert Ticket Graphical Cost Comparisons"),
                    HTML("City by City Cost Context and Ticket Vendor Comparisons")),
           tabPanel("Raw Data",
                    h1("Raw Datasets for Ticket Data and Cost of Living")))

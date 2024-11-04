##building the site

library(shiny)
library(shinythemes)

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
                   HTML("Zach Ricciardelli: Zach Ricciardelli is a...")),
           navbarMenu("Maps",
                    tabPanel("City by City Ticket Price",
                             h1("Ticket Price, Artist, and Venue Map Data"))),
           tabPanel("Graphical Cost Comparisons",
                    h1("Concert Ticket Graphical Cost Comparisons"),
                    HTML("Ticket Vendor Comparison Graph"),
                    img(src = "Ticket_Vendor_Comparison.png")),
           navbarMenu("Raw Data",
                    tabPanel("Cumulative Ticket Data",
                             h1("Cumulative Ticket Sale Data in the United States")),
                    tabPanel("Cost of Living Data",
                             h1("Raw Dataset of Cost of Living in United States Cities")),
                    ))


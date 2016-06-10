#load libraries in both UI and Server, otherwise functions won't work
library(shiny)
library(leaflet)
library(htmltools)
library(ggplot2)

shinyUI(navbarPage("IPL-Data-Visualization",
                   
                   tabPanel("Visualization",
                            pageWithSidebar(
                              
                              headerPanel("Select your favorite IPL Team"),
                              
                              sidebarPanel(
                                                                                                                            
                                radioButtons("selection", "Select a team to view their winning matches",
                                             c("All Matches till now" = "all",
                                               "Chennai Super Kings Wins" = "csk",
                                               "Deccan Chargers Win" = "dc",
                                               "Delhi DareDevils Wins" = "dd",
                                               "Gujarath Lions Wins" = "gl",
                                               "Kings XI Punjab Wins" = "kxp",
                                               "Kerala Tuskers Kochi Wins" = "ktk",
                                               "Kolkatta Knight Riders Wins" = "kkr",
                                               "Mumbai Indians Wins" = "mi",
                                               "Pune Warriors wins" = "pw",
                                               "Rajasthan Royals Wins" = "rr",
                                               "Rising Pune Super Gaints Wins" = "rps",
                                               "Royal Challengers Bangalore Wins" = "rcb",
                                               "Sun Risers Hyderabad Wins" = "sh",
                                               "Matches that Tied" = "t")),
                                h4('Select the stats tab for more information')
                                
                              ), 
                              mainPanel(
                                tabsetPanel(
                                  tabPanel("MAP", 
                                            leafletOutput("map", width = "860px", height = "480px")
                                           ),
                                  tabPanel("Stats", 
                                           h4('Matches won by year'),
                                           plotOutput("plot1"),
                                           h4('Most matches won at'),
                                           textOutput("info"))
                                          
                                )
                                
                              )
                              
                            )),
                   
                   tabPanel("About",
                            
                            fluidPage(
                              
                                # Application title
                                titlePanel("About IPL-Data-Visualization!"),
                                
                                # Documentation
                                mainPanel(
                                  p("The Indian Premier League (IPL) is a professional Twenty20 cricket league in India 
                                    contested every year by franchise teams representing Indian cities.
                                    The IPL is the most-attended cricket league in the world and ranks sixth among all sports leagues.
                                    "),
                                  p("This app lets you visualize the IPL Match data from the first season to 9th season(05/20/2016)
                                    It provides you the statistics about the no.of wins/losses,
                                    Venue in which the team has maximum wins. It also shows you the
                                    places they won on the world map. The data has been obtained from
                                    the github repository below."),
                                  a("IPL-Data_Visualization",href="https://github.com/ysharc/IPL-Data-Visualization"),
                                  p("Author: Yeshwanth Arcot"),
                                  
                                  h1('Quick Usage'),
                                  tags$ol(
                                    tags$li("Open [url]"), 
                                    tags$li("Select your favorite team on the right"), 
                                    tags$li("The Stats tab shows you some basic statistics of the team"),
                                    tags$li("The following are the features provided by the map"),
                                    tags$ul(
                                      p(""),
                                      tags$li("Map starts with an overview of all IPL matches played until now."),
                                      p(""),
                                      tags$img(src="http://i.imgur.com/VvZKdpQ.png",width="856px",height="415px"),
                                      p(""),
                                      tags$li("Select a subgroup to view their respective cluster. (For example kolkatta_wins in the following image)"),
                                      p(""),
                                      tags$img(src="http://i.imgur.com/SjNf6Uq.png",width="856px",height="415px"),
                                      p(""),
                                      tags$li("Hover mouse over a cluster point to see the area it covers"),
                                      p(""),
                                      tags$img(src="http://i.imgur.com/JnZuRla.png",width="856px",height="415px"),
                                      p(""),
                                      tags$li("zoom in to see the spread of the group"),
                                      p(""),
                                      tags$img(src="http://i.imgur.com/O0O6xKZ.png",width="856px",height="415px"),
                                      p(""),
                                      tags$li("At the final zoom level click the cluster to display a spiderweb of all the matches that took place in it."),
                                      p(""),
                                      tags$img(src="http://i.imgur.com/T7atVeM.png",width="856px",height="415px"),
                                      p(""),
                                      tags$li("The starting point of the spiral contains early day matches, where as the last point contains the latest match"),
                                      p(""),
                                      tags$img(src="http://i.imgur.com/eQycYSx.png",width="856px",height="415px"),
                                      p(""),
                                      tags$img(src="http://i.imgur.com/8MpGfcU.png",width="856px",height="415px")
                                    )
                                  )
                                )
                              )
                            )
                   
))
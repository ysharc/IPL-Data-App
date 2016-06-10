library(shiny)
library(leaflet)
library(htmltools)
library(ggplot2)
#%Read Data%
IPL = read.csv("input_data.csv")

#%Splitting it into subgroups%
chennai_wins <- IPL[which(IPL$Winner =='Chennai Super Kings'),]
Deccan_wins <- IPL[which(IPL$Winner =='Deccan Chargers'),]
Delhi_wins <- IPL[which(IPL$Winner =='Delhi Daredevils'),]
Punjab_wins <- IPL[which(IPL$Winner =='Kings XI Punjab'),]
kolkata_wins <- IPL[which(IPL$Winner =='Kolkata Knight Riders'),]
mumbai_wins <- IPL[which(IPL$Winner =='Mumbai Indians'),]
Rajasthan_wins <- IPL[which(IPL$Winner =='Rajasthan Royals'),]
Bangalore_wins <- IPL[which(IPL$Winner =='Royal Challengers Bangalore'),]
Hyderabad_wins <- IPL[which(IPL$Winner =='Sunrisers Hyderabad'),]
Gujarat_wins <- IPL[which(IPL$Winner =='Gujarat Lions'),]
Kochi_wins <- IPL[which(IPL$Winner =='Kochi Tuskers Kerala'),]
Pune_wins <- IPL[which(IPL$Winner =='Pune Warriors'),]
PuneGaints_wins <- IPL[which(IPL$Winner =='Rising Pune Supergiants'),]
Matches_that_tied <- IPL[which(IPL$Winner =='TIE'),]

#Creating Icons for each team
teamIcons <- iconList(
  csk = makeIcon("csk.png", iconWidth=36,iconHeight=36),
  dc = makeIcon("dc.png", iconWidth=36,iconHeight=36),
  dd = makeIcon("dd.png", iconWidth=36,iconHeight=36),
  gl = makeIcon("gl.png", iconWidth=36,iconHeight=36),
  kxp = makeIcon("kxp.png", iconWidth=36,iconHeight=36),
  ktk = makeIcon("ktk.png", iconWidth=36,iconHeight=36),
  kkr = makeIcon("kkr.png", iconWidth=36,iconHeight=36),
  mi = makeIcon("mi.png", iconWidth=36,iconHeight=36),
  pw = makeIcon("pw.png", iconWidth=36,iconHeight=36),
  rr = makeIcon("rr.png", iconWidth=36,iconHeight=36),
  rps = makeIcon("rps.png", iconWidth=36,iconHeight=36),
  rcb = makeIcon("rcb.png", iconWidth=36,iconHeight=36),
  sh = makeIcon("srh.png", iconWidth=36,iconHeight=36),
  t = makeIcon("draw.png", iconWidth=36,iconHeight=36)
)

shinyServer(function(input, output, session) {
  
  ##Stats Plot
  output$plot1 <- renderPlot({
    if(input$selection=="all"){
      qplot(IPL$Season,geom="bar",ylab="Wins",xlab="Season")
    }else{
      qplot(IPL[IPL$sf==input$selection,]$Season,geom="bar",ylab="Wins",xlab="Season")
    } 
  })  
  
  ##Most matches won at
  output$info <- renderText({
      if(input$selection=="all"){
        paste(IPL$venue[which.max(IPL$venue)])
      }else{
        paste(names(which.max(table(IPL[IPL$sf==input$selection,]$venue))))
      }
    })
  ## Interactive Map ###########################################
  
  # Create the map
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addProviderTiles("Esri.WorldGrayCanvas")%>%
      addMarkers(data=IPL,icon=~teamIcons[IPL$sf], group = "IPL",popup = ~htmlEscape(paste(Match,"***",date,"***","Winner: ",Winner)),clusterOptions = markerClusterOptions())
  })
  
  
  observe({
    proxy <- leafletProxy("map", data = IPL)
    
    # Remove any existing legend, and only if the legend is
    # enabled, create a new one.
    proxy %>% clearMarkers() %>% clearMarkerClusters()
    if (input$selection == "all") {
      
      proxy %>% 
        clearMarkers() %>% clearMarkerClusters() %>%
        addMarkers(data=IPL,icon=~teamIcons[IPL$sf], group = "IPL",popup = ~htmlEscape(paste(Match,"***",date,"***","Winner: ",Winner)),clusterOptions = markerClusterOptions())
    }else if (input$selection == "csk") {
      
      proxy %>% 
        clearMarkers() %>% clearMarkerClusters() %>%
        addMarkers(data=chennai_wins,icon=~teamIcons[chennai_wins$sf], group = "Chennai_wins",popup = ~htmlEscape(paste(Match,"***",date,"***","Winner: ",Winner)),clusterOptions = markerClusterOptions())
    }else if (input$selection == "dd") {
      
      proxy %>% 
        clearMarkers() %>% clearMarkerClusters() %>%
        addMarkers(data=Delhi_wins,icon=~teamIcons[Delhi_wins$sf], group = "Delhi_wins",popup = ~htmlEscape(paste(Match,"***",date,"***","Winner: ",Winner)),clusterOptions = markerClusterOptions())
    }else if (input$selection == "kxp") {
      
      proxy %>% 
        clearMarkers() %>% clearMarkerClusters() %>%
        addMarkers(data=Punjab_wins,icon=~teamIcons[Punjab_wins$sf], group = "Punjab_wins",popup = ~htmlEscape(paste(Match,"***",date,"***","Winner: ",Winner)),clusterOptions = markerClusterOptions())
    }else if (input$selection == "kkr") {
      
      proxy %>% 
        clearMarkers() %>% clearMarkerClusters() %>%
        addMarkers(data=kolkata_wins,icon=~teamIcons[kolkata_wins$sf], group = "Kolkata_wins",popup = ~htmlEscape(paste(Match,"***",date,"***","Winner: ",Winner)),clusterOptions = markerClusterOptions())
    }else if (input$selection == "mi") {
      
      proxy %>% 
        clearMarkers() %>% clearMarkerClusters() %>%
        addMarkers(data=mumbai_wins,icon=~teamIcons[mumbai_wins$sf], group = "Mumbai_wins",popup = ~htmlEscape(paste(Match,"***",date,"***","Winner: ",Winner)),clusterOptions = markerClusterOptions())
    }else if (input$selection == "dc") {
      
      proxy %>% 
        clearMarkers() %>% clearMarkerClusters() %>%
        addMarkers(data=Deccan_wins,icon=~teamIcons[Deccan_wins$sf], group = "Deccan_wins",popup = ~htmlEscape(paste(Match,"***",date,"***","Winner: ",Winner)),clusterOptions = markerClusterOptions())
    }else if (input$selection == "gl") {
      
      proxy %>% 
        clearMarkers() %>% clearMarkerClusters() %>%
        addMarkers(data=Gujarat_wins,icon=~teamIcons[Gujarat_wins$sf], group = "Gujarat_wins",popup = ~htmlEscape(paste(Match,"***",date,"***","Winner: ",Winner)),clusterOptions = markerClusterOptions())
    }else if (input$selection == "ktk") {
      
      proxy %>% 
        clearMarkers() %>% clearMarkerClusters() %>%
        addMarkers(data=Kochi_wins,icon=~teamIcons[Kochi_wins$sf], group = "Kochi_wins",popup = ~htmlEscape(paste(Match,"***",date,"***","Winner: ",Winner)),clusterOptions = markerClusterOptions())
    }else if (input$selection == "pw") {
      
      proxy %>% 
        clearMarkers() %>% clearMarkerClusters() %>%
        addMarkers(data=Pune_wins,icon=~teamIcons[Pune_wins$sf], group = "Pune_wins",popup = ~htmlEscape(paste(Match,"***",date,"***","Winner: ",Winner)),clusterOptions = markerClusterOptions())
    }else if (input$selection == "rps") {
      
      proxy %>% 
        clearMarkers() %>% clearMarkerClusters() %>%
        addMarkers(data=PuneGaints_wins,icon=~teamIcons[PuneGaints_wins$sf], group = "PuneGaints_wins",popup = ~htmlEscape(paste(Match,"***",date,"***","Winner: ",Winner)),clusterOptions = markerClusterOptions())
    }else if (input$selection == "sh") {
      
      proxy %>% 
        clearMarkers() %>% clearMarkerClusters() %>%
        addMarkers(data=Hyderabad_wins,icon=~teamIcons[Hyderabad_wins$sf], group = "Hyderabad_wins",popup = ~htmlEscape(paste(Match,"***",date,"***","Winner: ",Winner)),clusterOptions = markerClusterOptions())
    }else if (input$selection == "rr") {
      
      proxy %>% 
        clearMarkers() %>% clearMarkerClusters() %>%
        addMarkers(data=Rajasthan_wins,icon=~teamIcons[Rajasthan_wins$sf], group = "Rajasthan_wins",popup = ~htmlEscape(paste(Match,"***",date,"***","Winner: ",Winner)),clusterOptions = markerClusterOptions())
    }else if (input$selection == "rcb") {
      
      proxy %>% 
        clearMarkers() %>% clearMarkerClusters() %>%
        addMarkers(data=Bangalore_wins,icon=~teamIcons[Bangalore_wins$sf], group = "Bangalore_wins",popup = ~htmlEscape(paste(Match,"***",date,"***","Winner: ",Winner)),clusterOptions = markerClusterOptions())
    }else{
      
      proxy %>% 
        clearMarkers() %>% clearMarkerClusters() %>%
        addMarkers(data=Matches_that_tied,icon=~teamIcons[Matches_that_tied$sf], group = "Matches_that_tied",popup = ~htmlEscape(paste(Match,"***",date,"***","Winner: ",Winner)),clusterOptions = markerClusterOptions())
    }
  })
  
})

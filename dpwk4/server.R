library(shiny)
library(reshape)
library(dplyr)

# Define a server for the Shiny app
shinyServer(function(input, output) {
  
  # Fill in the spot we created for a plot
  output$polutionPlot <- renderPlot({
    
    airdata <- readRDS(file = url("https://raw.githubusercontent.com/anthonymacey/dp/master/dpwk4/airdata.rds"))
    
    #Validate the input day by getting the largest day for a given month
    selectday <- airdata[airdata$month==input$month, ]%>%
      group_by(month)%>% 
      summarise(day=max(day))
    
    selectday <- selectday$day
    
    if(input$day > selectday) {
      selectday <- selectday
    } else{
      selectday <- input$day
    }
    
    #Prepare data to plot
    daymonth <- cast(airdata[which(airdata$month == input$month &
                                                  airdata$day == selectday),], day ~ hour)
    
    daymonth$day <- NULL
    daymonth <- as.matrix(daymonth)
    
    #Plot data
    barplot(
      height = daymonth,
      main = paste("Hourly Data for ", selectday, "/", input$month, "/", "2017", sep =
                     ""),
      ylab = "NOX/PPB",
      xlab = "Hour",
      col = "Green"
    )
  })
})


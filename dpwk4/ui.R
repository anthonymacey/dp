# The data that this code uses us sourced from http://www.londonair.org.uk/ and is aggrigated as shown.
#
# library(lubridate)
# library(dplyr)
# 
# airdata <- read.csv(file = "https://raw.githubusercontent.com/anthonymacey/dp/master/dpwk4/airdata.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE)
# airdata$ReadingDateTime  <- as.POSIXct(airdata$ReadingDateTime, format = "%d/%m/%Y %H:%M")
# airdata$month <- month(airdata$ReadingDateTime)
# airdata$hour <- hour(airdata$ReadingDateTime)
# airdata$day <- day(airdata$ReadingDateTime)
# 
# airdata.no2 <- airdata[complete.cases(airdata), ]%>%
#   group_by(month, day, hour)%>% 
#   summarise(value=sum(Value))
# 
# saveRDS(airdata.no2, file = "airdata.rds", compress = "gzip")


ui <- fluidPage(
  
  # App title ----
  titlePanel("Oxides of Nitrogen (ppb) London Westminster 2017"),
  
  p("The data shows a summary of air quality from the London Air Quality Network (LAQN), and pollution for 3 Westminster sites (Oxford Street, Covent Garden & Marylebone Road)"),
  p("Select a day and month from the sliders to view an hourly summary of the data, it's the sum of 15 min averages for any given hour accross the three sites"),

  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar to demonstrate various slider options ----
    sidebarPanel(
      
      # Input: Month Selector
      sliderInput("month", "Month:",
                  min = 1, max = 12,
                  value = 1),
      
      # Input: Day Selector
      sliderInput("day", "Day:",
                  min = 1, max = 31,
                  value = 1)

    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      # Output: Table summarizing the values entered ----
      plotOutput("polutionPlot")  
      
    )
  )
)
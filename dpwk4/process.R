library(lubridate)
library(dplyr)

airdata <- read.csv(file = "https://raw.githubusercontent.com/anthonymacey/dp/master/dpwk4/airdata.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE)
airdata$ReadingDateTime  <- as.POSIXct(airdata$ReadingDateTime, format = "%d/%m/%Y %H:%M")
airdata$month <- month(airdata$ReadingDateTime)
airdata$hour <- hour(airdata$ReadingDateTime)
airdata$day <- day(airdata$ReadingDateTime)

airdata.no2 <- airdata[complete.cases(airdata), ]%>%
  group_by(month, day, hour)%>% 
  summarise(value=sum(Value))

saveRDS(airdata.no2, file = "airdata.rds", compress = "gzip")






## This set of functions installs the packages necessary to load
## a subset of data from the Household Power Consumption dataset,
## specifically records with Dates between February 1-2, 2007
## and loads the records into a data frame called twoDaysData.
## This code then plots a graph of Global Active Power over time
## and copies it to a PNG file titled 'plot2.png'.

install.packages(c("sqldf", "chron", "ggplot2", "lubridate")) ## install sqldf package
library(sqldf, chron, ggplot2, lubridate) ## load sqldf package

## read records with a Date on 2/1/2007 or 2/2/2007 into a data frame
fileName <- "household_power_consumption.txt" 
twoDaysData <- read.csv.sql(fileName, sql = 'select * from 
                            file where Date == "1/2/2007" or
                            Date == "2/2/2007"', header = TRUE, sep = ";") 
sqldf() ## close the connection

## convert characters to date and time formats and concatenate
## into a single DTTM date-time field
twoDaysData$DTTM <- as.POSIXct(paste(twoDaysData$Date, 
                                     twoDaysData$Time), 
                               format="%d/%m/%Y %H:%M:%S")


## plot the trend of Global Active Power over time
plot(twoDaysData$DTTM, twoDaysData$Global_active_power, 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power (kilowatts)")

## copy the plot into a .png file and close the png device
dev.copy(png, file = "plot2.png")
dev.off()
## This set of functions installs the packages necessary to load
## a subset of data from the Household Power Consumption dataset,
## specifically records with Dates between February 1-2, 2007
## and loads the records into a data frame called twoDaysData.
## This code then plots four graphs in a single view
## and copies it to a PNG file titled 'plot4.png'.

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

## create an empty plot which is 2 rows and 2 columns
par(mfrow = c(2,2))
        ## add the first plot to the chart: Global active power over time
        plot(twoDaysData$DTTM, twoDaysData$Global_active_power,
             ylab="Global Active Power", xlab="", type="l")
        
        ## add the second plot to the chart: voltage over time
        plot(twoDaysData$DTTM, twoDaysData$Voltage, 
             ylab="Voltage", xlab="datetime", type="l")
        
        ## add the third plot to the chart
        ## plot the trend of three Energy Sub Metering values over time
         plot(twoDaysData$DTTM, twoDaysData$Sub_metering_1, type="l", ylim=c(0,38),
              xlab="", ylab="Energy sub metering")
         par(new=T)
         plot(twoDaysData$DTTM, twoDaysData$Sub_metering_2, type="l", ylim=c(0,38),
              col="red", axes=F, xlab="", ylab="")
         par(new=T)
         plot(twoDaysData$DTTM, twoDaysData$Sub_metering_3, type="l", ylim=c(0,38),
              col="blue", axes=F, xlab="", ylab="")
         legend("topright", lwd = 1, pch = c(NA, NA, NA), col = c("black", "red", "blue"), 
                legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")
        
        ## add the fourth plot to the chart: Global reactive
        ## power over time
        plot(twoDaysData$DTTM, twoDaysData$Global_reactive_power, 
             ylab="Global_reactive_power", xlab="datetime", type="l")

## copy the plot into a .png file and close the png device
dev.copy(png, file = "plot4.png")
dev.off()
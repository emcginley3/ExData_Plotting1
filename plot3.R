## This set of functions installs the packages necessary to load
## a subset of data from the Household Power Consumption dataset,
## specifically records with Dates between February 1-2, 2007
## and loads the records into a data frame called twoDaysData.
## This code then plots a graph of three sub-metering values
## and copies it to a PNG file titled 'plot3.png'.

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

## plot the trend of three Energy Sub Metering values over time
plot(1, type="n", xlab="", ylab="Energy sub metering", ylim=c(0,38))
plot(twoDaysData$DTTM, twoDaysData$Sub_metering_1, type="l", ylim=c(0,38),
     xlab="", ylab="Energy sub metering")
par(new=T)
plot(twoDaysData$DTTM, twoDaysData$Sub_metering_2, type="l", ylim=c(0,38),
     col="red", axes=F, xlab="", ylab="")
par(new=T)
plot(twoDaysData$DTTM, twoDaysData$Sub_metering_3, type="l", ylim=c(0,38),
     col="blue", axes=F, xlab="", ylab="")

## add a legend with descriptions of each line and color
legend("topright", lwd = 1, pch = c(NA, NA, NA), col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## copy the plot into a .png file and close the png device
dev.copy(png, file = "plot3.png")
dev.off()
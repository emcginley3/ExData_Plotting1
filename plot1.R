## This set of functions installs the packages necessary to load
## a subset of data from the Household Power Consumption dataset,
## specifically records with Dates between February 1-2, 2007
## and loads the records into a data frame called twoDaysData.
## This code then plots a histogram of Global Active Power and
## copies it to a PNG file titled 'plot1.png'.

install.packages(c("sqldf", "chron", "ggplot2")) ## install sqldf package
library(sqldf, chron, ggplot2) ## load sqldf package

## read records with a Date on 2/1/2007 or 2/2/2007 into a data frame
fileName <- "household_power_consumption.txt" 
twoDaysData <- read.csv.sql(fileName, sql = 'select * from 
                            file where Date == "1/2/2007" or
                            Date == "2/2/2007"', header = TRUE, sep = ";") 
sqldf() ## close the connection

## convert characters to date and time formats
twoDaysData$Date <- as.Date(twoDaysData$Date, "%d/%m/%Y")
twoDaysData$Time <- chron(times=twoDaysData$Time)

## plot a histogram of Global Active Power with x-axis label,
## title, 12 breaks, and red bars
hist(twoDaysData$Global_active_power, breaks = 12, 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)",
     col = "red")

## copy the plot into a .png file and close the png device
dev.copy(png, file = "plot1.png")
dev.off()
## Plot1.r 
## To plot a histograph of global active power vs frequency
## output: plot1.png 
## Date: 08/11/2014 


## Set working directory and load necessary libiraries
setwd("./ExData_Plotting1")
library(data.table)

## Read input data file

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="householdpower.zip")
unzip("householdpower.zip")
tempData <- fread("household_power_consumption.txt")


## Set Date field to Date format
tempData$Date <- as.Date(tempData$Date, format="%d/%m/%Y")

## Filter only the dates required into a data frame
plotData <- data.frame(tempData[tempData$Date=="2007-02-01" | tempData$Date=="2007-02-02"])

#plotData <- data.frame(plotData)

## Set numeric fields to numeric format
for(i in c(3:9)) 
{
        plotData[,i] <- as.numeric(as.character(plotData[,i]))
}

# Create Date_Time variable and set date/time format
plotData$Date_Time <- paste(plotData$Date, plotData$Time)
plotData$Date_Time <- strptime(plotData$Date_Time, format="%Y-%m-%d %H:%M:%S")

## Create histograph
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "white")
par(mar = c(6, 6, 5, 4))
hist(plotData$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
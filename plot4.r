## Plot4.r 
## To plot 4 different charts: 
## Chart 1 (top left): Day vs Global Active Power
## Chart 2 (top right): Datetime vs Voltage
## Chart 3 (bottom left): Day vs Energy Sub Meterings
## Chart 4 (bottom right): Day vs Global Reactive Power 
## output: plot4.png
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

## plot graph
png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "white")
par(mfrow = c(2, 2), mar = c(14, 6, 2, 2), cex=.5)

## Chart 1
plot(plotData$Date_Time, plotData$Global_active_power, xaxt=NULL, xlab = "", ylab = "Global Active Power", type="n")
lines(plotData$Date_Time, plotData$Global_active_power, type="S")

## Chart 2
plot(plotData$Date_Time, plotData$Voltage, xaxt=NULL, xlab = "datetime", ylab = "Voltage", type="n")
lines(plotData$Date_Time, plotData$Voltage, type="S")

## Chart 3
plot(plotData$Date_Time, plotData$Sub_metering_1, xaxt=NULL, xlab = "", ylab = "Energy sub metering", type="n")
lines(plotData$Date_Time, plotData$Sub_metering_1, col = "black", type = "S")
lines(plotData$Date_Time, plotData$Sub_metering_2, col = "red", type = "S")
lines(plotData$Date_Time, plotData$Sub_metering_3, col = "blue", type = "S")
legend("topright", bty = "n", lty = c(1, 1), lwd = c(1, 1, 1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Chart 4
plot(plotData$Date_Time, plotData$Global_reactive_power, xaxt=NULL, xlab = "datetime", ylab = "Global_reactive_power", type="n")
lines(plotData$Date_Time, plotData$Global_reactive_power, type="S")

dev.off()
# This file contains code for:
#     1. Reading the data of Individual Household Electric Power Consumption Data Set from "household_power_consumption.txt" 
#        File URL: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#     2. merge and convert Date and Time columns into one column "full_time".
#     3. subseet the data using only data from the dates 2007-02-01 and 2007-02-02.
#     4. producing line graph for "Date_full" and Global_actve_power"
#     5. and export the graph to plot2.png file.


# Load "household_power_consumption.txt" data into R
powerData <- read.table(file = "household_power_consumption.txt", 
                        header = TRUE, sep = ";", na.strings = "?",
                        nrows = 2075259, comment.char = "")

# Merge and convert Date and Time columns into one column "full_time"
powerData$Date_full <- strptime(paste(powerData$Date, powerData$Time), 
                                "%d/%m/%Y%H:%M:%S")

# Subseet powerData using only data from the dates 2007-02-01 and 2007-02-02.
powerDataSubset <- subset(powerData, 
                          powerData$Date_full <= "2007-02-02 23:59:59" & 
                                powerData$Date_full >= "2007-02-01 00:00:00", 
                          select = c(-1, -2))

# Open graphic device (PNG file)
png(file = "plot2.png", height = 480, width = 480)

# Plot a line graph for "Date_full" and Global_actve_power" 
plot(x = powerDataSubset$Date_full, 
     y = powerDataSubset$Global_active_power,
     ylab = "Glocal Active Power (kilowatts)", 
     xlab = "", 
     type = "l")

# close graphic device (PNG file)
dev.off() 
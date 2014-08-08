## Read file:
powerData <- read.table(file = "household_power_consumption.txt", 
                        header = TRUE, sep = ";", na.strings = "?",
                        nrows = 2075259, comment.char = "")

## Merge and convert Date and Time columns into one column full_time
powerData$Date_full <- strptime(paste(powerData$Date, powerData$Time), "%d/%m/%Y%H:%M:%S")

## Subseet powerData using only data from the dates 2007-02-01 and 2007-02-02.
powerDataSubset <- subset(powerData, 
                          powerData$Date_full <= "2007-02-02 23:59:59" & 
                                powerData$Date_full >= "2007-02-01 00:00:00", 
                          select = c(-1, -2))

# Open graphic device
png(file = "plot3.png", height = 480, width = 480)

plot(x = powerDataSubset$Date_full,
     y = powerDataSubset$Sub_metering_1,
     col = 'black',
     type = "l",
     xlab = "", 
     ylab = "Energy sub metering")

points(x = powerDataSubset$Date_full,
       y = powerDataSubset$Sub_metering_2,
       col = "red",
       type = "l")

points(x = powerDataSubset$Date_full,
       y = powerDataSubset$Sub_metering_3,
       col = "blue",
       type = "l")

legend("topright", 
       lty = 1, lwd = 2, 
       col = c("black", "red", "blue"), 
       legend = c("Sub_mettering_1", "Sub_mettering_2", "Sub_mettering_3"))

# close to png file:
dev.off() 
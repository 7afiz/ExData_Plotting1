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
png(file = "plot4.png", height = 480, width = 480)

# Create a four paneled plotting windows
par(mfrow = (c(2, 2)))

# Plot a line graph for "Date_full" and Global_actve_power" (locaiton: top left)
plot(x = powerDataSubset$Date_full, 
     y = powerDataSubset$Global_active_power,
     ylab = "Glocal Active Power", 
     xlab = "", 
     type = "l")

# Plot a line graph for "Date_full" and "Voltage" (locaiton: top right)
plot(x = powerDataSubset$Date_full, 
     y = powerDataSubset$Voltage,
     ylab = "Voltage", 
     xlab = "datetimte", 
     type = "l")

# Plot a line graph for "Date_full" and "Sub_metering_1", "Sub_metering_2" and "Sub_metering_3" (locaiton: bottom left)
# "Date_full" and "Sub_metering_1"

plot(x = powerDataSubset$Date_full,
     y = powerDataSubset$Sub_metering_1,
     col = 'black',
     type = "l",
     xlab = "", 
     ylab = "Energy sub metering")

# "Date_full" and "Sub_metering_2",
points(x = powerDataSubset$Date_full,
       y = powerDataSubset$Sub_metering_2,
       col = "red",
       type = "l")

# "Date_full" and "Sub_metering_3",
points(x = powerDataSubset$Date_full,
       y = powerDataSubset$Sub_metering_3,
       col = "blue",
       type = "l")

# Add the legend
legend("topright", 
       lty = 1, lwd = 1, 
       bty = "n",
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Plot a line graph for "Date_full" and "Global_reactive_power" (locaiton: bottom right)
plot(x = powerDataSubset$Date_full, 
     y = powerDataSubset$Global_reactive_power,
     ylab = "Glocal_reactive_power", 
     xlab = "datetime", 
     type = "l")

# close graphic device (PNG file)
dev.off() 
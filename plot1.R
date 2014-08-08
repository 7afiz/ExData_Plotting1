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

# Open graphic device
png(file = "plot1.png", height = 480, width = 480)

# Plot a histogram for "Global_actve_power" 
hist(powerDataSubset$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (Kilowattts)", 
     ylab = "Frequency")

# close graphic device (PNG)
dev.off()
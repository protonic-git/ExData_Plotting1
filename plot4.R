##### Data Acquisition & Handling #####
# Data Source
dataSrc <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# Temporary file to store data
dataFile <- tempfile()
# Pulling in data
download.file(dataSrc, dataFile)
# Unzipping and reading in data
data <- read.table(unz(dataFile, "household_power_consumption.txt"), header = TRUE, sep = ";")
unlink(dataFile)

# Cleaning/Handling Data
cleanData <- data[data$Date=="1/2/2007" | data$Date=="2/2/2007",]
cleanData$datetime <- paste(cleanData$Date, cleanData$Time, sep = "-")
cleanData$datetime <- as.POSIXct(cleanData$datetime, format = "%d/%m/%Y-%H:%M:%S")

##### Plotting #####
# Save Image
png("plot4.png", width = 480, height = 480)

# Plot overall
par(mfrow = c(2,2))

# Plot first
plot(cleanData$datetime, cleanData$Global_active_power, 
     type = "l", xlab = "", xaxt = "n",
     ylab = "Global Active Power (kilowatts)"
)
# Relabel axis
marks <- c(min(cleanData$datetime), median(cleanData$datetime)+60, max(cleanData$datetime)+60)
axis(1, at = marks, labels = weekdays(marks))

# Plot second
plot(cleanData$datetime, cleanData$Voltage, type = "l",
     xlab = "datetime", xaxt = "n", ylab = "Voltage"
     )
# Relabel axis
axis(1, at = marks, labels = weekdays(marks))

# Plot third
plot(cleanData$datetime, cleanData$Sub_metering_1, col = "black",
     type = "l", xaxt = "n", 
     ylab = "Energy sub metering", xlab = ""
)
lines(cleanData$datetime, cleanData$Sub_metering_2, col = "red")
lines(cleanData$datetime, cleanData$Sub_metering_3, col = "blue")
# Legend
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c('black','red','blue'), lty = 1
)
# Relabel axis
axis(1, at = marks, labels = weekdays(marks))

# Plot fourth
plot(cleanData$datetime, cleanData$Global_reactive_power, type = "l",
     xlab = "datetime", xaxt = "n", ylab = "Global Reactive Power"
     )
# Relabel axis
axis(1, at = marks, labels = weekdays(marks))

# Complete Image Save
dev.off()

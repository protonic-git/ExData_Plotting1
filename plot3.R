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
cleanData$compDate <- paste(cleanData$Date, cleanData$Time, sep = "-")
cleanData$compDate <- as.POSIXct(cleanData$compDate, format = "%d/%m/%Y-%H:%M:%S")

##### Plotting #####
# Save Image
png("plot3.png", width = 480, height = 480)
# Plot
plot(cleanData$compDate, cleanData$Sub_metering_1, col = "black",
     type = "l", xaxt = "n", 
     ylab = "Energy sub metering", xlab = ""
     )
lines(cleanData$compDate, cleanData$Sub_metering_2, col = "red")
lines(cleanData$compDate, cleanData$Sub_metering_3, col = "blue")
# Legend
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c('black','red','blue'), lty = 1
       )
# Relabel axis
marks <- c(min(cleanData$compDate), median(cleanData$compDate)+60, max(cleanData$compDate)+60)
axis(1, at = marks, labels = weekdays(marks))
# Complete Image Save
dev.off()

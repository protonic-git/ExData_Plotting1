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

##### Plotting #####
# Save Image
png("plot1.png", width = 480, height = 480)
# Plot
hist(as.numeric(cleanData$Global_active_power), 
     col = 'red', 
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)"
     )
# Complete Image Save
dev.off()

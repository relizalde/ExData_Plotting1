## Steps 1 to 4 are the same for all plots
# 1. Loading the data
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
originalData <- read.table(unz(temp, "household_power_consumption.txt"), header=TRUE, sep=";")
unlink(temp)

# 2. Subsetting the data
originalData$Date <- as.Date(originalData$Date, format="%d/%m/%Y")
plotData <- subset(originalData, Date >= as.Date("2007-02-01") & Date <= as.Date('2007-02-02'))

# 3. Changing data types so values can be plot properly
# Converting to numeric vales
plotData$Global_active_power <- as.numeric(as.character(plotData$Global_active_power))
plotData$Global_reactive_power <- as.numeric(as.character(plotData$Global_reactive_power))
plotData$Voltage <- as.numeric(as.character(plotData$Voltage))
plotData$Global_intensity <- as.numeric(as.character(plotData$Global_intensity))
plotData$Sub_metering_1 <- as.numeric(as.character(plotData$Sub_metering_1))
plotData$Sub_metering_2 <- as.numeric(as.character(plotData$Sub_metering_2))
plotData$Sub_metering_3 <- as.numeric(as.character(plotData$Sub_metering_3))

## 4. Adding a column with Date+Time values
plotData["DateTime"] <- NA
plotData$DateTime <- strptime(paste(as.character(plotData$Date),plotData$Time, sep=" "),"%Y-%m-%d %H:%M:%S")

## 5. Energy sub-metering plot
## Making Plot 3
# Setting properties for the file where the plot will be saved
png("plot3.png", width = 480, height = 480)

plot(plotData$DateTime, plotData$Sub_metering_1, xlab="", ylab="Energy sub metering", type="l")
points(plotData$DateTime, plotData$Sub_metering_2, xlab="", type="l", col="Red")
points(plotData$DateTime, plotData$Sub_metering_3, xlab="", type="l", col="Blue")
legend("topright",lty=c(1,1,1), col=c("black","red","blue"),
       legend=names(plotData[,7:9]))

dev.off() ## Close the PNG device
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

## 5. Multiplots
## Making Plot 4
# Setting properties for the file where the plot will be saved
png("plot4.png", width = 480, height = 480)

par(mfrow = c(2,2)) ## Creates a 2 by 2 plotting area

## Primer cuadrante
plot(plotData$DateTime, plotData$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="l")

## Segundo cuadrante
plot(plotData$DateTime, plotData$Voltage, xlab="datetime", ylab="Voltage", type="l")

## Tercer cuadrante
plot(plotData$DateTime, plotData$Sub_metering_1, xlab="", ylab="Energy sub metering", type="l")
points(plotData$DateTime, plotData$Sub_metering_2, xlab="", type="l", col="Red")
points(plotData$DateTime, plotData$Sub_metering_3, xlab="", type="l", col="Blue")
legend("topright",lty=c(1,1,1), col=c("black","red","blue"), legend=names(myData[,7:9]),bty = "n")

## Cuarto cuadrante
plot(plotData$DateTime, plotData$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="l")

dev.off() ## Close the PNG device
## Loading the data
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)

myData <- read.table(unz(temp, "household_power_consumption.txt"), header=TRUE, sep=";")
unlink(temp)

## Subsetting the data
myData[,1] <- as.Date(myData[,1], format="%d/%m/%Y")
myData <- subset(myData, Date < as.Date("2007-2-3") & Date > as.Date('2007-1-31'))

## Adding a column with Date+Time values
myData["DateTime"] <- NA
myData$DateTime <- strptime(paste(as.character(myData$Date),myData$Time, sep=" "),"%Y-%m-%d %H:%M:%S")

## Convert columns 3 to 9 in numeric values
myData[,3] <- as.numeric(as.character(myData[,3]))
myData[,4] <- as.numeric(as.character(myData[,4]))
myData[,5] <- as.numeric(as.character(myData[,5]))
myData[,6] <- as.numeric(as.character(myData[,6]))
myData[,7] <- as.numeric(as.character(myData[,7]))
myData[,8] <- as.numeric(as.character(myData[,8]))
myData[,9] <- as.numeric(as.character(myData[,9]))

## Making Plot 4
png("plot4.png", width = 480, height = 480)

par(mfrow = c(2,2)) ## Creates a 2 by 2 plotting area

## Primer cuadrante
plot(myData$DateTime, myData[,3], xlab="", ylab="Global Active Power (kilowatts)", type="l")

## Segundo cuadrante
plot(myData$DateTime, myData[,5], xlab="datetime", ylab="Voltage", type="l")

## Tercer cuadrante
plot(myData$DateTime, myData[,7], xlab="", ylab="Energy sub metering", type="l")
points(myData$DateTime, myData[,8], xlab="", type="l", col="Red")
points(myData$DateTime, myData[,9], xlab="", type="l", col="Blue")
legend("topright",lty=c(1,1,1), col=c("black","red","blue"), legend=names(myData[,7:9]),bty = "n")

## Cuarto cuadrante
plot(myData$DateTime, myData[,4], xlab="datetime", ylab="Global_reactive_power", type="l")

dev.off() ## Close the PNG device
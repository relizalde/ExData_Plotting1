## Loading the data
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)

myData <- read.table(unz(temp, "household_power_consumption.txt"), header=TRUE, sep=";")
unlink(temp)

## Subsetting the data
myData[,1] <- as.Date(myData[,1], format="%d/%m/%Y")
myData <- subset(myData, Date < as.Date("2007-2-3") & Date > as.Date('2007-1-31'))

## Convert column 3 in numeric values
myData[,3] <- as.numeric(as.character(myData[,3]))

## Making Plot 1

png("plot1.png", width = 480, height = 480)

hist(myData[,3], col="Red", xlab="Global Active Power (kilowatts)", 
     main="Global Active Power", xlim=c(0,6), ylim=c(0,1200))

dev.off() ## Close the PNG device
## plot4.R 

## description of file
## This script uses UC Irvine Machine Learning Repository 
## Individual household electric power consumption Data Set
##
## The script reads all of the data from the file into R 
## The data from 2007-02-01 and 2007-02-02 is the subset 
## A histogram of Global Active Power (kilowatts) against frequency
## is created and saves as a PNG file with name plot1.png

## start of script

## read text file into R 
data <- read.table("household_power_consumption.txt", header=T, sep=";", na.strings="?")

## Subset the two dates we want to explore
validdates <- c("1/2/2007", "2/2/2007")
powerdata <- subset(data, Date %in% validdates)

# Create a new datetime variable
powerdata$datetime <- paste(powerdata$Date, powerdata$Time)

# Convert the datetime string to Date
powerdata$datetime <- strptime(powerdata$datetime, "%d/%m/%Y %R")

## Open the PNG graphic device (for mac)
## set file name
png("plot4.png",type="quartz")

# Set plot grid to 2 rows by 2 columns 
par(mfrow=(c(2,2)))

# Create initial plot - Global Active Power over time (topleft)
# set y axis label and set x axis to "" to remove default
plot(powerdata$datetime, powerdata$Global_active_power, type="l",
     ylab="Global Active Power", xlab="")

# Create initial plot - Voltage over time (topright)
# set y and x axis labels
plot(powerdata$datetime, powerdata$Voltage, type="l",
     ylab="Voltage", xlab="datetime")

# Create initial plot - Energy sub metering over time (bottomleft)
plot(powerdata$datetime, powerdata$Sub_metering_1, type="l",
     ylab="Energy sub metering", xlab="")

# Add line for Sub_metering_2 data
# set colour to red
lines(powerdata$datetime, powerdata$Sub_metering_2, type="l", col="red")

# Add line for Sub_metering_3 data
# set colour to blue
lines(powerdata$datetime, powerdata$Sub_metering_3, type="l", col="blue")

# Add Legend to Energy sub metering over time
# set relevant colours
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"), lwd=1, bty="n")

# Create initial plot - Global reactive power over time (bottomright)
# set y and x axis labels
plot(powerdata$datetime, powerdata$Global_reactive_power, type="l",
     ylab="Global_reactive_power", xlab="datetime")

# Close the device and create the PNG file
dev.off()

# end of script

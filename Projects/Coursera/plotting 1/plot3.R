## plot3.R 

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
png("plot3.png",type="quartz")

# Create the initial plot for Sub_metering_1
# set type to l
# label y axis, create null value for x axis to remove default
plot(powerdata$datetime, powerdata$Sub_metering_1, type="l",
     ylab="Energy sub metering", xlab="")

# Add lines for Sub_metering_2 data
lines(powerdata$datetime, powerdata$Sub_metering_2, type="l", col="red")

# Add lines Sub_metering_3 data
lines(powerdata$datetime, powerdata$Sub_metering_3, type="l", col="blue")

# Add Legend at top right
# set relevant colours and line weight
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"), lwd=1)

# Close the device and create the PNG file
dev.off()

# end of script
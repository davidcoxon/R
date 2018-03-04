## plot1.R 
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

## Open the PNG graphic device (for mac)
## set file name
png("plot1.png",type="quartz")

## Create initial histogram
## set main title and X axis label
## set colour to red
hist(powerdata$Global_active_power, main="Global Active Power",
                                     xlab="Global Active Power (kilowatts)",
                                     col="red") #red colour to red

## Create the PNG file and close the device
dev.off()

## end of script
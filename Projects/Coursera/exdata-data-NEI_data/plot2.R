## title: exploratory data analysis assignment 2 : plot 1
## author: david coxon
## date: 24/7/14

## code notes:
## I have include all of the code i used to to arrive at
## this plot including the code used to take some initial
## looks at the data that informed my decisions on which plots to use
## I have remark this code out so that it doesn't run.

## skip down to the bottom to 'create tidy plot' section to see 
## the code used spicifically to create the final plot if you wish.

## description: Plot 2 of Coursera Exploratory Data Analysis, Project 2 
## question: Have total emissions from PM2.5 decreased in the 
## Baltimore City, Maryland (fips == "24510") from 1999 to 2008?
## Use the base plotting system to make a plot answering this
## question.
## Criteria: you will need to make a single plot. Unless specified,
## you can use any plotting system in R to make your plot.
## approach: Separate the data into years, sum the data for each year and
## compare the sums of annual data.
## assumptions: That the Data for each year is complete, that the data is
## comparible, that there have been no changes in the way the data is
## collected or reported, that is no duplication between sources and there
## is no significant corruption within the data.

## load data
pmdata <- readRDS("summarySCC_PM25.rds")
pmclassification<- readRDS("Source_Classification_Code.rds")

## initial look at data
## dim(pmdata) #check number of columns and rows of data
## colnames(pmdata) #check column names
## head(pmdata) #look at first few lines of data
## summary(pmdata$Emissions) #look at averages

## tidy data
## separate out Baltimore City data
pm_bc <- subset(pmdata,fips == "24510")
## split data into years
pm99 <- subset(pm_bc,year == "1999")
pm02 <- subset(pm_bc,year == "2002")
pm05 <- subset(pm_bc,year == "2005")
pm08 <- subset(pm_bc,year == "2008")

##  separate out pm25 emissions column
pm99.emissions <-pm99$Emissions
pm02.emissions <-pm02$Emissions
pm05.emissions <-pm05$Emissions
pm08.emissions <-pm08$Emissions


## create dataframe containing subs of annual emissions
annualtotals<- c(sum(pm99.emissions),sum(pm02.emissions),sum(pm05.emissions),sum(pm08.emissions))

## initial look at data for individual years (repeat for each year)
## dim(pm99) #see how many rows of data there are
## summary(pm99) #look at a summary of the data
## tpm99 #see what the total emissions are for the year

## do some rough plots to see how data looks

## boxplot of log of individual emissions
## boxplot(log(pm99.emissions),log(pm02.emissions),log(pm05.emissions),log(pm08.emissions))
## this is a nice plot showing the mean pm25 emissions 1999-2008 are falling
## but the question specifically asks about total emissions which may be different

## boxplot of total emissions
## boxplot(sum(pm99.emissions),sum(pm02.emissions),sum(pm05.emissions),sum(pm08.emissions))
## this shows the total emissions falling 

## barplot of emissions
## barplot(table(pmdata$Emissions),col="Blue")
## this show each of the individual emissions

## grid od histograms of annual emissions
## par(mfrow=c(4,1),mar=c(4,4,2,1))
## hist(tpm99, col="red")
## hist(tpm02, col="yellow")
## hist(tpm05, col="green")
## hist(tpm08, col="blue")
## this is probably the best illustration of the decreasing pm25
## emissions however the question specifies a single plot and technically
## this is 4 plots. #note: need to make x-axis a standard length

## bar chart of annual emissions 
## requires a new dataFrame to be created with subs of emissions 
barplot(annualtotals,main="Total PM2.5 emissions in USA 1999-2008")
## label columns
names(annualtotals)[1]<-paste("1999")
names(annualtotals)[2]<-paste("2002")
names(annualtotals)[3]<-paste("2005")
names(annualtotals)[4]<-paste("2008")

## tidy plot
## set graphics device
png(file = "plot2.png",width = 680, height = 480)
## set number of digits before switching to scientific number notation
options(scipen=11)
## create plot
barplot(annualtotals,col=c("red","blue","red","blue"))
## set margins
par(mar=c(5,10,4,4))
## Add Labels
## axis labels
title(main="Total Annual PM2.5 emissions in Baltimore City 1999-2008",las=1,xlab="Year",ylab="PM[2.5] Emmisions",col="red")
## close graphics device
dev.off()

## Thank you for grading this project!
## End of File
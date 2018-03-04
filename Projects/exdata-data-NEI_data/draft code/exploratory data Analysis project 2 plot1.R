## title: exploratory data analysis assignment 2 : plot 1
## author: david coxon
## date: 24/7/14

## notes: remarked code
## I am going to include all of the code i used to to arrive at
## this plot including the code used to take some initial
## looks at the data that informed my decisions on what plots to use
## I will of course remark this code out so that it doesn't run.

## skip down to the bottom to 'create tidy plot' section to see 
## the code used spicifically to create the final plot if you wish.

## description: 
## question: Have total emissions from PM2.5 decreased in the United States
## from 1999 to 2008? Using the base plotting system, make a plot showing
## the total PM2.5 emission from all sources for each of the years 1999,
## 2002, 2005, and 2008.
## Criteria: you will need to make a single plot. Unless specified,
## you can use any plotting system in R to make your plot.
## approach:
## assumptions:

## load data
pmdata <- readRDS("summarySCC_PM25.rds")
pmclassification<- readRDS("Source_Classification_Code.rds")

## initial look at data
## dim(pmdata) #check number of columns and rows of data
## colnames(pmdata) #check column names
## head(pmdata) #look at first few lines of data
## yearx <- unique(pmdata$year) #yet unique years
## check unique years
## summary(pmdata$Emissions) #look at averages


## tidy data
## separate data into years
pm99 <- subset(pmdata,year == "1999")
pm02 <- subset(pmdata,year == "2002")
pm05 <- subset(pmdata,year == "2005")
pm08 <- subset(pmdata,year == "2008")
## get total for each year
tpm99 <-sum(pm99[4])
tpm02 <-sum(pm02[4])
tpm05 <-sum(pm05[4])
tpm08 <-sum(pm08[4])
##  separate out pm25 emissions column
pm99.emissions <-pm99$Emissions
pm02.emissions <-pm02$Emissions
pm05.emissions <-pm05$Emissions
pm08.emissions <-pm08$Emissions
str(pm99.emissions)
str(pm02.emissions)
str(pm05.emissions)
str(pm08.emissions)

## initial look at data for individual years (repeat for each year)
dim(pm99)
summary(pm99)
tpm99

## do some rough plots to see how data looks
## barplot of emissions
barplot(table(pmdata$Emissions),col="Blue")
## boxplot of log of individual emissions
boxplot(log(pm99.emissions),log(pm02.emissions),log(pm05.emissions),log(pm08.emissions))
## boxplot of total emissions
boxplot(tpm99,tpm02,tpm05,tpm08)
## vertical histograms of total emissions
> par(mfrow=c(4,1),mar=c(4,4,2,1))
> hist(tpm99, col="red")
> hist(tpm02, col="yellow")
> hist(tpm05, col="green")
> hist(tpm08, col="blue")
#note: need to make x-axis a standard length

## create tidy plot

## End of File

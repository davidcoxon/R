## title: exploratory data analysis assignment 2 : plot 6
## author: david coxon
## date: 24/7/14

## code notes:
## I have include all of the code i used to to arrive at
## this plot including the code used to take some initial
## looks at the data that informed my decisions on which plots to use
## I have remark this code out so that it doesn't run.

## skip down to the bottom to 'create tidy plot' section to see 
## the code used spicifically to create the final plot if you wish.

## description: Plot 6 of Coursera Exploratory Data Analysis, Project 2 
## question: Compare emissions from motor vehicle sources in Baltimore City
## with emissions from motor vehicle sources in Los Angeles County,
## California (fips == "06037"). Which city has seen greater
## changes over time in motor vehicle emissions?
## Criteria: you will need to make a single plot. Unless specified,
## you can use any plotting system in R to make your plot.
## approach: issolate data from los angeles and baltimore city,
## separate motor vehicle emissions from total emissions, calculate and
## compare changes in average valves over the 10 year period.
## system:given that we are comparing several variables it is
## likely that ggplot2 will be the best plotting tool to use. 
## assumptions: That the Data for each year is complete, that the data is
## comparible, that there have been no changes in the way the data is
## collected or reported, that is no duplication between sources and there
## is no significant corruption within the data.

## load data
pmdata <- readRDS("summarySCC_PM25.rds")
pmclassification<- readRDS("Source_Classification_Code.rds")

## tidy data
## separate out motor emisions
onroad <- subset(pmdata,type == "ON-ROAD")
nonroad <- subset(pmdata,type == "NON-ROAD")

## separate out Baltimore City data
pm_bc <- subset(pmdata,fips == "24510")
## separate out Baltimore City data
pm_la <- subset(pmdata,fips == "06037")

## split bc data into years
pm_bc_99 <- subset(pm_bc,year == "1999")
pm_bc_02 <- subset(pm_bc,year == "2002")
pm_bc_05 <- subset(pm_bc,year == "2005")
pm_bc_08 <- subset(pm_bc,year == "2008")

## split la data into years
pm_la_99 <- subset(pm_la,year == "1999")
pm_la_02 <- subset(pm_la,year == "2002")
pm_la_05 <- subset(pm_la,year == "2005")
pm_la_08 <- subset(pm_la,year == "2008")

## take an initial look at the data
## look at numbers of records
## dim(pmdata) #number of records in entire dataset
## dim(pm_bc) #number of records in entire dataset
## dim(pm_la) #number of records in entire dataset
## dim(pm_bc) #number of records in entire dataset

## initial observations
## la has more that 4 times the records of BC so
## it would be difficult to look at sums of records
## better look at averages



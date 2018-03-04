## title: exploratory data analysis assignment 2 : plot 3
## author: david coxon
## date: 24/7/14

## code notes:
## I have include all of the code i used to to arrive at
## this plot including the code used to take some initial
## looks at the data that informed my decisions on which plots to use
## I have remark this code out so that it doesn't run.

## skip down to the bottom to 'create tidy plot' section to see 
## the code used spicifically to create the final plot if you wish.

## description: Plot 3 of Coursera Exploratory Data Analysis, Project 2 
## question: Of the four types of sources indicated by the type
## (point, nonpoint, onroad, nonroad) variable, which of these four
## sources have seen decreases in emissions from 1999–2008 for
## Baltimore City? Which have seen increases in emissions from
## 1999–2008? Use the ggplot2 plotting system to make a plot answer
## this question.
## Criteria: you will need to make a single plot. Unless specified,
## you can use any plotting system in R to make your plot.
## approach: Separate out the data for Baltamore City,  split the
## data by source and year, compare the sum the data for each source by
## year.
## assumptions: That the Data for each year is complete, that the data is
## comparible, that there have been no changes in the way the data is
## collected or reported, that is no duplication between sources and there
## is no significant corruption within the data.

## load ggplot2 library
library(ggplot2)

## load data
pmdata <- readRDS("summarySCC_PM25.rds")
pmclassification<- readRDS("Source_Classification_Code.rds")

## initial look at data
## dim(pmdata) #check number of columns and rows of data
## colnames(pmdata) #check column names
## summary(pmdata$Emissions) #look at averages
## head(pmdata) #look at first few lines of data

## tidy data
## separate out Baltimore City data
pm_bc <- subset(pmdata,fips == "24510")

## factorize year #avoids intervening years being shown in plots
pm_bc$year <- factor(pm_bc$year,levels=c(1999,2002,2005,2008),labels=c("1999","2001","2005","2008"))

## separate out 1999 and 2008 data from Baltimore City data
pm_bc_compare <- subset(pm_bc,(year == "1999"|year == "2008"))

## get total emmisions per year by type
pm_bc_emissions_aggr <- aggregate(Emissions ~ year + type,data=pm_bc,FUN=sum)

## initial look at tidy data
dim(pm_bc)
summary(pm_bc$Emissions)

## initial look at summed data
head(pm_bc_emissions_aggr)

## initial observations of tidy data
summary(subset(pm99_bc$Emissions,type == "POINT"))
summary(subset(pm08_bc$Emissions,type == "POINT"))
summary(subset(pm99_bc$Emissions,type == "NONPOINT"))
summary(subset(pm08_bc$Emissions,type == "NONPOINT"))
summary(subset(pm99_bc$Emissions,type == "ON-ROAD"))
summary(subset(pm08_bc$Emissions,type == "ON-ROAD"))
summary(subset(pm99_bc$Emissions,type == "NON-ROAD"))
summary(subset(pm08_bc$Emissions,type == "NON-ROAD"))
## initial observations of tidy data
## 2008 emissions seem to have fallen from 1999 emissions for most
## types of emmision, with point having decreased most significantly
## non point emissions have increased marginally

## do some rough plots to see how data looks using ggplot2

## basic scatter year on year plot by type
## qplot(year,Emissions,data=pm_bc,fill=type)
## indicated overall fall in emissions but hard to see individual types
## basic density plot by type
## qplot(Emissions,data=pm_bc,col=type,geom=c("density"))
## can't see values clearly try log10 of emissions
## qplot(log10(Emissions),data=pm_bc,col=type,geom=c("density"))
## shows emission types clearly now need to bring in years
## qplot(log10(Emissions),data=pm_bc,col=type,geom=c("density"),facets=.~year)
## shows comparisons but is cluttered with all 4 years
## need to remove 2002 and 2005 from output
## qplot(log10(Emissions),data=pm_bc_compare,col=type,geom=c("density"),facets=.~year)
## this graph should provide a reasonable answer to the question it
## shows a side by side comparison of each type of emission by year
## qplot(log10(Emissions),data=pm_bc_compare,col=type,fill=type,alpha=I(.33),geom="density", main="PM2.5 Emissions in Baltimore City 1999 v 2008", xlab="log 10(pm2.5 Emmisions g/m3)", ylab="density",facets=.~year)
## although i loved this plot it involved comparing area rather than height
## and may have been a little miss leading if not read correctly.
## try a bar chart by type and year - needs a new aggregate data frame creating
## ggplot(pm_bc_emissions_aggr, aes(x=factor(year), y=Emissions, fill=type)) + geom_bar(stat="identity") + facet_grid(. ~ type)
## this is probably the clearest graph showing falls in all types but point.
## could add lm projection.

## tidy plot
## set graphics device
png(file = "plot3.png",width = 680, height = 480)
## create plot
ggplot(pm_bc_emissions_aggr, aes(x=year, y=Emissions, fill=type)) +
geom_bar(stat="identity") + facet_grid(. ~ type) + xlab("year") + ylab(expression("Total PM"[2.5]*" Emission")) +
ggtitle(expression("PM"[2.5]*paste(" Emissions in Baltimore ","City by source type", sep="")))
## close graphics device
dev.off()

## Thank you for grading this project!
## End of File
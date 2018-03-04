## title: exploratory data analysis assignment 2 : plot 5
## author: david coxon
## date: 24/7/14

## code notes:
## I have include all of the code i used to to arrive at
## this plot including the code used to take some initial
## looks at the data that informed my decisions on which plots to use
## I have remark this code out so that it doesn't run.

## skip down to the bottom to 'create tidy plot' section to see 
## the code used spicifically to create the final plot if you wish.

## description: Plot 5 of Coursera Exploratory Data Analysis, Project 2 
## question: How have emissions from motor vehicle sources changed
## from 1999–2008 in Baltimore City?
## Criteria: you will need to make a single plot. Unless specified,
## you can use any plotting system in R to make your plot.
## approach: issolate data from baltimore city,
## separate motor vehicle emissions from total emissions look at
## changes in valves over the 10 year period.
## system:given that we are comparing several variables it is
## likely that ggplot2 will be the best plotting tool to use. 
## assumptions: That the Data for each year is complete, that the data is
## comparible, that there have been no changes in the way the data is
## collected or reported, that is no duplication between sources and there
## is no significant corruption within the data.

## load data
pmdata <- readRDS("summarySCC_PM25.rds")
## pmclassification<- readRDS("Source_Classification_Code.rds")

## load library
library(ggplot2)

## factorize year #avoids intervening years being shown in plots
pmdata$year <- factor(pmdata$year,levels=c(1999,2002,2005,2008),labels=c("1999","2001","2005","2008"))

## extract relevant subsets of data
## separate out Baltimore City data
pm_bc <- subset(pmdata,fips == "24510")
## separate out motor emisions
pm_bc_onroad <- subset(pm_bc,type == "ON-ROAD")

## take an initial look at subsets
## dim(pm_bc)
## dim(pm_bc_onroad)
## head(pm_bc_onroad)
## summary(subset(pm_bc_onroad,year == "1999"))
## summary(subset(pm_bc_onroad,year == "2008"))
## the data appears to be as expected
## there appear to be a lot more observations in 2008
## that in 1999 about 1/3 more, the mean, min and max
## are all down

## produce datasets
pm_bc_onroad_sum <- aggregate(Emissions ~ year, pm_bc_onroad, FUN=sum)
## pm_bc_onroad_avg <- aggregate(Emissions ~ year, pm_bc_onroad, FUN=mean)

## produce roughplots
## create a blogplot of emissions
## qplot(year,Emissions,data=pm_bc_onroad,geom=c("boxplot","smooth"),se=FALSE)
## box plot shows decrease but is very bottom heavy try log10
## qplot(year,log10(Emissions),data=pm_bc_onroad,geom=c("boxplot","point"))
## log boxplot shows points and shows decrease but not as clerly as data suggests
## produce bar chart of sum of data
## ggplot(pm_bc_onroad_sum, aes(x=factor(year), y=Emissions)) + geom_bar(stat="identity")
## ggplot(pm_bc_onroad_avg, aes(x=factor(year), y=Emissions)) + geom_bar(stat="identity")
## both total and average graphs show significant drops
## total may gives a truer indication of pm2.5 levels
## uses a dataset with totals therefore Lm difficult

## create tidy plot
## set graphics device
png(file = "plot2.png",width = 680, height = 420)
## create plot
ggplot(pm_bc_onroad_sum, aes(x=factor(year), y=Emissions,fill=year,col=year, alpha=1/2)) + geom_bar(stat="identity") + theme_bw() + theme(legend.position = "none") +
  +     xlab("year") + ylab(expression("Total PM"[2.5]*" emissions")) +  ggtitle(expression("Total PM"[2.5]*" Emissions from Motor Vehicle Sources in Baltimore City"))
## close graphics device
dev.off()

## Thank you for grading this project!
## End of File
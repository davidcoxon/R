## title: exploratory data analysis assignment 2 : plot 4
## author: david coxon
## date: 24/7/14

## code notes:
## I have include all of the code i used to to arrive at
## this plot including the code used to take some initial
## looks at the data that informed my decisions on which plots to use
## I have remark this code out so that it doesn't run.

## skip down to the bottom to 'create tidy plot' section to see 
## the code used spicifically to create the final plot if you wish.

## description: Plot 4 of Coursera Exploratory Data Analysis, Project 2 
## question: Across the United States, how have emissions from coal
## combustion-related sources changed from 1999–2008?
## Criteria: you will need to make a single plot. Unless specified,
## you can use any plotting system in R to make your plot.
## approach: find all sources related to coal combustion,
## Separate out the data from coal combustion-related sources
## sum emissions by year and look at changes.
## assumptions: That the Data for each year is complete, that the data is
## comparible, that there have been no changes in the way the data is
## collected or reported, that is no duplication between sources and there
## is no significant corruption within the data.

## load data
pmdata <- readRDS("summarySCC_PM25.rds")
pmclassification<- readRDS("Source_Classification_Code.rds")

## factorize year #avoids intervening years being shown in plots
pmdata$year <- factor(pmdata$year,levels=c(1999,2002,2005,2008),labels=c("1999","2001","2005","2008"))

## load library
library(ggplot2)

## get required data
## get coal combustion-related sources
coal.combustion <- grepl("Fuel Comb.*Coal", pmclassification$EI.Sector)
coal.combustion.sources <- pmclassification[coal.combustion,]

# get emissions from coal combustion-related sources
pm.emissions <- pmdata[(pmdata$SCC %in% combustion.coal.sources$SCC), ]

# create dataset grouped by year
pm.emissions.byyear <- aggregate(Emissions ~ year, data=pm.emissions, FUN=sum)

## check data sets
## dim(coal.combustion)
## head(coal.combustion)
## dim(coal.combustion.sources)
## head(coal.combustion.sources)
## dim(pm.emissions)
## head(pm.emissions)
## dim(pm.emissions.byyear)
## head(pm.emissions.byyear)

## generate rouge plots
## total emisions by year as points
## qplot(year,Emissions,data=pm.emissions.byyear,geom = c("point", "line"), colour = year,size=4)
## shows required results but looks very weak graphically try bar chart
## bar chart emissons by year 
## ggplot(pm.emissions.byyear, aes(x=year, y=Emissions)) +geom_bar(stat="identity")
## shows required results and looks better graphically

## generate tidy plot
## supress mathmatical notation for numbers
options(scipen=11)
## set graphics device
png(file = "plot4.png",width = 680, height = 420)
ggplot(pm.emissions.byyear, aes(x=year, y=Emissions,fill=year,col=year)) + theme_bw() + + geom_bar(stat="identity") + scale_fill_brewer() + scale_color_grey() + xlab("year") + ylab(expression("Total PM"[2.5]*" Emissions")) +  ggtitle("PM2.5 Emissions from Coal Combustion-related Sources in USA 1999-2008")
## close graphics device
dev.off()
## Thank you for grading this project!
## End of File


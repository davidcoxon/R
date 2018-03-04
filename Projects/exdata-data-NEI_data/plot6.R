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
## assumptions: Assuming that 'motor vehicle sources' refers to 
## the on-road figures and that we do not have to factor in any of
## non-road numbers with include recreational vehicles etc.
## also assuming the Data for each year is complete, that the data is
## comparible between cities, that there have been no changes in the way
## the data is collected or reported, that is no duplication between
## sources and there is no significant corruption within the data.

## load data
pmdata <- readRDS("summarySCC_PM25.rds")
## pmclassification<- readRDS("Source_Classification_Code.rds")

## load library
library (ggplot2)

## factorize year #avoids intervening years being shown in plots
pmdata$year <- factor(pmdata$year,levels=c(1999,2002,2005,2008),labels=c("1999","2001","2005","2008"))

## tidy data
## separate out motor emisions
onroad <- subset(pmdata,type == "ON-ROAD")

## separate out Baltimore City data
pm_bc_or <- subset(onroad,fips == "24510")
## separate out LA data
pm_la_or <- subset(onroad,fips == "06037")
## combine Baltimore City and LA data
pm_comparison<- rbind(pm_bc_or,pm_la_or)
## replace fips codes with city names
pm_comparison$fips[which(pm_comparison$fips == "24510")] <- "Baltimore City"
pm_comparison$fips[which(pm_comparison$fips == "06037")] <- "Los Angeles County"
## replace fips fieldname with cities
names(pm_comparison)[1] <- "Cities"

## take an initial look at the data
## check dimensions of raw data versus on-road data
## dim(pmdata)
## dim(onroad)
## check dimensions of individual cities onroad data 
## dim(pm_bc_or)
## dim(pm_la_or)
## check dimensions of combined cities onroad  data 
## dim(pm_combined)
## head(pm_combined)
## check summary of emissions for 2 cities
## summary(pm_bc_or$Emissions)
## summary(pm_la_or$Emissions)

## initial observations
## while there are actually less observations for LA than Baltimore
## LA has higher emissions
## While many areas show a gradual decrease in emissions over the
## 10 year period LA seems to rise until 2005 before starting to
## decline in 2008.

## produce some rough plots
ggplot(pm_comparison, aes(x=year, y=Emissions, fill=County)) + geom_bar(stat="identity") + facet_grid(County  ~ ., scales="free")
## shows the differing pm2.5 levels but its difficult to see extent due to different scales
ggplot(pm_comparison, aes(x = year, y = Emissions, fill = Cities)) + geom_bar(stat = "identity", position = position_dodge()) + ggtitle(expression("Total PM"[2.5]*" Emissions from Motor Vehicle Sources in Baltimore City versus Los Angeles"))+ ylab(expression("Total PM"[2.5]*" emissions"))
## shows 
ggplot(pm_comparison, aes(x = year, y = Emissions, fill = Cities)) + geom_bar(stat = "identity")
## shows both baltimore and La trends cleanly as well as difference in scale of pm2.5

## generate tidy plot
## supress mathmatical notation for numbers
options(scipen=11)
## Custom Palette
colours <- c("#0B6138", "#9AFE2E", "#D92121", "#21D921", "#FFFF4D", "#FF9326")
## set graphics device
png(file = "plot2.png",width = 680, height = 420)
## create plot
ggplot(pm_comparison, aes(x = year, y = Emissions, fill = Cities)) + geom_bar(stat = "identity") + scale_fill_manual (values=colours) + ggtitle(expression("Total PM"[2.5]*" Emissions from Motor Vehicle Sources in Baltimore City versus Los Angeles"))+ ylab(expression("Total PM"[2.5]*" emissions"))
## close graphics device
dev.off()

## Thank you for grading this project!
## End of File

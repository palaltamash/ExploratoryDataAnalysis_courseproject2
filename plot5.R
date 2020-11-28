##Downloading data

library(ggplot2)

url <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
filename <- "exdata_data_NEI_data"

if(!file.exists(filename))
{
  download.file(url, destfile = filename)
  unzip(filename)
}


##Reading Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Years array
years <- unique(NEI$year)

##Subsetting by ON-ROAD source
motordata <- subset(NEI, type == "ON-ROAD")

##aggregating by year

aggregateEmissions <- aggregate(Emissions ~ year, motordata, sum)


##Making the plot
g <- ggplot(aggregateEmissions, aes(factor(year), Emissions))
g + geom_bar(stat = "identity")  +
  labs(x = "Years", y = "Emissions", title = "Emissions from MotorVehicles")


dev.copy(png, file = "plot5.png")
dev.off()

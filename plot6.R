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

##Subsetting by ON-ROAD source & LosAngeles + Baltimore 
motordata <- subset(NEI, type == "ON-ROAD" & 
                      (fips == "24510" |fips == "06037"))

##aggregating by year
aggregateEmissions <- aggregate(Emissions ~ year + fips, motordata, sum)


##Making the plot
g <- ggplot(aggregateEmissions, aes(factor(year), Emissions))
g + geom_bar(stat = "identity")  + facet_grid(.~fips)
  labs(x = "Years", y = "Emissions", title = "Emissions from MotorVehicles
       in Baltimore and LosAngeles")


dev.copy(png, file = "plot6.png")
dev.off()

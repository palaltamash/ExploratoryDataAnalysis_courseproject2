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

##Subsetting baltimore data
baltimore <- subset(NEI, fips == "24510")


##Making the plot
g <- ggplot(baltimore, aes(factor(year), Emissions))
g + geom_bar(stat = "identity") + facet_grid(.~type) +
  labs(x = "Years", y = "Emissions", title = "Emissions in Baltimore")


dev.copy(png, file = "plot3.png")
dev.off()

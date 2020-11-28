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

NEI <- merge(NEI,SCC, by = "SCC")
##Years array
years <- unique(NEI$year)

##Subsetting Level.One by "comb" and Level.Three by "coal" (from discussion 
## forums)
combVector <- grepl(pattern = "comb", SCC$SCC.Level.One, ignore.case = FALSE)
coalVector <- grepl(pattern = "Coal", SCC$SCC.Level.Three, ignore.case = FALSE)
coaldata <- NEI[combVector | coalVector, ]

##aggregating by year

aggregateEmissions <- aggregate(Emissions ~ year, coaldata, sum)


##Making the plot
g <- ggplot(aggregateEmissions, aes(factor(year), Emissions))
g + geom_bar(stat = "identity")  +
  labs(x = "Years", y = "Emissions", title = "Emissions from Coal Sources")


dev.copy(png, file = "plot4.png")
dev.off()

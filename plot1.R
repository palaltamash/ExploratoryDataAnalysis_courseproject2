##Downloading data

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

##Subsetting each year's data
data_1999 <- subset(NEI, year == 1999)
data_2002 <- subset(NEI, year == 2002)
data_2005 <- subset(NEI, year == 2005)
data_2008 <- subset(NEI, year == 2008)

##Calculating total emissions and storing in a array
totalemissions <- numeric(length = 4)

totalemissions[1] <- sum(data_1999$Emissions)
totalemissions[2] <- sum(data_2002$Emissions)
totalemissions[3] <- sum(data_2005$Emissions)
totalemissions[4] <- sum(data_2008$Emissions)

##Making the plot
barplot(totalemissions, names = years, xlab = "Years", ylab = "Total Emissions",
        main = "Total emissions in US per year")
dev.copy(png, file = "plot1.png")
dev.off()

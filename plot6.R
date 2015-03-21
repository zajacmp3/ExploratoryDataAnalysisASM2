#Read Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Merge data & filter autos data
merged <- merge(NEI, SCC[,c(1,4)], by.x = "SCC", by.y = "SCC", all.x = TRUE)
merged$EI.Sector <- as.character(merged$EI.Sector)
merged <- merged[grep("Vehicle", merged$EI.Sector),]

#Calculate sum of emissions per year in Baltimore & Los Angeles County
agg <- aggregate(Emissions ~ year * fips, data = merged[merged$fips == "24510" | merged$fips == "06037",], FUN = sum)
agg$fips[agg$fips == "24510"] <- "Baltimore"
agg$fips[agg$fips == "06037"] <- "Los Angeles"

#make plot
library(ggplot2)
qplot(data = agg, x = agg$year, y = agg$Emissions, facets=.~fips, geom = c("line"), main = "PM2.5 Emissions in Baltimore & Los Angeles County from motor vehicle sources", xlab = "Year", ylab = "Emissions")

#save plot
dev.copy(device = png, file = "plot6.png", width = 480, height = 480)
dev.off()
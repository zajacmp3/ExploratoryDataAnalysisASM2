#Read Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Merge data
merged <- merge(NEI, SCC[,c(1,4)], by.x = "SCC", by.y = "SCC", all.x = TRUE)
merged$EI.Sector <- as.character(merged$EI.Sector)
#Filter
filtered <- merged[grep("Vehicle", merged$EI.Sector),]

#Calculate sum of emissions per year in Baltimore
agg <- aggregate(Emissions ~ year, data = filtered[filtered$fips == "24510",], FUN = sum)

#make plot
library(ggplot2)
qplot(data = agg, x = agg$year, y = agg$Emissions, geom = c("line"), main = "PM2.5 Emissions in Baltimore from motor vehicle sources", xlab = "Year", ylab = "Emissions")

#save plot
dev.copy(device = png, file = "plot5.png", width = 480, height = 480)
dev.off()
#Read Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Merge data & filter coal data
merged <- merge(NEI, SCC[,c(1,3)], by.x = "SCC", by.y = "SCC", all.x = TRUE)
merged$Short.Name <- as.character(merged$Short.Name)
#Filter
filtered <- merged[grep("Coal", merged$Short.Name),]

#Calculate sum of emissions per year in United States
agg <- aggregate(Emissions ~ year, data = filtered, FUN = sum)

#make plot
library(ggplot2)
qplot(data = agg, x = agg$year, y = agg$Emissions, geom = c("line"), main = "PM2.5 Emissions in US from coal sources", xlab = "Year", ylab = "Emissions")

#save plot
dev.copy(device = png, file = "plot4.png", width = 480, height = 480)
dev.off()
#Read Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Calculate sum of emissions per year in Baltimore
agg <- aggregate(Emissions ~ year, data = NEI[NEI$fips == "24510",], FUN = sum)

#make plot
plot(agg$year, agg$Emissions, type = "l", xlab = "Year", ylab = "PM2.5 Emissions in tons", main = "Baltimore PM2.5 Pollution")

#save plot
dev.copy(device = png, file = "plot2.png", width = 480, height = 480)
dev.off()
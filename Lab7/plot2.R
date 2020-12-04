NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

data <- subset(aggregate(Emissions ~ fips + year, NEI, sum), fips == "24510")

png("plot2.png", width = 480, height = 480)
plot(data$year, data$Emissions,type = "l")
dev.off()

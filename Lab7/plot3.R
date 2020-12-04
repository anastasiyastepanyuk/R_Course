NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

data <- subset(aggregate(Emissions ~ fips + type + year, NEI, sum), fips == "24510")

library(ggplot2)
png("plot3.png", width = 480, height = 480)
qplot(x = year, y = Emissions, data = data, facets = . ~ type, geom = c("point", "line"))
dev.off()

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

data <- aggregate(Emissions ~ year, NEI, sum)
format(data$Emissions, scientific = FALSE)

png("plot1.png", width = 480, height = 480)
plot(data, type = "l")
dev.off()

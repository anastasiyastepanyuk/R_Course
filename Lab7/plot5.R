NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

mv <- merge(NEI, SCC[grep("Vehicle", SCC$SCC.Level.Three, ignore.case = T),], by = "SCC")
data <- aggregate(Emissions ~ year, subset(mv, fips == "24510"), sum)

png("plot5.png", width = 480, height = 480)
plot(data, type = "l")
dev.off()

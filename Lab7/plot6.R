NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

mr <- merge(NEI, SCC[grep("Vehicle", SCC$SCC.Level.Three, ignore.case = T), ], by = "SCC")
data <- aggregate(Emissions ~ fips + year, subset(mr, fips == "24510" | fips == "06037"), sum)

png("plot6.png", width = 480, height = 480)
ggplot(data, aes(year, Emissions))+geom_line(aes(color=fips))+geom_point(aes(color=fips))
dev.off()

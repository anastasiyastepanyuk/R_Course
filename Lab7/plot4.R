NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

l1 <- SCC[grep("comb", SCC$SCC.Level.One, ignore.case = T),]
l4 <- SCC[grep("coal", SCC$SCC.Level.Four, ignore.case = T),]
comb <- merge(NEI, merge(l1, l4))
data <- aggregate(Emissions ~ year, comb, sum)

png("plot4.png", width = 480, height = 480)
plot(sumsbyyear, type = "l")
dev.off()

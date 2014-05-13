NEI <- readRDS("summarySCC_PM25.rds")

NEIdt <- data.table(NEI)
#Grouping by year
emissions <- NEIdt[,list(emm=sum(Emissions)), by=list(fips, year)]
emissions <- emissions[emissions$fips=="24510",]
#Plotting
png("plot2.png")
plot(emissions$emm, type="l", ylab="Total PM2.5 Emissions (Baltimore)", xlab="years", x=emissions$year)
dev.off()
NEI <- readRDS("summarySCC_PM25.rds")

NEIdt <- data.table(NEI)
#Grouping by year
emissions <- NEIdt[,list(emm=sum(Emissions)), by=list(year)]

#Plotting
png("plot1.png")
plot(emissions$emm, type="l", ylab="Total PM2.5 Emissions", xlab="years", x=emissions$year)
dev.off()




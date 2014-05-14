library(ggplot2)
library(data.table)
NEI <- readRDS("summarySCC_PM25.rds")

NEIdt <- data.table(NEI)
#Grouping by year
emissions <- NEIdt[,list(Emmissions=sum(Emissions)), by=list(fips, year, type)]
emissions <- emissions[emissions$fips=="24510",]
#Plotting


p <- qplot(year, Emmissions, data=emissions, color=type,geom  =	c("point",	"smooth"))
p <- p + ggtitle("Emissions for Baltimore City by type of source")
ggsave(filename="plot3.png", plot=p)

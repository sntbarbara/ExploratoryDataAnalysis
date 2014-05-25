

library(ggplot2)
library(data.table)
library(sqldf)

SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")


SCC.coal.codes <- sqldf("select SCC from SCC where EI_Sector like '%vehicle%' group by SCC")$SCC
print(head(SCC.coal.codes))

NEIdt <- data.table(NEI)

#Filter data only by SCC from motor vehicles
NEIdt <- NEIdt[NEIdt$SCC %in% SCC.coal.codes,]

NEIdt <- NEIdt[NEIdt$fips %in% c("24510","06037"),]
#Grouping by year
emissions <- NEIdt[,list(Emmissions=sum(Emissions)), by=list(year, fips)]

#Plotting
p <- qplot(year, Emmissions, data=emissions,color=fips) + geom_line()
p <- p + ggtitle("Baltimore (24510) vs Los Angeles (06037)")
ggsave(filename="plot6.png", plot=p)
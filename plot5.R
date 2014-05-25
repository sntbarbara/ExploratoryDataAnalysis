

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

NEIdt <- NEIdt[NEIdt$fips=="24510",]
print(head(NEIdt))
#Grouping by year
emissions <- NEIdt[,list(Emmissions=sum(Emissions)), by=list(year)]

#Plotting
p <- qplot(year, Emmissions, data=emissions) + geom_line()
p <- p + ggtitle("Emissions from motor veh. in BaltimoreCity")
ggsave(filename="plot5.png", plot=p)
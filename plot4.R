library(ggplot2)
library(data.table)
library(sqldf)

SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

SCC.coal.codes <- sqldf("select SCC from SCC where Short_Name like '%coal%' group by SCC")$SCC

NEIdt <- data.table(NEI)

NEIdt <- NEIdt[NEIdt$SCC %in% SCC.coal.codes,]
#Grouping by year
emissions <- NEIdt[,list(Emmissions=sum(Emissions)), by=list(year)]

#Plotting
p <- qplot(year, Emmissions, data=emissions) + geom_line()
p <- p + ggtitle("Emissions from combustion coal")
ggsave(filename="plot4.png", plot=p)
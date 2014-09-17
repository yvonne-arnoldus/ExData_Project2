run <-function()
{
    source("ImportData.R")
    baltimore_city <- subset(NEI, fips == "24510", select = c(year, Emissions) )
    data <- aggregate(Emissions~year, baltimore_city, sum)
    print(data)
    barplot(data$Emission, beside=T, main="Total emissions in Baltimore City", xlab = "years", ylab = "Emission", names.arg = c("1999", "2002", "2005", "2008") )
    png("figure/plot2.png", width = 480, height = 480, bg="transparent")
    barplot(data$Emission, beside=T, main="Total emissions in Baltimore City", xlab = "years", ylab = "Emission", names.arg = c("1999", "2002", "2005", "2008") )
    dev.off()
}
run <-function()
{
    source("ImportData.R")
    data <- aggregate(Emissions~year, NEI, sum)
    print(data)
    barplot(data$Emission, beside=T, main="Total emissions in the United States", xlab = "years", ylab = "Emission", names.arg = c("1999", "2002", "2005", "2008") )
    png("figure/plot1.png", width = 480, height = 480, bg="transparent")
    barplot(data$Emission, beside=T, main="Total emissions in the United States", xlab = "years", ylab = "Emission", names.arg = c("1999", "2002", "2005", "2008") )
    dev.off()
}
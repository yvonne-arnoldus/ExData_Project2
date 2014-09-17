run <-function()
{
    # Import rds files to dataframes NEI and SCC
    source("ImportData.R")
    
    # Subset the data for only data for Baltimore city
    baltimore_city <- subset(NEI, fips == "24510", select = c(year, Emissions) )
    
    # create a sum of the emission, the total emission per year
    data <- aggregate(Emissions~year, baltimore_city, sum)
    
    # print total emissions
    print(data)
    
    # plot as barplot
    barplot(data$Emission, beside=T, main="Total emissions in Baltimore City", xlab = "years", ylab = "Emission", names.arg = c("1999", "2002", "2005", "2008") )
    
    # save barplot is png
    png("figure/plot2.png", width = 480, height = 480, bg="transparent")
    barplot(data$Emission, beside=T, main="Total emissions in Baltimore City", xlab = "years", ylab = "Emission", names.arg = c("1999", "2002", "2005", "2008") )
    dev.off()
}
run <-function()
{
    # Import rds files to dataframes NEI and SCC
    source("ImportData.R")
    
    # create a sum of the emission, the total emission
    data <- aggregate(Emissions~year, NEI, sum)
    
    # print total emissions
    print(data)
    
    # plot as barplot
    barplot(data$Emission, beside=T, main="Total emissions in the United States", xlab = "years", ylab = "Emission", names.arg = c("1999", "2002", "2005", "2008") )
    
    # save barplot as png
    png("figure/plot1.png", width = 480, height = 480, bg="transparent")
    barplot(data$Emission, beside=T, main="Total emissions in the United States", xlab = "years", ylab = "Emission", names.arg = c("1999", "2002", "2005", "2008") )
    dev.off()
}
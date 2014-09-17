run <-function()  {
    
    # import ggplot library
    library(ggplot2)
    
    # Import rds files to dataframes NEI and SCC
    source("ImportData.R")
    
    # Subset the data for only data for Baltimore city
    baltimore_city <- subset(NEI, fips == "24510", select = c(year, type, Emissions) )
    
    # create a sum of the emission, the total emission per year and type
    data <- aggregate(Emissions~year+type, baltimore_city, sum)
    
    # print total emissions
    print(data)
    
    # plot as barplot
    plot <- ggplot(data=data, aes(x=factor(year), y=Emissions, fill=type))
    plot <- plot + geom_bar(stat="identity", position="dodge")
    plot <- plot + xlab("years") + ylab("Emission") + ggtitle("Total emissions in Baltimore City per emission type")
    print(plot)
    
    # save barplot is png
    png("figure/plot3.png", width = 480, height = 480, bg="transparent")
    print(plot)
    dev.off()
}
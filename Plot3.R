run <-function()  {
    library(ggplot2)
    
    source("ImportData.R")
    
    baltimore_city <- subset(NEI, fips == "24510", select = c(year, type, Emissions) )
    data <- aggregate(Emissions~year+type, baltimore_city, sum)
    print(data)
    
    plot <- ggplot(data=data, aes(x=factor(year), y=Emissions, fill=type))
    plot <- plot + geom_bar(stat="identity", position="dodge")
    plot <- plot + xlab("years") + ylab("Emission") + ggtitle("Total emissions in Baltimore City per emission type")
    plot
    
    png("figure/plot3.png", width = 480, height = 480, bg="transparent")
    print(plot)
    dev.off()
}
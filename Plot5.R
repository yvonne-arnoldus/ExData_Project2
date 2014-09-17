run <-function()  {
    
    # import ggplot library
    library(ggplot2)
    
    # Import rds files to dataframes NEI and SCC
    source("ImportData.R")
    
    # Subset the data for only data for Baltimore city where type is ON-ROAD
    baltimore_city_onroad <- subset(NEI, fips == "24510" & type == "ON-ROAD", select = c(year, type, SCC, Emissions) )
    
    # I've search the column 'EI.Sector' in SCC for the word mobile to anwser 
    # this question
    mobile <- subset(SCC, grepl("mobile", EI.Sector, ignore.case=TRUE), select=c(SCC,EI.Sector))
    
    # merge the found SCC with the word mobile with the on-road data from Balitmore city
    merged.data <- merge(baltimore_city_onroad,mobile, by.x="SCC", by.y="SCC", all.x=FALSE)
    
    # create a sum of the emission, the total emission per year per mobile sector
    data <- aggregate(Emissions~year+EI.Sector, merged.data, sum)
    
    # print total emissions
    print(data)
    
    # plot as barplot
    plot <- ggplot(data=data, aes(x=factor(year), y=Emissions, fill=EI.Sector))
    plot <- plot + geom_bar(stat="identity", position="dodge")
    plot <- plot + xlab("years") + ylab("Emission") + ggtitle("Emission of mobile vehicles in Baltimore City")
    print(plot)
    
    # save barplot as png
    png("figure/plot5.png", width = 480, height = 480, bg="transparent")
    print(plot)
    dev.off()       
}
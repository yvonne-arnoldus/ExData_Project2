run <-function()
{
    # Import rds files to dataframes NEI and SCC
    source("ImportData.R")
    
    # I've search the column 'EI.Sector' in SCC for the word coal to anwser 
    # this question
    coal <- subset(SCC, grepl("coal", EI.Sector, ignore.case=TRUE), select=c(SCC,EI.Sector))
    
    # merge the found SCC with the word coal with the data
    merged.data <- merge(NEI,coal, by.x="SCC", by.y="SCC", all.x=FALSE)
    
    # create a sum of the emission, the total emission per year
    data <- aggregate(Emissions~year+EI.Sector, merged.data, sum)
    
    # print total emissions
    print(data)
    
    # plot as barplot
    plot <- ggplot(data=data, aes(x=factor(year), y=Emissions, fill=EI.Sector))
    plot <- plot + geom_bar(stat="identity", position="dodge")
    plot <- plot + xlab("years") + ylab("Emission") + ggtitle("Coal combustion-related emission in the US")
    plot
    
    # save barplot as png
    png("figure/plot4.png", width = 480, height = 480, bg="transparent")
    print(plot)
    dev.off()    

}
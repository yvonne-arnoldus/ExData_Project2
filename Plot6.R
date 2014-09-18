run <-function()  {
    
    # import ggplot library
    library(ggplot2)
    
    # Import rds files to dataframes NEI and SCC
    source("ImportData.R")
    
    # Subset the data for only data for Baltimore city or Los Angeles County and where type is ON-ROAD
    baltimore_city_or_los_angeles_county_onroad <- subset(NEI, ( fips == "06037" | fips == "24510" ) & type == "ON-ROAD", select = c(year, type, SCC, fips, Emissions) )
    
    # I've search the column 'EI.Sector' in SCC for the word mobile to anwser 
    # this question
    mobile <- subset(SCC, grepl("mobile", EI.Sector, ignore.case=TRUE), select=c(SCC,EI.Sector))
    
    # merge the found SCC with the word mobile with the on-road data from Baltimore city & Los Angeles County
    merged_data <- merge(baltimore_city_or_los_angeles_county_onroad,mobile, by.x="SCC", by.y="SCC", all.x=FALSE)
    
    # create a sum of the emission, the total emission per year per mobile sector for Baltimore city or Los Angeles County
    data <- aggregate(Emissions~year+fips+EI.Sector, merged_data, sum)
    
    # Sort data to calculate Diff
    data_sorted <- data[with(data, order(fips,EI.Sector,year)), ]
    
    # calculate difference in Emission from previous year
    for (i in 1:nrow(data_sorted)){
        
        #previous row
        j = i-1
        
        # row 1 is always 0
        if (i == 1) {
            data_sorted$Emissions.DiffPercentage[i] = 0
        } # calculate the difference in emmission cause we have the same sector and the same county
        else if ( data_sorted$EI.Sector[i] == data_sorted$EI.Sector[j] && data_sorted$fips[i] == data_sorted$fips[j] ) {
            data_sorted$Emissions.DiffPercentage[i] = -((data_sorted$Emissions[j] - data_sorted$Emissions[i])/data_sorted$Emissions[j]) * 100
        } # can't compare emissions cause not the same sector or the same county
        else {
            data_sorted$Emissions.DiffPercentage[i] = 0
        }
            
            
    }
    
    # print total emissions
    print(data_sorted)
    
    # plot as barplot
    plot <- ggplot(data=data_sorted, aes(x=factor(year), y=Emissions.DiffPercentage, fill=fips))
    plot <- plot + facet_wrap(~ EI.Sector, ncol=1)
    plot <- plot + geom_bar(stat="identity", position="dodge")
    plot <- plot + xlab("years") + ylab("Emission") + ggtitle("% difference in Emission of mobile vehicles compaired to the year before")
    plot <- plot + scale_fill_discrete(name="County",labels=c("Los Angeles County","Baltimore city"))
    print(plot)
    
    # save barplot as png
    png("figure/plot6.png", width = 680, height = 680, bg="transparent")
    print(plot)
    dev.off() 
}
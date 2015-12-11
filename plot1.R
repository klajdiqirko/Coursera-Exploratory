install.packages("dplyr")
columnsclass <- c('character', 'character', 'numeric', 'numeric',
                 'numeric', 'numeric', 'numeric', 'numeric', 'numeric')
power_cons <- read.table('house_power_cons.txt', sep = ';', header = TRUE,
                         colClasses = columnsclass, na.strings = '?')
# adding another column with Date Time togetther so that we can change it to
# POSIXct format. (Since R adds years when you want to change only time which is really stupid!!)
power_cons <- mutate(power_cons, Date_Time = paste(Date, Time, sep = " "))
# removing the Date, Time character columns.
power_cons <- select(power_cons, 3:10))
#Changing the format to Date/Time format.
power_cons$Date_Time <- strptime(power_cons$Date_Time, "%d/%m/%Y %H:%M:%S")
#subsetting the data to include only rows from 2007-02-01 to 2007-02-02.
Feb2007_power_cons <- subset(power_cons, 
                             Date_Time >= "2007-02-01 00:00:00" & 
                             Date_Time < "2007-02-03 00:00:00" )
# creating the first plot
with(Feb2007_power_cons, hist(Global_active_power, col = "red",
                              xlab = "Global Active Power (kilowatts)",
                              main = "Global Active Power"))
dev.copy(png, file = "plot1.png")
dev.off()
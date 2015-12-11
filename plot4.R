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
png(file = "plot4.png")
par(mfrow = c(2,2))
with(Feb2007_power_cons,{plot(Date_Time, Global_active_power, type = "l",
                              xlab = "", ylab = "Global Active Power", main = "")
                         plot(Date_Time, Voltage, type = "l",
                              xlab = "datetime", ylab = "Voltage", main = "")
with(Feb2007_power_cons, plot(Date_Time, Sub_metering_1, type = "n",
                              xlab = "",
                              ylab = "Energy sub metering", main = ""))
with(Feb2007_power_cons, lines(Date_Time, Sub_metering_1))
with(Feb2007_power_cons, lines(Date_Time, Sub_metering_2, col = "red"))
with(Feb2007_power_cons, lines(Date_Time, Sub_metering_3, col = "blue"))
legend("topright",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1,1,1), col = c("black", "red", "blue"), cex = 1, bty = "n")
plot(Date_Time, Global_reactive_power, type = "l",
     xlab = "datetime", main = "")
})
dev.off()
#Using read.csv.sql read data from '2/1/2007' to '2/2/2007'
library(sqldf)

power1 <- read.csv.sql("household_power_consumption.txt", header = TRUE, sep = ";",
                       sql= "select * from file where Date = '1/2/2007'")
power2 <- read.csv.sql("household_power_consumption.txt", header = TRUE, sep = ";",
                       sql= "select * from file where Date = '2/2/2007'")                                        
power <- rbind(power1, power2)

##Convert Date and Time 
#paste date and time together
x <- paste(power$Date, power$Time)

#Capital Y means 4 digits year(2007), y means two digits year(07)
t <- strptime(x, "%d/%m/%Y %H:%M:%S") 

#add new date&time column to power
final <-  cbind(t, power)

##draw four plots
#ajust margin 
par(mar =c(4,4,2,1))
#there are 4 plots in all
par(mfrow = c(2,2))


#1.Global Active Power
plot(final$t, final$Global_active_power, type = "n", ylab = "Global Active Power(kilowattes)", xlab = "")
lines(final$t, final$Global_active_power)

#2.Voltage
plot(final$t, final$Voltage, xlab = "datetime", ylab = "Voltage", type = "n")
lines(final$t, final$Voltage)

#3.Energy sub 
plot(final$t, final$Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "n")
lines(final$t, final$Sub_metering_1, col = "black")
lines(final$t, final$Sub_metering_2, col = "red")
lines(final$t, final$Sub_metering_3, col = "blue")
legend('topright', c("Sub_metering_1","Sub_metering_2",'Sub_metering_3') , 
       lty=1, col=c("black",'red', 'blue'), cex = 0.5)

#4.Global Reactive Power
plot(final$t, final$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "n")
lines(final$t, final$Global_reactive_power)

##Export plots
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()

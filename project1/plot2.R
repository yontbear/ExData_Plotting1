#Using read.csv.sql read data from '2/1/2007' to '2/2/2007'
library(sqldf)
power1 <- read.csv.sql("household_power_consumption.txt", header = TRUE, sep = ";",
                       sql= "select * from file where Date = '1/2/2007'")
power2 <- read.csv.sql("household_power_consumption.txt", header = TRUE, sep = ";",
                       sql= "select * from file where Date = '2/2/2007'")                                        
power <- rbind(power1, power2)

#Convert Date and Time 
x <- paste(power$Date, power$Time)
t <- strptime(x, "%d/%m/%Y %H:%M:%S") #Y mean 4 digits year, y MEANS 2 DIGITS
final <-  cbind(t, power)

#Draw plot
par(mar = c(4,6,2,1))
plot(final$t, final$Global_active_power, type = "n", ylab = "Global Active Power(kilowattes)", xlab = "")
lines(final$t, final$Global_active_power)
 
#Export plot
dev.copy(png, file = "plot2.png")
dev.off()

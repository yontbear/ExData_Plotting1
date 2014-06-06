#Using read.csv.sql read data from '2/1/2007' to '2/2/2007'
library(sqldf)
power1 <- read.csv.sql("household_power_consumption.txt", 
                       header = TRUE, sep = ";",
                       sql= "select * from file where Date = '1/2/2007'")
power2 <- read.csv.sql("household_power_consumption.txt", 
                       header = TRUE, sep = ";",
                       sql= "select * from file where Date = '2/2/2007'")                                        
power <- rbind(power1, power2)

#Convert Date and Time 
x <- paste(power$Date, power$Time)
#Y mean 4 digits year, y MEANS 2 DIGITS
t <- strptime(x, "%d/%m/%Y %H:%M:%S") 
final <-  cbind(t, power)

##
plot(final$t, final$Sub_metering_1, 
     ylab = "Energy sub metering", xlab = "", type = "n")
#add sub_1,col = black
lines(final$t, final$Sub_metering_1, col = "black")
      
#add sub_2, col = red
lines(final$t, final$Sub_metering_2, col = "red")
 
#add sub_3, col = blue
lines(final$t, final$Sub_metering_3, col = "blue")

#add legend
legend("topright",
       c("Sub_metering_1","Sub_metering_2",'Sub_metering_3') , 
       lty=1, col=c("black",'red', 'blue'), cex = 0.75)

##Export plots
dev.copy(png, file = "plot5.png", width = 480, height = 480)
dev.off()

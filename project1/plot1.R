
#Using read.csv.sql read data from '2/1/2007' to '2/2/2007'
library(sqldf)
power1 <- read.csv.sql("household_power_consumption.txt", header = TRUE, sep = ";",
                     sql= "select * from file where Date = '1/2/2007'")
power2 <- read.csv.sql("household_power_consumption.txt", header = TRUE, sep = ";",
                     sql= "select * from file where Date = '2/2/2007'")                                        
power <- rbind(power1, power2)


par(mar=c(5.1,4.1,4.1,2.1))
hist(power$Global_active_power, xlab = "Global Active Power(kilowatts)", 
     col = "red", main = "Global Active Power")

#Export plot
dev.copy(png, file = "plot1.png")
dev.off()

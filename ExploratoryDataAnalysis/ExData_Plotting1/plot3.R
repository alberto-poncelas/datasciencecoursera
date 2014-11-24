data<-read.table("household_power_consumption.txt",header=T,sep=";",na.string="?")
Sys.setlocale("LC_TIME", "English")

data <- subset(data, as.Date(data$Date, "%d/%m/%Y") %in% as.Date(c("01/02/2007", "02/02/2007"), "%d/%m/%Y"))




#plot3





time <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
sm1<-as.double(data$Sub_metering_1)
sm2<-as.double(data$Sub_metering_2)
sm3<-as.double(data$Sub_metering_3)


png("plot3.png", width=480, height=480)

plot(time, sm1, xlab="", ylab="Energy sub metering",type="l",col="black")
lines(time, sm2,col="red")
lines(time, sm3,col="blue")

legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1)


dev.off()



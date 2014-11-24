data<-read.table("household_power_consumption.txt",header=T,sep=";",na.string="?")


data <- subset(data, as.Date(data$Date, "%d/%m/%Y") %in% as.Date(c("01/02/2007", "02/02/2007"), "%d/%m/%Y"))




#plot2

png("plot2.png", width=480, height= 480)

time <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
plot(time, data$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)",type="l")



dev.off()



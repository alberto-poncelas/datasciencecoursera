Sys.setlocale("LC_TIME", "English")
data<-read.table("household_power_consumption.txt",header=T,sep=";",na.string="?")


data <- subset(data, as.Date(data$Date, "%d/%m/%Y") %in% as.Date(c("01/02/2007", "02/02/2007"), "%d/%m/%Y"))



#plot1

png("plot1.png", width=480, height= 480)
hist(as.numeric(data$Global_active_power),xlab="Global Active Power (kilowatts)",main = "Global Active Power",col = "red")
dev.off()



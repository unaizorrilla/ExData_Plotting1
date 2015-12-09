#load data frame from working directory
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)

eeframe<-read.csv(unz(temp, "household_power_consumption.txt"),sep = ";", header = T)
unlink(temp)

# do some conversions from time and date

eeframe$DateTime <-paste(eeframe$Date," ",eeframe$Time)

eeframe$DateTime <- as.POSIXlt(eeframe$DateTime,format="%d/%m/%Y %H:%M:%S")

eeframe$Date <- NULL
eeframe$Time <- NULL

#filter for "We will only be using data from the dates 2007-02-01 and 2007-02-02"
#can use also dplyr to filter

from <- as.POSIXlt("2007-02-01 00:00:00",format="%Y-%m-%d %H:%M:%S")
to <- as.POSIXlt("2007-02-03 00:00:00",format="%Y-%m-%d %H:%M:%S")
eeframe<-eeframe[eeframe$DateTime>=from & eeframe$DateTime <to,]

#do more conversions
eeframe$Sub_metering_1<-as.numeric(eeframe$Sub_metering_1)
eeframe$Sub_metering_2<-as.numeric(eeframe$Sub_metering_2)
eeframe$Sub_metering_3<-as.numeric(eeframe$Sub_metering_3)

png(filename = "plot3.png",width = 480,height = 480)

plot(x=eeframe$DateTime,y=eeframe$Sub_metering_1,col="black",type="l",ylab = "Energy sub metering",xlab = "")
lines(x=eeframe$DateTime,y=eeframe$Sub_metering_2,col="red",type="l")
lines(x=eeframe$DateTime,y=eeframe$Sub_metering_3,col="blue",type="l")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("back","red","blue"))

dev.off()
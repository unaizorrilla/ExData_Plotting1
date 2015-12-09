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
eeframe$Global_active_power<-as.numeric(eeframe$Global_active_power)


png(filename = "plot2.png",width = 480,height = 480)

plot(x=eeframe$DateTime,y=eeframe$Global_active_power,type="l",ylab = "Global Active Power (kilowatts)",xlab = "")

dev.off()
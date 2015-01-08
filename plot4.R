###############################################################################
#This set of codes Read the Electrical Power Consumption, selects the data within 
#time period 2007-02-01 - 2007-02-02, converts the data variables appropriately
#and make some plots.
#Olusoji O. D.
###############################################################################
rm(list=ls())
con1 <- file("C:/Users/USER/Documents/Coursera/data/household_power_consumption.txt",open="r")
#
con2 <- file("C:/Users/USER/Documents/Coursera/data/household_power_consumption_names.txt",open="r")
#
ass_data <- read.table(con1,sep=";",na.strings="?",stringsAsFactors=FALSE)
#
ass_data_names <- read.table(con2,nrows=1)
#Close the Opened Connections
close(con1)
close(con2)
#
ass_data_names2 <- sapply(ass_data_names,as.vector)
names(ass_data) <- ass_data_names2
library(chron)
Sys.setlocale("LC_TIME","English_United States.1252")
#
ass_data <- ass_data[(ass_data$Date=="2/2/2007" | ass_data$Date=="1/2/2007"),]
#
ass_data$Date <- as.Date(ass_data$Date,format="%d/%m/%Y")
#
ass_data$Time <- strptime(ass_data$Time,format="%H:%M:%S")
#
ass_data$Time <- times(format(ass_data$Time,"%H:%M:%S"))
#
ass_data <- within(ass_data,{timestamp=format(as.POSIXct(paste(ass_data$Date,ass_data$Time)),"%d/%m/%Y %H:%M:%S")})
#
ass_data$timestamp <- strptime(ass_data$timestamp, "%d/%m/%Y %H:%M:%S")
#
png(file="C:/Users/USER/ExData_Plotting1/plot4.png")
#
par(mfrow=c(2,2),bg=NA,mar=c(4.5,5.1,1.1,2.1))
#
with(ass_data, plot(timestamp, as.numeric(Global_active_power), type="l",xlab="",ylab="Global Active Power (kilowatts)"))
#
with(ass_data,plot(timestamp,Voltage,type="l",xlab="datetime",ylab="Voltage"))
#
with(ass_data, plot(timestamp,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering"),col=1)
#
with(ass_data, lines(timestamp,Sub_metering_2,col="red"))
with(ass_data, lines(timestamp,Sub_metering_3,col="blue"))
legend("topright",legend=c("sub_metering_1","sub_metering_2","sub_metering_3"),lty=c(1,1,1),col=c(1,2,4))
#
with(ass_data,plot(timestamp,Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power"))
#
dev.off()




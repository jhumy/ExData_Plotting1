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
png(height=480,width=480,file="C:/Users/USER/ExData_Plotting1/plot1.png")
#
par(bg=NA)
#
hist(as.numeric(ass_data$Global_active_power),main="Global Active Power",xlab="Global Active Power (Kilowatts)",col="red")
#
dev.off()


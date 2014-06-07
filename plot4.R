##Attempt at loading only required rows, will get this right later
#library(sqldf)
#ht <- read.csv.sql('household_power_consumption.txt', sep=";", header=T, sql = 'select * from file where Date in ("01/02/2007","02/02/2007")')

## Load Data into memory, 
##Data seems to corrupt if loaded with stringAsFactors default =T due to the ?
ht <- read.table('household_power_consumption.txt',sep=';', header=T, stringsAsFactors=F)

ht$DateTime <- paste(ht$Date,ht$Time,sep=' ')
##Date in format dd/mm/yyyy - dont need for this plot 
ht$Date <- as.Date(ht$Date , "%d/%m/%Y")
##Filter only dates required
d <- ht[ht$Date %in% as.Date(c('2007-02-01', '2007-02-02'),"%Y-%m-%d"),]
##time in format hh:mm:ss - dont need for this plot
#d$Time <- strptime(d$Time, "%H:%M:%S")

##Add datetime field (if just use date, all plots occur on two points only)
d$DateTime <- as.POSIXct(d$DateTime, format="%d/%m/%Y %H:%M:%S")
##open png graphics device
png(filename = "plot4.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
##setup 2x2 canvas
par(mfrow = c(2, 2))
##Chart 1
plot(d$DateTime, d$Global_active_power, type="l", xlab="", ylab="Global Active Power", cex.axis=0.9, cex.lab=0.9)
##Chart 2 
plot(d$DateTime, d$Voltage, type="l", xlab="datetime", ylab="Voltage", cex.axis=0.9, cex.lab=0.9)
##Chart 3
plot(d$DateTime, d$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", cex.axis=0.9, cex.lab=0.9)
lines(d$DateTime, d$Sub_metering_2, col="red")
lines(d$DateTime, d$Sub_metering_3, col="blue")
legend("topright", bty="n", cex=0.8, box.lwd = 0, col = c("black","blue", "red"),legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), lty=c(1,1,1))
##Chart 4
plot(d$DateTime, d$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power", cex.axis=0.8, cex.lab=0.9)

##close device (save file)
dev.off()

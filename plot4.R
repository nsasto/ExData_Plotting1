##Attempt at loading only required rows, will get this right later
#library(sqldf)
#ht <- read.csv.sql('household_power_consumption.txt', sep=";", header=T, sql = 'select * from file where Date in ("01/02/2007","02/02/2007")')

## Load Data into memory, 
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
d$Sub_metering_1 <- as.numeric(d$Sub_metering_1)
d$Sub_metering_2 <- as.numeric(d$Sub_metering_2)
d$Sub_metering_3 <- as.numeric(d$Sub_metering_3)
##open png graphics device
png(filename = "plot4.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
##draw line chart
plot(d$DateTime, d$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", cex.axis=1, cex.lab=1)
lines(d$DateTime, d$Sub_metering_2, col="red")
lines(d$DateTime, d$Sub_metering_3, col="blue")
legend("topright",col = c("black","blue", "red"),legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), lty=c(1,1,1))

##close device (save file)
dev.off()

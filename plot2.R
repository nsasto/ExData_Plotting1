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
##time in format hh:mm:ss
d$Time <- strptime(d$Time, "%H:%M:%S")
d$Global_active_power <- as.numeric(d$Global_active_power)
##Add datetime field (if just use date, all plots occur on two points only)
d$DateTime <- as.POSIXct(d$DateTime, format="%d/%m/%Y %H:%M:%S")
##open png graphics device
png(filename = "plot2.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
##draw line chart
plot(d$DateTime, d$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)", cex.axis=1, cex.lab=1)
##close device (save file)
dev.off()

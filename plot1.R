##Attempt at loading only required rows, will get this right later
#library(sqldf)
#ht <- read.csv.sql('household_power_consumption.txt', sep=";", header=T, sql = 'select * from file where Date in ("01/02/2007","02/02/2007")')

## Load Data into memory
ht <- read.table('household_power_consumption.txt',sep=';', header=T, stringsAsFactors=F, na.strings="?")
##Date in format dd/mm/yyyy
ht$Date <- as.Date(ht$Date , "%d/%m/%Y")
##Filter only dates required
d <- ht[ht$Date %in% as.Date(c('2007-02-01', '2007-02-02'),"%Y-%m-%d"),]
##time in format hh:mm:ss
d$Time <- strptime(d$Time, "%H:%M:%S")
d$Global_active_power <- as.numeric(d$Global_active_power)
##open png graphics device
png(filename = "plot1.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
##draw histogram
hist(d$Global_active_power, col = "red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
##close device (save file)
dev.off()
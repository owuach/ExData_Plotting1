library("data.table")


#Reads in the power data from file then subsets the power data for specified dates
powerdata <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# Prevent the Scientific Notation
powerdata[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Make a POSIXct date which is capable of being filtered and graphed by time of day
powerdata[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter the Dates for 2007-02-01 and 2007-02-02
powerdata <- powerdata[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot2.png", width=480, height=480)

## Plot 2
plot(x = powerdata[, dateTime]
     , y = powerdata[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()
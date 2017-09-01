library(readr)
library(lubridate)
library(dplyr)

df <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE)
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")
df$Time <- strptime(df$Time, format = "%H:%M:%S")
df$Time <- as.POSIXct(df$Time)
df$DateTime <- strptime(paste(df$Date, paste(hour(df$Time),minute(df$Time), sep=":")), format = "%Y-%m-%d %H:%M")
df$DateTime <- as.POSIXct(df$DateTime)
tb <- tbl_df(df)
day2 <- filter(tb, Date>=as.Date("2007-02-01") & Date<=as.Date("2007-02-02"))

png('plot4.png')

par(mfrow = c(2,2))

plot(day2$DateTime, day2$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

plot(day2$DateTime, day2$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

plot(day2$DateTime, day2$Sub_metering_3, ylim=c(1,40),ylab="Energy Sub metering", xlab="", type = "n")
lines(day2$DateTime, day2$Sub_metering_1, type = "l", col = "black")
lines(day2$DateTime, day2$Sub_metering_2, type = "l", col = "red")
lines(day2$DateTime, day2$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

plot(day2$DateTime, day2$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()

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

png('plot1.png')

hist(day2$Global_active_power,col="red",main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

dev.off()

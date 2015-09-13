# common code to load the dates in question
full <-
  read.table(
    "household_power_consumption.txt", header = TRUE, sep = ";",na.strings =
      "?"
  )
dates <- as.Date(full$Date, "%d/%m/%Y")
datetimes <-
  strptime(paste(full$Date, full$Time), format = "%d/%m/%Y %H:%M:%S", tz =
             "UTC")
full$datetime <- datetimes
ourdata <-
  subset(full, ((datetimes$year == 107) &
                  (datetimes$mon == 1) &
                  ((datetimes$mday == 1) | (datetimes$mday == 2)
                  )))
# end common code to load the dates in question


png(filename = "plot4.png")

# 2x2 matrix of plots
# default margins ok, don't need to set e.g. par(mfcol = c(2,2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
par(mfcol = c(2,2))

with(ourdata, {
  #upper left
  plot(
    datetime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"
  )
  
  #lower left
  plot(
    datetime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"
  )
  lines(datetime, Sub_metering_2, col = "red")
  lines(datetime, Sub_metering_3, col = "blue")
  legend(
    "topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col =
      c("black", "red", "green"), lty = c(1,1,1), bty = "n"
  )
  
  #upper right
  plot(datetime, Voltage, type = "l")
  
  #lower right
  plot(datetime, Global_reactive_power, type = "l")
})
dev.off()

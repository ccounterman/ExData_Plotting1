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
full$POSIXlt <- datetimes
ourdata <-
  subset(full, ((datetimes$year == 107) &
                  (datetimes$mon == 1) &
                  ((datetimes$mday == 1) | (datetimes$mday == 2)
                  )))
# end common code to load the dates in question


png(filename = "plot2.png")
plot(
  ourdata$POSIXlt, ourdata$Global_active_power, type = "l", xlab = "", ylab =
    "Global Active Power (kilowatts)"
)
dev.off()

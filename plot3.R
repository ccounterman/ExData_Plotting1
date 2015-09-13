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


png(filename="plot3.png")
plot(ourdata$POSIXlt, ourdata$Sub_metering_1, type="l", xlab ="", ylab="Energy sub metering")
lines(ourdata$POSIXlt, ourdata$Sub_metering_2, col="red")
lines(ourdata$POSIXlt, ourdata$Sub_metering_3, col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "green"), lty=c(1,1,1))
dev.off()


  
  

library(graphics)

# check if data is in workspace, if not, load data from file
if (!exists("hpc")) {
    file = "household_power_consumption.txt"
    hpc <- read.table(file,
                      sep = ";",
                      header = TRUE,
                      na.strings = "?")
    # convert characters to dates
    hpc$Date <- strptime(as.character(hpc$Date),
                         format = "%d/%m/%Y")
    # days to subset
    days <- strptime(c("2007-02-01", "2007-02-02"),
                     format = "%Y-%m-%d")
    # subset specified days
    hpc_days <- subset(hpc, hpc$Date %in% days)
    
    # Create column with complete Date, Time values
    hpc_days$Time2 <- with(hpc_days, as.POSIXlt(paste(Date, Time)))
}
if (!file.exists("plot4.png")) {
    # open png device of specified size
    png("plot4.png", width = 480, height = 480)

    # set up plot for 2x2
    par(mfcol = c(2,2))
    
    # First plot
    plot(x = hpc_days$Time2,
         y = hpc_days$Global_active_power,
         xlab ="",
         ylab = "Global Active Power (kilowatts)",
         type = "l")
    # Second plot
    plot(x = hpc_days$Time2,
         y = hpc_days$Sub_metering_1,
         xlab ="",
         ylab = "Energy sub metering",
         type = "l")
    lines(x = hpc_days$Time2,
          y = hpc_days$Sub_metering_2,
          col = "red")
    lines(x = hpc_days$Time2,
          y = hpc_days$Sub_metering_3,
          col = "blue")
    
    legend("topright",
           legend = names(hpc_days)[7:9],
           lwd = 1,
           col = c("black", "red", "blue"))
    
    # Third plot
    plot(x = hpc_days$Time2,
         y= hpc_days$Voltage,
         type = "l",
         xlab = "",
         ylab = "Voltage")
    
    # Fourth plot
    plot(x = hpc_days$Time2,
         y= hpc_days$Global_reactive_power,
         type = "l",
         xlab = "",
         ylab = "Global Reactive Power")

    dev.off()
}
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


if (!file.exists("plot2.png")) {
    # open png device of specified size
    png("plot2.png", width = 480, height = 480)

    plot(x = hpc_days$Time2,
         y = hpc_days$Global_active_power,
         xlab ="",
         ylab = "Global Active Power (kilowatts)",
         type = "l")

    dev.off()
}
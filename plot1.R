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
}

# open png device of specified size
png("plot1.png", width = 480, height = 480)
hist(hpc_days$Global_active_power, 
     xlab = "Global Active Power (killowatts)",
     main = "Global Active Power",
     col = "red",)

dev.off()

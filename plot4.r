# download the zip file
download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile="exdata_data_household_power_consumption.zip",
              method="curl")

# unzip and load
unzip("exdata_data_household_power_consumption.zip")
d <- read.table("household_power_consumption.txt", header=TRUE,
                sep=";", na.strings="?", stringsAsFactors=FALSE)

# Update the date field from string to date
d$Date <- as.Date(d$Date, "%d/%m/%Y")

# grab only 2007-02-01 to 2007-02-02
d <- subset(d, d$Date >= '2007-02-01' & d$Date < '2007-02-03')

# Create a new field called Timestamp using the Date and Time field
d <- within(d, { Timestamp=format(as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S") })
d$Timestamp <- as.POSIXlt(d$Timestamp, "%d/%m/%Y %H:%M:%S",tz = Sys.timezone())

# Plot the graphs

# top left
#png("plot2.png")
with(d, plot(Timestamp, Global_active_power, type="l",
             xlab="", ylab="Global Active Power"))
#dev.off()

# top right
with(d, plot(Timestamp, Voltage, type="l",
             xlab="datetime", ylab="Voltage"))

# bottom left
with(d, plot(Timestamp, Sub_metering_1, type="l", xlab="",
             ylab="Energy sub metering"))
with(d, lines(Timestamp, Sub_metering_2, col="red"))
with(d, lines(Timestamp, Sub_metering_3, col="blue"))
legend("topright", lty=1, col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n")

#png("plot3.png")
with(d, plot(Timestamp, Sub_metering_1, type="l"))
with(d, lines(Timestamp, Sub_metering_2, col="red"))
with(d, lines(Timestamp, Sub_metering_3, col="blue"))
#legend("topright", lty=1, col=c("black", "red", "blue"),
#       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#dev.off()

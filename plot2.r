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

# Plot the graph
png("plot2.png")
with(d, plot(Timestamp, Global_active_power, type="l",
             xlab="", ylab="Global Active Power (kilowatts)"))
dev.off()

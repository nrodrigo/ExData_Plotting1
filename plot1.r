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

# Plot the histrogram
hist(d$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.copy(png, "plot1.png")
dev.off()

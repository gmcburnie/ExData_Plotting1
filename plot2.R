## Create "data" directory if doesn't already exist. 
if(!file.exists("data")) {
    dir.create("data")
}

## Download and unzip dataset if doesn't already exist
if(!file.exists("data/household_power_consumption.txt")) {
    temp <- tempfile()
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl, temp, mode="wb")
    unzip(temp, exdir="data")
}

data <- read.csv("./data/household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")

## Create formatted date and time column  
dates <- data$Date
times <- data$Time
x <- paste(dates, times)
data$Date_time <- strptime(x, "%d/%m/%Y %H:%M:%S")

## subset dataframe for observations on 2007/02/01 and 2007/02/02
startDate <- as.POSIXlt("2007-02-01 00:00:00")
endDate <- as.POSIXlt("2007-02-02 23:59:59")
dataTimeframe <- subset(data, Date_time >= startDate  & Date_time <= endDate)

## Plot histogram and output plot to plot2.png
png(file = "plot2.png", width=480, height=480) # Create 480x480 png
with(dataTimeframe, plot(Date_time, 
                         Global_active_power, 
                         ylab="Global Active Power (kilowatts)", 
                         xlab="",
                         type="l"))
#dev.copy(png, file = "plot2.png", width=480, height=480) # Create 480x480 png
dev.off() # Close device


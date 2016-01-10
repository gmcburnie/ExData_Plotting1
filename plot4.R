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

## Plot with png device and output to plot4.png
png(file = "plot4.png", width=480, height=480)

## Create 2x2 canvas
par(mfrow=c(2, 2))

## Plot line graph showing Global Active Power over time period
with(dataTimeframe, 
     plot(Date_time, 
          Global_active_power, 
          ylab="Global Active Power", 
          xlab="",
          type="l")
)

## Plot line graph showing voltage over time period
with(dataTimeframe, 
     plot(Date_time, 
          Voltage, 
          ylab="Voltage", 
          xlab="datetime",
          type="l")
)


## Plot line graph showing energy sub metering over time period
with(dataTimeframe, {
    plot(Date_time, 
         Sub_metering_1, 
         ylab="Energy sub metering", 
         xlab="",
         type="l",
         col="black")
    lines(Date_time, 
          Sub_metering_2,
          col="red")
    lines(Date_time, 
          Sub_metering_3,
          col="blue")
    legend("topright", 
           lty = 1, 
           col = c("black", "red", "blue"),
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           bty='n')
})

## Plot line graph showing Global Reactive Power (kw) over time period
with(dataTimeframe, 
     plot(Date_time, 
          Global_reactive_power, 
          ylab="Global Reactive Power",
          xlab="datetime",
          type="l")
)

dev.off() # Close device




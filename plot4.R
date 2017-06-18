plot4<- function() {
  #Read few rows from file to get column classes details
  df <- read.delim("household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE, nrows=10)
  
  #to get column classes from df data.frame object
  l <- lapply(df, class)
  
  # read full data into df data.frame
  df <- read.delim("household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE, colClasses = l, na.strings = "?")
  
  #change class of Date column to Date
  df$Date <- as.Date(df$Date,format = "%d/%m/%Y")
  
  #create subset of data in variable d
  d <- df[df$Date == "2007-02-02" | df$Date == "2007-02-01",]
  
  #remove df data.frame to free space
  remove(df)
  
  #convert Time column to POSIXlt
  d$Time <- strptime(paste(d$Date,d$Time),"%Y-%m-%d %H:%M:%S")
  
  #code to create plot4
  par(mfrow=c(2,2))
  with(d, {plot(Time,Global_active_power, ylab="Global Active Power", xlab = "", type="l")
    plot(Time,Voltage, ylab="Voltage",xlab = "datetime", type="l")
    plot(Time,Sub_metering_1,type="l", main="",ylab="Energy sub metering",xlab = "")
    lines(d$Time,d$Sub_metering_2,col="red")
    lines(d$Time,d$Sub_metering_3,col="blue")
    legend("topright",lty = c(1,1), lwd(2.5,2.5),border = "white", col = c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), ncol=1,cex=.75,bty="n")
    par(yaxs="i")
    plot(Time,Global_reactive_power, ylab="Global_reactive_power",xlab = "datetime", type="l", cex.axis=.75)
  }
  )
  #copy plot 4 to plot4.png
  dev.copy(png, "plot4.png", width=480, height=480)
  
  dev.off()
}

plot4()
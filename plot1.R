plot1 <- function() {
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

#code to create plot1
hist(d$Global_active_power, main = "Global Active Power", ylab = "Frequency", xlab = "Global Active Power (kilowatts)", col = "red")

#copy plot 1 to plot1.png
dev.copy(png, "plot1.png", width=480, height=480)

dev.off()
}

plot1()
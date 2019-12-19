### Plot 3
## Importing sqldf
install.packages("sqldf")
library (sqldf)
workfile <- file("./household_power_consumption.txt")

##sqldf does two things: changing date format and converting nas from "?" to "0/blank"
data_subset <- sqldf("select * from workfile where Date = '1/2/2007' or Date = '2/2/2007'", dbname = tempfile(), file.format = list(header = TRUE, row.names = FALSE, sep =";"))
close(workfile)

#Importing the lubridate package
install.packages("lubridate")
library(lubridate)

# Creating a new DateTime variable
data_subset$DateTime <- dmy_hms(paste(data_subset$Date, data_subset$Time))

# Setting the plot requirement as PNG files of 480 x 480 pixels
png(filename = "./plot3.png", 
    width = 480, 
    height = 480, 
    units = "px")

# Creating the plot using the with function
with(data_subset, {
    plot(DateTime,
         Sub_metering_1, 
         type = "l",
         ylab = "Energy sub metering",
         xlab = "")
    lines(DateTime,
          Sub_metering_2, 
          type = "l",
          col = "red")
    lines(DateTime,
          Sub_metering_3, 
          type = "l",
          col = "blue")
    legend("topright", 
           c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           col = c("black", "red", "blue"),
           lty = c(1, 1, 1))
})

dev.off()
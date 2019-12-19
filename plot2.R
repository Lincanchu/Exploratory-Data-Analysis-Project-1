### Plot 2

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
png(filename = "./plot2.png", 
    width = 480, 
    height = 480, 
    units = "px")

# Creating the plot using the plot function
plot(data_subset$Global_active_power ~ data_subset$DateTime, 
     type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")
dev.off()
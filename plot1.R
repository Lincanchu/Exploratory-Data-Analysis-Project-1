### Plot 1
## Importing sqldf
install.packages("sqldf")
library (sqldf)
workfile <- file("./household_power_consumption.txt")

##sqldf does two things: changing date format and converting nas from "?" to "0/blank"
data_subset <- sqldf("select * from workfile where Date = '1/2/2007' or Date = '2/2/2007'", dbname = tempfile(), file.format = list(header = TRUE, row.names = FALSE, sep =";"))
close(workfile)

# Setting the plot requirement as PNG files of 480 x 480 pixels
png(filename = "./plot1.png", 
    width = 480, 
    height = 480, 
    units = "px")

# Creating the plot using the hist function
hist(data_subset$Global_active_power, 
     col = "red",
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

dev.off()
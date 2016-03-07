##
## Exploratory Data Analysis: Week01: Project: Plot 2
##
## setwd("C:/JEB/educat/2015.DataScience/2016.03.ExploratoryDataAnalysis/repo/")
##
## Assignment: 
##     Given the project data provided at: 
##    "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
##
##    Download and clean the data suitable for generation of exploratory graphs.
## 
##    Construct each plot and save it to a 480x480 pixel PNG file.
##    Name each of the plot files as `plot1.png`, `plot2.png`, etc.
##    Create a separate R code file (`plot1.R`, `plot2.R`, etc.) that constructs 
##    the corresponding plot, i.e. code in `plot1.R` constructs `plot1.png` plot. 
##
##    Include code for reading the data, so that the plot can be fully reproduced. 
##    Include the code that creates the PNG file.
##

# set known path & file names
#
hpath <- getwd() # save our spot
upath <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dname <- "ExData_Plotting1"
ztemp <- "temp.zip"
fname <- "household_power_consumption.txt"
dpath <- file.path(hpath, dname)

# Make sure the working directory is there
if (!file.exists(dpath)){ dir.create(dpath) }
setwd(dpath)

# Check if the data is downloaded and download when applicable
if (!file.exists(fname)) {
    download.file(upath, destfile = "temp.zip")
    unzip("temp.zip")
    file.remove("temp.zip")
}

if (!file.exists(fname)) { stop("Failed to download dataset") }

# Read the dataset

ptable <- read.table(fname, header = TRUE, sep = ";", na.strings = "?", colClasses=c("character", "character", rep("numeric",7)))

# Adjust the date and time columns

ptable$Time <- strptime(paste(ptable$Date, ptable$Time), "%d/%m/%Y %H:%M:%S")
ptable$Date <- as.Date(ptable$Date, "%d/%m/%Y")

# Subset the data to cover only 01 Feb 2007 and 02 Feb 2007 (GroundHog Day)

ghData <- subset(ptable, (Date==as.Date("2007-02-01") | Date==as.Date("2007-02-02")))

########################################################################################
# Draw the graphics where I can see them.

with (ghData, 
      plot(Time, 
           Global_active_power, 
           type="l", 
           xlab="", 
           ylab="Global Active Power (kilowatts)"
           ))

########################################################################################
# Draw the graphics on the file device.
# could have used the appropriate "copy" function;
# but there was a warning about some inconsistancies.
#

png("plot2.png", width=480, height=480)
with (ghData, 
      plot(Time, 
           Global_active_power, 
           type="l", 
           xlab="", 
           ylab="Global Active Power (kilowatts)"
      ))
dev.off()

########################################################################################
setwd(hpath) # go home






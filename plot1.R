setwd("/Users/Damian/Documents/ExData_Plotting1")

if(!file.exists("datos")) {
  
  dir.create("datos")
}

fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./datos/datoscomprimidos.zip",method="curl")
dateDownloaded<-date()
unzip("./datos/datoscomprimidos.zip",exdir="./datos")

datos.raw<-read.table("./datos/household_power_consumption.txt",
                      header=T,
                      sep=";",
                      na.strings="?",
                      stringsAsFactors=F)

#We create a new dataframe, selecting only the two dates that interest us
datos<-datos.raw[datos.raw$Date %in% c("1/2/2007","2/2/2007"),]

#We create a character variable pasting the Date with the Time
datos$momento<-paste(datos$Date,datos$Time)

#We add a POSIXlt variable
datos$momento2<-strptime(datos$momento,format="%e/%m/%Y %H:%M:%S")

#We create the plot
png(filename="Plot1.png",width=480,height=480)
hist(datos$Global_active_power,
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     col="red",
     ylim=c(0,1200)
     )
dev.off()




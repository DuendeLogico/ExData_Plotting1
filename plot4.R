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

#We create a new dataframe selecting only the two dates that interest us
datos<-datos.raw[datos.raw$Date %in% c("1/2/2007","2/2/2007"),]

#We create a character variable pasting the Date with the Time
datos$momento<-paste(datos$Date,datos$Time)

#We add a POSIXlt variable
datos$momento2<-strptime(datos$momento,format="%e/%m/%Y %H:%M:%S")

#We create the plot
Sys.setlocale("LC_TIME","en_US.UTF-8") #changes the locale so that weekdays appear in english
png(filename="Plot4.png",width=480,height=480)
par(mfcol=c(2,2))
par(cex.lab=0.8)
plot(datos$momento2,datos$Global_active_power,
     ylab="Global Active Power",
     type="l",
     xlab="")
plot(datos$momento2,datos$Sub_metering_1,
     ylab="Energy sub metering",
     type="l",
     xlab="")
lines(datos$momento2,datos$Sub_metering_2,col="red")
lines(datos$momento2,datos$Sub_metering_3,col="blue")
legend("topright",
       col=c("black","red","blue"),
       lty=1,
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       bty="n",
       cex=0.8)
plot(datos$momento2,datos$Voltage,
     type="l",
     xlab="datetime",
     ylab="Voltage")

plot(datos$momento2,datos$Global_reactive_power,
     type="l",
     xlab="datetime",
     ylab="Global_reactive_power")

dev.off()
Sys.setlocale("LC_TIME","es_ES.UTF-8") #Changes the locale again to its original value



cData <- read.csv("D:/Documents/R/Crime_Data_from_2010_to_Present.csv", sep=",")
shotData <- cData[cData$Crime.Code %in% c(250,251,753), c("DR.Number","Date.Occurred","Time.Occurred","Weapon.Description","Status.Description","Address","Cross.Street","Location")]

shotData$Hour <- as.numeric(unlist(sapply(shotData$Time.Occurred, FUN=function(data) {
  if (nchar(data) <= 2) {
    return("0")
  }
  else if (nchar(data) == 3) {
    return(as.character(substr(data, 1, 1)))
  }
  else if (nchar(data) == 4) {
    return(as.character(substr(data, 1, 2)))
  }
})))

extractLocation = function(data, longorlat) {
  if (longorlat == "long") {
    longitude <- strsplit(as.character(data),",")[[1]][2]
    longitude <- substr(longitude, 2, nchar(longitude)-1)
    return(as.numeric(longitude))
  }
  else {
    latitude <- strsplit(as.character(data),",")[[1]][1]
    latitude <- substr(latitude, 2, nchar(latitude))
    return(as.numeric(latitude))
  }
}

shotData$Longitude <- sapply(shotData$Location, FUN=function(location){extractLocation(location, longorlat = "long")})
shotData$Latitude <- sapply(shotData$Location, FUN=function(location){extractLocation(location, longorlat = "lat")})

shotData <- shotData[shotData$Latitude != 0 & shotData$Longitude != 0 ,c("DR.Number","Date.Occurred","Time.Occurred","Hour","Weapon.Description","Status.Description","Address","Cross.Street","Longitude","Latitude")]

write.csv(shotData, file = "ready_la_crime.csv", row.names = FALSE)
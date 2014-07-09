if(!file.exists("data")){
    dir.create("data")
}

#Baltimore data files
#https://data.baltimorecity.gov/Transportation/Baltimore-Fixed-Speed-Cameras/dz54-2aru
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"

#if the file is https then must use curl - if on a mac
#curl not required on windows
#download.file(fileUrl, destfile="./data/cameras.csv", method="curl")
download.file(fileUrl, destfile="./data/cameras.csv")

#list the file [and folder?] contents of a directory
list.files("./data")

#timestamp
dateDownloaded <- date()
dateDownloaded

---
#will fail since the default is tab delimited
#cameraData <- read.table("./data/cameras.csv")
cameraData <- read.table("./data/cameras.csv", sep=",", header=TRUE)
head(cameraData)

#note: read.csv is read.table with header=TRUE and sep=","
#params:
#quote -> whether there are any quoated values - quoate="" means no quotes -> the usual value
#na.strings - set the character that represents a missing value (NA,-1,etc.)
#nrows - how many rows to read
#skip - how many rows to skip before beginning to read


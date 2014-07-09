if(!file.exists("data")){
    dir.create("data")
}

#Baltimore data files
#https://data.baltimorecity.gov/Transportation/Baltimore-Fixed-Speed-Cameras/dz54-2aru
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
#note: need to add mode="wb" -> binary mode
download.file(fileUrl, destfile="./data/cameras.xlsx", mode="wb") 

dateDownload <- date()

library(xlsx)

cameraData <- read.xlsx("./data/cameras.xlsx",sheetIndex = 1, header=TRUE)
head(cameraData)

# can read specific columns and row indices
colIndex <- 2:3
rowIndex <- 1:4
cameraDataSubset <- read.xlsx("./data/cameras.xlsx", 
                                sheetIndex=1, 
                                colIndex=colIndex, 
                                rowIndex=rowIndex)

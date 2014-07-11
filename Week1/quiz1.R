if(!file.exists("data")){
    dir.create("data")
}

#Questions 1 + 2 Data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

download.file(fileUrl, destfile="./data/community.csv")

dateDownloaded <- date()
print(dateDownloaded)

communityData <- read.table("./data/community.csv", sep=",", header=TRUE)

#Question 1
propertyValue <- communityData$VAL
milOrMore <- propertyValue[!is.na(propertyValue) & propertyValue == 24]


#Question 3 Data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx" 
download.file(fileUrl, destfile="./data/gas.xlsx", mode="wb") 

dateDownload <- date()
print(dateDownloaded)

library(xlsx)

gasData <- read.xlsx("./data/gas.xlsx",sheetIndex = 1, header=TRUE)
head(gasData)

#Question 3
colIndex <- 7:15
rowIndex <- 18:23
dat <- read.xlsx("./data/gas.xlsx", 
                    sheetIndex=1, 
                    colIndex=colIndex, 
                    rowIndex=rowIndex)

sum(dat$Zip*dat$Ext,na.rm=T)

#Question 4 Data
library(XML)

#Original "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
#Seems to have an issue. Remove the secure section to the below
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"

doc <- xmlTreeParse(fileUrl, useInternal=TRUE)
rootNode <- xmlRoot(doc)

#xmlName(rootNode) 
#names(rootNode) 
#xmlSApply(rootNode, xmlValue)

zipcodeData <- xpathSApply(rootNode,"//zipcode",xmlValue)
specificZipcode <- zipcodeData[zipcodeData == "21231"]
length(specificZipcode)

#Question 5
library(data.table)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"

download.file(fileUrl, destfile="./data/community2.csv")
file <- "./data/community2.csv"
DT <- fread(file)

#find the fastest option:
system.time(DT[,mean(pwgtp15),by=SEX]) #Fasterest ~0 time


rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2] #has an error -> x must be numeric

system.time({mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)})# ~0.1

system.time(mean(DT$pwgtp15,by=DT$SEX)) #~0 time but only gives one number...

system.time(sapply(split(DT$pwgtp15,DT$SEX),mean)) #~0 time gives unlabelled answer 

system.time(tapply(DT$pwgtp15,DT$SEX,mean)) #~0 time gives unlabbeled answer
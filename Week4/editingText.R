if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/cameras.csv")
cameraData <- read.csv("./data/cameras.csv")
names(cameraData)

#makes everything be lower case
tolower(names(cameraData))
#everything to upper case
toupper(names(cameraData))

#separate out variables separated by a .
splitNames = strsplit(names(cameraData),"\\.")
splitNames[[5]] #intersection - has no . so no change
splitNames[[6]] #Location.1 -> "Location" and "1"


mylist <- list(letters = c("A", "b", "c"), numbers = 1:3, matrix(1:25, ncol = 5))
head(mylist)

mylist[1]
mylist$letters
mylist[[1]]

splitNames[[6]][1]

firstElement <- function(x){x[1]} #takes the first element of a list
sapply(splitNames,firstElement) #split the names and take only the first element
#good way of getting rid of names separated by . / etc

fileUrl1 <- "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 <- "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1,destfile="./data/reviews.csv")
download.file(fileUrl2,destfile="./data/solutions.csv")
reviews <- read.csv("./data/reviews.csv"); solutions <- read.csv("./data/solutions.csv")
head(reviews,2)
head(solutions,2)

names(reviews)
#substitute first instance of "_" with "" in the list names(reviews)
sub("_","",names(reviews),) 

#substitute all instances of "_" with "" in the list names(reviews)
gsub("_","",names(reviews),) 

testName <- "this_is_a_test"
sub("_","",testName)
gsub("_","",testName)

# search string, and variable to look for
# returns a list of indices that match
grep("Alameda",cameraData$intersection)
#returns a list of true or false on the comparison per index
table(grepl("Alameda",cameraData$intersection))
#subset to only data for intersection is not Alameda
cameraData2 <- cameraData[!grepl("Alameda",cameraData$intersection),]

#return the values where Alameda appers
#by setting value = TRUE
#note grep is not exact match -> more like contains
grep("Alameda",cameraData$intersection,value=TRUE)

#value does not exist -> empty list
grep("JeffStreet",cameraData$intersection)
#length is 0 if empty list
length(grep("JeffStreet",cameraData$intersection))

#install.packages("stringr")
library(stringr)
nchar("Jeffrey Leek") #length -> 12
substr("Jeffrey Leek",1,7) #subtring by beginning and ending index
#make one string with " " in between
#can use sep argument to change default
paste("Jeffrey","Leek") 
paste0("Jeffrey","Leek") #make one string with no in between string
str_trim("    Jeff      ") #get rid of beginning and ending white space
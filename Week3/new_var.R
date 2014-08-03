if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"

download.file(fileUrl,destfile="./data/restaurants.csv")
restData <- read.csv("./data/restaurants.csv")

#param
#min, max, incretement interval
s1 <- seq(1,10,by=2);
s1

param
#min, max, # of interpolate values
s2 <- seq(1,10, length=3);
s2

#creates a list of consecutive indicies
# makes an increasing list of integers from 1 to n 
#where n is the length of the along argument
x <- c(1,3,8,25,100);
seq(along=x) 

#BINARY VARIABLES

#create a new col that is of type boolean
#it will be true or false based on equality in the list of locations
restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)

#make an error col for zipcode
restData$zipWrong = ifelse(restData$zipCode,TRUE,FALSE)
table(restData$zipWrong, restData$zipCode <0)

#Categorical Variables
restData$zipGroups = cut(restData$zipCode,breaks=quantile(restData$zipCode))
table(restData$zipGroups)
# --- how many values in each percentile

#which zipcodes fall in which quartile
#pseudo clustering
table(restData$zipGroups,restData$zipCode)

#Easier cutting
#install.packages('Hmisc')
library(Hmisc)
#g is the # of quantiles you want to break it in to
restData$zipGroups = cut2(restData$zipCode, g = 4)
table(restData$zipGroups) # same quantiles as before
#class of zipgroups is a factor

#Factor Variables
#turn zipCode from integer into factor
restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]

class(restData$zcf)

#levels of factor variables
#make a list
yesno <- sample(c("yes","no"), size=10, replace=TRUE)
as.numeric(yesnofac) # no is the lower value b/c n comes before y in alphabet
#turn it into a factor
yesnofac <- factor(yesno, levels=c("yes","no")) # make the yes value be the "lower" value
relevel(yesnofac,ref="yes")
as.numeric(yesnofac) #turn it back into a number

#reset restData at this line to make example to make sense
library(Hmisc)
library(plyr)
#calculate dataframe row quantile and add quantile classification to dataframe
restData2 = mutate(restData,zipGroups=cut2(zipCode,g=4))
table(restData2$zipGroups)
names(restData)
names(restData2) 
head(restData2$zipGroups)

#common transforms on slide in lecture
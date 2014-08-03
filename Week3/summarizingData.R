if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"

download.file(fileUrl,destfile="./data/restaurants.csv")
restData <- read.csv("./data/restaurants.csv")

head(restData,n=3)
tail(restData,n=3)
summary(restData)
#Technical R details of data frame
str(restData)

quantile(restData$councilDistrict,na.rm=TRUE)
#custom percentiles
quantile(restData$councilDistrict,probs=c(0.5,0.75,0.9))

#table tally results
#useNA - if any - create a column with NA for missing values
table(restData$zipCode,useNA="ifany")

#2D table
table(restData$councilDistrict, restData$zipCode)

#check for missing values
sum(is.na(restData$councilDistrict))

#logically ors them together (ie true if 1, na false if no na)
any(is.na(restData$councilDistrict))

#logically ands them together
all(restData$zipCode > 0)

#sum all the columns
#specifically in this instance will find all the number of nas in each column
colSums(is.na(restData))

#check if all columns sum are 0 ie no NAs in all columns
all(colSums(is.na(restData)) == 0)

#how many restaurants have zipcode 21212 [both true and false]
table(restData$zipCode %in% c("21212"))
#how many restaurants have zipcode 21212 or 21213 [both true and false]
table(restData$zipCode %in% c("21212", "21213"))

#can be used as a logical selector
head(restData[restData$zipCode %in% c("21212", "21213"),])

#Cross tabs
#standard dataset
data(UCBAdmissions)
DF = as.data.frame(UCBAdmissions)
summary(DF)

#Freq is the data in the table
# broken down by gender and if admitted or rejected
xt <- xtabs(Freq ~ Gender + Admit, data = DF)
xt

#Flat tables
#standard dataset again
# breaks data is in table
# . means break it down by ALL variables
warpbreaks$replicate <- rep(1:9, len=54)
xt = xtabs(breaks ~., data=warpbreaks)
xt #messy to use
ftable(xt) #summarize and clean up

fakeData = rnorm(1e5)
object.size(fakeData) # default in bytes
print(object.size(fakeData), units="Mb") #change the units to be more meaningful
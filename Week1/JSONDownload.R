#install.packages(jsonlite)
library(jsonlite)

#dataframe of dataframes
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos") 
names(jsonData) 

#one of the dataframes inside the main one
names(jsonData$owner)
#nested quite deep
jsonData$owner$login

#iris is a dataset dataframe
#dataframe to json
myjson <- toJSON(iris, pretty=TRUE)
cat(myjson) #Display json object [head displays really raw output]

#json to dataframe
iris2 <- fromJSON(myjson)
head(iris2)
# Note that installing RMySQL is a pain in the bum
# install Rtools and click yes on cygwin dlls
# Download SQL Server 5.5
# add Renviro.site file in the relevant R version
# add the system variable (redudant maybe but do it anyway) to windows
# install.packages('DBI') may be necessary

library(RMySQL)

#web facing servers
ucscDb <- dbConnect(MySQL(), user="genome", host="genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb,"show databases;")
dbDisconnect(ucscDb)
#head(result)

hg19 <- dbConnect(MySQL(), 
                  user="genome",
                  host="genome-mysql.cse.ucsc.edu",
                  db="hg19")
allTables <- dbListTables(hg19)
length(allTables) #list of tables
#allTables[1:5]

dbListFields(hg19,"affyU133Plus2") #get all the column names of a table
dbGetQuery(hg19,"select count(*) from affyU133Plus2") #executes injected code

affyData <- dbReadTable(hg19, "affyU133Plus2") #parse mySql date into a dataframe
#head(affyData)

#subset of data
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query) #execute code
#quantile(affyMis$misMatches)

affyMisSmall <- fetch(query,n=10) #get only the first 10
dbClearResult(query) #clear the result of the query

#dim(affyMisSmall)

dbDisconnect(hg19) #close cnxn

#local:

pass <- "****" #put the real password in
localhost <- dbConnect(MySQL(), user="root", host="127.0.0.1",password=pass)
result <- dbGetQuery(localhost,"show databases;")
dbDisconnect(localhost)
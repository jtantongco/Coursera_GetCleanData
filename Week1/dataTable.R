#install.packages("data.table")
library(data.table)


DF = data.frame(x=rnorm(9),
                y=rep(c("a","b","c"), each=3),
                z=rnorm(9))
head(DF,3)

DT = data.table(x=rnorm(9),
                y=rep(c("a","b","c"), each=3),
                z=rnorm(9))
head(DT,3)

#the above are roughly equivalent

tables() #view all data tables
DT[2,] # just like in data frames [2nd row only]
DT[DT$y=="a",] #just like in data frames [where y is a]
#when only one index -> subsets on rows
DT[c(2,3)] #returns full 2nd and 3rd row

#DT[,c(2,3)] #does NOT return the 2nd and 3rd column

#expression - anything enclosed in curly brackets
k = {print(10); 5}
#will print 10 but the value of k at the end will be 5

#can pass a list of functions to perform as the 2nd argument of the Datatable
#   note: arguments in the list that are 
#   the names of columns do not need to be in quotation marks
DT[,list(mean(x),sum(z))]
#in this case - V1 will be the mean of the x values and 
#   V2 will be the sum of the Z values

#table of the y values - how many occurances and table the distinct outputs
DT[,table(y)] 

#adds new columns very quickly to existing dataset
DT[,w:=z^2] #add a new column "w" whose value for the row is the z value squared
DT #doesn't automatically show it on that last one

#dataframes -  if a new column is added, then 2 copies are made
#data tables - only one copy 
#data tables are objects -> pass by reference ex:
DT2 <- DT
DT[, y:=2] #generates a warning

#expressions in new data
DT[, m:={tmp <- (x+z); log2(tmp+5)}] #m = log2(x+z+5)

#binary variables
DT[,a:=x>0]

#decisions on binary variables
DT[,b:=mean(x+w),by=a]
# there will be two means 
# one from rows where a is true and one from where a is false
# based on the value of a, the value will be selected for the column b

# .N -> an integer, length 1, containing the number
set.seed(123)
DT <- data.table(x=sample(letters[1:3],1E5, TRUE)) 
#create a list from the first 3 that is 1E5 big with repitition on
DT[,.N,by=x] #counts the number occurances grouped by the x column

#Keys -> if set, can subset and sort more rapidly
DT <- data.table(x=rep(c("a","b","c"),each=100), y=rnorm(300))
setkey(DT,x) #set the key to be the x column
DT['a'] #return all rows where the x column is 'a'

#Use keys for x to facilitate joins
DT1 <- data.table(x=c('a','a','b','dt1') ,y=1:4)
DT2 <- data.table(x=c('a','b','dt2') ,z=5:7)
setkey(DT1, x); setkey(DT2, x)
merge(DT1,DT2) 
#sorta like logical AND
#key entry not present in both means it wont show up
#key present more than once it, will go with the highest value for cols being merged


#large dataframes
big_df <- data.frame(x=rnorm(1E6),y=rnorm(1E6))
file <- tempfile()
write.table(big_df, file=file, row.names=FALSE, col.names=TRUE, sep="\t", quote=FALSE)

system.time(fread(file)) #better performance with tables
system.time(read.table(file, header=TRUE,sep="\t"))
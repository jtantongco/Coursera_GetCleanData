#install.packages('reshape2')
library(reshape2)
head(mtcars)

#melting dataset
#seprate out id and measure variables
#will create a dataframe where id variables are kept
#a variable column and value column is added
#the value column will store the value of the measure variables
# the variable column will store what original column had the value in the value column
#note that depending on how many measure variables are supplied,
# this can make the dataframe much longer
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars,
                id=c("carname","gear","cyl"),
                measure.vars=c("mpg","hp") )

head(carMelt, n=3)
tail(carMelt, n=3)

#melting data allows it to be recast
#different way of resummarizing data
cylData <- dcast(carMelt, cyl ~ variable)
cylData

#note that 1,2,3 are row #s
#cyl mpg hp
#1   4  11 11 
# for 4 cylinders there are 11 measurements for mpg, and hp for calculation
#2   6   7  7
#3   8  14 14

cylData <- dcast(carMelt, cyl ~ variable, mean)
cylData

#note that 1,2,3 are row #s
#cyl      mpg        hp
#1   4 26.66364  82.63636 
#for 4 cylinder cars, the mean mpg is 26.66 and mean hp is 82.64
#2   6 19.74286 122.28571
#3   8 15.10000 209.21429

head(InsectSprays)
#spray is ID of spray used
# count is the # of insects seen on use of specific spray

#apply along index
#ie. group all As togther, group all Bs together, ...
#then do the supplied function on the group
#ie. sum all counts of A, sum all counts of B, ...
tapply(InsectSprays$count, InsectSprays$spray, sum)

#split apply and combine

#split on count using the col spray to group
#creates a list for A, list for B, ...
spIns = split(InsectSprays$count, InsectSprays$spray)
spIns
#apply
sprCount = lapply(spIns,sum) #apply fcn to each element of list arg
sprCount
#combine
unlist(sprCount)
# does apply and combine together
sapply(spIns,sum)

#plyr package way
#src, var to summarize, type of op, how do we want to summarize
ddply(InsectSprays,.(spray),summarize, sum=sum(count))

#create a new variable
#calculate sum as ave fun
spraySums <- ddply(InsectSprays,.(spray),summarize, sum=ave(count,FUN=sum))
# as in new var - does the same calculation as above 
# but sum of A will appear paired with every row that has A

#other fcn
#acast
#arrange
#mutate
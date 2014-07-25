set.seed(13435)
#set 1 to 5 in var1
#set 6 to 10 in var2
#set 11 to 15 in var3
X <- data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
#scarmble the rows
X <- X[sample(1:5),]; 
#add some NAs
X$var2[c(1,3)] = NA
X

#index row and col subset
X[,1]
X[,"var1"]
X[1:2,"var2"]

#logical row and col subset
X[(X$var1 <= 3 & X$var3 > 11),]
X[(X$var1 <= 3 | X$var3 > 15),]

#subsetting that deals with NAs
#NAs are filtered out automatically
X[which(X$var2 > 8),]

#sort - increasing
sort(X$var1)
#sort - decreasing
sort(X$var1,decreasing=TRUE)
#sort - as above - push nas to the end
sort(X$var2,na.last=TRUE)

#sort dataframe - order
#order on a variable 1 looking variable 3 in case of ties
X[order(X$var1, X$var3),]

#install.packages('plyr')
library(plyr)
arrange(X,var1) # basically same as above

#descending order sort
arrange(X, desc(var1))

#adding a column
X$var4 <- rnorm(5)
X
#another method #puts column on right
Y <- cbind(X,rnorm(5))
# Y <- cbind(rnorm(5), X) #puts column on left
Y
